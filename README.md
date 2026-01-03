# Replication and Extension of Thompson et al. (2020)

## "Universal Vote-by-Mail Has No Impact on Partisan Turnout or Vote Share"

> **Note:** This project is an experiment in the use of AI to produce new empirical research. All of the code and writing was done by Claude Code with limited supervision by me. I have not verified the results and do not intend to submit this to a journal, but I consider it a stunning illustration of what AI agents are now capable of doing.
>
> — Andrew B. Hall

---

This repository contains a complete replication and extension of Thompson, Wu, Yoder, and Hall (2020), published in the *Proceedings of the National Academy of Sciences*.

**Original Paper**: Thompson, D. M., Wu, J. A., Yoder, J., & Hall, A. B. (2020). Universal vote-by-mail has no impact on partisan turnout or vote share. *PNAS*, 117(25), 14052-14056.

---

## Key Findings

### Replication
- All 12 coefficients from Tables 2 and 3 replicate exactly to 3 decimal places
- Python implementation using `pyfixest` matches original Stata results

### Extension (2020-2024)
- **Turnout**: VBM increases turnout by ~2 percentage points (robust across all specifications)
- **Partisan Effects**: No systematic effect on Democratic vote share
  - Original period effect (0.007) diminishes to 0.003 (not significant) with extended data
  - Only 2018 pilot counties show positive partisan effect; later cohorts show zero effect
  - Population-weighted estimates show precisely zero partisan effect

---

## Project Structure

```
vbm_replication/
├── README.md                 # This file
├── requirements.txt          # Python dependencies
├── original/                 # Original paper materials
│   ├── code/                 # Original Stata do-files
│   ├── data/
│   │   ├── raw/             # Raw data files
│   │   └── modified/        # analysis.dta
│   └── paper/               # Original paper PDF
├── code/                     # Python replication code
│   ├── 02_replicate.py      # Replicates Tables 2 & 3
│   ├── 03_prepare_extension.py  # Prepares extension data
│   └── 04_extension_analysis.py # Runs extension analysis
├── data/
│   ├── raw/                 # Raw extension data
│   │   └── cvap_2018_2022/  # Census CVAP data
│   ├── extension/           # Processed extension data
│   │   ├── california_vbm_adoption.csv
│   │   ├── election_results_2020_2024.csv
│   │   └── cvap_2018_2022.csv
│   └── processed/           # Analysis-ready data
│       └── analysis_extended.csv
├── output/
│   ├── tables/              # Results tables (CSV)
│   ├── figures/             # Figures (PNG/PDF)
│   └── paper/               # Paper draft and LaTeX tables
└── notes/                   # Documentation and notes
    ├── original_materials_review.md
    ├── original_paper_summary.md
    ├── literature_review.md
    ├── extension_rationale.md
    ├── replication_comparison.md
    ├── extension_data_documentation.md
    ├── data_preparation_notes.md
    └── extension_analysis_results.md
```

---

## Requirements

```
pandas>=1.3.0
numpy>=1.20.0
pyfixest>=0.18.0
matplotlib>=3.4.0
seaborn>=0.11.0
scipy>=1.7.0
requests>=2.25.0
```

Install with: `pip install -r requirements.txt`

---

## Reproducing the Analysis

### Step 1: Replication of Original Results
```bash
cd vbm_replication
python code/02_replicate.py
```
This reproduces Tables 2 and 3 from the original paper.

### Step 2: Prepare Extension Data
```bash
python code/03_prepare_extension.py
```
This creates `data/processed/analysis_extended.csv` with 2020-2024 data.

### Step 3: Run Extension Analysis
```bash
python code/04_extension_analysis.py
```
This runs all extension analyses and generates figures.

---

## Data Sources

| Data | Source | Years |
|------|--------|-------|
| Original analysis data | Stanford Digital Repository | 1996-2018 |
| CA VCA adoption | California Secretary of State | 2018-2024 |
| Presidential results | MIT Election Data + Science Lab | 2020, 2024 |
| Governor/Senate results | MIT Election Data + Science Lab | 2022 |
| CVAP | U.S. Census Bureau (ACS 5-year) | 2018-2022 |

---

## Main Results Tables

### Table 1: Original vs Extended Period

| Outcome | Specification | Original (1996-2018) | Extended (1996-2024) |
|---------|---------------|---------------------|---------------------|
| Dem Vote Share | Basic | 0.029** | 0.024*** |
| | Linear Trends | 0.011** | 0.006* |
| | Quadratic Trends | 0.007* | 0.003 |
| Turnout | Basic | 0.021** | 0.026*** |
| | Linear Trends | 0.022*** | 0.020*** |
| | Quadratic Trends | 0.021** | 0.021*** |

### Table 2: Heterogeneity by VCA Adoption Cohort

| Cohort | Counties | Dem Vote Share | Turnout |
|--------|----------|---------------|---------|
| 2018 | 5 | 0.032** | 0.025** |
| 2020 | 10 | -0.007 | 0.028** |
| 2022 | 12 | 0.006 | 0.029** |
| 2024 | 3 | -0.014 | 0.041 |

---

## Output Files

### Tables (`output/tables/`)
- `table2_replication.csv` - Replication of Table 2
- `table3_replication.csv` - Replication of Table 3
- `extension_partisan_results.csv` - Extended partisan analysis
- `extension_turnout_results.csv` - Extended turnout analysis
- `cohort_results.csv` - Heterogeneity by adoption cohort
- `event_study_results.csv` - Event study coefficients

### Figures (`output/figures/`)
- `main_results.png/pdf` - Original vs extended comparison
- `event_study.png/pdf` - Event study plots
- `cohort_heterogeneity.png/pdf` - Effects by adoption cohort

### Paper (`output/paper/`)
- `vbm_extension_paper.md` - Full research paper
- `tables.tex` - LaTeX formatted tables

---

## Citation

If you use this replication or extension, please cite:

```bibtex
@article{thompson2020universal,
  title={Universal vote-by-mail has no impact on partisan turnout or vote share},
  author={Thompson, Daniel M and Wu, Jennifer A and Yoder, Jesse and Hall, Andrew B},
  journal={Proceedings of the National Academy of Sciences},
  volume={117},
  number={25},
  pages={14052--14056},
  year={2020}
}
```

---

## Notes

- **Utah 2022**: The Senate race featured McMullin (I) vs Lee (R) with no Democratic candidate. McMullin votes are coded as the Democratic proxy.
- **CVAP**: Uses 2018-2022 ACS 5-year estimates for all extension years.
- **Pre-trends**: Evidence of pre-trends for 2018 pilot counties suggests caution in interpreting their treatment effects causally.

---

## License

This replication is provided for academic purposes. Original data is subject to the terms of the Stanford Digital Repository.
