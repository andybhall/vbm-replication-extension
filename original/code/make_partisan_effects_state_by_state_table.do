gl root = "~/Dropbox/VBM"


/////////////////////////////////////////////
// Build California Table
/////////////////////////////////////////////

* Bring in the analysis data for California
project, uses("$root/modified data/analysis.dta")
use "$root/modified data/analysis.dta", clear
keep if state == "CA"

* Diff-in-diff with state-year fixed effects, Dem turnout share
// Table S4, Col 1
reghdfe share_votes_dem treat, ///
		a(county_id state_year) vce(clust county_id)
local b2 = _b[treat]
local n2 = e(N)
distinct county_id if e(sample)
local nc2 = r(ndistinct)
distinct state_year if e(sample)
local ne2 = r(ndistinct)
areg share_votes_dem treat i.state_year, a(county_id) vce(clust county_id)
boottest treat, nograph cluster(county_id) boottype(wild)
matrix ci = r(CI)
local l2 = ci[1,1]
local u2 = ci[1,2]

* Diff-in-diff with state-year fixed effects and linear trends, Dem turnout share
// Table S4, Col 2
reghdfe share_votes_dem treat, ///
	a(county_id state_year county_id##c.year) ///
	vce(clust county_id)	
local b3 = _b[treat]
local n3 = e(N)
distinct county_id if e(sample)
local nc3 = r(ndistinct)
distinct state_year if e(sample)
local ne3 = r(ndistinct)
areg share_votes_dem treat i.state_year i.county_id#c.year, a(county_id) vce(clust county_id)
boottest treat, nograph cluster(county_id) boottype(wild)
matrix ci = r(CI)
local l3 = ci[1,1]
local u3 = ci[1,2]

* Diff-in-diff with state-year fixed effects and quadratic trends, Dem turnout share
// Table S4, Col 3
reghdfe share_votes_dem treat, ///
	a(election_id county_id##c.year county_id##c.year2) ///
	vce(clust county_id)
local b4 = _b[treat]
local n4 = e(N)
distinct county_id if e(sample)
local nc4 = r(ndistinct)
distinct state_year if e(sample)
local ne4 = r(ndistinct)
areg share_votes_dem treat i.state_year i.county_id#c.year i.county_id#c.year2, a(county_id) vce(clust county_id)
boottest treat, nograph cluster(county_id) boottype(wild)
matrix ci = r(CI)
local l4 = ci[1,1]
local u4 = ci[1,2]

* Prepare an analysis dataset with each row being a state-year-office for California
project, uses("$root/modified data/analysis.dta")
use "$root/modified data/analysis.dta", clear
keep if state=="CA"
keep state county county_id year state_year dem_share* treat year2 year3
reshape long dem_share, i(state county year) j(office) s

* Diff-in-diff with state-year fixed effects, Dem vote share
// Table S4, Col 4
reghdfe dem_share treat, ///
	a(county_id state_year) vce(clust county_id)
local b6 = _b[treat]
local n6 = e(N)
distinct county_id if e(sample)
local nc6 = r(ndistinct)
distinct state_year if e(sample)
local ne6  = r(ndistinct)
areg dem_share treat i.state_year, a(county_id) vce(clust county_id)
boottest treat, nograph cluster(county_id) boottype(wild)
matrix ci = r(CI)
local l6 = ci[1,1]
local u6 = ci[1,2]

* Diff-in-diff with state-year fixed effects and linear trends, Dem vote share
// Table S4, Col 5
reghdfe dem_share treat, ///
	a(county_id state_year county_id##c.year) ///
	vce(clust county_id)
local b7 = _b[treat]
local n7 = e(N)
distinct county_id if e(sample)
local nc7 = r(ndistinct)
distinct state_year if e(sample)
local ne7  = r(ndistinct)
areg dem_share treat i.state_year i.county_id#c.year, a(county_id) vce(clust county_id)
boottest treat, nograph cluster(county_id) boottype(wild)
matrix ci = r(CI)
local l7 = ci[1,1]
local u7 = ci[1,2]

* Diff-in-diff with state-year fixed effects and quadratic trends, Dem vote share
// Table S4, Col 6
reghdfe dem_share treat, ///
	a(state_year county_id##c.year county_id##c.year2) ///
	vce(clust county_id)
local b8 = _b[treat]
local n8 = e(N)
distinct county_id if e(sample)
local nc8 = r(ndistinct)
distinct state_year if e(sample)
local ne8  = r(ndistinct)	
areg dem_share treat i.state_year i.county_id#c.year i.county_id#c.year2, a(county_id) vce(clust county_id)
boottest treat, nograph cluster(county_id) boottype(wild)
matrix ci = r(CI)
local l8 = ci[1,1]
local u8 = ci[1,2]

* Build Table S4
quietly {
	cap log close
	set linesize 255
	log using "$root/output/partisan_effects_table_ca.tex", text replace
	
	noi di "\begin{table}[h]"
	noi di "\centering"
	noi di "\caption{\textbf{Vote-by-Mail Expansion Does Not Appear to Favor Either Party in California.}\label{tab:partisan_effects_ca}}"
	noi di "\begin{tabular}{lcccccc}"
	noi di "\toprule \toprule"
	noi di " & \multicolumn{3}{c}{Dem Turnout Share [0-1]} & \multicolumn{3}{c}{Dem Vote Share [0-1]} \\"
	noi di " & (1) & (2) & (3) & (4) & (5) & (6) \\"
	noi di "\midrule"
	noi di "VBM & " %4.3f `b2' " & " %4.3f `b3' " & " %4.3f `b4' " & " %4.3f `b6' " & " %4.3f `b7' " & " %4.3f `b8' " \\"
	noi di " & [" %4.3f `l2' "," %4.3f `u2' "] & [" %4.3f `l3' "," %4.3f `u3' "] & [" %4.3f `l4' "," %4.3f `u4' "] & [" %4.3f `l6' "," %4.3f `u6' "] & [" %4.3f `l7' "," %4.3f `u7' "] & [" %4.3f `l8' "," %4.3f `u8' "] \\[2mm]"
	noi di "\# Counties & " %8.0fc `nc2' " & " %8.0fc `nc3' " & " %8.0fc `nc4' " & " %8.0fc `nc6' " & " %8.0fc `nc7' " & " %8.0fc `nc8' " \\"
	noi di "\# Elections & " %8.0fc `ne2' " & " %8.0fc `ne3' " & " %8.0fc `ne4' " & " %8.0fc `ne6' " & " %8.0fc `ne7' " & " %8.0fc `ne8' " \\"
	noi di "\# Obs & " %8.0fc `n2' " & " %8.0fc `n3' " & " %8.0fc `n4' " & " %8.0fc `n6' " & " %8.0fc `n7' " & " %8.0fc `n8' " \\"
	noi di "\midrule"
	noi di "County FE & Yes & Yes & Yes & Yes & Yes & Yes \\"
	noi di "Year FE & Yes & Yes & Yes & Yes & Yes & Yes \\"
	noi di "County Trends & No & Linear & Quad & No & Linear & Quad\\"
	noi di "\bottomrule \bottomrule"
	noi di "\multicolumn{7}{p{.8\textwidth}}{\footnotesize{Block wild bootstrap confidence intervals clustered by county in brackets.}}"
	noi di "\end{tabular}"
	noi di "\end{table}"
	
	log off
}




/////////////////////////////////////////////
// Build Utah Table
/////////////////////////////////////////////

* Bring in the analysis data for Utah
project, uses("$root/modified data/analysis.dta")
use "$root/modified data/analysis.dta", clear
keep if state == "UT"

* Diff-in-diff with state-year fixed effects, Dem turnout share
// Table S5, Col 1
reghdfe share_votes_dem treat, ///
		a(county_id state_year) vce(clust county_id)
local b2 = _b[treat]
local n2 = e(N)
distinct county_id if e(sample)
local nc2 = r(ndistinct)
distinct state_year if e(sample)
local ne2 = r(ndistinct)
areg share_votes_dem treat i.state_year, a(county_id) vce(clust county_id)
boottest treat, nograph cluster(county_id) boottype(wild)
matrix ci = r(CI)
local l2 = ci[1,1]
local u2 = ci[1,2]

* Diff-in-diff with state-year fixed effects and linear trends, Dem turnout share
// Table S5, Col 2
reghdfe share_votes_dem treat, ///
	a(county_id state_year county_id##c.year) ///
	vce(clust county_id)	
local b3 = _b[treat]
local n3 = e(N)
distinct county_id if e(sample)
local nc3 = r(ndistinct)
distinct state_year if e(sample)
local ne3 = r(ndistinct)
areg share_votes_dem treat i.state_year i.county_id#c.year, a(county_id) vce(clust county_id)
boottest treat, nograph cluster(county_id) boottype(wild)
matrix ci = r(CI)
local l3 = ci[1,1]
local u3 = ci[1,2]

* Diff-in-diff with state-year fixed effects and quadratic trends, Dem turnout share
// Table S5, Col 3
reghdfe share_votes_dem treat, ///
	a(election_id county_id##c.year county_id##c.year2) ///
	vce(clust county_id)
local b4 = _b[treat]
local n4 = e(N)
distinct county_id if e(sample)
local nc4 = r(ndistinct)
distinct state_year if e(sample)
local ne4 = r(ndistinct)
areg share_votes_dem treat i.state_year i.county_id#c.year i.county_id#c.year2, a(county_id) vce(clust county_id)
boottest treat, nograph cluster(county_id) boottype(wild)
matrix ci = r(CI)
local l4 = ci[1,1]
local u4 = ci[1,2]

* Prepare an analysis dataset with each row being a state-year-office for Utah
project, uses("$root/modified data/analysis.dta")
use "$root/modified data/analysis.dta", clear
keep if state=="UT"
keep state county county_id year state_year dem_share* treat year2 year3
reshape long dem_share, i(state county year) j(office) s

* Diff-in-diff with state-year fixed effects, Dem vote share
// Table S5, Col 4
reghdfe dem_share treat, ///
	a(county_id state_year) vce(clust county_id)
local b6 = _b[treat]
local n6 = e(N)
distinct county_id if e(sample)
local nc6 = r(ndistinct)
distinct state_year if e(sample)
local ne6  = r(ndistinct)
areg dem_share treat i.state_year, a(county_id) vce(clust county_id)
boottest treat, nograph cluster(county_id) boottype(wild)
matrix ci = r(CI)
local l6 = ci[1,1]
local u6 = ci[1,2]

* Diff-in-diff with state-year fixed effects and linear trends, Dem vote share
// Table S5, Col 5
reghdfe dem_share treat, ///
	a(county_id state_year county_id##c.year) ///
	vce(clust county_id)
local b7 = _b[treat]
local n7 = e(N)
distinct county_id if e(sample)
local nc7 = r(ndistinct)
distinct state_year if e(sample)
local ne7  = r(ndistinct)
areg dem_share treat i.state_year i.county_id#c.year, a(county_id) vce(clust county_id)
boottest treat, nograph cluster(county_id) boottype(wild)
matrix ci = r(CI)
local l7 = ci[1,1]
local u7 = ci[1,2]

* Diff-in-diff with state-year fixed effects and quadratic trends, Dem vote share
// Table S5, Col 6
reghdfe dem_share treat, ///
	a(state_year county_id##c.year county_id##c.year2) ///
	vce(clust county_id)
local b8 = _b[treat]
local n8 = e(N)
distinct county_id if e(sample)
local nc8 = r(ndistinct)
distinct state_year if e(sample)
local ne8  = r(ndistinct)	
areg dem_share treat i.state_year i.county_id#c.year i.county_id#c.year2, a(county_id) vce(clust county_id)
boottest treat, nograph cluster(county_id) boottype(wild)
matrix ci = r(CI)
local l8 = ci[1,1]
local u8 = ci[1,2]
		


* Build Table S5
quietly {
	cap log close
	set linesize 255
	log using "$root/output/partisan_effects_table_ut.tex", text replace
	
	noi di "\begin{table}[h]"
	noi di "\centering"
	noi di "\caption{\textbf{Vote-by-Mail Expansion Does Not Appear to Favor Either Party in Utah.}\label{tab:partisan_effects_ut}}"
	noi di "\begin{tabular}{lcccccc}"
	noi di "\toprule \toprule"
	noi di " & \multicolumn{3}{c}{Dem Turnout Share [0-1]} & \multicolumn{3}{c}{Dem Vote Share [0-1]} \\"
	noi di " & (1) & (2) & (3) & (4) & (5) & (6) \\"
	noi di "\midrule"
	noi di "VBM & " %4.3f `b2' " & " %4.3f `b3' " & " %4.3f `b4' " & " %4.3f `b6' " & " %4.3f `b7' " & " %4.3f `b8' " \\"
	noi di " & [" %4.3f `l2' "," %4.3f `u2' "] & [" %4.3f `l3' "," %4.3f `u3' "] & [" %4.3f `l4' "," %4.3f `u4' "] & [" %4.3f `l6' "," %4.3f `u6' "] & [" %4.3f `l7' "," %4.3f `u7' "] & [" %4.3f `l8' "," %4.3f `u8' "] \\[2mm]"
	noi di "\# Counties & " %8.0fc `nc2' " & " %8.0fc `nc3' " & " %8.0fc `nc4' " & " %8.0fc `nc6' " & " %8.0fc `nc7' " & " %8.0fc `nc8' " \\"
	noi di "\# Elections & " %8.0fc `ne2' " & " %8.0fc `ne3' " & " %8.0fc `ne4' " & " %8.0fc `ne6' " & " %8.0fc `ne7' " & " %8.0fc `ne8' " \\"
	noi di "\# Obs & " %8.0fc `n2' " & " %8.0fc `n3' " & " %8.0fc `n4' " & " %8.0fc `n6' " & " %8.0fc `n7' " & " %8.0fc `n8' " \\"
	noi di "\midrule"
	noi di "County FE & Yes & Yes & Yes & Yes & Yes & Yes \\"
	noi di "Year FE & Yes & Yes & Yes & Yes & Yes & Yes \\"
	noi di "County Trends & No & Linear & Quad & No & Linear & Quad\\"
	noi di "\bottomrule \bottomrule"
	noi di "\multicolumn{7}{p{.8\textwidth}}{\footnotesize{Block wild bootstrap confidence intervals clustered by county in brackets.}}"
	noi di "\end{tabular}"
	noi di "\end{table}"
	
	log off
}



/////////////////////////////////////////////
// Build Washington Table
/////////////////////////////////////////////

* Prepare an analysis dataset with each row being a state-year-office for Utah
project, uses("$root/modified data/analysis.dta")
use "$root/modified data/analysis.dta", clear
keep if state=="WA"
keep state county county_id year state_year dem_share* treat year2 year3
reshape long dem_share, i(state county year) j(office) s

* Diff-in-diff with state-year fixed effects, Dem vote share
// Table S6, Col 1
reghdfe dem_share treat, ///
	a(county_id state_year) vce(clust county_id)
local b6 = _b[treat]
local n6 = e(N)
distinct county_id if e(sample)
local nc6 = r(ndistinct)
distinct state_year if e(sample)
local ne6  = r(ndistinct)
areg dem_share treat i.state_year, a(county_id) vce(clust county_id)
boottest treat, nograph cluster(county_id) boottype(wild)
matrix ci = r(CI)
local l6 = ci[1,1]
local u6 = ci[1,2]

* Diff-in-diff with state-year fixed effects and linear trends, Dem vote share
// Table S6, Col 2
reghdfe dem_share treat, ///
	a(county_id state_year county_id##c.year) ///
	vce(clust county_id)
local b7 = _b[treat]
local n7 = e(N)
distinct county_id if e(sample)
local nc7 = r(ndistinct)
distinct state_year if e(sample)
local ne7  = r(ndistinct)
areg dem_share treat i.state_year i.county_id#c.year, a(county_id) vce(clust county_id)
boottest treat, nograph cluster(county_id) boottype(wild)
matrix ci = r(CI)
local l7 = ci[1,1]
local u7 = ci[1,2]

* Diff-in-diff with state-year fixed effects and quadratic trends, Dem vote share
// Table S6, Col 3
reghdfe dem_share treat, ///
	a(state_year county_id##c.year county_id##c.year2) ///
	vce(clust county_id)
local b8 = _b[treat]
local n8 = e(N)
distinct county_id if e(sample)
local nc8 = r(ndistinct)
distinct state_year if e(sample)
local ne8  = r(ndistinct)	
areg dem_share treat i.state_year i.county_id#c.year i.county_id#c.year2, a(county_id) vce(clust county_id)
boottest treat, nograph cluster(county_id) boottype(wild)
matrix ci = r(CI)
local l8 = ci[1,1]
local u8 = ci[1,2]	


* Build Table S6
quietly {
	cap log close
	set linesize 255
	log using "$root/output/partisan_effects_table_wa.tex", text replace
	
	noi di "\begin{table}[h]"
	noi di "\centering"
	noi di "\caption{\textbf{Vote-by-Mail Expansion Does Not Appear to Favor Either Party in Washington.}\label{tab:partisan_effects_wa}}"
	noi di "\begin{tabular}{lccc}"
	noi di "\toprule \toprule"
	noi di " & \multicolumn{3}{c}{Dem Vote Share [0-1]} \\"
	noi di " & (1) & (2) & (3) \\"
	noi di "\midrule"
	noi di "VBM & " %4.3f `b6' " & " %4.3f `b7' " & " %4.3f `b8' " \\"
	noi di " & [" %4.3f `l6' "," %4.3f `u6' "] & [" %4.3f `l7' "," %4.3f `u7' "] & [" %4.3f `l8' "," %4.3f `u8' "] \\[2mm]"
	noi di "\# Counties & " %8.0fc `nc6' " & " %8.0fc `nc7' " & " %8.0fc `nc8' " \\"
	noi di "\# Elections & " %8.0fc `ne6' " & " %8.0fc `ne7' " & " %8.0fc `ne8' " \\"
	noi di "\# Obs  & " %8.0fc `n6' " & " %8.0fc `n7' " & " %8.0fc `n8' " \\"
	noi di "\midrule"
	noi di "County FE & Yes & Yes & Yes  \\"
	noi di "Year FE & Yes & Yes & Yes  \\"
	noi di "County Trends & No & Linear & Quad \\"
	noi di "\bottomrule \bottomrule"
	noi di "\multicolumn{4}{p{.5\textwidth}}{\footnotesize{Block wild bootstrap confidence intervals clustered by county in brackets.}}"
	noi di "\end{tabular}"
	noi di "\end{table}"
	
	log off
}

