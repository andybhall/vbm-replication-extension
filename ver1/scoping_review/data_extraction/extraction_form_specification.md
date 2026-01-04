# Data Extraction Form Specification

## Overview

This document specifies the data extraction form structure. Create an Excel workbook (`extraction_form.xlsx`) with the following sheets.

---

## Sheet 1: Study_Characteristics

| Column | Field Name | Data Type | Description | Example |
|--------|------------|-----------|-------------|---------|
| A | Study_ID | Text | Unique identifier | Tregellas2007 |
| B | First_Author | Text | Last name of first author | Tregellas |
| C | Year | Number | Publication year | 2007 |
| D | Title | Text | Full article title | Gray matter volume differences... |
| E | Journal | Text | Journal name | Schizophrenia Research |
| F | Country | Text | Study location | USA |
| G | Study_Design | Dropdown | Study design | Cross-sectional / Longitudinal / Case-control |
| H | Sample_Size_Total | Number | Total N | 64 |
| I | N_SZ_Smokers | Number | N schizophrenia smokers | 14 |
| J | N_SZ_NonSmokers | Number | N schizophrenia non-smokers | 18 |
| K | N_HC_Smokers | Number | N healthy control smokers | 2 |
| L | N_HC_NonSmokers | Number | N healthy control non-smokers | 30 |
| M | Funding_Source | Text | Funding information | NIH, etc. |
| N | Conflict_Interest | Text | COI statement | None declared |

---

## Sheet 2: Population_Details

| Column | Field Name | Data Type | Description | Example |
|--------|------------|-----------|-------------|---------|
| A | Study_ID | Text | Link to Sheet 1 | Tregellas2007 |
| B | Diagnosis_Criteria | Dropdown | Diagnostic system | DSM-IV / DSM-5 / ICD-10 |
| C | Diagnosis_Instrument | Text | How diagnosis confirmed | SCID, CASH, DIGS |
| D | Diagnosis_Types | Text | Specific diagnoses included | Schizophrenia only / Including schizoaffective |
| E | Age_SZ_Smokers_Mean | Number | Mean age | 39.6 |
| F | Age_SZ_Smokers_SD | Number | SD | 8.8 |
| G | Age_SZ_NonSmokers_Mean | Number | Mean age | 38.2 |
| H | Age_SZ_NonSmokers_SD | Number | SD | 9.1 |
| I | Age_HC_Mean | Number | Mean age (all HC) | 35.3 |
| J | Age_HC_SD | Number | SD | 9.3 |
| K | Sex_SZ_Smokers_Male_Pct | Number | % male | 71.4 |
| L | Sex_SZ_NonSmokers_Male_Pct | Number | % male | 66.7 |
| M | Sex_HC_Male_Pct | Number | % male | 43.8 |
| N | Illness_Duration_Years_Mean | Number | Mean illness duration | 15.2 |
| O | Illness_Duration_Years_SD | Number | SD | 8.5 |
| P | Medication_Status | Dropdown | Medication status | Medicated / Unmedicated / Mixed |
| Q | Medication_Type | Text | Type of antipsychotic | Typical / Atypical / Both |
| R | CPZ_Equivalents_Mean | Number | Chlorpromazine equivalents | 450 |
| S | CPZ_Equivalents_SD | Number | SD | 200 |
| T | Education_Years_Mean | Number | Mean education | 14.0 |
| U | Exclusion_Criteria | Text | Study exclusions | Substance abuse, neurological disorder |

---

## Sheet 3: Smoking_Details

| Column | Field Name | Data Type | Description | Example |
|--------|------------|-----------|-------------|---------|
| A | Study_ID | Text | Link to Sheet 1 | Tregellas2007 |
| B | Smoking_Definition | Text | How smoker defined | Current daily smoker ≥1 year |
| C | NonSmoker_Definition | Text | How non-smoker defined | <100 lifetime cigarettes |
| D | Verification_Method | Dropdown | How verified | Self-report / Cotinine / CO |
| E | Smoking_Duration_Years_Mean | Number | Mean years smoking | 18.5 |
| F | Smoking_Duration_Years_SD | Number | SD | 10.2 |
| G | CPD_Mean | Number | Cigarettes per day | 23.8 |
| H | CPD_SD | Number | SD | 13.0 |
| I | Pack_Years_Mean | Number | Pack-years | 14.9 |
| J | Pack_Years_SD | Number | SD | 15.0 |
| K | FTND_Mean | Number | Fagerström score | 5.2 |
| L | FTND_SD | Number | SD | 2.1 |
| M | Abstinence_Hours | Number | Hours smoke-free before scan | 12 |
| N | Former_Smokers_Included | Dropdown | Former smokers? | Yes / No / Not specified |
| O | Former_Smokers_Handling | Text | How handled | Excluded / Separate group / With non-smokers |

