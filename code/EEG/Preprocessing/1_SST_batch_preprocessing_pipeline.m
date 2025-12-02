%% Batch EEG Preprocessing Pipeline for SST Data with ICA

% Author: Røskva
% Date: 09.05.25
% Last changed: 15.08.25

% DESCRIPTION:
% This script performs batch preprocessing of EEG data (.vhdr files) for 
% Stop Signal Task (SST) experiments. The pipeline prepares data for 
% subsequent manual ICA component rejection and analysis.

% Long description:
% This script loops through files in a specified folder and processes the ones that fit the description (being .vhdr files in this case).
% It extracts a base name for each file for import and storage.
% We apply a low pass filter (40Hz), resample to 500Hz, high pass filter (0.1Hz) and remove EMG channels.
% We map electrode names and add FCz as the empty reference eletrode, then we re-reference to the average of the earlobes.
% We create an event list and rename the triggers for epoching (different script).
% We run the ICA but do not remove any components.


%% 0. Initialize EEGLAB and Set Paths
addpath('\\hume.uio.no\student-u87\....matlab-link', ...
    '\\hypatia.uio.no\lh-sv-psi\project-folder', ...
    '\\hypatia.uio.no\lh-sv-psi\project-code-folder');
eeglab;  % Start EEGLAB
% Define folders
raw_folder = '\\hypatia.uio.no\raw-folder';
out_folder = '\\hypatia.uio.no\out-folder';
% Get all .vhdr files in the raw folder
vhdr_files = dir(fullfile(raw_folder, '*.vhdr'));
% Loop over each file
for f = 1:length(vhdr_files)
    try
        % Get file info
        [~, base_name, ~] = fileparts(vhdr_files(f).name); % e.g., 'SST_152_1'
        disp(['Processing: ' base_name]);
        %% 1. Import Data
        EEG = pop_loadbv(raw_folder, vhdr_files(f).name);
        %% 2. Filtering
        EEG = pop_eegfiltnew(EEG, 'hicutoff', 40, 'plotfreqz', 0); % Low-pass 40 Hz
        %% 3. Resample to 500 Hz
        EEG = pop_resample(EEG, 500);
        %% More filtering :)
        EEG = pop_eegfiltnew(EEG, 'locutoff', 0.1, 'plotfreqz', 0); % High-pass 0.1 Hz
        %% 4. Remove EMG Channels
        EEG = pop_select(EEG, 'rmchannel', {'L_EMG', 'R_EMG'});


        %% Look up locations + append empty FCz
        
EEG = pop_chanedit(EEG, {'lookup','standard_1005.elc'},'append',1,'changefield',{2,'labels','FCz'});


        %% Re-reference to avg earlobes + add online reference
        EEG = pop_reref( EEG, find(ismember({EEG.chanlocs.labels}, {'A1','A2'})),'refloc',struct('labels',{'FCz'},'type',{''},'theta',[],'radius',[],'X',[],'Y',[],'Z',[],'sph_theta',[],'sph_phi',[],'sph_radius',[],'urchan',[],'ref',{''},'datachan',0));

              %% 7. Event List Creation and Trigger Renaming
        % Relevant triggers
        gl = 'S  1'; % Go stimulus - left - go trial
        gr = 'S  2'; % Go stimulus - right - go trial
        gsl = 'S  3'; % Go stimulus - left - stop trial
        gsr = 'S  4'; % Go stimulus - right - stop trial
        sl = 'S  5'; % Stop stimulus - left
        sr = 'S  6'; % Stop stimulus - right
        rl = 'S 65';  % Response - left
        rr = 'S 71'; % Response - right
        cl = 'Not collected'; % for CRT task, not collected in this data set
        cr = 'Not collected';
        % Extract meaningful event names
        EEG = SST_recode(EEG, EEG.srate, gl, gr, gsl, gsr, sl, sr, rl, rr, cl, cr);
        %% 8. Run ICA
        EEG = pop_runica(EEG, 'extended', 1, 'interrupt', 'on');
        %% 9. Save ICA Decomposition
        out_filename = [base_name '_ICA.set'];
        pop_saveset(EEG, 'filename', out_filename, 'filepath', out_folder);
        disp(['SUCCESS: ' base_name ' processed and saved as ' out_filename]);
        catch ME
      % Display error in console
         disp(['ERROR processing ' vhdr_files(f).name ':']);
         disp(getReport(ME, 'extended', 'hyperlinks', 'off'));
      % Log to error file with timestamp
        fid = fopen(fullfile(out_folder, 'processing_errors.log'), 'a');
        fprintf(fid, '[%s] Error in %s:\n%s\n\n', ...
            datetime("now"), vhdr_files(f).name, getReport(ME));
        fclose(fid);
    end
end
disp('Batch processing complete!');
