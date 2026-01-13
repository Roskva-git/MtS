%% Clean data with ICA

% Author: Røskva
% Date: 09.05.25
% Last changed: 13.01.26

% Workflow: 
% Step 1. Run preprocessing script with ICA
% step 2. Reject independent components 
% Step 3. Run the mapping script using the logfile to map events
% Step 4. Get behavioural overview
% Step 5. Epoch & analyze

% DESCRIPTION
% This script sets up the process for manual ICA inspection
% We open EEGLAB, load the file we want to inspect and find the correct
% channel location so the components are mapped correctly
% Then we remove components manually and save the file


% 0. Initialize EEGLAB and Set Paths
addpath('\\hume.uio.no\MATLAB-eeglab-location', ...
    '\\hypatia.uio.no\project-folder\', ...
    '\\hypatia.uio.no\code-folder');
eeglab;  % Start EEGLAB

% 1. Load existing dataset
EEG = pop_loadset('filename','TST_XX_X_ICA.set','filepath','\\hypatia.uio.no\\preproc-folder\\');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );

% 2. Find correct channel locations - THIS MAY NOT BE NECESSARY
% EEG=pop_chanedit(EEG, {'lookup','standard_1005.elc'});
% [ALLEEG, EEG, CURRENTSET] = eeg_store(ALLEEG, EEG, CURRENTSET);

% 3. Manual ICA component inspection and cleaning
% Use EEGLAB GUI: Tools > Inspect/Label Components > By Map
% Visually inspect each component for artifacts:
% - Eye blinks: frontal distribution, regular spikes
% - Eye movements: lateral frontal pattern  
% - Muscle artifacts: high frequency, temporal locations
% - Heart artifacts: regular rhythm
% Mark bad components, then Tools > Remove Components

% 4. Save cleaned dataset (do this manually after component removal)
% pop_saveset(EEG, 'filename', 'TST_71_1_cleaned.set', 'filepath', output_path);
