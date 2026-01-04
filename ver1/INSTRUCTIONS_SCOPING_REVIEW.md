# Scoping Review: Structural Brain Alterations, Symptom Severity, and Psychological Flexibility in Smoking versus Non-Smoking Patients with Schizophrenia

## Project Overview

This scoping review follows the Joanna Briggs Institute (JBI) methodology for scoping reviews and PRISMA-ScR reporting guidelines. The project adapts a rigorous, phase-based approach with mandatory checkpoints to ensure quality and transparency.

**Research Questions**:
1. What structural brain differences (measured by T1-weighted sMRI) exist between smoking and non-smoking patients with schizophrenia?
2. How do these structural differences correlate with psychiatric symptom severity (positive and negative symptoms)?
3. What is known about psychological flexibility in relation to brain structure in smoking schizophrenia patients?
4. What are the implications for smoking cessation interventions?

**Differentiation from Koster et al. (2025)**:
| Aspect | Koster 2025 | This Review |
|--------|-------------|-------------|
| Modality | sMRI + fMRI | sMRI ONLY |
| Focus | Brain alterations (descriptive) | Brain-symptom correlations (clinical) |
| Psychological flexibility | Not addressed | Novel construct included |
| Intervention implications | Not addressed | ACT/smoking cessation focus |
| Population | Schizophrenia spectrum + CHR | Diagnosed schizophrenia only |

---

## IMPORTANT: Stop-and-Check Points

Throughout this project, there are mandatory **STOP AND CHECK** points marked with the stop sign. At each checkpoint, you must:
1. Summarize what you have completed
2. Present key outputs for review
3. List any issues or concerns
4. **Wait for human approval before proceeding**

Do not proceed past a checkpoint without explicit approval.

---

## PHASE 0: Project Setup and Protocol Development

### Task 0.1: Create Project Structure

Create the following directory structure:

```
scoping_review/
├── README.md                    # Project overview
├── INSTRUCTIONS.md              # This file
├── requirements.txt             # Dependencies (if any scripts)
├── protocol/                    # Review protocol documents
│   ├── protocol_draft.md        # Protocol for registration
│   ├── PRISMA-ScR_checklist.md  # Reporting checklist
│   └── PCC_framework.md         # Eligibility criteria
├── search/                      # Search documentation
│   ├── search_strategy.md       # Full search strings
│   ├── database_searches/       # Search results by database
│   │   ├── pubmed_results.csv
│   │   ├── psycinfo_results.csv
│   │   ├── embase_results.csv
│   │   └── cochrane_results.csv
│   └── handsearch_results.csv   # Reference list screening
├── screening/                   # Screening process
│   ├── deduplicated_records.csv # After deduplication
│   ├── title_abstract_screening.csv
│   ├── fulltext_screening.csv
│   └── exclusion_reasons.csv    # With reasons for exclusion
├── data_extraction/             # Extracted data
│   ├── extraction_form.xlsx     # Blank template
│   ├── extracted_data.xlsx      # Completed extractions
│   └── extraction_notes.md      # Decisions and clarifications
├── synthesis/                   # Analysis and synthesis
│   ├── evidence_tables.md       # Summary tables
│   ├── narrative_synthesis.md   # Qualitative synthesis
│   └── gap_analysis.md          # Research gaps identified
├── output/
│   ├── tables/                  # Publication-ready tables
│   ├── figures/                 # PRISMA flow diagram, etc.
│   └── paper/                   # Final manuscript
└── notes/                       # Working documentation
    ├── meeting_notes.md
    ├── decisions_log.md
    └── reference_management.md
```

### Task 0.2: Define Eligibility Criteria (PCC Framework)

Create `protocol/PCC_framework.md` with:

#### Population
- **Included**: Adults (≥18 years) with a diagnosis of schizophrenia, schizoaffective disorder, or schizophreniform disorder based on standardized criteria (DSM-IV/5 or ICD-10/11)
- **Excluded**:
  - Adolescents or pediatric populations
  - Clinical high-risk (CHR) for psychosis without diagnosis
  - Other psychotic disorders (e.g., brief psychotic disorder, delusional disorder)
  - Studies that do not separate schizophrenia from other diagnoses

