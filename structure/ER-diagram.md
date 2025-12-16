### participants

Stable demographics

| Column name       | Type        | Key | Description                                   |
|-------------------|-------------|-----|-----------------------------------------------|
| participant_id    | TEXT        | PK  | Unique participant identifier                 |
| age               | INTEGER     |     | Age in years                                  |
| gender            | INTEGER     |     | 0 = woman, 1 = man                            |
| edu_years         | INTEGER     |     | Years of education (cleaned value)            |
| edu_original      | TEXT        |     | Original free-text education response         |


### timepoints

Recruitment, daily, bi-weekly, EEG session

| Column name    | Type     | Key | Description                                             |
|----------------|----------|-----|---------------------------------------------------------|
| timepoint_id   | TEXT     | PK  | Unique timepoint identifier                             |
| participant_id | TEXT     | FK  | References participants(participant_id)                 |
| timepoint_type | TEXT     |     | recruitment, daily, biweekly, eeg_session               |
| date           | DATE     |     | Calendar date (when applicable)                         |
| index_in_type  | INTEGER  |     | Order within timepoint type (e.g. daily day 1–28)       |


### instruments

PHO, MADRS, MINI, GAD, SST, Stroop, etc.

| Column name    | Type | Key | Description                                      |
|----------------|------|-----|--------------------------------------------------|
| instrument_id  | TEXT | PK  | Instrument identifier (e.g. MADRS, SST, RS)      |
| modality       | TEXT |     | questionnaire, eeg, actigraphy, diary            |
| description    | TEXT |     | Human-readable description                       |



### administrations

Questionnaire X at timepoint Y / EEG task Z in session 2

| Column name        | Type | Key | Description                                                   |
|--------------------|------|-----|---------------------------------------------------------------|
| administration_id  | TEXT | PK  | Unique administration instance                                |
| participant_id     | TEXT | FK  | References participants(participant_id)                       |
| timepoint_id       | TEXT | FK  | References timepoints(timepoint_id)                           |
| instrument_id      | TEXT | FK  | References instruments(instrument_id)                         |
| file_path          | TEXT |     | Path to raw or processed data file (if applicable)            |
| processing_state   | TEXT |     | raw, preprocessed, cleaned, epoched, etc.                     |
| processing_version | TEXT |     | Script or pipeline version identifier                         |


### measures

Item-level responses, summary scores, EEG-derived metrics

| Column name        | Type  | Key | Description                                               |
|--------------------|-------|-----|-----------------------------------------------------------|
| measure_id         | TEXT  | PK  | Unique measure identifier                                 |
| administration_id  | TEXT  | FK  | References administrations(administration_id)             |
| measure_name       | TEXT  |     | Name of item or derived measure                           |
| value              | REAL  |     | Numeric or coded value                                    |
| unit               | TEXT  |     | Unit of measurement (if applicable)                       |


