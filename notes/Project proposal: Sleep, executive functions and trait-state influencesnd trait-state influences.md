# On sleep, executive functions, and state-trait influences

- [Methods](#methods)
- [Organisation and planning](#organisation-and-planning)
- [Data management plan](#data-management-plan)
- [Ethical approval](#ethical-approval)
- [References](#references)

For my master thesis I'm using data from the Mind the Sleep project initiated by Margrethe Hansen and René Huster, as a part of Margrethe’s PhD project. The main aim of the study was to explore how sleep disturbances impact executive functions and affect (with a particular focus on depressive symptoms), as well as how it might relate to brain function.
A fundamental challenge in cognitive neuroscience concerns whether cognitive measures reflect stable individual traits or state-dependent fluctuations. Recent findings from Thunberg et al. (2024) suggest that common executive function measures lack temporal stability, with test-retest reliability as low as r = .34 for the stop signal reaction time (SSRT). This instability indicates that cognitive control measures could be primarily influenced by situational factors rather than representing stable dispositional abilities. The specific factors driving this instability are unclear, which limits our understanding of when cognitive assessments provide reliable information about individual capabilities.
Sleep represents a state variable that could explain observed instability in cognitive measures. Sleep disturbances differentially affect cognitive subcomponents, with sleep deprivation primarily impairing top-down control processes while leaving automatic processes intact (Kusztor et al., 2019). This selective vulnerability suggests that some cognitive measures may be more state-dependent than others, with their reliability tied to recent sleep patterns rather than reflecting measurement error or inherent trait instability.
Unity and diversity? 
To address these issues, my project will use latent state–trait modelling, a structural equation modelling framework that partitions observed variance into stable trait-like components and occasion-specific fluctuations (Steyer, Schmitt, & Eid, 1999). This approach allows me to quantify how much of executive function performance reflects enduring individual differences versus temporary variation, and to test whether sleep measures at different timescales help explain variation in performance. 
Possible research questions:
1.	How much of the variance in EF performance is accounted for by individual differences, and how much is between-session variance (state + residual error)?
2.	Do people with better average sleep also tend to perform better on stable, trait-like components of EF?
3.	Do the short-term sleep measures (like the night before a session, or resting state EEG) account for EF performance changes from one session to the next?
4.	Do the associations between sleep and EF performance look similar across tasks, or are some tasks more sensitive to sleep than others?

## Methods
Participants (N = ~50) are recruited through online advertisements and screened for depression via phone using the MADRS depression screening tool. Eligible participants attend an initial 1.5-hour session including clinical interview (MINI) and baseline questionnaires. Participants are then equipped with actigraphy devices and instructed in daily sleep diary completion. They are also given daily questionnaires through e-mail. At two-week intervals, participants complete EEG sessions with executive function assessments (stop signal, task-switching, Stroop, and n-back tasks) and repeated questionnaire measures.


**Analysis**


I will apply latent state-trait modelling (LST-SEM) to repeated executive function tasks (stop signal, Stroop, n-back, task-switching) across the study sessions. For each EF measure, the repeated task scores will be modelled as indicators of latent trait and state factors. A trait component captures stable individual differences in EF performance across sessions. Since we only measure executive functions at two timepoints, the second component will encompass both state variance and residual error. 
The sleep variables derived from actigraphy (e.g., sleep duration, efficiency, fragmentation, variability) will be included as predictors of the state component to assess whether sleep quality and timing explain within-person fluctuations in EF performance. Average sleep across the recording period (or a two-week baseline) will be used as a trait-like indicator of sleep and related to the EF trait component. Short-term predictors, like sleep quality the night before a session or resting-state EEG at the beginning of a session, will also be included. They can be modelled in relation to the state component of EF, to test whether deviations from normal sleep patterns influence performance on the tasks (after accounting for trait variance and residual error). Model estimation will be conducted within a structural equation modelling framework, and I will evaluate model fit and variance decomposition.

## Organisation and planning
This project is a part of an ongoing study. We have already had two rounds of data collection, and we plan to have two more rounds before Christmas. One of them is ongoing now in September, and the next will start in early November. Each round has a maximum of 15 participants because of the number of actigraphs we have available. Data collection for each participant takes 5 weeks.
 
During the data collection period I also plan to read articles, and to start cleaning the data we have already collected. I can also make preprocessing pipelines before all the data is gathered. In December I will start preliminary analyses, and in January I will have the dataset ready for further analysis. In January I plan to start writing the thesis. In the beginning of April I will have the first draft ready and will continue editing and writing until the deadline in May. 
**Milestones**
October 1st: First draft of methods section finished
October 15th: First draft of introduction finished
November 1st: Preprocessing pipelines ready 
December 15th: Finished data collection
January 15th: All data is preprocessed, cleaned and ready for analysis
February 15th: Analyses finished
March 1st: Results section draft
March 15th: Discussion section draft 
April 1st: Complete first draft with abstract
April 15th: Revised draft 
May 1st: Final draft
May 15th: Final thesis submission

## Data management plan
Same as the parent project (“Mind the sleep”) on ForskPro.

## Ethical approval
The project was approved by the Regional Committees for Medical and Health Research Ethics (REK #197760).

## References
Hox, J.J. & Bechger, T.M. (1998). An Introduction to Structural Equation Modeling. Family Science Review, 11, 354-373. 
Kusztor, A., Raud, L., Juel, B. E., Nilsen, A. S., Storm, J. F., & Huster, R. J. (2019). Sleep deprivation differentially affects subcomponents of cognitive control. Sleep, 42(4), zsz016. https://doi.org/10.1093/sleep/zsz016
Steyer, R., Schmitt, M. & Eid, M. (1999). Latent State-Trait Theory and Research in Personality and Individual Differences. European Journal of Personality, 13, 389-408.
Thunberg, C., Wiker, T., Bundt, C., & Huster, R. J. (2024). On the (un)reliability of common behavioral and electrophysiological measures from the stop signal task: Measures of inhibition lack stability over time. Cortex, 175, 81-105. https://doi.org/10.1016/j.cortex.2024.02.008
