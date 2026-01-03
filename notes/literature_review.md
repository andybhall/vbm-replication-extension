# Literature Review: Vote-by-Mail Effects on Electoral Outcomes

## Summary Table of Verified Citations

| Authors | Year | Journal | Topic | Key Finding | Verified |
|---------|------|---------|-------|-------------|----------|
| Gerber, Huber, & Hill | 2013 | Political Science Research and Methods | WA all-mail elections | VBM increases turnout, especially for low-participation voters | Yes |
| Kousser & Mullin | 2007 | Political Analysis | CA mail ballot elections | VBM does not increase turnout in general elections; may increase in special elections | Yes |
| Southwell & Burchett | 2000 | American Politics Quarterly | Oregon VBM | Reported 10pp turnout increase in Oregon | Yes |
| Gronke et al. | 2008 | Annual Review of Political Science | Convenience voting review | VBM changes how people vote but may not draw new voters | Yes |
| Berinsky, Burns, & Traugott | 2001 | Public Opinion Quarterly | Who votes by mail | VBM effects concentrated among high-SES voters already likely to vote | Yes |
| Goodman-Bacon | 2021 | Journal of Econometrics | Staggered DiD methods | TWFE estimator is weighted average of 2x2 DiDs; can be biased | Yes |
| Callaway & Sant'Anna | 2021 | Journal of Econometrics | DiD with multiple periods | Proposes unbiased estimators for staggered DiD | Yes |
| Sun & Abraham | 2021 | Journal of Econometrics | Event study estimation | Standard event study can be contaminated by heterogeneous effects | Yes |
| Amlani & Collitt | 2022 | Election Law Journal | 2020 VBM effects | 2.6pp turnout increase from universal VBM; no partisan advantage | Yes |
| Thompson et al. | 2020 | PNAS | VBM partisan effects | Null partisan effects; ~2pp turnout increase | Yes |

---

## 1. Foundational VBM Studies

### Gerber, Huber, and Hill (2013)

**Citation**: Gerber, Alan S., Gregory A. Huber, and Seth J. Hill. 2013. "Identifying the Effect of All-Mail Elections on Turnout: Staggered Reform in the Evergreen State." *Political Science Research and Methods* 1(1): 91-116.

**Method**: Exploits Washington State's county-by-county adoption of all-mail elections (2005-2011) using individual-level voter file data.

**Key Findings**:
- All-mail voting significantly increases turnout
- Effect is larger for low-participation registrants than frequent voters
- VBM reduces turnout disparities between high and low participation groups
- No evidence of partisan effects

**Relevance**: Uses similar staggered adoption design as Thompson et al. (2020); provides individual-level complement to county-level analysis.

---

### Kousser and Mullin (2007)

**Citation**: Kousser, Thad, and Megan Mullin. 2007. "Does Voting by Mail Increase Participation? Using Matching to Analyze a Natural Experiment." *Political Analysis* 15(4): 428-445.

**Method**: Uses matching methods to analyze California counties where voters were quasi-randomly assigned to vote by mail in certain precincts.

**Key Findings**:
- VBM does **not** increase participation in general elections
- In fact, voters assigned to mail voting turn out at *lower* rates than polling-place voters
- VBM *does* increase turnout in low-salience special elections

**Relevance**: Challenges optimistic claims about VBM turnout effects; highlights importance of election context.

---

### Southwell and Burchett (2000)

**Citation**: Southwell, Priscilla L., and Justin I. Burchett. 2000. "The Effect of All-Mail Elections on Voter Turnout." *American Politics Quarterly* 28(1): 72-79.

**Method**: Analyzes 48 statewide elections in Oregon before and after VBM adoption.

**Key Findings**:
- Reported approximately 10 percentage point increase in turnout after VBM adoption
- Widely cited as evidence for VBM's turnout benefits

**Caveats**: Later research (Gronke & Miller 2012) questioned these findings, finding a "novelty effect" that faded over time.

---

### Gronke et al. (2008)

**Citation**: Gronke, Paul, Eva Galanes-Rosenbaum, Peter A. Miller, and Daniel Toffey. 2008. "Convenience Voting." *Annual Review of Political Science* 11: 437-455.

**Key Points**:
- Reviews all forms of convenience voting (early voting, VBM, absentee, etc.)
- Over 30% of Americans use some form of convenience voting
- Literature on turnout effects is extensive but mixed
- Little research on campaign effects, election costs, or fraud risk
- VBM may not draw in new citizens or appeal to disempowered populations

**Relevance**: Provides comprehensive literature review through 2008.

---

### Berinsky, Burns, and Traugott (2001)

**Citation**: Berinsky, Adam J., Nancy Burns, and Michael W. Traugott. 2001. "Who Votes by Mail? A Dynamic Model of the Individual-Level Consequences of Voting-by-Mail Systems." *Public Opinion Quarterly* 65(2): 178-197.

**Key Findings**:
- VBM effects are concentrated among high-SES voters already likely to vote
- Reforms designed to make voting easier may **increase** rather than reduce socioeconomic biases
- Challenges assumption that convenience voting helps underrepresented groups

**Relevance**: Important for understanding *who* is affected by VBM, not just whether turnout increases.

---

## 2. Post-2020 VBM Studies

### Amlani and Collitt (2022)

**Citation**: Amlani, Sharif, and Samuel Collitt. 2022. "The Impact of Vote-By-Mail Policy on Turnout and Vote Share in the 2020 Election." *Election Law Journal* 21(2): 135-149.

**Method**: Two-period difference-in-differences comparing counties that changed VBM policies for 2020 vs. those that did not.

**Key Findings**:
- Counties adopting universal VBM experienced 2.6 percentage point higher turnout
- **No evidence of partisan advantage** from VBM expansion
- Only states switching from no-excuse to universal VBM saw significant turnout increases