#### Concept
The interplay between:
1. **Smoking status**: Current smokers vs. non-smokers (former smokers noted separately if available)
   - Preferentially: Current daily smokers for ≥1 year
   - Accept study-specific definitions with explicit classification
2. **Structural brain measures** (T1-weighted sMRI):
   - Gray matter volume (VBM, ROI-based)
   - Cortical thickness
   - Cortical surface area
   - Subcortical volumes
   - Total brain volume, white matter volume
   - **Excluded**: DTI/diffusion metrics, fMRI, PET, SPECT, MRS
3. **Psychiatric symptom severity**:
   - PANSS (positive, negative, general subscales)
   - BPRS
   - SAPS/SANS
   - Other validated symptom scales
4. **Psychological flexibility** (if reported):
   - AAQ-II (Acceptance and Action Questionnaire)
   - Other ACT-related measures

#### Context
- Published primary research (peer-reviewed)
- Cross-sectional and longitudinal designs
- Any geographic setting
- English language only
- No date restrictions

### Task 0.3: Review Seed Literature

You have access to the following seed materials:

**Review articles for identifying primary studies:**
1. Koster et al. (2025) - Primary source for initial studies
2. Sosa-Moscoso et al. (2025)
3. Thoma & Daum (2013)
4. Tesselaar et al. (2025)
5. Smucny & Tregellas (2017)

**Action**: Extract all primary sMRI studies from these reviews and document in `search/handsearch_results.csv`

### Task 0.4: Draft Protocol for Registration

Create `protocol/protocol_draft.md` following PRISMA-P guidelines:
- Title
- Registration (OSF recommended for scoping reviews)
- Authors and contributions
- Rationale
- Objectives
- Eligibility criteria
- Information sources
- Search strategy
- Selection process
- Data charting
- Synthesis methods

---

## STOP AND CHECK - CHECKPOINT 0: Setup Complete

**Before proceeding, confirm:**
- [ ] Directory structure created
- [ ] PCC eligibility criteria defined
- [ ] Seed literature reviewed and studies extracted
- [ ] Protocol draft ready for registration

**Present for review:**
1. PCC framework document
2. List of studies identified from seed reviews (with modality classification)
3. Draft protocol summary

**STOP and wait for approval to proceed to Phase 1.**

---

## PHASE 1: Systematic Search

### Task 1.1: Develop Search Strategy

Create comprehensive search strings for each database. Document in `search/search_strategy.md`.

**Core search concepts:**

| Concept | Search Terms |
|---------|-------------|
| Population | schizophrenia OR "schizophrenic disorder" OR schizoaffective OR schizophreniform OR psychosis OR psychotic |
| Exposure | smoking OR tobacco OR cigarette OR nicotine OR "tobacco use" |
| Outcome 1 | "structural MRI" OR sMRI OR "magnetic resonance imaging" OR "brain structure" OR "gray matter" OR "grey matter" OR "cortical thickness" OR VBM OR "voxel-based morphometry" OR "brain volume" |
| Outcome 2 (symptoms) | symptom* OR PANSS OR "positive symptom*" OR "negative symptom*" OR BPRS OR SAPS OR SANS |
| Outcome 3 (psych flex) | "psychological flexibility" OR "experiential avoidance" OR AAQ OR "acceptance and commitment" OR ACT |

**Search string template (PubMed):**
```
((schizophrenia[MeSH] OR schizophrenia[tiab] OR schizoaffective[tiab] OR psychotic disorder*[tiab])
AND
(smoking[MeSH] OR tobacco[tiab] OR cigarette*[tiab] OR nicotine[tiab])
AND
(magnetic resonance imaging[MeSH] OR "structural MRI"[tiab] OR "gray matter"[tiab] OR "grey matter"[tiab] OR "cortical thickness"[tiab] OR VBM[tiab] OR "brain volume"[tiab] OR "voxel-based morphometry"[tiab]))
```

**Databases to search:**
1. MEDLINE/PubMed
2. PsycINFO (via ProQuest or EBSCOhost)
3. Embase
4. CINAHL Complete
5. Web of Science
6. Cochrane Library

### Task 1.2: Psychological Flexibility Extension Search

