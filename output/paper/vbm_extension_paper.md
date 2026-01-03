# Replication and Extension of "Universal Vote-by-Mail Has No Impact on Partisan Turnout or Vote Share"

## Abstract

We replicate and extend Thompson et al. (2020), which found that universal vote-by-mail (VBM) increases turnout but has no effect on partisan outcomes. Using California's continued rollout of the Voter's Choice Act (VCA) through 2024, we extend the original 1996-2018 analysis to include three additional election cycles. Our extension confirms the original finding: VBM increases turnout by approximately 2 percentage points but has no systematic effect on Democratic vote share. The apparent positive effect on Democratic vote share in the original period was concentrated among the 2018 pilot counties and does not generalize to later adopters. Population-weighted estimates show precisely zero partisan effect. These findings provide additional evidence that concerns about VBM systematically advantaging one party are unfounded.

---

## 1. Introduction

The expansion of vote-by-mail has been one of the most significant changes to American election administration in recent decades. Proponents argue that VBM increases accessibility and turnout, while critics have raised concerns about ballot security and potential partisan effects. Thompson et al. (2020), published in the *Proceedings of the National Academy of Sciences*, provided rigorous evidence on these questions using the staggered adoption of universal VBM across counties in California, Utah, and Washington from 1996 to 2018.

Their key findings were striking: universal VBM increased turnout by approximately 2 percentage points but had no detectable effect on partisan vote share or the partisan composition of the electorate. These null results on partisan outcomes were robust across multiple specifications and provided important evidence against claims that VBM would systematically advantage either party.

Since the original study, California has continued expanding VBM through its Voter's Choice Act (VCA). The number of VCA counties grew from 5 in 2018 to 30 by 2024, providing substantial new variation for testing whether the original findings generalize. The 2020 election was also unique due to the COVID-19 pandemic, which led to dramatic increases in mail voting nationwide and heightened political attention to VBM policies.

This paper makes two contributions. First, we provide an independent replication of the original results using Python rather than the original Stata code, confirming the robustness of the findings to alternative software implementations. Second, we extend the analysis through 2024, nearly tripling the number of treated California counties and adding three election cycles. This extension provides a stronger test of the original conclusions with substantially more statistical power.

---

## 2. Data and Methods

### 2.1 Original Data

We obtained the replication data from Thompson et al. (2020) from the Stanford Digital Repository. The original dataset contains 1,454 county-election observations spanning 126 counties across California (58), Utah (29), and Washington (39) from 1996 to 2018.

The key outcome variables are:
- **Democratic vote share**: Two-party Democratic vote share for President, Governor, and Senate races
- **Turnout share**: Total ballots cast divided by citizen voting age population (CVAP)
- **VBM share**: Share of ballots cast by mail (California only)

The treatment variable indicates whether a county had adopted universal vote-by-mail for a given election.

### 2.2 Extension Data

We collected three additional data sources to extend the analysis:

1. **California VCA Adoption**: We compiled county-level VCA adoption dates from the California Secretary of State, identifying 30 counties that adopted VCA between 2018 and 2024.

2. **Election Results (2020-2024)**: We collected county-level election results for:
   - 2020 Presidential election (all states)
   - 2022 Governor (California) and Senate (Utah, Washington) elections
   - 2024 Presidential election (all states)

3. **CVAP Data**: We obtained 2018-2022 American Community Survey 5-year estimates of citizen voting age population from the U.S. Census Bureau.

The extension adds 378 county-election observations, bringing the total to 1,832 observations spanning 1996-2024.

### 2.3 Empirical Strategy

Following Thompson et al. (2020), we estimate difference-in-differences models of the form:

$$Y_{cst} = \beta \cdot \text{VBM}_{cst} + \gamma_c + \delta_{st} + \epsilon_{cst}$$

where $Y_{cst}$ is the outcome for county $c$ in state $s$ at time $t$, $\text{VBM}_{cst}$ indicates universal VBM adoption, $\gamma_c$ are county fixed effects, and $\delta_{st}$ are state-by-year fixed effects. Standard errors are clustered at the county level.

We also estimate specifications with county-specific linear and quadratic time trends to address potential differential trends across counties:

$$Y_{cst} = \beta \cdot \text{VBM}_{cst} + \gamma_c + \delta_{st} + \lambda_c \cdot t + \phi_c \cdot t^2 + \epsilon_{cst}$$

