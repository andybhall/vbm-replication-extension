# Phase 4: Data Preparation Notes

## Overview

This document describes the creation of the extended analysis dataset for replicating and extending Thompson et al. (2020).

---

## Files Created

### `data/processed/analysis_extended.csv`

The main analysis dataset combining original (1996-2018) and extension (2020-2024) data.

| Column | Description |
|--------|-------------|
| state | State abbreviation (CA, UT, WA) |
| county | County name |
| county_id | Unique county identifier (1-126) |
| year | Election year |
| treat | Treatment indicator (=1 if universal VBM) |
| dem_share_pres | Democratic two-party vote share (President) |
| dem_share_gov | Democratic two-party vote share (Governor) |
| dem_share_sen | Democratic two-party vote share (Senate) |
| turnout_share | Turnout (ballots / CVAP) |
| vbm_share | Share of ballots cast by mail (CA only, original period) |
| share_votes_dem | Democratic share of all ballots (voter file, original only) |
| cvap | Citizen Voting Age Population |
| state_year | State-year interaction for fixed effects |
| year_c | Centered year (year - 1996) |
| year_c2 | Squared centered year |
| extension | Indicator for extension period (=1 if year >= 2020) |

### Dimensions
- **Total observations**: 1,832
- **Original period (1996-2018)**: 1,454 observations
- **Extension period (2020-2024)**: 378 observations
- **Counties**: 126 (58 CA + 29 UT + 39 WA)

---

## Treatment Variable Construction

### California
- `treat = 1` if `year >= vca_first_year` for that county
- VCA adoption timing:
  - 2018: 5 pilot counties
  - 2020: +10 counties (15 cumulative)
  - 2022: +12 counties (27 cumulative)
  - 2024: +3 counties (30 cumulative)
- 28 counties remain non-VCA through 2024

### Utah and Washington
- `treat = 1` for all years in extension period
- Both states were already 100% VBM by 2020

---

## Data Availability by Period

| Variable | Original (1996-2018) | Extension (2020-2024) | Total |
|----------|---------------------|----------------------|-------|
| dem_share_pres | 698 | 252 | 950 |
| dem_share_gov | 756 | 58 | 814 |
| dem_share_sen | 544 | 68 | 612 |
| turnout_share | 1,240 | 252 | 1,492 |
| vbm_share | 892 | 0 | 892 |
| share_votes_dem | 986 | 0 | 986 |

**Notes on missing variables in extension:**
- `vbm_share`: Not collected for extension (would require detailed ballot-mode data)
- `share_votes_dem`: Requires voter file data (not publicly available)
- `turnout_share`: Available for 2020 and 2024 only (presidential years)

---

## Validation Results

### Replication Check (Original Period Only)
Using long-format dem_share (matching Table 2, Cols 4-6):

| Specification | Original Paper | Replication | Difference |
|---------------|---------------|-------------|------------|
| Basic | 0.028 (0.011) | 0.029 (0.011) | <0.001 |
| Linear Trends | 0.011 (0.004) | 0.011 (0.004) | 0.000 |
| Quadratic Trends | 0.007 (0.003) | 0.007 (0.003) | <0.001 |

### Extended Analysis Preview (1996-2024)
| Specification | Coefficient | SE | N |
|---------------|------------|-----|-----|
| Basic | 0.024 | 0.007 | 2,376 |
| Linear Trends | 0.006 | 0.003 | 2,376 |
| Quadratic Trends | 0.003 | 0.003 | 2,376 |

**Preliminary observation**: Extended analysis shows smaller coefficients than original period alone, suggesting additional California VCA adoptions (2020-2024) may have had smaller effects on Democratic vote share than the 2018 pilot counties. This will be explored further in Phase 5.

---

## Known Issues

1. **CVAP Timing**: Using 2018-2022 ACS 5-year estimates for all extension years. Population changes between 2020-2024 could introduce measurement error in turnout calculations.

2. **Two counties with turnout > 100%**: Due to CVAP estimation error relative to actual registration/voting population. These are flagged but not adjusted.

3. **2022 Turnout Missing**: Only have total votes for presidential years (2020, 2024). Governor/Senate races in 2022 don't provide total ballot counts comparable to presidential years.

4. **Utah 2022 Senate**: McMullin (Independent) coded as Democratic proxy. This is noted but acceptable given the unique race structure.
