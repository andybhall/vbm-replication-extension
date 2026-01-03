# Original Data Examination

## Dataset: analysis.dta

### Dimensions
- **Rows**: 1,454 observations (county-election level)
- **Columns**: 134 variables

### Observations by State
| State | N | % of Total |
|-------|---|------------|
| California | 638 | 43.9% |
| Washington | 468 | 32.2% |
| Utah | 348 | 23.9% |

### Treatment Distribution
| State | Untreated (treat=0) | Treated (treat=1) | % Treated |
|-------|---------------------|-------------------|-----------|
| California | 633 | 5 | 0.8% |
| Utah | 289 | 59 | 17.0% |
| Washington | 193 | 275 | 58.8% |
| **Total** | 1,115 | 339 | 23.3% |

### Year Coverage
Years in dataset: 1996, 1998, 2000, 2002, 2004, 2006, 2008, 2010, 2012, 2014, 2016, 2018

(Even years only - general election years)

### County Coverage
| State | Counties |
|-------|----------|
| California | 58 |
| Utah | 29 |
| Washington | 39 |
| **Total** | 126 |

---

## Key Outcome Variables

### Democratic Turnout Share (`share_votes_dem`)
- **Definition**: Democratic share of all ballots cast (from voter file)
- **Availability**: CA and UT only (WA lacks voter file data)
- **N**: 986 non-null values
- **Mean**: 0.284, SD: 0.176
- **Range**: [0.016, 0.658]

### Democratic Vote Share (`dem_share_gov`, `dem_share_pres`, `dem_share_sen`)
- **Definition**: Democratic two-party vote share by office
- **Availability**: All three states
- **N (gov)**: 756, **N (pres)**: 698, **N (sen)**: 544
- **Mean**: ~0.42-0.43

### Turnout Share (`turnout_share`)
- **Definition**: Total ballots cast / CVAP
- **Availability**: All three states
- **N**: 1,240 non-null values
- **Mean**: 0.542, SD: 0.121
- **Range**: [0.225, 0.935]

### VBM Share (`vbm_share`)
- **Definition**: Share of ballots cast by mail
- **Availability**: CA only
- **N**: 892 non-null values (but 580 for CA-only Table 3 analysis)
- **Mean**: 0.583, SD: 0.246
- **Range**: [0.008, 1.000]

---

## Treatment Variable

### `treat`
- **Definition**: =1 if universal VBM in effect for that county-election
- **Type**: Binary (0/1)
- **N treated observations**: 339 (23.3% of sample)

---

## Fixed Effect Variables

### `county_id`
- **Definition**: Unique county identifier
- **Values**: 1-126

### `state_year`
- **Definition**: State × Year interaction
- **Note**: Not present in original data; created as `state + "_" + year`
- **Example values**: "CA_1998", "UT_2016", "WA_2004"

### `year2`
- **Definition**: Year squared (for quadratic trends)
- **Present in original data**: Yes

---

## Data Quality Checks

### Missing Values
Most variables have some missing values due to:
- Outcome availability by state (e.g., voter file data only for CA/UT)
- Outcome availability by election type (not all offices in all years)
- VBM share only available for CA

### No Unexpected Issues
- County counts match expected (58 CA + 29 UT + 39 WA = 126)
- Year range matches paper description (1996-2018)
- Treatment pattern consistent with VBM adoption history
