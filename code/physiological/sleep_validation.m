import pandas as pd
import numpy as np
import os
os.chdir(r"C:\Users\catba\Documents\Universitetet i Oslo\Høsten 2025\MICC - Master project\Code")
os.getcwd()

# -----------------------------
# 1. FILE PATHS (EDIT THESE)
# -----------------------------
actigraphy_file = "All_Actigraphy_Combined.xlsx"
diary_file = "MtS_AllSleepDiaries_long_format.xlsx"
startdates_file = "DiaryStartDates.xlsx"

output_file = "combined_sleep_summary.csv"

# -----------------------------
# 2. HELPER FUNCTIONS
# -----------------------------

def parse_european_date(series):
    """Parse dates in European day-month-year order, safely."""
    return pd.to_datetime(series, dayfirst=True, errors="coerce")


def time_to_minutes(series):
    """
    Convert a column with times (HH:MM or HH:MM:SS or Excel time/datetime)
    to minutes since midnight. Returns float with NaN for unparseable values.
    """
    # Convert to string to handle mixed Excel types
    s = series.astype(str)
    t = pd.to_datetime(s, errors="coerce")
    minutes = t.dt.hour * 60 + t.dt.minute
    return minutes


def circular_minutes_diff(a, b):
    """
    Compute circular difference in minutes between two time-of-day values
    (in minutes since midnight), taking into account wrap around at 24h.
    Returns NaN if either input is NaN.
    """
    diff = (a - b).abs()
    # 24h = 1440 minutes, use the shorter way around the clock
    diff = diff.where(diff <= 720, 1440 - diff)
    return diff


# -----------------------------
# 3. LOAD DATA
# -----------------------------
act = pd.read_excel(actigraphy_file)
diary = pd.read_excel(diary_file)
startdates = pd.read_excel(startdates_file)

# Strip whitespace from column names, just in case
act.columns = act.columns.str.strip()
diary.columns = diary.columns.str.strip()
startdates.columns = startdates.columns.str.strip()

# Ensure ID is string everywhere
for df in (act, diary, startdates):
    df["ID"] = df["ID"].astype(str).str.strip()

# -----------------------------
# 4. CLEAN & PREP ACTIGRAPHY
# -----------------------------

# Parse actigraphy date (European format)
act["Date_parsed"] = parse_european_date(act["Date"])

# Drop rows with completely empty sleep data (padding) or missing date
core_cols = ["In_bed", "Out_bed", "Total_sleep_time"]
all_core_nan = act[core_cols].isna().all(axis=1)
act_clean = act.loc[~all_core_nan & act["Date_parsed"].notna()].copy()

# Parse times to minutes since midnight
act_clean["In_bed_min"] = time_to_minutes(act_clean["In_bed"])
act_clean["Out_bed_min"] = time_to_minutes(act_clean["Out_bed"])

# Re-index actigraphy days per participant based on date
act_clean = act_clean.sort_values(["ID", "Date_parsed"])
act_clean["ActiDay"] = act_clean.groupby("ID").cumcount() + 1

# -----------------------------
# 5. CLEAN & PREP DIARY
# -----------------------------

# Merge diary with start dates
diary_merged = diary.merge(startdates, on="ID", how="left")

# Parse DiaryStartDate (European format if needed)
diary_merged["DiaryStartDate_parsed"] = parse_european_date(
    diary_merged["DiaryStartDate"]
)

# Convert Day and 11_startDay to numeric
diary_merged["Day_num"] = pd.to_numeric(diary_merged["Day"], errors="coerce")
diary_merged["startCode"] = pd.to_numeric(
    diary_merged["11_startDay"], errors="coerce"
)

# Compute DiaryEntryDate: the date the diary was filled out
diary_merged["DiaryEntryDate"] = (
    diary_merged["DiaryStartDate_parsed"] +
    pd.to_timedelta(diary_merged["Day_num"] - 1, unit="D")
)

# Compute DiarySleepDate:
# days coded 0 correspond to the previous night,
# days coded 1 correspond directly to the actigraphy night
# => DiarySleepDate = DiaryEntryDate - (1 - startCode)
diary_merged["DiarySleepDate"] = (
    diary_merged["DiaryEntryDate"] -
    pd.to_timedelta(1 - diary_merged["startCode"], unit="D")
)

# Parse diary times to minutes since midnight
diary_merged["tryToSleep_min"] = time_to_minutes(
    diary_merged["tryToSleepTime"]
)
diary_merged["getUpTime_min"] = time_to_minutes(
    diary_merged["getUpTime"]
)

# -----------------------------
# 6. MERGE DIARY & ACTIGRAPHY BY ID + DATE
# -----------------------------
merged = act_clean.merge(
    diary_merged,
    left_on=["ID", "Date_parsed"],
    right_on=["ID", "DiarySleepDate"],
    how="outer",
    indicator=True,
    suffixes=("_acti", "_diary")
)

# -----------------------------
# 7. COMPUTE TIME DIFFERENCES
# -----------------------------

# Bedtime: actigraphy In_bed vs diary tryToSleepTime
merged["bed_diff_min"] = circular_minutes_diff(
    merged["In_bed_min"], merged["tryToSleep_min"]
)

# Wake time: actigraphy Out_bed vs diary getUpTime
merged["wake_diff_min"] = circular_minutes_diff(
    merged["Out_bed_min"], merged["getUpTime_min"]
)

# -----------------------------
# 8. VALIDITY & ERROR CODES
# -----------------------------
merged["valid_day"] = False
merged["error_code"] = ""

# Conditions for different merge types
left_only = merged["_merge"] == "left_only"
right_only = merged["_merge"] == "right_only"
both = merged["_merge"] == "both"

# 8a. Only actigraphy, no diary entry for this date
merged.loc[left_only, "error_code"] = "no_diary_entry"

# 8b. Only diary, no actigraphy for this date
merged.loc[right_only, "error_code"] = "no_actigraphy_for_date"

# 8c. Both actigraphy and diary present
both_mask = both.copy()

# Check missing time data in "both" rows
time_cols = ["In_bed_min", "Out_bed_min", "tryToSleep_min", "getUpTime_min"]
missing_time = merged[time_cols].isna().any(axis=1) & both_mask
merged.loc[missing_time, "error_code"] = "missing_time_data"

# Define threshold-based validity where no missing time data
no_missing_time = both_mask & ~missing_time

bed_ok = merged["bed_diff_min"] <= 30
wake_ok = merged["wake_diff_min"] <= 30
valid_mask = no_missing_time & bed_ok & wake_ok

merged.loc[valid_mask, "valid_day"] = True
merged.loc[valid_mask, "error_code"] = "ok"

# Rows with both present, no missing time, but differences too large
too_large_diff = no_missing_time & ~valid_mask
merged.loc[too_large_diff, "error_code"] = "difference_above_threshold"

# -----------------------------
# 9. OPTIONAL: TIDY COLUMNS
# -----------------------------
# Keep things that are likely useful; you can drop any later in MATLAB if not needed.

# For clarity, rename the actigraphy date column used for merging
merged.rename(columns={"Date_parsed": "ActigraphyDate"}, inplace=True)

# -----------------------------
# 10. SAVE TO CSV
# -----------------------------
merged.to_csv(output_file, index=False)

print(f"Saved merged file to: {output_file}")
print("Summary:")
print("  Total rows:", len(merged))
print("  Valid days:", merged["valid_day"].sum())
print("  Error codes:")
print(merged["error_code"].value_counts(dropna=False))
