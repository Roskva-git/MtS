# Contents

- [Project description](#project-description)
- [Explanations](#explanations)
- [Executive functions](#executive-functions)
- [Sleep](#sleep)
- [Mood](#mood)
- [Machine learning methods](#machine-learning-methods)
- [Uncertainty quantification](#uncertainty-quantification)
- [Reflections](#reflections)
- [Bibliography](#bibliography)

## Project description
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

3. Non-linear relationships
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

2. Temporal convolutional networks (TCNs)
Can capture patterns at multiple timescales simultaneously
Often outperform RNNs for time series
Add Bayesian layers for uncertainty quantification

3. Transformer-based models
Self-attention mechanisms could identify which specific days/patterns most influence cognitive performance
Can handle irregular sampling and missing data naturally

**Uncertainty quantification approaches**
1. Bayesian neural networks
Instead of point estimates, learn distributions over weights
Naturally provides uncertainty in predictions
Can distinguish between epistemic uncertainty (model uncertainty) and aleatoric uncertainty (data noise)

2. Deep ensembles
Train multiple models with different initializations
Disagreement between models indicates uncertainty
Often more practical than full Bayesian approaches

3. Monte Carlo dropout
Keep dropout active during inference
Run multiple forward passes
Variance in predictions estimates uncertainty

**Which cognitive functions are most predictable from sleep?**
Maybe working memory (N-back) is highly sleep-dependent while task-switching is more robust

**When does the model become uncertain?**
High uncertainty might indicate critical missing data or unusual sleep patterns
Could identify which participants need closer monitoring

**What temporal patterns matter most?**
Use attention weights or SHAP values to identify if it's last night's sleep, weekly average, or variability that matters

**How much missing data is too much?**
Quantify at what point uncertainty becomes too high for reliable predictions
This has direct implications for clinical deployment


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

**What are executive functions?** Is there a difference between hate speech and offensive language?

There is no single, consistent hate speech definition across the board. Article 20, paragraph 2 of the International Covenant on Civil and Political Rights (ICCPR) states that “any advocacy of national, racial or religious hatred that constitutes incitement to discrimination, hostility or violence shall be prohibited by law. When we are working with hate speech detection, it is important to discriminate between what is hate speech and what is simply offensive language. Offensive language can refer to any expression, such as profanity, insults, or vulgarity, that is likely to cause offense or discomfort, regardless of intent or target. Unlike hate speech, it does not necessarily involve attacks on individuals or groups based on intrinsic characteristics, nor does it inherently aim to incite hatred or discrimination. 

Introducing the HateXplain dataset, with a mission to reduce unintended bias toward communities who are targets of hate speech, by incorporating human rationales behind hate speech classification (Mathew et al., 2021)

- Problems with the dataset: Annotated by Mturk workers. Inter-rater agreement of 0.46, and we found many instances that were wrong.

Uncover biased text features by applying explanation techniques (Gongane et al., 2024)

Current context is hate speech in Brazil (in Portuguese, a low resource language) (Salles et al., 2025)

**HateBRXplain corpus** (Vargas et al., 2025; Vargas et al., 2022)

- The HateBRXplain corpus comprises a collection of 7000 Instagram comments collected from the posts of Brazilian politicians. The posts are manually annotated as either "offensive" or "non-offensive", with offensiveness labelled as highly, moderately or slightly offensive. Nine forms of hate speech were identified, namely xenophobia, racism, homophobia, sexism, religious intolerance, partyism, apology to dictatorship, antisemitism and fat-phobia.

## Sleep

What is attended in BERT? Which tokens are attended, 61,7% attention on CLS. BERT naturally performs very well even without further fine-tuning. (INSERT BRAGES EXPLANATION). Summary vector CLS?


## Mood


## Machine learning methods


## Uncertainty quantification


## Reflections

1. **What are the advantages of incorporating human-based rationales into the models?**
   - Value-based choices (normative answers)

2. **Why should we provide explainable models for sensitive tasks such as hate speech detection?**
   - Avoid bias (ethnic stereotypes, over-sensitivity to group identifiers)

3. **There are well-known metrics to evaluate improvements in model performance, but how can we measure gains in interpretability?** How do we evaluate the quality of the explanations? (e.g., *Faithfulness*: comprehensiveness, sufficiency; *Plausibility*: IOU F1-score, token-level precision, recall, and F1-score).

4. **We need to discuss the assumptions we are making about our research. Why are we doing this at all?**

5. **SHAP and LIME are defined as post-hoc explanation methods, but our approach may be considered inherently explaining or self-explaining.** What’s the difference between these two types of approaches? Also, what are the advantages and disadvantages of using each?

Imposing human based rationales on statistical learning models can arguably be necessary with the types of classifications we are making in this project. Hate speech is defined by what sort of values we have in society, it is a fluent property and not an objective truth. By having human annotators single out the words that make a text offensive or inoffensive, we have a greater chance of making our models pick up on the right cues for what makes a specific utterance hateful. We can avoid more random rationales that often come with machine learning because they are good at picking up any pattern, even ones that we don't see as meaningful. This is an advantage in some settings, but when it comes to value-based choices, we need to be in control of the rationales.

Explainability in the process of detecting hate speech is important because democracy vs freedom of speech.

It is also important to note that hate speech is heavily dependent on the context of the utterance, and of the sender. Hate speech expresses hate or encourages discrimination against a person or a group based on characteristics such as gender, political affiliation, race, sexuality and so on. However, there are certain important nuances and distinctions to make. There are many examples of minority groups reclaiming words or phrases that have been used in a negative fashion by mainstream society, such as black communities with the word "nigger" and LGBT communities with words such as "queer" or "gay". We need to be sensitive to this, as both human annotators and a machine learning model run the risk of defining words such as group identifiers as offensive, when it is in fact context dependent. Implementing hate speech detection to censor public communication could in the worst-case lead to discrimination of minorities, which is exactly what we want to avoid.

## Bibliography

Devlin, J., Chang, M.-W., Lee, K., & Toutanova, K. (2018). BERT: Pre-training of Deep Bidirectional Transformers for Language Understanding (Version 2). arXiv. https://doi.org/10.48550/ARXIV.1810.04805

DeYoung, J., Jain, S., Rajani, N. F., Lehman, E., Xiong, C., Socher, R., & Wallace, B. C. (2020). ERASER: A Benchmark to Evaluate Rationalized NLP Models (Version 2). arXiv. https://doi.org/10.48550/ARXIV.1911.03429

General Data Protection Regulation, Regulation (EU) 2016/679 of the European Parliament and of the Council of 27 April 2016 on the protection of natural persons with regard to the processing of personal data and on the free movement of such data, and repealing Directive 95/46/EC (General Data Protection Regulation). (2016). https://gdpr-info.eu/

Gongane, V. U., Munot, M. V., & Anuse, A. D. (2024). A survey of explainable AI techniques for detection of fake news and hate speech on social media platforms. Journal of Computational Social Science, 7(1), 587–623. https://doi.org/10.1007/s42001-024-00248-9

International Covenant on Civil and Political Rights. (1966, December 16). United Nations. https://www.ohchr.org/en/instruments-mechanisms/instruments/international-covenant-civil-and-political-rights

Jacovi, A., & Goldberg, Y. (2020). Towards Faithfully Interpretable NLP Systems: How should we define and evaluate faithfulness? (Version 3). arXiv. https://doi.org/10.48550/ARXIV.2004.03685

Mathew, B., Saha, P., Yimam, S. M., Biemann, C., Goyal, P., & Muhherjee, A. (2021). HateXplain: A Benchmark Dataset for Explainable Hate Speech Detection. 14867–14875. https://github.com/punyajoy/HateXplain

Salles, I., Vargas, F., & Benevenuto, F. (2025). HateBRXplain: A Benchmark Dataset with Human-Annotated Rationales  for Explainable Hate Speech Detection in Brazilian Portuguese. Proceedings of the 31st International Conference on Computational Linguistics, 6659–6669.

Vargas, F. A., Carvalho, I., de Góes, F. R., Benevenuto, F., & Pardo, T. A. S. (2022). HateBR: A Large Expert Annotated Corpus of Brazilian Instagram Comments for Offensive Language and Hate Speech Detection. https://doi.org/10.48550/ARXIV.2103.14972

Vargas, F., Carvalho, I., Pardo, T. A. S., & Benevenuto, F. (2025). Context-aware and expert data resources for Brazilian Portuguese hate speech detection. Natural Language Processing, 31(2), 435–456. https://doi.org/10.1017/nlp.2024.18