**Separate search for psychological flexibility + brain structure:**
```
("psychological flexibility"[tiab] OR "experiential avoidance"[tiab] OR AAQ[tiab] OR "acceptance and commitment"[tiab])
AND
(schizophrenia[MeSH] OR schizophrenia[tiab] OR psychosis[tiab])
AND
(brain[tiab] OR neuroimaging[tiab] OR MRI[tiab] OR "magnetic resonance"[tiab])
```

**Expected results**: Very few (0-3 studies). This gap supports your primary study's contribution.

### Task 1.3: Execute Searches

For each database:
1. Run the search strategy
2. Export results to CSV/RIS
3. Document: Date, database, search string used, number of results
4. Save to `search/database_searches/`

### Task 1.4: Reference List Screening

Screen reference lists of:
1. All included studies (backward citation)
2. Koster et al. (2025) systematic review
3. Other relevant reviews

Document additional studies found in `search/handsearch_results.csv`

---

## STOP AND CHECK - CHECKPOINT 1: Search Complete

**Before proceeding, confirm:**
- [ ] Search strategies documented for all databases
- [ ] All database searches executed and saved
- [ ] Reference list screening completed
- [ ] Psychological flexibility extension search completed

**Present for review:**
1. Total records identified per database
2. Combined total before deduplication
3. Psychological flexibility search results (likely very few - document this gap)
4. Any search challenges or modifications needed

**STOP and wait for approval to proceed to Phase 2.**

---

## PHASE 2: Screening and Selection

### Task 2.1: Deduplication

1. Import all search results into reference manager (EndNote, Zotero, or Covidence)
2. Remove duplicates automatically
3. Manual check for remaining duplicates
4. Document: Total records after deduplication

Save deduplicated list to `screening/deduplicated_records.csv`

### Task 2.2: Title and Abstract Screening

Apply eligibility criteria to screen titles and abstracts:

**Quick exclusion criteria:**
- Not human subjects
- Not schizophrenia/schizoaffective/schizophreniform
- No neuroimaging
- fMRI/DTI/PET only (no structural MRI)
- Review/meta-analysis/protocol only
- Not smoking-related
- Pediatric/adolescent only
- Non-English

**Process:**
1. Screen independently (ideally 2 reviewers)
2. Resolve disagreements by discussion
3. When uncertain, include for full-text review

Document in `screening/title_abstract_screening.csv` with columns:
- ID, Authors, Year, Title, Include (Yes/No/Maybe), Reason if excluded, Screener

### Task 2.3: Full-Text Screening

For records passing title/abstract screening:
1. Obtain full texts
2. Apply full eligibility criteria
3. Document exclusion reasons

**Detailed exclusion reasons to track:**
1. Wrong population (not schizophrenia)
2. Wrong imaging modality (fMRI, DTI, PET only)
3. No smoking comparison (all smokers or all non-smokers)
4. No structural brain outcome reported
5. Duplicate dataset (same sample as another included study)
6. Unable to obtain full text
7. Not primary research
8. Other (specify)

Document in `screening/fulltext_screening.csv` and `screening/exclusion_reasons.csv`

### Task 2.4: Create PRISMA Flow Diagram

Create flow diagram showing:
- Records identified from databases (by source)
- Records identified from other sources
- Duplicates removed
- Records screened (title/abstract)
- Records excluded at screening
- Full-texts assessed
- Full-texts excluded (with reasons)
- Studies included in review

Save to `output/figures/PRISMA_flow_diagram.png`

---

## STOP AND CHECK - CHECKPOINT 2: Screening Complete

**Before proceeding, confirm:**
- [ ] Deduplication completed
- [ ] Title/abstract screening completed
- [ ] Full-text screening completed
- [ ] PRISMA flow diagram created
- [ ] All exclusion reasons documented

**Present for review:**
1. PRISMA flow diagram with numbers
2. List of included studies (citation + brief description)
3. Summary of exclusion reasons
4. Any studies where eligibility was uncertain

**STOP and wait for approval to proceed to Phase 3.**

---

## PHASE 3: Data Extraction

### Task 3.1: Finalize Data Extraction Form

Create standardized extraction form in `data_extraction/extraction_form.xlsx` with the following fields:

#### Sheet 1: Study Characteristics
| Field | Description |
|-------|-------------|
| Study_ID | Unique identifier |
| First_Author | Last name |
| Year | Publication year |
| Country | Study location |
| Study_Design | Cross-sectional, longitudinal, case-control |
| Sample_Size_Total | Total N |
| Sample_Size_SZ_Smokers | N schizophrenia smokers |
| Sample_Size_SZ_NonSmokers | N schizophrenia non-smokers |
| Sample_Size_HC_Smokers | N healthy control smokers (if applicable) |
| Sample_Size_HC_NonSmokers | N healthy control non-smokers (if applicable) |
| Funding | Funding source |

#### Sheet 2: Population Details
| Field | Description |
|-------|-------------|
| Study_ID | Link to Sheet 1 |
| Diagnosis_Criteria | DSM-IV, DSM-5, ICD-10, etc. |
| Diagnosis_Instrument | SCID, CASH, etc. |
| Age_Mean_SD | Mean age (SD) by group |
| Sex_Distribution | % male by group |
| Illness_Duration | Years since diagnosis |
| Medication_Status | Medicated, unmedicated, mixed |
| Medication_Type | Typical, atypical, both |
| Medication_Dose_CPZ | Chlorpromazine equivalents if reported |
| Exclusion_Criteria | Study-specific exclusions |

#### Sheet 3: Smoking Details
| Field | Description |
|-------|-------------|
| Study_ID | Link to Sheet 1 |
| Smoking_Definition | How smoker/non-smoker defined |
| Smoking_Duration_Years | Mean years smoking |
| Cigarettes_Per_Day | Mean CPD |
| Pack_Years | Mean pack-years |
| FTND_Score | Fagerström score if reported |
| Nicotine_Abstinence | Hours abstinent before scan |
| Former_Smokers_Included | Yes/No, how handled |

#### Sheet 4: Neuroimaging Details
| Field | Description |
|-------|-------------|
| Study_ID | Link to Sheet 1 |
| Scanner_Manufacturer | Siemens, GE, Philips |
| Scanner_Field_Strength | 1.5T, 3T |
| Sequence_Type | T1-MPRAGE, etc. |
| Analysis_Software | SPM, FSL, FreeSurfer, etc. |
| Analysis_Approach | VBM, ROI, surface-based |
| Whole_Brain_vs_ROI | Whole-brain, ROI, both |
| ROIs_Examined | List specific regions if ROI |
| Covariates_Adjusted | Age, sex, ICV, etc. |
| Multiple_Comparison_Correction | FWE, FDR, uncorrected, etc. |

