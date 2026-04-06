"""
Script: extract_sleep_daily.py

Author: Røskva
Project: Mind the Sleep (MtS) – Master’s Thesis
Date created: 25.03.2026
Date edited: 25.03.2026

Description:
This script extracts day-by-day sleep metrics from the MtS sleep diary dataset
for the 14 days preceding the first EEG session.

For each participant and each valid day for the 14 days preceding the first EEG session 
(including the night immediately preceding EEG; day 0), the script computes:
- Total Sleep Time (TST): tryToSleep → first awakening − SOL − WASO
- Sleep Onset Latency (SOL): minutes (NaN → 0)
- Wake After Sleep Onset (WASO): minutes (NaN → 0)
- Sleep Efficiency (SE): TST / (bedTime → getUpTime) × 100
- Number of awakenings: count (NaN → 0)

Input:
- CSV file: MtS_allSleepDiaries - Copy.csv

Output:
- sleep_daily.csv (long format; one row per participant × day)

Variables:
- 4_tryToSleepTime / 4_bedTime
- 5_solMin
- 6_awakeningNumber
- 7_awakeningMin
- 8_awakeTime
- 9_getUpTime

Notes:
- Missing SOL, WASO, and awakenings are treated as 0
- Days with invalid or missing time data are excluded
- Time differences crossing midnight are handled automatically
"""

import pandas as pd
import numpy as np

# --- LOAD ---
df = pd.read_csv(
    "//hypatia.uio.no/.../MtS_allSleepDiaries - Copy.csv",
    sep=";",
    encoding="cp1252"
)

rows = []

# --- LOOP ---
for i, row in df.iterrows():

    ID = row['ID']
    session1 = row['12_session1']
    correct = row['11_correctStart']

    EEG_idx = session1 if correct == 1 else session1 - 1

    start = int(EEG_idx - 14)
    end = int(EEG_idx)

    for t in range(start, end + 1):

        if t < 1:
            continue

        try:
            # --- TIMES ---
            sleep_time = pd.to_datetime(row.get(f'4_tryToSleepTime_T{t}'), errors='coerce')
            if pd.isna(sleep_time):
                sleep_time = pd.to_datetime(row.get(f'4_bedTime_T{t}'), errors='coerce')

            awake_time = pd.to_datetime(row.get(f'8_awakeTime_T{t}'), errors='coerce')
            bed_time   = pd.to_datetime(row.get(f'4_bedTime_T{t}'), errors='coerce')
            getup_time = pd.to_datetime(row.get(f'9_getUpTime_T{t}'), errors='coerce')

            if pd.isna(sleep_time) or pd.isna(awake_time) or pd.isna(bed_time) or pd.isna(getup_time):
                continue

            # --- DURATIONS ---
            tib_tst = (awake_time - sleep_time).total_seconds() / 60
            if tib_tst <= 0:
                tib_tst += 24 * 60

            tib_full = (getup_time - bed_time).total_seconds() / 60
            if tib_full <= 0:
                tib_full += 24 * 60

            # --- VARIABLES ---
            sol  = pd.to_numeric(row.get(f'5_solMin_T{t}'), errors='coerce')
            waso = pd.to_numeric(row.get(f'7_awakeningMin_T{t}'), errors='coerce')
            awak = pd.to_numeric(row.get(f'6_awakeningNumber_T{t}'), errors='coerce')

            sol  = 0 if pd.isna(sol) else sol
            waso = 0 if pd.isna(waso) else waso
            awak = 0 if pd.isna(awak) else awak

            # --- TST ---
            tst = tib_tst - sol - waso

            if tst <= 0 or tst > 24*60:
                continue

            se = (tst / tib_full) * 100

            # --- STORE ROW ---
            rows.append({
                'ID': ID,

                'diary_day': t,                     # absolute position in dataset
                'day_relative_to_EEG': t - EEG_idx, # -14 … -1
                'is_night_before_EEG': (t == EEG_idx),

                'TST_h': tst / 60,
                'SOL_min': sol,
                'WASO_min': waso,
                'SE_pct': se,
                'awakenings': awak
            })

        except:
            continue

# --- CREATE DATAFRAME ---
daily_sleep = pd.DataFrame(rows)

# --- SAVE ---
daily_sleep.to_csv(
    r"C:\Users\...\sleep_daily.csv",
    index=False
)

print("FILE SAVED")
