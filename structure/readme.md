# Data structure and database design

Mind the Sleep is a multimodal, longitudinal study with repeated measures across multiple timescales (daily, bi-weekly, session-based) and data modalities (questionnaires, actigraphy, EEG, behavioral tasks).

This folder contains documentation and the SQLite database implementing the relational structure used to organize and access the data in a consistent way across analyses.

## Contents

### ER-diagram.md
Describes the conceptual entity–relationship structure of the database, including core entities (participants, timepoints, instruments, administrations, measures) and their relationships.  
This file documents design decisions and serves as the reference schema for the database.

### test_participant.md
Walkthrough of a single participant mapped end-to-end onto the database structure.  
Used to validate that the schema can represent all collected data without special cases or ad hoc solutions.

### database.sqlite
A lightweight SQLite database implementing the documented schema.  
The database stores metadata, longitudinal structure, and derived measures, and references file-based data (e.g. EEG, actigraphy) via paths rather than storing raw signals.

## Scope and principles
- Raw data remain in the filesystem (Hypatia/TSD). The database functions as an index and integration layer.
- The schema is intentionally minimal and extensible.
- Documentation files precede and guide implementation.

This structure is intended to support reproducible data access and downstream analyses (e.g. longitudinal and latent state–trait models) across MATLAB, R, and Python.