**Relevance**: Directly extends Thompson et al. analysis to 2020 election; confirms null partisan findings in COVID context.

---

### Additional 2020 Election Research

**Partisan Polarization in Voting Methods**:
- Research found ~20 percentage point gap between Democrats and Republicans in preference for mail voting by June 2020
- 59% of Democrats voted by mail vs. only 30% of Republicans
- Voting method became polarized along partisan lines during COVID

**COVID-19 Effects**:
- States under Democratic control more likely to expand VBM
- Personal COVID exposure influenced turnout and vote mode choices
- Convenience voting jumped 29.3% in 2020 compared to 2016

---

## 3. Methodological Papers on Staggered Difference-in-Differences

### Goodman-Bacon (2021)

**Citation**: Goodman-Bacon, Andrew. 2021. "Difference-in-Differences with Variation in Treatment Timing." *Journal of Econometrics* 225(2): 254-277.

**Key Contribution**:
- Shows that standard two-way fixed effects (TWFE) DiD is a weighted average of all possible 2×2 DiD comparisons
- Weights can be negative when treatment effects vary over time
- Later-treated units can serve as controls for earlier-treated units (and vice versa)
- This can produce biased estimates when effects are heterogeneous

**Implications for VBM Research**:
- Thompson et al. use staggered adoption design
- If VBM effects differ by adoption cohort or change over time, TWFE may be biased
- Extension should consider robustness to alternative estimators

**Software**: `bacondecomp` (Stata/R) for decomposition analysis.

---

### Callaway and Sant'Anna (2021)

**Citation**: Callaway, Brantly, and Pedro H.C. Sant'Anna. 2021. "Difference-in-Differences with Multiple Time Periods." *Journal of Econometrics* 225(2): 200-230.

**Key Contribution**:
- Proposes group-time average treatment effects (ATT(g,t))
- Avoids problematic comparisons in TWFE
- Allows aggregation to various summary parameters
- Handles conditional parallel trends

**Software**: `did` package in R.

---

### Sun and Abraham (2021)

**Citation**: Sun, Liyang, and Sarah Abraham. 2021. "Estimating Dynamic Treatment Effects in Event Studies with Heterogeneous Treatment Effects." *Journal of Econometrics* 225(2): 175-199.

**Key Contribution**:
- Shows standard event study coefficients can be "contaminated" by effects from other periods
- Apparent pre-trends can arise from treatment effect heterogeneity alone
- Proposes interaction-weighted estimator that is robust to heterogeneity

**Implications for VBM Research**:
- Event study plots in Thompson et al. may be affected
- Extension should consider Sun-Abraham estimator for event studies

**Software**: `eventstudyweights` (Stata) for diagnostics.

---

## 4. Key Themes and Gaps in Literature

### What We Know
1. **Turnout effects are modest**: Most rigorous studies find 2-3 percentage point increases
2. **No consistent partisan advantage**: Neither party systematically benefits
3. **Changes how, not who**: VBM changes voting method more than voter composition
4. **Context matters**: Effects may differ between general and special elections

### What Remains Uncertain
1. **Post-COVID dynamics**: Has politicization of VBM changed its effects?
2. **Long-run effects**: Do initial turnout gains persist or fade?
3. **Heterogeneity**: Do effects differ by demographic groups, election types, or time?

### Methodological Considerations
1. **Staggered DiD concerns**: Standard TWFE may be biased with heterogeneous effects
2. **Limited new variation**: Most states are now 100% VBM, reducing ability to estimate effects
3. **COVID confounds**: Difficult to separate VBM effects from pandemic effects in 2020

---

## References (Full Citations)

Amlani, Sharif, and Samuel Collitt. 2022. "The Impact of Vote-By-Mail Policy on Turnout and Vote Share in the 2020 Election." *Election Law Journal* 21(2): 135-149.

Berinsky, Adam J., Nancy Burns, and Michael W. Traugott. 2001. "Who Votes by Mail? A Dynamic Model of the Individual-Level Consequences of Voting-by-Mail Systems." *Public Opinion Quarterly* 65(2): 178-197.

Callaway, Brantly, and Pedro H.C. Sant'Anna. 2021. "Difference-in-Differences with Multiple Time Periods." *Journal of Econometrics* 225(2): 200-230.

Gerber, Alan S., Gregory A. Huber, and Seth J. Hill. 2013. "Identifying the Effect of All-Mail Elections on Turnout: Staggered Reform in the Evergreen State." *Political Science Research and Methods* 1(1): 91-116.

Goodman-Bacon, Andrew. 2021. "Difference-in-Differences with Variation in Treatment Timing." *Journal of Econometrics* 225(2): 254-277.

Gronke, Paul, Eva Galanes-Rosenbaum, Peter A. Miller, and Daniel Toffey. 2008. "Convenience Voting." *Annual Review of Political Science* 11: 437-455.

Kousser, Thad, and Megan Mullin. 2007. "Does Voting by Mail Increase Participation? Using Matching to Analyze a Natural Experiment." *Political Analysis* 15(4): 428-445.

Southwell, Priscilla L., and Justin I. Burchett. 2000. "The Effect of All-Mail Elections on Voter Turnout." *American Politics Quarterly* 28(1): 72-79.

Sun, Liyang, and Sarah Abraham. 2021. "Estimating Dynamic Treatment Effects in Event Studies with Heterogeneous Treatment Effects." *Journal of Econometrics* 225(2): 175-199.

Thompson, Daniel M., Jennifer A. Wu, Jesse Yoder, and Andrew B. Hall. 2020. "Universal Vote-by-Mail Has No Impact on Partisan Turnout or Vote Share." *Proceedings of the National Academy of Sciences* 117(25): 14052-14056.