#### Sheet 5: Outcomes - Brain Structure
| Field | Description |
|-------|-------------|
| Study_ID | Link to Sheet 1 |
| Outcome_Type | GM volume, cortical thickness, etc. |
| Brain_Region | Specific region |
| Comparison | SZ-S vs SZ-NS, etc. |
| Direction | Smokers > Non-smokers, Smokers < Non-smokers, No difference |
| Effect_Size | If reported (Cohen's d, etc.) |
| Statistical_Value | t, F, z value |
| P_Value | Significance level |
| Coordinates_MNI | Peak coordinates if reported |

#### Sheet 6: Outcomes - Symptom Correlations
| Field | Description |
|-------|-------------|
| Study_ID | Link to Sheet 1 |
| Symptom_Scale | PANSS, BPRS, etc. |
| Symptom_Subscale | Positive, Negative, General, Total |
| Brain_Region | Region correlated |
| Correlation_Type | Pearson, Spearman, partial |
| Correlation_Coefficient | r value |
| P_Value | Significance |
| Sample_For_Correlation | Which group(s) |
| Direction | Positive, Negative, None |

#### Sheet 7: Psychological Flexibility (if reported)
| Field | Description |
|-------|-------------|
| Study_ID | Link to Sheet 1 |
| PF_Measure | AAQ-II, other |
| PF_Score_Smokers | Mean (SD) |
| PF_Score_NonSmokers | Mean (SD) |
| PF_Brain_Correlation | Any brain-PF correlations |
| PF_Symptom_Correlation | Any symptom-PF correlations |

### Task 3.2: Pilot Extraction

1. Select 3 diverse studies for pilot extraction
2. Both reviewers extract independently
3. Compare and resolve discrepancies
4. Refine extraction form if needed

### Task 3.3: Full Data Extraction

1. Extract data from all included studies
2. Contact authors for missing data if critical
3. Document any assumptions or decisions in `data_extraction/extraction_notes.md`

### Task 3.4: Data Verification

1. Second reviewer verifies 20% of extractions
2. Calculate agreement rate
3. Resolve any discrepancies

---

## STOP AND CHECK - CHECKPOINT 3: Data Extraction Complete

**Before proceeding, confirm:**
- [ ] Extraction form finalized
- [ ] Pilot extraction completed
- [ ] All studies extracted
- [ ] Verification completed
- [ ] Extraction decisions documented

**Present for review:**
1. Completed extraction spreadsheet
2. Summary statistics (N studies by design, country, year)
3. Any missing data or concerns
4. Studies that reported symptom correlations
5. Studies that reported psychological flexibility (likely none)

**STOP and wait for approval to proceed to Phase 4.**

---

## PHASE 4: Evidence Synthesis

### Task 4.1: Descriptive Summary

Create summary tables in `synthesis/evidence_tables.md`:

**Table 1: Study Characteristics**
- Author, Year, Country, Design, Sample sizes, Scanner

**Table 2: Participant Characteristics**
- Demographics, diagnosis criteria, illness duration, medication

**Table 3: Smoking Characteristics**
- Definition, duration, CPD, pack-years, FTND

**Table 4: Neuroimaging Methods**
- Scanner, software, approach, covariates

### Task 4.2: Narrative Synthesis - Brain Structure Findings

Organize findings by:

**4.2.1 By Brain Region:**
- Prefrontal cortex (DLPFC, OFC, ACC)
- Temporal cortex (STG, MTG)
- Parietal cortex
- Insular cortex
- Subcortical structures (hippocampus, amygdala, basal ganglia, thalamus)
- Cerebellum
- Global measures (total GM, WM, brain volume)

**4.2.2 By Comparison Type:**
- SZ smokers vs. SZ non-smokers
- SZ smokers vs. HC smokers
- SZ smokers vs. HC non-smokers
- Interaction effects (smoking × diagnosis)

**4.2.3 By Outcome Measure:**
- Gray matter volume
- Cortical thickness
- Surface area
- Other structural measures

### Task 4.3: Narrative Synthesis - Symptom Severity Correlations

**Key questions:**
1. Do studies report correlations between brain structure and symptoms?
2. Are these correlations examined separately for smokers vs. non-smokers?
3. What patterns emerge (positive symptoms, negative symptoms)?
4. Are there brain regions consistently linked to symptoms in smokers?

Create table: Region × Symptom type × Direction of correlation × N studies

### Task 4.4: Psychological Flexibility Gap Analysis

Document:
1. How many studies mentioned psychological flexibility? (Expected: 0)
2. How many measured AAQ-II or similar? (Expected: 0-1)
3. What is the evidence gap?
4. How does this support your primary study's contribution?

### Task 4.5: Research Gap Identification

Create `synthesis/gap_analysis.md` identifying:

1. **Methodological gaps:**
   - Sample size limitations
   - Cross-sectional vs. longitudinal
   - Confounders not controlled
   - Heterogeneous smoking definitions

2. **Content gaps:**
   - Brain regions understudied
   - Symptom correlations not examined
   - Psychological flexibility not addressed
   - Intervention implications not explored

3. **Population gaps:**
   - Geographic representation
   - Sex differences
   - Illness stage
   - Medication effects

---

## STOP AND CHECK - CHECKPOINT 4: Synthesis Complete

**Before proceeding, confirm:**
- [ ] All summary tables created
- [ ] Narrative synthesis completed by region and comparison
- [ ] Symptom correlation synthesis completed
- [ ] Psychological flexibility gap documented
- [ ] Research gaps identified

**Present for review:**
1. Summary tables
2. Key findings by brain region
3. Symptom correlation summary
4. Gap analysis highlighting opportunities for primary study

**STOP and wait for approval to proceed to Phase 5.**

---

## PHASE 5: Manuscript Preparation

### Task 5.1: Abstract (250-300 words structured)

**Background**: Brief context on smoking in schizophrenia, brain effects, gap in symptom correlation literature

**Objectives**: State the 3-4 research questions

**Methods**: JBI scoping review methodology, databases searched, eligibility criteria

**Results**: N studies included, key structural findings, symptom correlation findings, psychological flexibility gap

**Conclusions**: Main message, implications for research and practice

### Task 5.2: Introduction (~1500 words)

Structure:
1. **Opening**: Smoking prevalence in schizophrenia, health burden
2. **Brain effects**: What's known about smoking and brain structure generally
3. **Schizophrenia context**: Existing evidence on brain alterations in SZ smokers
4. **Gap 1**: Symptom severity correlations not systematically reviewed
5. **Gap 2**: Psychological flexibility not addressed
6. **Rationale**: Why scoping review (heterogeneous methods, mapping needed)
7. **Objectives**: State research questions

### Task 5.3: Methods (~1500 words)

Follow PRISMA-ScR checklist:
1. **Protocol and registration**: OSF registration details
2. **Eligibility criteria**: PCC framework
3. **Information sources**: Databases, date range, other sources
4. **Search**: Reference search strategy document
5. **Selection of sources**: Screening process, software used
6. **Data charting**: Extraction form description
7. **Synthesis**: Narrative synthesis approach

### Task 5.4: Results (~2500 words)

1. **Search results**: PRISMA flow diagram, numbers
2. **Study characteristics**: Summary table, narrative description
3. **Participant characteristics**: Demographics, clinical features
4. **Smoking characteristics**: Definitions, severity measures
5. **Neuroimaging methods**: Scanners, analysis approaches
6. **Brain structure findings**:
   - By region (organized subsections)
   - By comparison type
   - Consistency across studies
7. **Symptom severity correlations**:
   - Which studies examined
   - Findings by symptom type
   - Patterns identified
8. **Psychological flexibility**: Gap statement

### Task 5.5: Discussion (~1500 words)

1. **Summary of findings**: Key messages
2. **Comparison to Koster 2025**: What we add
3. **Clinical implications**:
   - Brain regions as potential biomarkers
   - Symptom-structure relationships
   - Implications for smoking cessation interventions
4. **Research implications**:
   - Need for psychological flexibility studies
   - Methodological recommendations
   - Future directions (your primary study)
5. **Limitations**: Of included studies and of this review
6. **Conclusions**: Bottom line

### Task 5.6: Tables and Figures

**Required:**
1. PRISMA-ScR flow diagram
2. Table 1: Study characteristics
3. Table 2: Participant and smoking characteristics
4. Table 3: Neuroimaging methods
5. Table 4: Brain structure findings summary
6. Table 5: Symptom correlation findings (if sufficient data)

**Optional:**
- Figure: Brain regions implicated (schematic)
- Supplementary tables with full extraction data

### Task 5.7: References

- Use consistent citation format (APA 7th or journal-specific)
- Verify all citations
- Include PRISMA-ScR statement citation
- Include JBI methodology citation

---

## STOP AND CHECK - CHECKPOINT 5: Manuscript Draft Complete

**Before proceeding, confirm:**
- [ ] All sections drafted
- [ ] Tables and figures created
- [ ] PRISMA-ScR checklist completed
- [ ] References verified

**Present for review:**
1. Complete manuscript draft
2. All tables and figures
3. PRISMA-ScR checklist
4. Target journal recommendation

**STOP and wait for approval to proceed to Phase 6.**

---

## PHASE 6: Finalization and Submission

### Task 6.1: Internal Review

1. All authors review complete draft
2. Check for consistency across sections
3. Verify all numbers match PRISMA diagram
4. Ensure tables match text

### Task 6.2: PRISMA-ScR Compliance Check

Complete PRISMA-ScR checklist item by item:
- Title (Item 1)
- Abstract (Items 2)
- Introduction (Items 3-4)
- Methods (Items 5-11)
- Results (Items 12-17)
- Discussion (Items 18-20)
- Funding (Item 21)

### Task 6.3: Prepare Supplementary Materials

1. Full search strategies for each database
2. List of excluded studies with reasons
3. Complete data extraction spreadsheet
4. PRISMA-ScR checklist

### Task 6.4: Journal Selection and Formatting

Recommended journals:
- Schizophrenia Bulletin (where Koster published)
- Schizophrenia Research
- Psychological Medicine
- Psychiatry Research: Neuroimaging
- Journal of Psychiatric Research

Format according to target journal guidelines.

### Task 6.5: Final Submission Package

Prepare:
- Cover letter
- Title page
- Main manuscript (anonymized if required)
- Tables
- Figures
- Supplementary materials
- Author contributions statement
- Conflict of interest declarations
- Data availability statement

---

## FINAL CHECKPOINT: Project Complete

**Confirm all deliverables:**
- [ ] Registered protocol (OSF)
- [ ] Complete manuscript
- [ ] All supplementary materials
- [ ] PRISMA-ScR checklist
- [ ] Submission package ready

**Present final deliverables for review.**

---

## Appendix A: Quality Standards

### Methodological Standards
- Follow JBI scoping review methodology
- Complete PRISMA-ScR checklist
- Document all decisions transparently
- Use standardized extraction form

### Reporting Standards
- Report exact search strings reproducibly
- Report all screening numbers
- Document exclusion reasons
- Present findings narratively (no meta-analysis in scoping review)

### Differentiation Standards
- Clearly state how this differs from Koster 2025
- Emphasize symptom severity correlation focus
- Highlight psychological flexibility gap
- Connect to clinical/intervention implications

---

## Appendix B: Key References

### Methodology
- Peters MDJ, et al. (2020). Updated methodological guidance for the conduct of scoping reviews. JBI Evidence Synthesis.
- Tricco AC, et al. (2018). PRISMA Extension for Scoping Reviews (PRISMA-ScR): Checklist and Explanation. Annals of Internal Medicine.

### Comparator Review
- Koster M, et al. (2025). The Association Between Chronic Tobacco Smoking and Brain Alterations in Schizophrenia: A Systematic Review of Magnetic Resonance Imaging Studies. Schizophrenia Bulletin, 51(3), 608-624.

### Background
- Šagud M, et al. (2018). Smoking in Schizophrenia: an Updated Review. Psychiatria Danubina.
- de Leon J & Diaz FJ (2005). A meta-analysis of worldwide studies demonstrates an association between schizophrenia and tobacco smoking behaviors. Schizophrenia Research.

---

## Appendix C: Studies to Include from Seed Literature

Based on initial review, the following sMRI studies from Koster et al. (2025) and other sources should be assessed for inclusion:

| Study | Modality | Include? |
|-------|----------|----------|
| Tregellas et al. (2007) | sMRI (VBM) | Yes |
| Van Haren et al. (2010) | sMRI (volumes) | Yes |
| Zhang et al. (2010) | DTI | No - DTI |
| Welch et al. (2011) | sMRI (volumes) | No - CHR |
| Stone et al. (2012) | sMRI (VBM) | No - CHR |
| Cullen et al. (2012) | DTI | No - DTI |
| Schneider et al. (2014) | sMRI (VBM) | Yes |
| Jørgensen et al. (2015) | sMRI (CT) | Yes |
| Yokoyama et al. (2018) | sMRI (VBM) | Yes |
| Ringin et al. (2022) | sMRI | Yes |
| Koster et al. (2025) | sMRI | Yes - if primary data |
| Musket et al. (2026) | sMRI (hippo) | Yes |
| Qiu et al. (2024) | Multimodal | Check if sMRI reported separately |

**To be determined after full-text review.**

---

## Appendix D: Psychological Flexibility - Expected Gap

Based on preliminary searches, **no studies** have been identified that examine:
- Psychological flexibility (AAQ-II) in schizophrenia patients who smoke
- Brain structure correlations with psychological flexibility in this population
- ACT intervention effects on brain structure in smoking schizophrenia patients

**This gap directly supports the contribution of your planned primary study** examining ACT for smoking cessation in schizophrenia using fMRI (your funded project: Grant Code 1-BBCL).

The scoping review will formally document this gap and establish the rationale for future research integrating psychological flexibility into neuroimaging studies of smoking in schizophrenia.