---

## Sheet 4: Neuroimaging_Methods

| Column | Field Name | Data Type | Description | Example |
|--------|------------|-----------|-------------|---------|
| A | Study_ID | Text | Link to Sheet 1 | Tregellas2007 |
| B | Scanner_Manufacturer | Dropdown | Scanner brand | Siemens / GE / Philips |
| C | Scanner_Model | Text | Scanner model | Allegra |
| D | Field_Strength | Dropdown | Tesla | 1.5T / 3T |
| E | Sequence_Type | Text | MRI sequence | T1-MPRAGE |
| F | Voxel_Size | Text | Resolution | 1x1x1 mm |
| G | Analysis_Software | Text | Software used | SPM2, FSL, FreeSurfer |
| H | Software_Version | Text | Version | SPM12 |
| I | Analysis_Approach | Dropdown | Method | VBM / ROI / Surface-based / Manual |
| J | Whole_Brain_vs_ROI | Dropdown | Coverage | Whole-brain / ROI only / Both |
| K | ROIs_Examined | Text | If ROI, which regions | Prefrontal, hippocampus |
| L | Preprocessing_Steps | Text | Key preprocessing | Normalization, smoothing 8mm |
| M | Template_Used | Text | Normalization template | MNI152 |
| N | Covariates_Statistical | Text | Covariates in model | Age, sex, TIV |
| O | Multiple_Comparison | Dropdown | Correction method | FWE / FDR / Uncorrected / Cluster |
| P | Significance_Threshold | Text | P-value threshold | p<0.05 FWE |

---

## Sheet 5: Brain_Structure_Findings

| Column | Field Name | Data Type | Description | Example |
|--------|------------|-----------|-------------|---------|
| A | Study_ID | Text | Link to Sheet 1 | Tregellas2007 |
| B | Finding_ID | Text | Unique finding ID | Tregellas2007_F1 |
| C | Outcome_Measure | Dropdown | What measured | GM volume / Cortical thickness / Surface area |
| D | Brain_Region | Text | Specific region | Right superior temporal gyrus |
| E | Lobe | Dropdown | Lobe | Frontal / Temporal / Parietal / Occipital / Subcortical / Cerebellar |
| F | Hemisphere | Dropdown | Side | Left / Right / Bilateral |
| G | Comparison | Dropdown | Groups compared | SZ-S vs SZ-NS / SZ-S vs HC-NS / Interaction |
| H | Direction | Dropdown | Finding direction | Smokers > Non-smokers / Smokers < Non-smokers / No difference |
| I | Statistical_Test | Text | Test used | t-test, ANCOVA, regression |
| J | Statistical_Value | Number | Test statistic | t=3.45 |
| K | P_Value | Number | Significance | 0.001 |
| L | Effect_Size_Type | Text | Type of ES | Cohen's d |
| M | Effect_Size_Value | Number | ES value | 0.65 |
| N | CI_Lower | Number | 95% CI lower | 0.32 |
| O | CI_Upper | Number | 95% CI upper | 0.98 |
| P | MNI_X | Number | X coordinate | 52 |
| Q | MNI_Y | Number | Y coordinate | -12 |
| R | MNI_Z | Number | Z coordinate | 4 |
| S | Cluster_Size | Number | Voxels | 245 |
| T | Notes | Text | Additional notes | Controlled for age, sex |

---

## Sheet 6: Symptom_Correlations

| Column | Field Name | Data Type | Description | Example |
|--------|------------|-----------|-------------|---------|
| A | Study_ID | Text | Link to Sheet 1 | Tregellas2007 |
| B | Correlation_ID | Text | Unique ID | Tregellas2007_C1 |
| C | Symptom_Scale | Dropdown | Scale used | PANSS / BPRS / SAPS / SANS |
| D | Symptom_Subscale | Dropdown | Subscale | Positive / Negative / General / Total |
| E | Symptom_Score_Smokers_Mean | Number | Mean score smokers | 18.5 |
| F | Symptom_Score_Smokers_SD | Number | SD | 5.2 |
| G | Symptom_Score_NonSmokers_Mean | Number | Mean score non-smokers | 16.2 |
| H | Symptom_Score_NonSmokers_SD | Number | SD | 4.8 |
| I | Brain_Region_Correlated | Text | Region | Prefrontal cortex |
| J | Correlation_Sample | Dropdown | Which sample | SZ smokers only / SZ non-smokers only / All SZ / All participants |
| K | Correlation_Type | Dropdown | Test type | Pearson / Spearman / Partial |
| L | Correlation_Coefficient | Number | r value | -0.42 |
| M | P_Value | Number | Significance | 0.015 |
| N | Covariates_Controlled | Text | Adjustments | Age, illness duration |
| O | Direction_Interpretation | Text | Meaning | Higher symptoms = lower volume |
| P | Notes | Text | Additional info | Post-hoc analysis |

