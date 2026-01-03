# Extension Rationale: Extending Thompson et al. (2020) Through 2024

## 1. What Changed After 2018?

### COVID-19 Pandemic and Emergency VBM Expansion
- The 2020 election occurred amid a global pandemic
- Many states temporarily expanded vote-by-mail access
- VBM usage surged nationwide (convenience voting up 29.3% from 2016)
- 59% of Democrats voted by mail vs. 30% of Republicans in 2020

### VBM Became a Partisan Issue
- Voting method became polarized along party lines
- ~20 percentage point gap between D and R preferences for mail voting by mid-2020
- Republican politicians and media challenged VBM legitimacy
- This polarization may have changed who uses VBM and how it affects elections

### California Voter's Choice Act Continued Rollout
The VCA rollout provides the primary new variation for our extension:

| Year | Counties Adopted | Cumulative Counties | % of CA Registered Voters |
|------|------------------|---------------------|---------------------------|
| 2018 | 5 | 5 | ~15% |
| 2020 | 10 | 15 | ~50% |
| 2022 | 12 | 27 | ~70% |
| 2024 | 2 | 29 | ~78% |

**Key 2020 Adopters**: Los Angeles, Orange (two largest counties)
**Recent 2024 Adopters**: Placer, others

---

## 2. What New Variation Exists?

### California: Primary Source of New Variation

**Strong new variation (2020-2024)**:
- 24 additional counties adopted VCA after the original study period
- Includes Los Angeles County (largest in the state)
- Creates substantial within-state variation for 2020, 2022, 2024 elections

**Elections available**:
- 2020: Presidential general election (Biden vs. Trump)
- 2021: Gubernatorial recall election (Newsom)
- 2022: Gubernatorial general election (Newsom vs. Dahle)
- 2024: Presidential general election (Harris vs. Trump)

### Utah: Limited New Variation

- By 2019, essentially all counties were 100% vote-by-mail
- No new treatment variation after original study period
- Can include in pooled analysis but provides no new identifying variation
- Useful for examining whether null effects persist

### Washington: No New Variation

- 100% VBM statewide since 2011
- No new treatment variation
- Can include but provides no new identifying variation
- Useful for trend comparisons

**Summary**: California is the key state for the extension analysis.

---

## 3. Research Questions for the Extension

### Primary Questions

1. **Do the null partisan effects hold in the post-COVID period?**
   - Original finding: VBM has no effect on Democratic vote share or turnout share
   - Test: Do estimates from 2020-2024 data show similar null effects?

2. **Is there evidence of heterogeneous effects by time period?**
   - Original period (1996-2018) vs. extension period (2020-2024)
   - Interaction model: `VBM × Post2018` to test for differential effects

3. **Do event study patterns look similar before and after 2018?**
   - Original showed flat pre-trends and small post-effects
   - Extension: Does the same pattern hold for new California adopters?

### Secondary Questions

4. **Are there differential effects in high-profile vs. low-profile elections?**
   - 2020/2024 presidential elections were exceptionally high-salience
   - 2021 recall and 2022 gubernatorial were lower-salience

5. **Do effects differ by county characteristics?**
   - Urban vs. rural
   - High vs. low Democratic vote share
   - Early vs. late adopters

---

## 4. Limitations to Acknowledge

### Less New Variation Than Original Paper
- Original paper had extensive staggered adoption across all three states
- Extension relies almost entirely on California VCA rollout
- Utah and Washington provide no new treatment variation
- Statistical power for extension-period effects may be limited

### COVID-19 Confounds the 2020 Election
- Impossible to fully separate VBM effects from pandemic effects
- Many voters changed behavior due to health concerns, not VBM per se
- National turnout was exceptionally high for other reasons
- Consider dropping or flagging 2020 in robustness checks

### Partisan Polarization of VBM
- VBM is no longer a politically neutral policy
- Self-selection into voting methods is now partisan
- This may affect who adopts VBM and how it affects outcomes
- Harder to interpret effects as "causal effect of VBM" vs. "effect of partisan sorting"

### Comparability of Elections
- Original study pooled presidential, gubernatorial, and senatorial elections
- Extension period includes a recall election (2021) which is unusual
- Different election types may have different dynamics

### External Validity
- Results specific to California, Utah, Washington
- May not generalize to other states or nationwide implementation
- These three states have relatively established VBM infrastructure

---

## 5. Contribution of the Extension

Despite limitations, this extension makes several contributions:

### Empirical Contributions
1. **First rigorous test of VBM effects in post-COVID era** using quasi-experimental design
2. **Replication of influential PNAS paper** with new data
3. **10+ additional years of variation** in California VCA rollout

### Methodological Contributions
1. **Apply modern DiD methods** (Callaway-Sant'Anna, Sun-Abraham) to check robustness
2. **Test for heterogeneity** across time periods and contexts
3. **Transparent replication** of original analysis

### Policy Contributions
1. **Timely evidence** as states continue debating VBM expansion
2. **Test whether politicization** has changed VBM's effects
3. **Inform post-pandemic** election policy decisions

---

## 6. Summary

| Aspect | Original (1996-2018) | Extension (2020-2024) |
|--------|---------------------|----------------------|
| Primary variation | WA, UT staggered; CA VCA 2018 | CA VCA continued rollout |
| States with variation | All three | California only |
| Context | Normal elections | COVID, polarization |
| # New treated units | N/A | 24 CA counties |
| Key limitation | N/A | Cannot separate VBM from COVID |

**Bottom line**: The extension tests whether Thompson et al.'s null partisan findings hold in a fundamentally different political context. While we cannot make causal claims as strong as the original, we can provide valuable descriptive and quasi-experimental evidence on VBM effects in the post-COVID era.
