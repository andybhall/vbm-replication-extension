# Original Materials Review

## 1. File Inventory

### Code Files (`original/code/`)

| File | Purpose |
|------|---------|
| `make_partisan_turnout_table.do` | **Produces Table 2** - Partisan outcomes (Dem turnout share, Dem vote share) |
| `make_participation_table.do` | **Produces Table 3** - Participation outcomes (turnout, VBM share) |
| `make_partisan_effects_state_by_state_table.do` | State-by-state partisan results |
| `make_participation_table_state_by_state.do` | State-by-state participation results |
| `make_leads_plots.do` | Event study/leads plots |
| `make_participation_graphs.do` | Participation visualization |
| `make_age_turnout_table.do` | Age-based turnout analysis |
| `make_race_turnout_table.do` | Race-based turnout analysis |
| `make_pov_turnout_table.do` | Poverty-based turnout analysis |
| `prep_analysis_data.do` | Prepares main analysis dataset |
| `prep_policy_data.do` | Prepares policy/treatment data |
| `prep_gov_data.do` | Prepares gubernatorial election data |
| `prep_pres_data.do` | Prepares presidential election data |
| `prep_sen_data.do` | Prepares senatorial election data |
| `prep_participation_tables.do` | Prepares participation analysis data |
| `prep_citizen_voting_age_pop.do` | Prepares CVAP data |
| `prep_composition_data.do` | Prepares voter composition data |

### Modified/Analysis Data Files (`original/data/modified/`)

| File | Dimensions | Description |
|------|------------|-------------|
| `analysis.dta` | 1454 × 134 | **Main analysis dataset** - county-election level |
| `participation.dta` | 1240 × 17 | Participation data |
| `governor.dta` | 1317 × 7 | Gubernatorial election results |
| `president.dta` | 911 × 7 | Presidential election results |
| `senator.dta` | 544 × 5 | Senatorial election results |
| `policies.dta` | 2179 × 12 | VBM policy adoption data |
| `county_cvap.dta` | - | Citizen Voting Age Population |
| `composition.dta` | - | Voter composition data |
| Various composition files | - | Age, race, poverty breakdowns |

### Raw Data Files (`original/data/raw/`)

Organized in subdirectories:
- `census_poverty_race/` - Census demographic data
- `eavs/` - Election Administration and Voting Survey data
- `gov/`, `gov_wa/` - Gubernatorial election results by state
- `participation/` - Turnout and participation data
- `policies/` - VBM policy adoption data
- `population/` - Population estimates
- `pres/`, `pres_wa/` - Presidential election results
- `registration/` - Voter registration data
- `sen_wa/` - Senate election results

---

## 2. Main Analysis Workflow

### Step 1: Data Preparation
1. Raw election data is cleaned and standardized by state
2. VBM policy adoption dates are coded
3. CVAP data is merged in for turnout calculations
4. Data is merged into county-election panel

### Step 2: Main Analysis (`analysis.dta`)
The analysis dataset contains 1454 county-election observations:
- **California**: 638 observations (5 treated)
- **Utah**: 348 observations (59 treated)
- **Washington**: 468 observations (275 treated)

### Step 3: Regression Analysis
Tables 2 and 3 are produced using `reghdfe` with:
- County fixed effects
- State × Year fixed effects
- Optional county-specific linear/quadratic trends
- Clustered standard errors at county level

---

## 3. Key Variable Definitions

### Treatment Variable
| Variable | Definition |
|----------|------------|
| `treat` | =1 if universal VBM in effect for that county-election |

### Outcome Variables
| Variable | Definition |
|----------|------------|
| `share_votes_dem` | Democratic share of all ballots cast (voter file data, CA and UT only) |
| `dem_share_gov` | Democratic two-party vote share in gubernatorial races |
| `dem_share_pres` | Democratic two-party vote share in presidential races |
| `dem_share_sen` | Democratic two-party vote share in senatorial races |
| `turnout_share` | Total ballots cast / CVAP |
| `vbm_share` | Share of ballots cast by mail (CA only) |

### Fixed Effects Variables
| Variable | Definition |
|----------|------------|
| `county_id` | Unique county identifier |
| `state_year` | State × Year interaction for fixed effects |
| `state_year_id` | Numeric version of state_year |
| `year2` | Year squared (for quadratic trends) |
| `year3` | Year cubed |

