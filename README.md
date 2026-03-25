# Mind the Sleep

Sleep plays a vital role in daily functioning and helps protect against both physical and psychological health issues. We want to learn more about how everyday sleep habits influence mood and cognition, and how these patterns may be linked to symptoms of depression.


# On sleep, executive functions, and state-trait influences

This is the project description for my master thesis in cognitive neuroscience.

- [Methods](#methods)
- [Organisation and planning](#organisation-and-planning)
- [Data management plan](#data-management-plan)
- [Ethical approval](#ethical-approval)
- [References](#references)

For my master’s thesis, I use data from the *Mind the Sleep* project initiated by Margrethe Hansen and René Huster. The broader study examines how sleep relates to cognition and mental health. The current project focuses on **cognitive control in a task-switching paradigm**, and how it varies as a function of sleep.

A central challenge in cognitive neuroscience is determining whether cognitive measures reflect stable individual differences (traits) or fluctuate depending on situational factors (states). Evidence suggests that many commonly used measures of cognitive control show low reliability across time, indicating substantial variability that is not well understood.

Sleep is a strong candidate for explaining this variability. It operates across multiple timescales, from relatively stable individual patterns (habitual sleep) to short-term fluctuations (sleep the night before testing). These different aspects of sleep may differentially influence cognitive control.

The present project examines whether:
1. Habitual sleep is associated with overall levels of cognitive control  
2. Night-to-night sleep variation predicts fluctuations in performance  
3. Behavioural and neural measures of control show similar sensitivity to sleep  

Cognitive control is measured using:
- Reaction times in a task-switching paradigm (switch costs, congruency effects)  
- Frontal midline theta (4–8 Hz) derived from EEG time–frequency analysis 

## Methods
Participants (N = ~50) are recruited through online advertisements and screened for depression via phone using the MADRS depression screening tool. Eligible participants attend an initial 1.5-hour session including clinical interview (MINI) and baseline questionnaires. Participants are then equipped with actigraphy devices and instructed in daily sleep diary completion. They are also given daily questionnaires through e-mail. At two-week intervals, participants complete EEG sessions with executive function assessments (stop signal, task-switching, Stroop, and n-back tasks) and repeated questionnaire measures.


**Analysis**

EEG data are processed using EEGLAB and analyzed with time–frequency methods (ERSP). The primary neural measure is frontal midline theta power (4–8 Hz), typically extracted from electrode FCz in a post-stimulus time window.

Behavioural measures include reaction times and derived indices such as switch costs and congruency effects.

Sleep is operationalized at two levels:
- **Habitual sleep**: average sleep metrics across the recording period  
- **Nightly sleep**: sleep parameters from the night preceding each session  

Analyses focus on linking these sleep measures to:
- between-subject differences in performance (habitual sleep)  
- within-subject variation across sessions (nightly sleep)  

Statistical approaches include repeated-measures comparisons and condition contrasts (e.g., switch vs. repeat, congruent vs. incongruent), as well as extraction of theta-band activity for further analysis.


## Organisation and planning
Data collection is finished.


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
- Thunberg, C., Wiker, T., Bundt, C., & Huster, R. J. (2024). On the (un)reliability of common behavioral and electrophysiological measures from the stop signal task: Measures of inhibition lack stability over time. Cortex, 175, 81-105. https://doi.org/10.1016/j.cortex.2024.02.008
