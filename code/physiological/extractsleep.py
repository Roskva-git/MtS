"""
Script: extractsleep.py

Author: Røskva
Project: Mind the Sleep (MtS) – Master’s Thesis
Date created: 23.03.2026
Date edited: 25.03.2026

Description:
This script computes participant-level sleep summary metrics from the MtS sleep diary dataset.
Metrics are calculated for the 14 days preceding the first EEG session.

For each participant, the script computes:
- Total Sleep Time (TST): tryToSleep → first awakening − SOL − WASO
- Sleep Onset Latency (SOL): minutes (NaN → 0)
- Wake After Sleep Onset (WASO): minutes (NaN → 0)
- Sleep Efficiency (SE): TST / (bedTime → getUpTime) × 100
- Number of awakenings: count (NaN → 0)

For each variable, the script outputs:
- Mean across valid days
- Standard deviation (intra-individual variability)

Additional outputs:
- Number of valid diary days per participant
- Indicator for inclusion in analysis (≥ 7 valid days)

Input:
- CSV file: MtS_allSleepDiaries - Copy.csv

Output:
- sleep_summary.csv (one row per participant)

Variables:
- 4_tryToSleepTime / 4_bedTime
- 5_solMin
- 6_awakeningNumber
- 7_awakeningMin
- 8_awakeTime
- 9_getUpTime
- 12_session1
- 11_correctStart

Notes:
- Missing SOL, WASO, and awakenings are treated as 0
- Days with invalid or missing time values are excluded
- Time differences crossing midnight are handled
- Summary statistics are based only on valid days within the 14-day window
"""


import pandas as pd
import numpy as np

# --- LOAD DATA ---
df = pd.read_csv(
    "//hypatia.uio.no/.../MtS_allSleepDiaries - Copy.csv",
    sep=";",
    encoding="cp1252"
)

sleep_summary = []

# --- LOOP ---
for i, row in df.iterrows():

    ID = row['ID']
    session1 = row['12_session1']
    correct = row['11_correctStart']

    EEG_idx = session1 if correct == 1 else session1 - 1

    start = int(EEG_idx - 14)
    end   = int(EEG_idx - 1)

    TST_vals = []
    WASO_vals = []
    SE_vals = []
    AWAK_vals = []
    SOL_vals = []

    for t in range(start, end + 1):

        if t < 1:
            continue

        try:
            # --- TRY TO SLEEP (fallback) ---
            sleep_time = pd.to_datetime(row.get(f'4_tryToSleepTime_T{t}'), errors='coerce')
            if pd.isna(sleep_time):
                sleep_time = pd.to_datetime(row.get(f'4_bedTime_T{t}'), errors='coerce')

            # --- FIRST AWAKENING ---
            awake_time = pd.to_datetime(row.get(f'8_awakeTime_T{t}'), errors='coerce')

            # --- BEDTIME + GET UP ---
            bed_time = pd.to_datetime(row.get(f'4_bedTime_T{t}'), errors='coerce')
            getup_time = pd.to_datetime(row.get(f'9_getUpTime_T{t}'), errors='coerce')

            if pd.isna(sleep_time) or pd.isna(awake_time) or pd.isna(bed_time) or pd.isna(getup_time):
                continue

            # --- TIB for TST ---
            tib_tst = (awake_time - sleep_time).total_seconds() / 60
            if tib_tst <= 0:
                tib_tst += 24 * 60

            # --- TIB for SE ---
            tib_full = (getup_time - bed_time).total_seconds() / 60
            if tib_full <= 0:
                tib_full += 24 * 60

            # --- COMPONENTS ---
            waso = pd.to_numeric(row.get(f'7_awakeningMin_T{t}'), errors='coerce')
            awak = pd.to_numeric(row.get(f'6_awakeningNumber_T{t}'), errors='coerce')
            sol  = pd.to_numeric(row.get(f'5_solMin_T{t}'), errors='coerce')

            sol  = 0 if pd.isna(sol) else sol
            waso = 0 if pd.isna(waso) else waso
            awak = 0 if pd.isna(awak) else awak

            # --- TST ---
            tst = tib_tst - sol - waso

            if tst <= 0 or tst > 24*60:
                continue

            # --- SLEEP EFFICIENCY ---
            se = (tst / tib_full) * 100

            # --- STORE ---
            TST_vals.append(tst / 60)   # hours
            WASO_vals.append(waso)      # minutes
            SE_vals.append(se)          # %
            AWAK_vals.append(awak)
            SOL_vals.append(sol)        # minutes

        except:
            continue

    # --- ARRAYS ---
    TST_vals = np.array(TST_vals)
    WASO_vals = np.array(WASO_vals)
    SE_vals = np.array(SE_vals)
    AWAK_vals = np.array(AWAK_vals)
    SOL_vals = np.array(SOL_vals)

    n_valid = len(TST_vals)

    def m_sd(x):
        return (np.nanmean(x), np.nanstd(x)) if len(x) > 0 else (np.nan, np.nan)

    tst_m, tst_sd = m_sd(TST_vals)
    waso_m, waso_sd = m_sd(WASO_vals)
    se_m, se_sd = m_sd(SE_vals)
    awak_m, awak_sd = m_sd(AWAK_vals)
    sol_m, sol_sd = m_sd(SOL_vals)

    sleep_summary.append({
        'ID': ID,

        'TST_mean_h': tst_m,
        'TST_sd_h': tst_sd,

        'SOL_mean_min': sol_m,
        'SOL_sd_min': sol_sd,

        'WASO_mean_min': waso_m,
        'WASO_sd_min': waso_sd,

        'SE_mean_pct': se_m,
        'SE_sd_pct': se_sd,

        'awakenings_mean': awak_m,
        'awakenings_sd': awak_sd,

        'n_valid_days': n_valid,
        'valid_for_analysis': n_valid >= 7
    })

# --- SAVE ---
sleep_summary = pd.DataFrame(sleep_summary)

sleep_summary.to_csv(
    r"C:\Users\roskvatb\...\sleep_summary.csv",
    index=False
)

print("FILE SAVED")