---

## Sheet 7: Psychological_Flexibility

| Column | Field Name | Data Type | Description | Example |
|--------|------------|-----------|-------------|---------|
| A | Study_ID | Text | Link to Sheet 1 | |
| B | PF_Measure | Dropdown | Instrument | AAQ-II / CFQ / Other |
| C | PF_Measure_Other | Text | If other, specify | |
| D | PF_Score_SZ_Smokers_Mean | Number | Mean score | |
| E | PF_Score_SZ_Smokers_SD | Number | SD | |
| F | PF_Score_SZ_NonSmokers_Mean | Number | Mean score | |
| G | PF_Score_SZ_NonSmokers_SD | Number | SD | |
| H | PF_Group_Difference_P | Number | P-value for difference | |
| I | PF_Brain_Correlation_Region | Text | Brain region | |
| J | PF_Brain_Correlation_R | Number | Correlation coefficient | |
| K | PF_Brain_Correlation_P | Number | P-value | |
| L | PF_Symptom_Correlation_Scale | Text | Symptom scale | |
| M | PF_Symptom_Correlation_R | Number | Correlation coefficient | |
| N | PF_Symptom_Correlation_P | Number | P-value | |
| O | Notes | Text | Additional notes | |

**Note**: This sheet is expected to have few or no entries, which documents the research gap.

---

## Sheet 8: Quality_Notes

| Column | Field Name | Data Type | Description |
|--------|------------|-----------|-------------|
| A | Study_ID | Text | Link to Sheet 1 |
| B | Sample_Size_Adequate | Dropdown | Yes / No / Borderline |
| C | Groups_Matched | Text | How groups matched |
| D | Confounders_Addressed | Text | Which confounders controlled |
| E | Smoking_Well_Defined | Dropdown | Yes / Partial / No |
| F | Analysis_Appropriate | Dropdown | Yes / Partial / No |
| G | Results_Clearly_Reported | Dropdown | Yes / Partial / No |
| H | Limitations_Acknowledged | Dropdown | Yes / Partial / No |
| I | Overall_Quality_Notes | Text | Summary assessment |

---

## Dropdown Options Reference

### Study_Design
- Cross-sectional
- Longitudinal
- Case-control
- Mixed

### Diagnosis_Criteria
- DSM-IV
- DSM-5
- ICD-10
- ICD-11
- Other

### Medication_Status
- Medicated
- Unmedicated
- Mixed
- Not reported

### Scanner_Manufacturer
- Siemens
- GE
- Philips
- Other

### Field_Strength
- 1.5T
- 3T
- Other

### Analysis_Approach
- VBM
- ROI
- Surface-based
- Manual tracing
- Automated segmentation
- Other

### Whole_Brain_vs_ROI
- Whole-brain
- ROI only
- Both

### Multiple_Comparison
- FWE
- FDR
- Cluster-based
- Uncorrected
- Bonferroni
- Other

### Outcome_Measure
- Gray matter volume
- White matter volume
- Cortical thickness
- Surface area
- Subcortical volume
- Total brain volume
- Ventricular volume
- Other

### Direction
- Smokers > Non-smokers
- Smokers < Non-smokers
- No significant difference
- Interaction effect

### Comparison
- SZ-S vs SZ-NS (primary)
- SZ-S vs HC-S
- SZ-S vs HC-NS
- SZ-NS vs HC-NS
- Diagnosis × Smoking interaction
- Correlation with smoking severity
- Other

### Symptom_Scale
- PANSS
- BPRS
- SAPS
- SANS
- CGI
- GAF
- Other

### Symptom_Subscale
- Positive
- Negative
- General
- Total
- Other

### Correlation_Type
- Pearson
- Spearman
- Partial correlation
- Regression coefficient
- Other

---

## Instructions for Use

1. Create Excel workbook with 8 sheets named as specified
2. Add column headers as specified
3. Add data validation dropdowns where indicated
4. Create a blank template for pilot extraction
5. After pilot, make any necessary refinements
6. Use consistent coding across all extractors
7. Document any deviations or decisions in extraction_notes.md
