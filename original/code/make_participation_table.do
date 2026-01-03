gl root = "~/Dropbox/VBM"

* Bring in the analysis data
project, uses("$root/modified data/analysis.dta")
use "$root/modified data/analysis.dta", clear

* Diff-in-diff with state-year fixed effects, turnout share
// Table 3, Col 1
reghdfe turnout_share treat, ///
	a(county_id state_year) vce(clust county_id)
local b1 = _b[treat]
local se1 = _se[treat]
local n1 = e(N)
distinct county_id if e(sample)
local nc1 = r(ndistinct)
distinct state_year if e(sample)
local ne1 = r(ndistinct)

* Diff-in-diff with state-year fixed effects and linear trends, turnout share
// Table 3, Col 2
reghdfe turnout_share treat, ///
	a(county_id##c.year state_year) ///
	vce(clust county_id)
local b2 = _b[treat]
local se2 = _se[treat]
local n2 = e(N)
distinct county_id if e(sample)
local nc2 = r(ndistinct)
distinct state_year if e(sample)
local ne2 = r(ndistinct)		

* Diff-in-diff with state-year fixed effects and quadratic trends, turnout share
// Table 3, Col 3
reghdfe turnout_share treat, ///
	a(county_id##c.year county_id##c.year2 state_year) ///
	vce(clust county_id)
local b3 = _b[treat]
local se3 = _se[treat]
local n3 = e(N)
distinct county_id if e(sample)
local nc3 = r(ndistinct)
distinct state_year if e(sample)
local ne3 = r(ndistinct)

* Diff-in-diff with state-year fixed effects, vote-by-mail share
// Table 3, Col 4
reghdfe vbm_share treat if state=="CA", ///
	a(county_id state_year) vce(clust county_id)
local b4 = _b[treat]
local se4 = _se[treat]
local n4 = e(N)
distinct county_id if e(sample)
local nc4 = r(ndistinct)
distinct state_year if e(sample)
local ne4 = r(ndistinct)

* Diff-in-diff with state-year fixed effects and linear trends, vote-by-mail share
// Table 3, Col 5
reghdfe vbm_share treat if state=="CA", ///
	a(county_id##c.year state_year) vce(clust county_id)
local b5 = _b[treat]
local se5 = _se[treat]
local n5 = e(N)
distinct county_id if e(sample)
local nc5 = r(ndistinct)
distinct state_year if e(sample)
local ne5 = r(ndistinct)

* Diff-in-diff with state-year fixed effects and quadratic trends, vote-by-mail share
// Table 3, Col 6
reghdfe vbm_share treat if state=="CA", ///
	a(county_id##c.year county_id##c.year2 state_year) ///
	vce(clust county_id)
local b6 = _b[treat]
local se6 = _se[treat]
local n6 = e(N)
distinct county_id if e(sample)
local nc6 = r(ndistinct)
distinct state_year if e(sample)
local ne6 = r(ndistinct)


* Build the table
quietly {
	cap log close
	set linesize 255
	log using "$root/output/participation_table.tex", text replace
	
	noi di "\begin{table}[t]"
	noi di "\centering"
	noi di "\caption{\textbf{Vote-by-Mail Expansion Increases Participation.}\label{tab:participation}}"
	noi di "\begin{tabular}{lcccccc}"
	noi di "\toprule \toprule"
	noi di " & \multicolumn{3}{c}{Turnout Share [0-1]} & \multicolumn{3}{c}{Vote-by-Mail Share [0-1]} \\"
	noi di " & (1) & (2) & (3) & (4) & (5) & (6) \\"
	noi di "\midrule"
	noi di "VBM & " %4.3f `b1' " & " %4.3f `b2' " & " %4.3f `b3' " & " %4.3f `b4' " & " %4.3f `b5' " & " %4.3f `b6' " \\"
	noi di " & (" %4.3f `se1' ") & (" %4.3f `se2' ") & (" %4.3f `se3' ") & (" %4.3f `se4' ") & (" %4.3f `se5' ") & (" %4.3f `se6' ") \\[2mm]"
	noi di "\# Counties & " %8.0fc `nc1' " & " %8.0fc `nc2' " & " %8.0fc `nc3' " & " %8.0fc `nc4' " & " %8.0fc `nc5' " & " %8.0fc `nc6' " \\"
	noi di "\# Elections & " %8.0fc `ne1' " & " %8.0fc `ne2' " & " %8.0fc `ne3' " & " %8.0fc `ne4' " & " %8.0fc `ne5' " & " %8.0fc `ne6' " \\"
	noi di "\# Obs & " %8.0fc `n1' " & " %8.0fc `n2' " & " %8.0fc `n3' " & " %8.0fc `n4' " & " %8.0fc `n5' " & " %8.0fc `n6' " \\"
	noi di "\midrule"
	noi di "County FE & Yes & Yes & Yes & Yes & Yes & Yes \\"
	noi di "State by Year FE & Yes & Yes & Yes & Yes & Yes & Yes \\"
	noi di "County Trends & No & Linear & Quad & No & Linear & Quad \\"
	noi di "\bottomrule \bottomrule"
	noi di "\multicolumn{7}{p{.8\textwidth}}{\footnotesize{Robust standard errors clustered by county in parentheses.}}"
	noi di "\end{tabular}"
	noi di "\end{table}"
	
	log off
}

