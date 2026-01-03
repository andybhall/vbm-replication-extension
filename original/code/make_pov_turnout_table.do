gl root = "~/Dropbox/VBM"

* Bring in the analysis data
project, uses("$root/modified data/analysis.dta")
use "$root/modified data/analysis.dta", clear

* Diff-in-diff with state-year fixed effects, 
* turnout share from tracts with >13% above poverty line
// Table S12, Col 1
reghdfe share_votes_high_pov13 treat, ///
		a(county_id state_year) vce(clust county_id)
local b1 = _b[treat]
local se1 = _se[treat]
local n1 = e(N)
distinct county_id if e(sample)
local nc1 = r(ndistinct)
distinct state_year if e(sample)
local ne1 = r(ndistinct)

* Diff-in-diff with state-year fixed effects and linear trends, 
* turnout share from tracts with >13% above poverty line
// Table S12, Col 2
reghdfe share_votes_high_pov13 treat, ///
	a(county_id state_year county_id##c.year) ///
	vce(clust county_id)
local b2 = _b[treat]
local se2 = _se[treat]
local n2 = e(N)
distinct county_id if e(sample)
local nc2 = r(ndistinct)
distinct state_year if e(sample)
local ne2 = r(ndistinct)

* Diff-in-diff with state-year fixed effects and quadratic trends, 
* turnout share from tracts with >13% above poverty line
// Table S12, Col 3
reghdfe share_votes_high_pov13 treat, ///
	a(state_year county_id##c.year county_id##c.year2) ///
	vce(clust county_id)
local b3 = _b[treat]
local se3 = _se[treat]
local n3 = e(N)
distinct county_id if e(sample)
local nc3 = r(ndistinct)
distinct state_year if e(sample)
local ne3 = r(ndistinct)


* Build Table S12
quietly {
	cap log close
	set linesize 255
	log using "$root/output/pov_effects_table.tex", text replace
	
	noi di "\begin{table}[h]"
	noi di "\centering"
	noi di "\caption{\textbf{Vote-by-Mail Expansion Does Not Appear Have Large Effects on Socio-Economic Status of the Electorate.}\label{tab:pov_effects}}"
	noi di "\begin{tabular}{lccc}"
	noi di "\toprule \toprule"
	noi di " & \multicolumn{3}{c}{Turnout Share High-Poverty Tracts [0-1]}  \\"
	noi di " & (1) & (2) & (3)   \\"
	noi di "\midrule"
	noi di "VBM & " %4.3f `b1' " & " %4.3f `b2' " & " %4.3f `b3'  " \\"
	noi di " & (" %4.3f `se1' ") & (" %4.3f `se2' ") & (" %4.3f `se3' ")  \\[2mm]"
	noi di "\# Counties & " %8.0fc `nc1' " & " %8.0fc `nc2' " & " %8.0fc `nc3'  " \\"
	noi di "\# Elections & " %8.0fc `ne1' " & " %8.0fc `ne2' " & " %8.0fc `ne3'  " \\"
	noi di "\# Obs & " %8.0fc `n1' " & " %8.0fc `n2' " & " %8.0fc `n3'  " \\"
	noi di "\midrule"
	noi di "County FE & Yes & Yes & Yes \\"
	noi di "State by Year FE &  Yes & Yes & Yes  \\"
	noi di "County Trends & No  & Linear & Quad \\"
	noi di "\bottomrule \bottomrule"
	noi di "\multicolumn{4}{p{.5\textwidth}}{\footnotesize{Robust standard errors clustered by county in parentheses.}}"
	noi di "\end{tabular}"
	noi di "\end{table}"
	
	log off
}