### Other Key Variables
| Variable | Definition |
|----------|------------|
| `state` | State name (CA, UT, WA) |
| `county` | County name |
| `year` | Election year (1998-2018) |
| `cvap` | Citizen Voting Age Population |
| `ballots_cast` | Total ballots cast |
| `registered` | Registered voters |
| `vca18` | =1 if county adopted Voter's Choice Act by 2018 (CA) |
| `ut_all_mail_year` | Year Utah county adopted all-mail voting |

---

## 4. Stata Commands Requiring Python Equivalents

### Primary Regression Command

**Stata**: `reghdfe`
```stata
reghdfe share_votes_dem treat, ///
    a(county_id state_year) vce(clust county_id)
```

**Python Equivalent**: `pyfixest` (preferred - designed to replicate `reghdfe`)

```python
# Primary approach: pyfixest (closest to reghdfe)
import pyfixest as pf

# Basic diff-in-diff with county and state-year FE
model = pf.feols("share_votes_dem ~ treat | county_id + state_year",
                 data=df, vcov={"CRV1": "county_id"})

# With county-specific linear trends
model = pf.feols("share_votes_dem ~ treat | county_id + state_year + county_id[year]",
                 data=df, vcov={"CRV1": "county_id"})
```

**Alternative approaches**:
```python
# Option 2: linearmodels
from linearmodels import PanelOLS
model = PanelOLS(y, X, entity_effects=True, time_effects=True)
result = model.fit(cov_type='clustered', cluster_entity=True)

# Option 3: statsmodels with dummy variables
import statsmodels.api as sm
model = sm.OLS(y, X_with_dummies)
result = model.fit(cov_type='cluster', cov_kwds={'groups': county_id})
```

### Stata-to-Python Translation Table

| Stata | Python (pyfixest) | Notes |
|-------|-------------------|-------|
| `reghdfe ... , a(fe1 fe2)` | `pf.feols("y ~ x \| fe1 + fe2", ...)` | High-dimensional FE |
| `vce(clust county_id)` | `vcov={"CRV1": "county_id"}` | Clustered SEs |
| `a(county_id##c.year)` | `\| county_id + county_id[year]` | County-specific linear trends |
| `a(county_id##c.year2)` | `\| county_id[year] + county_id[year2]` | County-specific quadratic trends |
| `distinct` | `df['var'].nunique()` | Count unique values |
| `reshape long` | `pd.wide_to_long()` or `pd.melt()` | Reshape data |

### Key Differences to Note

1. **Fixed Effects Handling**: Stata's `reghdfe` automatically handles high-dimensional fixed effects efficiently. In Python, we need to either:
   - Use `linearmodels.PanelOLS` (handles entity/time FE)
   - Create dummy variables manually (memory-intensive for many FE)
   - Use within-transformation (demeaning)

2. **County-Specific Trends**: Must be constructed manually in Python:
   ```python
   # Linear trends: county_i × year
   df['county_year_trend'] = df.groupby('county_id').cumcount()

   # Quadratic trends: add county_i × year²
   df['county_year2_trend'] = df['county_year_trend'] ** 2
   ```

3. **State × Year FE**: Need to create interaction variable:
   ```python
   df['state_year'] = df['state'] + '_' + df['year'].astype(str)
   ```

---

## 5. Data Notes and Caveats

### Sample Restrictions
- **Table 2, Cols 1-3**: Democratic turnout share available only for CA and UT (87 counties)
- **Table 2, Cols 4-6**: Democratic vote share available for all three states (126 counties)
- **Table 3, Cols 4-6**: VBM share available only for CA (58 counties)

### Treatment Variation
- **California**: Very limited (5 VCA counties by 2018)
- **Utah**: Moderate (59 treated observations, staggered adoption 2012-2019)
- **Washington**: Extensive (100% VBM since 2011, 275 treated observations)

### Years Covered
- Years in data: 1998-2018
- Includes even years only (election years)

---

## 6. Packages Required for Python Replication

```
pandas>=1.3.0
numpy>=1.20.0
statsmodels>=0.12.0
pyfixest>=0.18.0      # Primary package for reghdfe replication
linearmodels>=4.25    # Alternative for panel models
matplotlib>=3.4.0
seaborn>=0.11.0
scipy>=1.7.0
```
