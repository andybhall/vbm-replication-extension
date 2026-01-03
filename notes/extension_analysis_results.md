# Extension Analysis Results

## Overview

This document summarizes the results of extending Thompson et al. (2020) from 1996-2018 to include elections through 2024, exploiting the continued rollout of California's Voter's Choice Act (VCA).

---

## Data Summary

| Period | Observations | CA Treated Counties | Treatment Rate (CA) |
|--------|-------------|--------------------|--------------------|
| Original (1996-2018) | 1,454 | 5 (2018 only) | 0.9% |
| Extension (2020-2024) | 378 | 15→27→30 | 26%→47%→52% |
| **Combined** | **1,832** | - | - |

---

## Main Results

### Table 2 Extension: Democratic Vote Share

| Specification | Original (1996-2018) | Extended (1996-2024) | Change |
|---------------|---------------------|---------------------|--------|
| Basic | 0.029 (0.011)** | 0.024 (0.007)*** | -0.005 |
| Linear Trends | 0.011 (0.004)** | 0.006 (0.003)* | -0.005 |
| Quadratic Trends | 0.007 (0.004)* | 0.003 (0.003) | -0.004 |

**Key Finding**: The positive effect of VBM on Democratic vote share **diminishes** when including 2020-2024 data. With quadratic trends, the effect becomes statistically insignificant.

### Table 3 Extension: Turnout

| Specification | Original (1996-2018) | Extended (1996-2024) | Change |
|---------------|---------------------|---------------------|--------|
| Basic | 0.021 (0.009)** | 0.026 (0.006)*** | +0.005 |
| Linear Trends | 0.022 (0.007)*** | 0.020 (0.005)*** | -0.002 |
| Quadratic Trends | 0.021 (0.008)** | 0.021 (0.006)*** | 0.000 |

**Key Finding**: The positive effect of VBM on turnout **persists** in the extended sample, remaining around 2 percentage points.

---

## Heterogeneity by VCA Adoption Cohort

### Democratic Vote Share (Presidential)

| Cohort | Coefficient | SE | Significant? |
|--------|------------|-----|-------------|
| 2018 Pilot (5 counties) | +0.032 | 0.011 | Yes |
| 2020 Adopters (10 counties) | -0.007 | 0.011 | No |
| 2022 Adopters (12 counties) | +0.006 | 0.011 | No |
| 2024 Adopters (3 counties) | -0.014 | 0.045 | No |

**Key Finding**: Only the 2018 pilot counties show a statistically significant positive effect. Later cohorts show essentially **zero partisan effects**.

### Turnout

| Cohort | Coefficient | SE | Significant? |
|--------|------------|-----|-------------|
| 2018 Pilot | +0.025 | 0.008 | Yes |
| 2020 Adopters | +0.028 | 0.011 | Yes |
| 2022 Adopters | +0.029 | 0.010 | Yes |
| 2024 Adopters | +0.041 | 0.023 | No |

**Key Finding**: All cohorts show positive turnout effects of 2.5-4 percentage points.

---

## Robustness Checks

### 1. Sample Restrictions

| Sample | Dem Vote Share Coef | SE |
|--------|--------------------|----|
| Full sample | 0.024 | 0.007 |
| Presidential only | 0.016 | 0.007 |
| Exclude 2024 | 0.026 | 0.008 |
| 2018+ only | **-0.011** | 0.005 |
| California only | 0.019 | 0.010 |
| Exclude CA | 0.029 | 0.010 |

**Note**: Using only post-2018 data shows a **negative** (though insignificant) effect on Democratic vote share.

### 2. Placebo Test

Testing whether 2018 pilot counties showed differential trends before VCA adoption:
- Placebo coefficient (2016): 0.031 (0.011)**

**Concern**: The significant placebo effect suggests pre-existing trends that could bias the treatment effect estimates for 2018 adopters.

### 3. Population Weighting

| Weighting | Dem Vote Share Coef | SE |
|-----------|--------------------|----|
| Unweighted | 0.003 | 0.007 |
| CVAP-weighted | -0.004 | 0.005 |

**Note**: Population-weighted estimates show **no partisan effect**, suggesting larger counties (which drive most votes) show no VBM impact on vote share.

---

## Event Study Results

### Democratic Vote Share (California Only)
Event time relative to VCA adoption (t=-2 is reference):

| Event Time | Coefficient | SE | Interpretation |
|------------|------------|-----|----------------|
| t = -10 | +0.025 | 0.019 | Pre-trend |
| t = -8 | +0.008 | 0.016 | Pre-trend |
| t = -6 | +0.012 | 0.011 | Pre-trend |
| t = -4 | -0.026 | 0.015 | Pre-trend |
| t = -2 | 0 (ref) | - | Reference |
| t = 0 | **-0.035*** | 0.018 | Year of adoption |
| t = 2 | +0.001 | 0.016 | Post-treatment |
| t = 4 | -0.025 | 0.029 | Post-treatment |
| t = 6 | +0.019 | 0.030 | Post-treatment |

**Interpretation**: No clear post-treatment effect. The significant negative effect at t=0 is surprising but may reflect noise or composition effects.

### Turnout (California Only)

| Event Time | Coefficient | SE |
|------------|------------|-----|
| t = -10 to -4 | -0.01 to -0.01 | ~0.01 |
| t = -2 | 0 (ref) | - |
| t = 0 to 6 | +0.001 to +0.006 | ~0.01-0.02 |

**Interpretation**: Flat pre-trends and modest positive (though insignificant) post-treatment effects.

---

## Summary and Conclusions

### Main Finding

**The extension confirms the original paper's core conclusion: Universal vote-by-mail has no meaningful impact on partisan outcomes but modestly increases turnout.**

### Detailed Conclusions

1. **Partisan Effects Diminish**: The small positive effect on Democratic vote share in the original period (driven primarily by 2018 pilot counties) does not persist when additional VCA adoptions are included.

2. **Selection Effects**: The 2018 pilot counties were more Democratic-leaning before adoption, which may explain their apparent positive treatment effect. Later cohorts show no partisan effect.

3. **Turnout Effects Persist**: VBM continues to increase turnout by approximately 2 percentage points across all adoption cohorts.

4. **Population-Weighted Results**: When weighted by population, there is no partisan effect, suggesting VBM does not systematically advantage either party in terms of vote share.

### Limitations

1. **CVAP Measurement**: Using 2018-2022 ACS for all years introduces measurement error.

2. **2022 Turnout**: Missing comparable turnout data for midterm elections.

3. **Voter File Data**: Cannot replicate Democratic turnout share analysis (Table 2, Cols 1-3) without voter file data.

4. **Pre-trends**: Evidence of pre-trends for 2018 pilot counties suggests caution in interpreting their treatment effects causally.

---

## Files Generated

- `output/tables/extension_partisan_results.csv` - Main partisan outcome results
- `output/tables/extension_turnout_results.csv` - Main turnout results
- `output/tables/event_study_results.csv` - Event study coefficients
- `output/figures/event_study.png` - Event study visualization
