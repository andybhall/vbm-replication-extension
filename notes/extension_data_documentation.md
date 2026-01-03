# Extension Data Documentation

## Overview

This document describes the data collected for extending Thompson et al. (2020) from 1996-2018 to include elections through 2024.

---

## Data Files

### 1. `data/extension/california_vbm_adoption.csv`

**Description**: California county-level VCA (Voter's Choice Act) adoption years

| Column | Description |
|--------|-------------|
| county | County name |
| vca_first_year | First election year under VCA (2018, 2020, 2022, 2024, or NA) |
| source | Data source (CA SOS) |
| verified | Whether verified (Yes/No) |
| notes | Additional notes |

**Summary**:
- 58 California counties
- 30 VCA counties (52%)
- 28 non-VCA counties (48%)

**Adoption Timeline**:
| Year | Counties Added | Cumulative | Counties |
|------|----------------|------------|----------|
| 2018 | 5 | 5 | Madera, Napa, Nevada, Sacramento, San Mateo |
| 2020 | 10 | 15 | Amador, Butte, Calaveras, El Dorado, Fresno, Los Angeles, Mariposa, Orange, Santa Clara, Tuolumne |
| 2022 | 12 | 27 | Alameda, Kings, Marin, Merced, Riverside, San Benito, San Diego, Santa Cruz, Sonoma, Stanislaus, Ventura, Yolo |
| 2024 | 3 | 30 | Humboldt, Imperial, Placer |

---

### 2. `data/extension/election_results_2020_2024.csv`

**Description**: County-level election results for 2020, 2022, and 2024

| Column | Description |
|--------|-------------|
| state | State abbreviation (CA, UT, WA) |
| county | County name (standardized) |
| county_fips | 5-digit FIPS code |
| year | Election year |
| office | Office type (PRESIDENT, GOVERNOR, SENATE) |
| votes_dem | Democratic (or proxy) votes |
| votes_rep | Republican votes |
| total_votes | Total votes cast |
| dem_share | Democratic two-party vote share |

**Observations**: 378 rows

| State | Year | Office | N |
|-------|------|--------|---|
| CA | 2020 | President | 58 |
| CA | 2022 | Governor | 58 |
| CA | 2024 | President | 58 |
| UT | 2020 | President | 29 |
| UT | 2022 | Senate | 29 |
| UT | 2024 | President | 29 |
| WA | 2020 | President | 39 |
| WA | 2022 | Senate | 39 |
| WA | 2024 | President | 39 |

**Note on Utah 2022**: The Utah Senate race was Mike Lee (R) vs Evan McMullin (I). No Democratic candidate ran. McMullin votes are coded as `votes_dem` as a proxy for non-Republican voting.

---

### 3. `data/extension/cvap_2018_2022.csv`

**Description**: Citizen Voting Age Population from 2018-2022 ACS 5-year estimates

| Column | Description |
|--------|-------------|
| state | State abbreviation |
| county | County name |
| county_fips | 5-digit FIPS code |
| cvap | CVAP estimate |
| cvap_moe | Margin of error |

**Summary by State**:
| State | Counties | Total CVAP |
|-------|----------|------------|
| CA | 58 | 26,078,150 |
| UT | 29 | 2,204,510 |
| WA | 39 | 5,488,695 |

---

## Data Sources

1. **California VCA Adoption**: California Secretary of State website
2. **Election Results**:
   - 2020 & 2024 Presidential: tonmcg/us-election-2020-results GitHub repository
   - 2022 Elections: MIT Election Data + Science Lab (MEDSL)
3. **CVAP**: U.S. Census Bureau, 2018-2022 ACS 5-year estimates

---

## Data Quality Notes

1. **County Name Standardization**: All county names standardized to title case without "County" suffix (e.g., "Los Angeles" not "LOS ANGELES COUNTY")

2. **Cross-Dataset Alignment**: All county names verified to match across VCA, election results, and CVAP datasets

3. **Missing Data**: None. All 126 counties have complete data for all collected variables.

4. **CVAP Timing**: The 2018-2022 ACS estimates represent population as of 2020 (midpoint). Will need to consider appropriate CVAP for each election year in extension analysis.

---

## Extension Research Design

The extension exploits the staggered rollout of VCA in California:
- **Treatment**: VCA adoption (universal mail voting)
- **Control**: Non-VCA counties in CA, plus all of UT and WA (already 100% VBM)
- **Key Variation**: 30 CA counties adopted VCA between 2018-2024

### Treatment Timing by Election Year
| Election | Newly Treated Counties | Total Treated | Control Counties |
|----------|----------------------|---------------|------------------|
| 2020 | 10 (CA) | 15 CA + all UT/WA | 43 CA |
| 2022 | 12 (CA) | 27 CA + all UT/WA | 31 CA |
| 2024 | 3 (CA) | 30 CA + all UT/WA | 28 CA |

This staggered adoption provides the variation needed for difference-in-differences analysis extending the original 1996-2018 period.
