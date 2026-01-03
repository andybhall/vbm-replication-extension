gl root = "~/Dropbox/VBM"

* Bring in the analysis data
project, uses("$root/modified data/analysis.dta")
use "$root/modified data/analysis.dta", clear

* Diff-in-diff with state-year fixed effects, Dem turnout share
// Table 2, Col 1
reghdfe share_votes_dem treat, ///
	a(county_id state_year) vce(clust county_id)
local b1 = _b[treat]
local se1 = _se[treat]
local n1 = e(N)
distinct county_id if e(sample)
local nc1 = r(ndistinct)
distinct state_year if e(sample)
local ne1 = r(ndistinct)

* Diff-in-diff with state-year fixed effects and linear trends, Dem turnout share
// Table 2, Col 2
reghdfe share_votes_dem treat, ///
	a(county_id county_id##c.year state_year) ///
	vce(clust county_id)	
local b2 = _b[treat]
local se2 = _se[treat]
local n2 = e(N)
distinct county_id if e(sample)
local nc2 = r(ndistinct)
distinct state_year if e(sample)
local ne2 = r(ndistinct)

* Diff-in-diff with state-year fixed effects and quadratic trends, Dem turnout share
// Table 2, Col 3
reghdfe share_votes_dem treat, ///
	a(county_id##c.year county_id##c.year2 state_year) ///
	vce(clust county_id)
local b3 = _b[treat]
local se3 = _se[treat]
local n3 = e(N)
distinct county_id if e(sample)
local nc3 = r(ndistinct)
distinct state_year if e(sample)
local ne3 = r(ndistinct)


* Prepare an analysis dataset with each row being a state-year-office
project, uses("$root/modified data/analysis.dta")
use "$root/modified data/analysis.dta", clear
keep state county county_id year state_year dem_share* treat year2 year3
reshape long dem_share, i(state county year) j(office) s

* Diff-in-diff with state-year fixed effects, Dem vote share
// Table 2, Col 4
reghdfe dem_share treat, ///
	a(county_id state_year) vce(clust county_id)
local b4 = _b[treat]
local se4 = _se[treat]
local n4 = e(N)
distinct county_id if e(sample)
local nc4 = r(ndistinct)
distinct state_year if e(sample)
local ne4 = r(ndistinct)

* Diff-in-diff with state-year fixed effects and linear trends, Dem vote share
// Table 2, Col 5	
reghdfe dem_share treat, ///
	a(county_id state_year county_id##c.year) ///
	vce(clust county_id)
local b5 = _b[treat]
local se5 = _se[treat]
local n5 = e(N)
distinct county_id if e(sample)
local nc5 = r(ndistinct)
distinct state_year if e(sample)
local ne5  = r(ndistinct)

* Diff-in-diff with state-year fixed effects and quadratic trends, Dem vote share
// Table 2, Col 6
reghdfe dem_share treat, ///
	a(state_year county_id county_id##c.year county_id##c.year2) ///
	vce(clust county_id)
local b6 = _b[treat]
local se6 = _se[treat]
local n6 = e(N)
distinct county_id if e(sample)
local nc6 = r(ndistinct)
distinct state_year if e(sample)
local ne6  = r(ndistinct)


* Build the table
quietly {
	cap log close
	set linesize 255
	log using "$root/output/partisan_effects_table.tex", text replace
	
	noi di "\begin{table}[t]"
	noi di "\centering"
	noi di "\caption{\textbf{Vote-by-Mail Expansion Does Not Appear to Favor Either Party.}\label{tab:partisan_effects}}"
	noi di "\begin{tabular}{lcccccc}"
	noi di "\toprule \toprule"
	noi di " & \multicolumn{3}{c}{Dem Turnout Share [0-1]} & \multicolumn{3}{c}{Dem Vote Share [0-1]} \\"
	noi di " & (1) & (2) & (3) & (4) & (5) & (6)  \\"
	noi di "\midrule"
	noi di "VBM & " %4.3f `b1' " & " %4.3f `b2' " & " %4.3f `b3' " & " %4.3f `b4' " & " %4.3f `b5' " & " %4.3f `b6'  " \\"
	noi di " & (" %4.3f `se1' ") & (" %4.3f `se2' ") & (" %4.3f `se3' ") & (" %4.3f `se4' ") & (" %4.3f `se5' ") & (" %4.3f `se6' ")  \\[2mm]"
	noi di "\# Counties & " %8.0fc `nc1' " & " %8.0fc `nc2' " & " %8.0fc `nc3' " & " %8.0fc `nc4' " & " %8.0fc `nc5' " & " %8.0fc `nc6' " \\"
	noi di "\# Elections & " %8.0fc `ne1' " & " %8.0fc `ne2' " & " %8.0fc `ne3' " & " %8.0fc `ne4' " & " %8.0fc `ne5' " & " %8.0fc `ne6' " \\"
	noi di "\# Obs & " %8.0fc `n1' " & " %8.0fc `n2' " & " %8.0fc `n3' " & " %8.0fc `n4' " & " %8.0fc `n5' " & " %8.0fc `n6' " \\"
	noi di "\midrule"
	noi di "County FE & Yes & Yes & Yes & Yes & Yes & Yes \\"
	noi di "State by Year FE & Yes & Yes & Yes & Yes & Yes & Yes \\"
	noi di "County Trends & No & Linear & Quad & No & Linear & Quad\\"
	noi di "\bottomrule \bottomrule"
	noi di "\multicolumn{7}{p{.8\textwidth}}{\footnotesize{Robust standard errors clustered by county in parentheses.  "
	noi di "The number of counties is smaller in columns 1-3 because we have partisan turnout share for CA and UT, but not WA.  "
	noi di "Columns 4-6 use data from all three states.}}"
	noi di "\end{tabular}"
	noi di "\end{table}"
	
	log off
}
