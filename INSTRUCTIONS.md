# AI-Generated Academic Paper: Replicating and Extending "Universal Vote-by-Mail Has No Impact on Partisan Turnout or Vote Share"

## Project Overview

You are tasked with producing a complete academic political science paper by replicating and extending Thompson, Wu, Yoder, and Hall (2020), published in PNAS. The original paper used a difference-in-differences design to estimate the causal effects of universal vote-by-mail (VBM) on partisan electoral outcomes, finding null partisan effects and a modest (~2 percentage point) increase in overall turnout.

**Your task**: 
1. Replicate the original findings using the authors' published replication data and code
2. Extend the analysis by collecting new data for the same three states (California, Utah, Washington) through 2024
3. Test whether the null partisan findings hold in the post-COVID era

**Original paper**: https://www.pnas.org/doi/10.1073/pnas.2007249117  
**Original replication materials**: https://github.com/stanford-dpl/vbm

---

## IMPORTANT: Stop-and-Check Points

Throughout this project, there are mandatory **STOP AND CHECK** points marked with 🛑. At each of these points, you must:
1. Summarize what you have completed
2. Present key outputs for review
3. List any issues or concerns
4. **Wait for human approval before proceeding**

Do not proceed past a 🛑 checkpoint without explicit approval.

---

## PHASE 0: Project Setup and Original Materials

### Task 0.1: Create Project Structure

Create the following directory structure:

```
vbm_replication/
├── README.md
├── INSTRUCTIONS.md
├── requirements.txt
├── original/                    # Original paper materials
│   ├── code/
│   ├── data/
│   │   ├── raw/
│   │   └── modified/
│   └── paper/
├── code/                        # Your analysis code
├── data/
│   ├── raw/                     # Downloaded data
│   ├── processed/               # Cleaned datasets
│   └── extension/               # New 2020-2024 data
├── notes/                       # Documentation
├── output/
│   ├── tables/
│   ├── figures/
│   └── paper/
└── logs/
```

### Task 0.2: Download Original Replication Materials

Clone or download the original replication repository:
```
https://github.com/stanford-dpl/vbm
```

