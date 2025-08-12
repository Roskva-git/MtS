# Contents

- [Mind the Sleep](#mind-the-sleep)
- [Project description](#project-description)
- [Explanations](#explanations)
- [Executive functions](#executive-functions)
- [Sleep](#sleep)
- [Mood](#mood)
- [Machine learning methods](#machine-learning-methods)
- [Uncertainty quantification](#uncertainty-quantification)
- [Reflections](#reflections)
- [Literature search](#literature-search)
- [Bibliography](#bibliography)

## Mind the Sleep
Sleep plays a vital role in daily functioning and helps protect against both physical and psychological health issues. We want to learn more about how everyday sleep habits influence mood and cognition, and how these patterns may be linked to symptoms of depression.

Sleep is important for optimal cognitive functioning and can further act as a protective factor against developing physical and psychological health problems. In this project, we investigate how sleep influences and interacts with cognitive and mood-related symptoms of depression. We have a particular focus on executive functions, which is a group of cognitive processes contributing to regulating behavior and feelings.

## Project ideas

How about this:
"On the (un)reliability of common behavioral and electrophysiological measures from the stop signal task: Measures of inhibition lack stability over time"
x
uncertainty quantification 


This is currently more like brainstorming than an actual description.

Topic: Temporal dynamics with missing data
"Development and validation of uncertainty-aware deep learning models for predicting cognitive performance from incomplete sleep and mood time series data"
This would involve:
* Using the daily questionnaires and actigraphy as inputs
* Predicting SST, Stroop, N-back performance at the two EEG timepoints
* Comparing models that explicitly quantify uncertainty vs. traditional approaches
* Examining whether uncertainty estimates correlate with actual prediction errors


1. Temporal dependencies and patterns

**Cumulative sleep debt** Multiple nights of poor sleep compound

**Sleep regularity** Variance in sleep timing matters as much as duration

**Circadian rhythms** When someone sleeps relative to their chronotype

**Recovery patterns** How quickly someone bounces back from sleep disruption


2. Non-linear relationships

**Threshold effects** Performance might be stable until sleep drops below 6 hours, then decline sharply

**Saturation effects** Extra sleep beyond 8 hours might not improve performance

**Interaction effects** Poor sleep might affect Stroop performance more in people with depression symptoms

**Individual differences** Some people might be more resilient to sleep loss


**Methods for deep learning**

1. LSTM/GRU networks with uncertainty

Pseudo-architecture:

Input: 35 days of [sleep_duration, sleep_quality, mood_scores, actigraphy_features]

↓

LSTM layers (capture temporal dependencies)

↓

Dropout layers (for uncertainty via Monte Carlo dropout)

↓

Output: Predicted cognitive scores + uncertainty estimates

3. Temporal convolutional networks (TCNs).
Can capture patterns at multiple timescales simultaneously.
Often outperform RNNs for time series.
Add Bayesian layers for uncertainty quantification.

4. Transformer-based models.
Self-attention mechanisms could identify which specific days/patterns most influence cognitive performance.
Can handle irregular sampling and missing data naturally.

**Uncertainty quantification approaches**
1. Bayesian neural networks.
Instead of point estimates, learn distributions over weights.
Naturally provides uncertainty in predictions.
Can distinguish between epistemic uncertainty (model uncertainty) and aleatoric uncertainty (data noise).

2. Deep ensembles.
Train multiple models with different initializations.
Disagreement between models indicates uncertainty.
Often more practical than full Bayesian approaches.

3. Monte Carlo dropout.
Keep dropout active during inference.
Run multiple forward passes.
Variance in predictions estimates uncertainty.

**Which cognitive functions are most predictable from sleep?**
Maybe working memory (N-back) is highly sleep-dependent while task-switching is more robust?

**When does the model become uncertain?**
High uncertainty might indicate critical missing data or unusual sleep patterns.
Could identify which participants need closer monitoring.

**What temporal patterns matter most?**
Use attention weights or SHAP values to identify if it's last night's sleep, weekly average, or variability that matters.

**How much missing data is too much?**
Quantify at what point uncertainty becomes too high for reliable predictions.
This has direct implications for clinical deployment.

## Explanations

**Chronotypes**
Read up on this

**Insert keyword** 
- This is for short explainations

**MINI**
Short description of the tool and what it measures

**MADRS**
Short description of the tool and what it measures

**Stop signal task**
Short description of the task and what it measures

**Task switching task**
Short description of the task and what it measures

**Stoop test**
Short description of the task and what it measures

**N-back**
Short description of the task and what it measures

**Actigraphy**
How do we use it and why


## Executive functions

**What are executive functions?** Add text
- Keywords

  
## Sleep

What is it. Why is it. When is it?

## Mood


## Machine learning methods
Maybe explanations should be in the sections they belong to, rather than having a big chunk of them in the beginning. 

Could Masked Rationale Prediction be used in uncertainty quantification (Kim, Lee and Sohn, 2022)? In the instances where we actually have all the data, we could still train as if it was missing.


## Uncertainty quantification

A Python Toolbox for Machine Learning on Partially-Observed Time Series:
https://pypots.com/

Supervised Machine Learning for Science, chapter 13 Uncertainty:
https://ml-science-book.com/uncertainty.html 

## Reflections

1. **Here we would want questions to ponder on?**
   - And reflective answers (or something along those lines)

2. **Possibly several questions?**
   - Add deep thinking (in this section)

## Literature search

Search conducted on Web of Science (33 results), PsychInfo (8 results), PubMed (25 results) and Oria (58 results):
("sleep" OR "actigraphy") AND ("executive function*" OR "cognitive performance")  AND ("machine learning" OR "deep learning").

Looked through the references in the MtS proposal to ExtraStiftelsen


## Bibliography

Create a list of the papers that are actually used in the thesis.
