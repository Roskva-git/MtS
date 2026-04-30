# Mind the Sleep: sleep and cognitive control

This repository contains code and project documentation for my master’s thesis in cognitive neuroscience at the University of Oslo.

The thesis used data from the *Mind the Sleep* project, initiated by Margrethe Hansen and René Huster. The broader project examines how sleep relates to cognition and mental health. The present thesis focused on whether naturalistic variation in sleep is associated with behavioural and neural indices of cognitive control in a task-switching paradigm.

## Thesis focus

The thesis examined whether different aspects of sleep were associated with cognitive flexibility and cognitive stability.

Cognitive flexibility was operationalized as switch costs in a task-switching paradigm, meaning differences between switch and repeat trials. Cognitive stability was operationalized as congruency effects, meaning differences between incongruent and congruent trials. Frontal midline theta power was extracted from EEG as a neural index of cognitive control engagement.

Sleep was assessed using daily sleep diaries. The main sleep variables were:

- **Habitual sleep duration**: each participant’s mean total sleep time across the recording period
- **Sleep variability**: within-participant standard deviation in total sleep time
- **Night-before sleep deviation**: deviation in total sleep time from the participant’s own average on the night before EEG testing

## Research questions
The project asked whether:

1. Habitual sleep duration, sleep variability, or night-before sleep deviation were associated with task performance
2. Sleep-related associations differed between switch costs and congruency effects
3. Frontal midline theta showed task-related modulation and/or sleep-related associations

## Data

The repository does not contain raw EEG data, sleep diary data, actigraphy data, questionnaire data, or identifiable participant information.

Data were collected as part of the *Mind the Sleep* project and stored on the University of Oslo’s secure TSD platform. Any paths in the public code have been anonymized or replaced with placeholders.

## Methods overview
Participants completed daily sleep diaries across the recording period and attended EEG sessions involving several executive-function tasks. The present thesis used the first EEG recording of the task-switching paradigm.

The task-switching paradigm used bivalent letter-number stimuli. The colour of the stimulus indicated whether participants should respond according to the letter rule or the number rule. Trials were classified as switch or repeat trials, and as congruent or incongruent trials.

Behavioural outcomes included:

- Reaction time on correct trials
- Accuracy, with omissions treated as unsuccessful trials
- Switch and congruency effects

EEG analyses focused on frontal midline theta power. Theta was defined as 4–8 Hz event-related spectral perturbation power from 200–500 ms after stimulus onset, averaged across Fz, FCz, and Cz.

## Analysis

Analyses included:

- Repeated-measures ANOVAs testing task effects of switch and congruency on reaction time, accuracy, and theta power
- Linear mixed-effects models for reaction time and theta
- Logistic mixed-effects models for accuracy
- Separate sleep models for habitual sleep duration, sleep variability, and night-before sleep deviation
- Benjamini–Hochberg false discovery rate correction for sleep-related fixed effects

## Repository structure
The repository contains analysis scripts for behavioural data, sleep data, and EEG/theta extraction. File paths have been anonymized, and scripts may require local adaptation before they can be run.


**Milestones**

- October 1st: First draft of methods section finished
- October 15th: First draft of introduction finished
- November 1st: Preprocessing pipelines ready 
- December 15th: Finished data collection
- January 15th: All data is preprocessed, cleaned and ready for analysis
- February 15th: Analyses finished
- March 1st: Results section draft
- March 15th: Discussion section draft 
- April 23rd: Complete first draft with abstract
- May 1st: Final draft
- May 8th: Final thesis submission


## Data management plan
Same as the parent project (“Mind the sleep”) on ForskPro.

## Ethical approval
The project was approved by the Regional Committees for Medical and Health Research Ethics (REK #197760).

## References
- Hox, J.J. & Bechger, T.M. (1998). An Introduction to Structural Equation Modeling. Family Science Review, 11, 354-373. 
- Kusztor, A., Raud, L., Juel, B. E., Nilsen, A. S., Storm, J. F., & Huster, R. J. (2019). Sleep deprivation differentially affects subcomponents of cognitive control. Sleep, 42(4), zsz016. https://doi.org/10.1093/sleep/zsz016
- Steyer, R., Schmitt, M. & Eid, M. (1999). Latent State-Trait Theory and Research in Personality and Individual Differences. European Journal of Personality, 13, 389-408.

## References

- Cavanagh, J. F., & Frank, M. J. (2014). Frontal theta as a mechanism for cognitive control. *Trends in Cognitive Sciences, 18*(8), 414–421. https://doi.org/10.1016/j.tics.2014.04.012
- Friedman, N. P., & Miyake, A. (2017). Unity and diversity of executive functions: Individual differences as a window on cognitive structure. *Cortex, 86*, 186–204. https://doi.org/10.1016/j.cortex.2016.04.023
- Kusztor, A., Raud, L., Juel, B. E., Nilsen, A. S., Storm, J. F., & Huster, R. J. (2019). Sleep deprivation differentially affects subcomponents of cognitive control. *Sleep, 42*(4), zsz016. https://doi.org/10.1093/sleep/zsz016
- Nack, C., & Chiu, Y.-C. (2023). Cognitive flexibility and stability at the task-set level: A dual-dimension framework. *Advances in Psychology, 1*(1). https://doi.org/10.56296/aip00007
- Thunberg, C., Bundt, C., & Huster, R. J. (2024). On the (un)reliability of common behavioral and electrophysiological measures from the stop signal task: Measures of inhibition lack stability over time. *Cortex, 175*, 81–105. https://doi.org/10.1016/j.cortex.2024.02.008