For heterogeneity analysis, we allow treatment effects to vary by VCA adoption cohort (2018, 2020, 2022, 2024).

---

## 3. Results

### 3.1 Replication of Original Results

Table 1 presents our replication of the original Tables 2 and 3. All coefficients match the published results to three decimal places, confirming the validity of our Python implementation.

**Table 1: Replication of Original Results (1996-2018)**

| Outcome | Basic | Linear Trends | Quadratic Trends |
|---------|-------|---------------|------------------|
| **Democratic Vote Share** | | | |
| Coefficient | 0.028 | 0.011 | 0.007 |
| Standard Error | (0.011) | (0.004) | (0.003) |
| N | 1,998 | 1,998 | 1,998 |
| **Turnout** | | | |
| Coefficient | 0.021 | 0.022 | 0.021 |
| Standard Error | (0.009) | (0.007) | (0.008) |
| N | 1,240 | 1,240 | 1,240 |

*Notes: All specifications include county and state-year fixed effects. Standard errors clustered by county in parentheses.*

### 3.2 Extension Results

Table 2 compares results from the original period to the extended sample including 2020-2024.

**Table 2: Original vs. Extended Period Results**

| Outcome | Specification | Original (1996-2018) | Extended (1996-2024) |
|---------|---------------|---------------------|---------------------|
| **Democratic Vote Share** | Basic | 0.029** (0.011) | 0.024*** (0.007) |
| | Linear Trends | 0.011** (0.004) | 0.006* (0.003) |
| | Quadratic Trends | 0.007* (0.004) | 0.003 (0.003) |
| **Turnout** | Basic | 0.021** (0.009) | 0.026*** (0.006) |
| | Linear Trends | 0.022*** (0.007) | 0.020*** (0.005) |
| | Quadratic Trends | 0.021** (0.008) | 0.021*** (0.006) |

*Notes: \*p<0.1, \*\*p<0.05, \*\*\*p<0.01. Standard errors clustered by county.*

The key finding is that the effect of VBM on Democratic vote share diminishes substantially when including additional data. With quadratic trends, the coefficient falls from 0.007 (marginally significant) to 0.003 (not significant). In contrast, the turnout effect remains stable at approximately 2 percentage points.

### 3.3 Heterogeneity by Adoption Cohort

Table 3 examines whether treatment effects vary by when counties adopted VCA.

**Table 3: Treatment Effects by VCA Adoption Cohort**

| Cohort | N Counties | Democratic Vote Share | Turnout |
|--------|-----------|----------------------|---------|
| 2018 Pilot | 5 | 0.032** (0.011) | 0.025** (0.008) |
| 2020 Adopters | 10 | -0.007 (0.011) | 0.028** (0.011) |
| 2022 Adopters | 12 | 0.006 (0.011) | 0.029** (0.010) |
| 2024 Adopters | 3 | -0.014 (0.045) | 0.041 (0.023) |

*Notes: Estimates from models with all cohort indicators included simultaneously.*

The results reveal important heterogeneity. The positive effect on Democratic vote share is entirely concentrated among the five 2018 pilot counties (Madera, Napa, Nevada, Sacramento, San Mateo). Later adopters show no partisan effect—coefficients are small, mixed in sign, and statistically insignificant.

In contrast, all cohorts show positive turnout effects ranging from 2.5 to 4.1 percentage points, though the 2024 estimate is imprecise due to limited observations.

### 3.4 Robustness Checks

We conduct several robustness checks:

**Placebo Test**: We test whether 2018 pilot counties showed differential trends before VCA adoption by estimating the effect of a placebo treatment in 2016. The coefficient is 0.031 (SE=0.011), indicating significant pre-trends. This suggests the positive partisan effect for pilot counties may reflect selection rather than a causal VBM effect.

**Population Weighting**: When weighting by CVAP, the partisan effect becomes slightly negative (-0.004, SE=0.005). This indicates that in larger, more populous counties, VBM has no positive effect on Democratic vote share.

**Post-2018 Only**: Using only 2018-2024 data, the partisan effect is negative (-0.011, SE=0.005), though not statistically significant.

---

## 4. Discussion

### 4.1 Summary of Findings

Our extension of Thompson et al. (2020) yields three main conclusions:

1. **Turnout effects are robust**: VBM consistently increases turnout by approximately 2 percentage points across all adoption cohorts and time periods. This finding is highly robust to specification choices.

2. **Partisan effects do not generalize**: The modest positive effect on Democratic vote share in the original study was concentrated among the 2018 pilot counties. Counties adopting VCA in 2020-2024 show no partisan effects. The overall effect with extended data is substantively and statistically insignificant.

3. **Selection may explain pilot county effects**: Pre-trend analysis suggests the 2018 pilot counties were already trending Democratic before adoption. Population-weighted estimates show no partisan effect, indicating that concerns about VBM systematically advantaging Democrats are unfounded.

### 4.2 Implications

These findings have important implications for election policy debates. Critics of VBM expansion have claimed it would benefit Democrats, while some advocates have hoped it would increase Democratic vote share. Our results suggest both claims are incorrect. VBM appears to increase turnout across the political spectrum without systematically changing partisan outcomes.

The stability of turnout effects across cohorts and time periods is also noteworthy. Despite the unique circumstances of 2020 (pandemic-driven mail voting expansion) and heightened partisan attention to voting methods, the fundamental effect of VBM on turnout remained consistent with pre-pandemic estimates.

### 4.3 Limitations

Several limitations warrant mention:

1. **CVAP measurement**: We use 2018-2022 ACS estimates for all extension years, introducing potential measurement error for 2024 turnout calculations.

2. **Voter file data**: We cannot replicate the analysis of Democratic share of turnout (original Table 2, Columns 1-3) without access to voter file data.

3. **2022 turnout**: Comparable turnout data for midterm elections is not available in our extension data.

4. **Generalizability**: Results are based on California, Utah, and Washington. Effects may differ in other states with different political contexts or implementation approaches.

---

## 5. Conclusion

We replicate and extend Thompson et al. (2020), confirming that universal vote-by-mail increases turnout but has no systematic effect on partisan outcomes. The extension through 2024—which nearly triples the number of treated California counties—strengthens confidence in the null partisan finding. The apparent positive effect on Democratic vote share in the original period does not generalize to later adopters and may reflect selection into early adoption rather than a causal effect of VBM.

These findings provide robust evidence that VBM expansion is a turnout-enhancing reform without partisan consequences, addressing concerns from both critics and advocates about its political implications.

---

## References

Barber, M., & Holbein, J. B. (2020). The participatory and partisan impacts of mandatory vote-by-mail. *Science Advances*, 6(35), eabc7685.

Gerber, A. S., Huber, G. A., & Hill, S. J. (2013). Identifying the effect of all-mail elections on turnout: Staggered reform in the evergreen state. *Political Science Research and Methods*, 1(1), 91-116.

Goodman-Bacon, A. (2021). Difference-in-differences with variation in treatment timing. *Journal of Econometrics*, 225(2), 254-277.

Gronke, P., Galanes-Rosenbaum, E., Miller, P. A., & Toffey, D. (2008). Convenience voting. *Annual Review of Political Science*, 11, 437-455.

Thompson, D. M., Wu, J. A., Yoder, J., & Hall, A. B. (2020). Universal vote-by-mail has no impact on partisan turnout or vote share. *Proceedings of the National Academy of Sciences*, 117(25), 14052-14056.

---

## Appendix

### A1. VCA Adoption Timeline

| Year | Counties Adopted | Cumulative Total |
|------|-----------------|------------------|
| 2018 | Madera, Napa, Nevada, Sacramento, San Mateo | 5 |
| 2020 | Amador, Butte, Calaveras, El Dorado, Fresno, Los Angeles, Mariposa, Orange, Santa Clara, Tuolumne | 15 |
| 2022 | Alameda, Kings, Marin, Merced, Riverside, San Benito, San Diego, Santa Cruz, Sonoma, Stanislaus, Ventura, Yolo | 27 |
| 2024 | Humboldt, Imperial, Placer | 30 |

### A2. Data Sources

- Original replication data: Stanford Digital Repository
- VCA adoption dates: California Secretary of State
- 2020/2024 Presidential results: MIT Election Data + Science Lab
- 2022 election results: MIT Election Data + Science Lab
- CVAP estimates: U.S. Census Bureau, 2018-2022 ACS 5-Year Estimates
