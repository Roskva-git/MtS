# FDR correction for sleep-related fixed effects across planned mixed models
# Correction family: 9 models x 4 sleep-related terms = 36 p-values
# Method: Benjamini-Hochberg false discovery rate correction

FDR_table <- data.frame(
  outcome = c(
    rep("RT", 4),
    rep("Accuracy", 4),
    rep("Theta", 4),
    
    rep("RT", 4),
    rep("Accuracy", 4),
    rep("Theta", 4),
    
    rep("RT", 4),
    rep("Accuracy", 4),
    rep("Theta", 4)
  ),
  
  sleep_predictor = c(
    rep("TST deviation", 12),
    rep("Mean TST", 12),
    rep("TST SD", 12)
  ),
  
  effect = rep(
    c(
      "Sleep",
      "Switch x Sleep",
      "Congruency x Sleep",
      "Switch x Congruency x Sleep"
    ),
    9
  ),
  
  p_uncorrected = c(
    # RT + TST deviation
    0.0741, 0.0351, 0.3535, 0.4019,
    
    # Accuracy + TST deviation
    0.7870, 0.7458, 0.1622, 0.2294,
    
    # Theta + TST deviation
    0.6140, 0.6450, 0.4570, 0.7490,
    
    # RT + Mean TST
    0.1886, 0.4328, 0.5052, 0.4520,
    
    # Accuracy + Mean TST
    0.9903, 0.0157, 0.3568, 0.5478,
    
    # Theta + Mean TST
    0.6705, 0.0289, 0.5572, 0.1330,
    
    # RT + TST SD
    0.0802, 0.0387, 0.7473, 0.3979,
    
    # Accuracy + TST SD
    0.9694, 0.0197, 0.4391, 0.5908,
    
    # Theta + TST SD
    0.6109, 0.0301, 0.8935, 0.4955
  )
)

# Apply Benjamini-Hochberg FDR correction
FDR_table$q_FDR <- p.adjust(FDR_table$p_uncorrected, method = "BH")

# Add significance markers
FDR_table$significant_uncorrected <- FDR_table$p_uncorrected < 0.05
FDR_table$significant_FDR <- FDR_table$q_FDR < 0.05

# Round for readable output
FDR_table$p_uncorrected_rounded <- round(FDR_table$p_uncorrected, 4)
FDR_table$q_FDR_rounded <- round(FDR_table$q_FDR, 4)

# Reorder columns
FDR_table <- FDR_table[, c(
  "outcome",
  "sleep_predictor",
  "effect",
  "p_uncorrected_rounded",
  "q_FDR_rounded",
  "significant_uncorrected",
  "significant_FDR"
)]

# Print full table
print(FDR_table)

# Print only effects that were significant before correction
print(subset(FDR_table, significant_uncorrected == TRUE))

# Print only effects that survive FDR correction
print(subset(FDR_table, significant_FDR == TRUE))

# Optional: save table
write.csv(
  FDR_table,
  "FDR_sleep_related_effects.csv",
  row.names = FALSE
)