This repository contains:
- **code/**: Stata .do files with the original analysis
- **original data/**: Raw data sources
- **modified data/**: Cleaned analysis datasets

Save these to the `original/` directory in your project.

### Task 0.3: Examine Original Code and Data

Carefully review the original materials:

1. **Identify the main analysis script**: Look for the .do file that produces Tables 2 and 3
2. **Understand the data structure**: Examine the modified/analysis datasets
3. **Document variable definitions**: What is each variable and how is it constructed?
4. **Note the Stata commands used**: What regression commands, options, and packages?

Create `notes/original_materials_review.md` documenting:
- File inventory (what's in each folder)
- Main analysis workflow
- Key variable definitions from the data
- Stata commands that need Python equivalents

### Task 0.4: Translate Stata to Python (Conceptually)

The original code is in Stata. You will work in Python. Document the key translations needed:

| Stata Command | Python Equivalent | Notes |
|--------------|-------------------|-------|
| `reghdfe` | `linearmodels.PanelOLS` or `statsmodels` | High-dimensional fixed effects |
| `cluster()` | Clustered standard errors option | Must specify clustering |
| `absorb()` | Entity/time effects in panel model | Fixed effects |

Note: You may discover additional packages are needed. Install as necessary but document all dependencies.

---

## 🛑 CHECKPOINT 0: Project Setup Complete

**Before proceeding, confirm:**
- [ ] Project directory structure created
- [ ] Original replication materials downloaded
- [ ] Original code reviewed and documented
- [ ] Data files inventory complete
- [ ] Key Stata-to-Python translations identified

**Present for review:**
1. Contents of `notes/original_materials_review.md`
2. List of original data files and their dimensions (rows × columns)
3. Any issues accessing the original materials

**STOP and wait for approval to proceed to Phase 1.**

---

## PHASE 1: Literature Review and Background Research

### Task 1.1: Summarize the Original Paper

Read the original paper carefully. Create `notes/original_paper_summary.md` containing:

**1. Research Question**
- What causal question does the paper address?
- Why does it matter (policy relevance)?

**2. Identification Strategy**
- What is the source of variation?
- What is the key identifying assumption?
- Why is the staggered county-level rollout valuable?

**3. Data**
- What three states are included and why?
- What is the time period covered?
- What are the key outcome variables?
- What is the unit of analysis?

**4. Main Specifications**
Write out the estimating equation:
```
Y_cst = β(VBM_cst) + γ_cs + δ_st + ε_cst
```
Explain each term.

**5. Key Findings**
Document the main results from Tables 2 and 3:

*Table 2 - Partisan Outcomes:*
| Outcome | Basic | Linear Trends | Quad Trends |
|---------|-------|---------------|-------------|
| Dem turnout share | 0.007 (0.003) | 0.001 (0.001) | 0.001 (0.001) |
| Dem vote share | 0.028 (0.011) | 0.011 (0.004) | 0.007 (0.003) |

*Table 3 - Participation Outcomes:*
| Outcome | Basic | Linear Trends | Quad Trends |
|---------|-------|---------------|-------------|
| Turnout | 0.021 (0.009) | 0.022 (0.007) | 0.021 (0.008) |
| VBM share | 0.186 (0.027) | 0.157 (0.035) | 0.136 (0.085) |

**6. Robustness Checks**
- What additional analyses do they perform?
- State-by-state results?
- Event study specifications?

### Task 1.2: Literature Review

Search for and summarize the relevant literature. For **each paper you cite**, you must:
1. Search for the paper to verify it exists
2. Find the actual publication details (journal, year, volume, pages)
3. Read at least the abstract and results

**Required papers to find and summarize:**

*Foundational VBM studies:*
- Gerber, Huber, and Hill (2013) - Washington State VBM analysis
- Kousser and Mullin (2007) - VBM and participation
- Southwell and Burchett (2000) - All-mail elections
- Gronke et al. (2008) - Convenience voting review
- Berinsky, Burns, and Traugott (2001) - Who votes by mail

*Post-2020 studies (search for these):*
- Any papers examining VBM effects during/after COVID-19
- Studies of the 2020 election and mail voting

*Methodological papers on staggered diff-in-diff:*
- Goodman-Bacon (2021) - Difference-in-differences with variation in treatment timing
- Callaway and Sant'Anna (2021) - Difference-in-differences with multiple time periods
- Sun and Abraham (2021) - Event study estimation

Create `notes/literature_review.md` with a summary table:

| Authors | Year | Journal | Topic | Key Finding | Verified? |
|---------|------|---------|-------|-------------|-----------|
| ... | ... | ... | ... | ... | Yes/No |

**CRITICAL**: Mark each paper as "Verified" only if you confirmed it exists. If you cannot verify a paper, do not include it.

### Task 1.3: Document the Extension Rationale

Create `notes/extension_rationale.md` explaining:

1. **What changed after 2018?**
   - COVID-19 pandemic and emergency VBM expansion
   - VBM becoming a partisan issue
   - Continued California Voter's Choice Act rollout

2. **What new variation exists?**
   - California: Additional counties adopted VCA for 2020, 2022, 2024
   - Utah and Washington: Already 100% VBM by 2019-2020, limited new variation
   - The extension will primarily test California's continued rollout

3. **Research questions for the extension:**
   - Do the null partisan effects hold in the post-COVID period?
   - Is there evidence of heterogeneous effects by time period?
   - Do event study patterns look similar pre- and post-2018?

4. **Limitations to acknowledge:**
   - Less new variation than original paper (most states fully adopted)
   - Post-2020 period may have different dynamics
   - Cannot separate VBM effects from COVID effects in 2020

---

## 🛑 CHECKPOINT 1: Literature Review Complete

**Before proceeding, confirm:**
- [ ] Original paper thoroughly summarized
- [ ] Literature review completed with verified citations
- [ ] Extension rationale documented
- [ ] All papers cited have been verified to exist

**Present for review:**
1. Contents of `notes/original_paper_summary.md`
2. Literature review table with verification status
3. Extension rationale summary

**STOP and wait for approval to proceed to Phase 2.**

---

## PHASE 2: Replication with Original Data

Before collecting new data, first replicate the original results using the original data. This ensures your code is correct before introducing new data.

### Task 2.1: Load and Examine Original Data

Load the analysis datasets from the original replication materials. For each dataset:

1. Print dimensions (rows × columns)
2. List all variable names
3. Show summary statistics
4. Check for missing values
5. Verify the data matches what the paper describes

Create `notes/original_data_examination.md` documenting what you find.

### Task 2.2: Replicate Table 2 (Partisan Outcomes)

Using the original data, replicate Table 2 from the paper.

**Specification 1: Basic diff-in-diff**
```python
# Outcome: Democratic turnout share (or Democratic vote share)
# Model: Y_cst = β(VBM_cst) + county_FE + state_year_FE + ε_cst
# Cluster standard errors at county level
```

**Specification 2: With linear county trends**
```python
# Add county-specific linear time trends
```

**Specification 3: With quadratic county trends**
```python
# Add county-specific quadratic time trends
```

**Outcomes to estimate:**
1. Democratic share of turnout (columns 1-3)
2. Democratic two-party vote share (columns 4-6)

Save results to `output/tables/table2_replication.csv`

### Task 2.3: Replicate Table 3 (Participation Outcomes)

Using the same approach, replicate Table 3.

**Outcomes:**
1. Turnout (ballots cast / CVAP)
2. VBM share (share of votes cast by mail)

Save results to `output/tables/table3_replication.csv`

### Task 2.4: Compare Replication to Original

Create a comparison table showing:

| Outcome | Specification | Original | Replicated | Difference |
|---------|--------------|----------|------------|------------|
| Dem turnout share | Basic | 0.007 | ??? | ??? |
| ... | ... | ... | ... | ... |

If differences exceed 10% of the original estimate, investigate:
- Data differences?
- Specification differences?
- Package/computation differences?

Document any discrepancies in `notes/replication_comparison.md`.

---

## 🛑 CHECKPOINT 2: Replication Complete

**Before proceeding, confirm:**
- [ ] Table 2 replicated
- [ ] Table 3 replicated
- [ ] Results compared to original
- [ ] Any discrepancies documented and explained

**Present for review:**
1. Replication comparison table
2. Any issues or discrepancies found
3. Your code for the main regressions

**STOP and wait for approval to proceed to Phase 3.**

---

## PHASE 3: Extension Data Collection

Now collect new data to extend the analysis through 2024.

### Task 3.1: Identify Data Needs

For the extension, you need to collect **new years of data for the same counties**:

**California** (58 counties):
- Elections: 2020 gubernatorial recall, 2022 gubernatorial, 2024 presidential
- VBM adoption: Which additional counties adopted VCA after 2018?
- California is the key state for the extension (still has variation)

**Utah** (29 counties):
- Elections: 2020 presidential, 2022 senatorial, 2024 presidential
- VBM adoption: By 2019, all counties were VBM (no new variation)

**Washington** (39 counties):
- Elections: 2020 presidential, 2022 senatorial, 2024 presidential  
- VBM adoption: 100% VBM since 2011 (no new variation)

**Data to collect for each county-election:**
1. Total votes cast
2. Democratic votes
3. Republican votes
4. CVAP (Citizen Voting Age Population) - use 2020 Census/ACS data

### Task 3.2: Collect California Extension Data

**VBM Adoption (Critical!):**

Research which California counties have adopted the Voter's Choice Act:
- 2018: 5 counties (Madera, Napa, Nevada, Sacramento, San Mateo)
- 2020: Additional counties joined
- 2022: More counties joined
- 2024: Current status

Source: California Secretary of State VCA page
https://www.sos.ca.gov/elections/voters-choice-act/

Create `data/extension/california_vbm_adoption.csv`:
```
county,vca_first_year,source,verified
Madera,2018,CA SOS,Yes
Napa,2018,CA SOS,Yes
...
```

**Election Results:**

Collect county-level results from California Secretary of State:
https://www.sos.ca.gov/elections/prior-elections/

For each election, save to `data/extension/california_results_{year}.csv`

### Task 3.3: Collect Utah Extension Data

Utah has been 100% vote-by-mail since 2019, so there's no new VBM variation. However, collect election results for consistency:

Source: Utah Lieutenant Governor / Elections
https://voteinfo.utah.gov/

### Task 3.4: Collect Washington Extension Data

Washington has been 100% vote-by-mail since 2011, so there's no new VBM variation. Collect election results:

Source: Washington Secretary of State
https://www.sos.wa.gov/elections/research/

### Task 3.5: Collect CVAP Data

Get updated Citizen Voting Age Population data from Census:
https://www.census.gov/programs-surveys/decennial-census/about/voting-rights/cvap.html

Use 2020 Census-based estimates for 2020-2024 elections.

### Task 3.6: Data Validation

Before proceeding, validate all collected data:

1. **County coverage**: Do you have all 58 CA + 29 UT + 39 WA = 126 counties?
2. **Year coverage**: Data for 2020, 2022, 2024 elections?
3. **Vote totals**: Do they seem reasonable? Compare to known state totals.
4. **VBM coding**: Double-check California VCA adoption dates against multiple sources.

Create `notes/extension_data_validation.md` documenting all checks.

---

## 🛑 CHECKPOINT 3: Extension Data Collected

**Before proceeding, confirm:**
- [ ] California VBM adoption dates verified
- [ ] Election results collected for 2020-2024
- [ ] CVAP data obtained
- [ ] Data validation complete

**Present for review:**
1. List of data files created
2. Summary of California VCA adoption (which counties, which years)
3. Any data collection issues or gaps
4. Validation check results

**STOP and wait for approval to proceed to Phase 4.**

---

## PHASE 4: Merge and Prepare Extension Dataset

### Task 4.1: Standardize Variable Names

Ensure extension data uses the same variable names as original:
- `state`
- `county` 
- `year`
- `vbm` (=1 if universal VBM in effect)
- `dem_votes`
- `rep_votes`
- `total_votes`
- `cvap`

### Task 4.2: Construct Analysis Variables

```python
# Two-party Democratic vote share
dem_voteshare = dem_votes / (dem_votes + rep_votes)

# Turnout rate
turnout = total_votes / cvap

# VBM indicator
vbm = 1 if year >= vbm_first_year else 0
```

### Task 4.3: Append Extension to Original Data

Create a combined dataset:
1. Load original analysis data (1996-2018)
2. Append extension data (2020-2024)
3. Create indicator for post-2018 period

Save as `data/processed/full_analysis_data.csv`

### Task 4.4: Summary Statistics for Extended Sample

Create summary statistics table showing:
- N observations by state and period (1996-2018 vs 2020-2024)
- Mean and SD of outcomes by period
- Number of treated (VBM=1) observations by state-period

Save as `output/tables/summary_stats_extended.csv`

---

## 🛑 CHECKPOINT 4: Extension Dataset Ready

**Before proceeding, confirm:**
- [ ] Extension data merged with original
- [ ] Variables constructed correctly
- [ ] Summary statistics computed
- [ ] No unexpected missing values or outliers

**Present for review:**
1. Dataset dimensions (total N, N by state, N by period)
2. Summary statistics table
3. Any data quality concerns

**STOP and wait for approval to proceed to Phase 5.**

---

## PHASE 5: Extension Analysis

### Task 5.1: Main Results with Extended Data

Re-estimate the main specifications using the full 1996-2024 sample.

**Replicate Table 2 and Table 3 specifications** with extended data.

Compare results:
| Outcome | Period | Basic | Linear Trends | Quad Trends |
|---------|--------|-------|---------------|-------------|
| Dem vote share | 1996-2018 (orig) | ... | ... | ... |
| Dem vote share | 1996-2024 (extended) | ... | ... | ... |

### Task 5.2: Test for Heterogeneous Effects by Period

Estimate models with interaction terms:

```python
# Does VBM effect differ post-2018?
Y_cst = β1(VBM_cst) + β2(VBM_cst × Post2018_t) + β3(Post2018_t) + γ_cs + δ_st + ε_cst
```

The coefficient β2 tests whether the VBM effect changed after 2018.

### Task 5.3: Separate Estimates by Period

Estimate the main specification separately for:
1. 1996-2018 (original period)
2. 2020-2024 (extension period)

Note: The extension period has much less variation (mainly California VCA expansion).

### Task 5.4: California-Specific Analysis

Since California provides most of the new variation, estimate:
1. California-only models for 2018-2024
2. Event study around VCA adoption for California counties

### Task 5.5: Event Study Specification

Estimate an event study model (if sufficient data):

```python
# Relative time to VBM adoption
# k = years since adoption (negative = pre-adoption)
Y_cst = Σ_k β_k × 1(t - adoption_year = k) + γ_cs + δ_st + ε_cst
```

Create event study plot showing:
- Point estimates by relative year
- 95% confidence intervals
- Clear marking of pre- vs post-adoption periods

### Task 5.6: Robustness Checks

1. **Alternative specifications**: Different fixed effects structures
2. **Dropping 2020**: Test sensitivity to the COVID election year
3. **Placebo tests**: If applicable

---

## 🛑 CHECKPOINT 5: Extension Analysis Complete

**Before proceeding, confirm:**
- [ ] Main results with extended data
- [ ] Heterogeneity by period tested
- [ ] California-specific analysis done
- [ ] Event study estimated (if feasible)
- [ ] Robustness checks completed

**Present for review:**
1. Main results tables comparing original vs. extended
2. Heterogeneity tests (interaction terms)
3. Event study figure
4. Key findings summary

**STOP and wait for approval to proceed to Phase 6.**

---

## PHASE 6: Paper Writing

### Task 6.1: Abstract (150-200 words)

Write an abstract that:
- States the research question
- Describes the data and method (diff-in-diff, three states, 1996-2024)
- Summarizes findings (replication confirms null, extension shows...)
- Notes limitations and implications

### Task 6.2: Introduction (~1500 words)

Structure:
1. **Hook**: Policy relevance of VBM, especially post-COVID
2. **Research question**: Does universal VBM affect partisan outcomes?
3. **Approach**: Replicate Thompson et al. (2020), extend to 2024
4. **Findings**: Preview your results
5. **Contribution**: What this adds (post-COVID test, methodological exercise)
6. **Roadmap**: Paper structure

### Task 6.3: Background (~1500 words)

Cover:
1. **VBM policy landscape**: What is universal VBM? Which states use it?
2. **Theoretical expectations**: Why might VBM affect partisan outcomes? Why might it not?
3. **Prior evidence**: Summarize literature from Phase 1
4. **Post-COVID context**: How 2020 changed the debate

### Task 6.4: Data (~1500 words)

Describe:
1. **Original data**: Thompson et al. replication materials
2. **Extension data**: New years collected for CA, UT, WA
3. **VBM adoption coding**: How treatment is defined (especially California VCA)
4. **Variable definitions**: Each variable clearly defined
5. **Summary statistics**: Reference the summary stats table

### Task 6.5: Empirical Strategy (~1500 words)

Explain:
1. **Difference-in-differences design**: Intuition and formal setup
2. **Estimating equation**: Present with notation explained
3. **Identifying assumption**: Parallel trends
4. **Threats to identification**: What could bias results?
5. **Extension considerations**: Less new variation, COVID confounds

### Task 6.6: Results (~2500 words)

Present:
1. **Replication results**: Do you replicate the original findings?
2. **Extended main results**: Full sample estimates
3. **Period heterogeneity**: Do effects differ post-2018?
4. **California analysis**: Focus on where variation exists
5. **Event study**: Visual evidence on dynamics
6. **Robustness**: Sensitivity checks

For each result:
- State the point estimate and confidence interval
- Interpret the magnitude
- Compare to original paper findings

### Task 6.7: Discussion and Conclusion (~1000 words)

Address:
1. **Summary**: What did you find?
2. **Interpretation**: What do results mean for the VBM debate?
3. **Limitations**: What can't you conclude?
4. **Implications**: For policy, for future research
5. **Conclusion**: Bottom line message

### Task 6.8: Tables and Figures

**Required tables:**
1. Summary statistics (original and extension periods)
2. Main results - replication of Table 2
3. Main results - replication of Table 3
4. Extended sample results
5. Period heterogeneity tests

**Required figures:**
1. Map or timeline of VBM adoption
2. Event study plot (if estimated)
3. Comparison of original vs. replicated estimates

### Task 6.9: References

Create bibliography with **only verified citations**.

Use consistent format (e.g., APSA style):
```
Gerber, Alan S., Gregory A. Huber, and Seth J. Hill. 2013. "Identifying the Effect of All-Mail Elections on Turnout: Staggered Reform in the Evergreen State." Political Science Research and Methods 1(1): 91-116.
```

---

## 🛑 CHECKPOINT 6: Paper Draft Complete

**Before proceeding, confirm:**
- [ ] All sections written
- [ ] Tables and figures created
- [ ] References verified
- [ ] Paper is coherent and complete

**Present for review:**
1. Complete paper draft
2. All tables and figures
3. Bibliography

**STOP and wait for approval to proceed to Phase 7.**

---

## PHASE 7: Code Organization and Final Deliverables

### Task 7.1: Organize Analysis Code

Structure code files:
```
code/
├── 00_setup.py              # Package imports, paths
├── 01_examine_original.py   # Review original data
├── 02_replicate.py          # Replication analysis
├── 03_collect_extension.py  # Extension data collection
├── 04_prepare_data.py       # Merge and clean
├── 05_extension_analysis.py # Extension results
├── 06_figures.py            # Create figures
├── 07_tables.py             # Format tables
└── utils.py                 # Helper functions
```

### Task 7.2: Create Requirements File

```
# requirements.txt
pandas>=1.3.0
numpy>=1.20.0
statsmodels>=0.12.0
matplotlib>=3.4.0
seaborn>=0.11.0
requests>=2.25.0
# Add any additional packages used
```

### Task 7.3: Documentation

Create `README.md` explaining:
- Project overview
- How to reproduce results
- Data sources
- File structure

### Task 7.4: Final Validation

Run full pipeline from scratch:
1. Start with original replication data
2. Run all code sequentially  
3. Verify outputs match what's in paper

---

## 🛑 FINAL CHECKPOINT: Project Complete

**Confirm all deliverables:**
- [ ] Complete paper (Markdown or PDF)
- [ ] All analysis code
- [ ] All data files (or download instructions)
- [ ] Documentation
- [ ] Requirements file

**Present final deliverables for review.**

---

## Appendix: Original Paper Key Results (Reference)

### Table 2: Partisan Outcomes

| | Dem Turnout Share | | | Dem Vote Share | | |
|---|---|---|---|---|---|---|
| | (1) | (2) | (3) | (4) | (5) | (6) |
| VBM | 0.007 | 0.001 | 0.001 | 0.028 | 0.011 | 0.007 |
| SE | (0.003) | (0.001) | (0.001) | (0.011) | (0.004) | (0.003) |
| Counties | 87 | 87 | 87 | 126 | 126 | 126 |
| County FE | Yes | Yes | Yes | Yes | Yes | Yes |
| State×Year FE | Yes | Yes | Yes | Yes | Yes | Yes |
| County trends | No | Linear | Quad | No | Linear | Quad |

### Table 3: Participation Outcomes

| | Turnout | | | VBM Share | | |
|---|---|---|---|---|---|---|
| | (1) | (2) | (3) | (4) | (5) | (6) |
| VBM | 0.021 | 0.022 | 0.021 | 0.186 | 0.157 | 0.136 |
| SE | (0.009) | (0.007) | (0.008) | (0.027) | (0.035) | (0.085) |
| Counties | 126 | 126 | 126 | 58 | 58 | 58 |
| County FE | Yes | Yes | Yes | Yes | Yes | Yes |
| State×Year FE | Yes | Yes | Yes | Yes | Yes | Yes |
| County trends | No | Linear | Quad | No | Linear | Quad |

---

## Quality Standards Reminder

### Statistical Standards
- Report point estimates with standard errors AND confidence intervals
- Cluster standard errors at county level
- Interpret null results correctly ("cannot reject null" ≠ "no effect")

### Writing Standards  
- Clear, active prose
- Define all variables and acronyms
- Appropriate hedging on causal claims

### Reproducibility Standards
- All results reproducible from code
- No manual steps
- Seeds set for any stochastic elements

### Citation Standards
- Every cited paper must be verified to exist
- No hallucinated citations
- Consistent citation format
