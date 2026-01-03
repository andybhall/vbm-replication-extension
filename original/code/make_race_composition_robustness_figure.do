
gl root = "~/Dropbox/VBM"

set scheme plotplain

* Bring in the analysis data
project, uses("$root/modified data/analysis.dta")
use "$root/modified data/analysis.dta", clear

* Run regressions changing the age cutoff above which the change in turnout might be located
matrix define output = J(100, 3, .)
local r = 1
qui forval a=34(1)90 {
	noi di `a'
	reghdfe share_votes_high_white`a' treat, ///
		a(county_id i.county_id##c.year state_year) ///
		vce(clust county_id)
	matrix output[`r',1] = _b[treat]
	matrix output[`r',2] = _se[treat]
	matrix output[`r',3] = `a'
	local r = `r' + 1
}

* Prepare the output from the regressions for coefficient plots
svmat output
keep output*
rename (output*) (b se white)
drop if b==.
gen upper = b + se*1.96
gen lower = b - se*1.96
replace white = white/100

* Plot the change in turnout across age
// Figure S10
twoway (rcap lower upper white) ///
	(scatter b white, m(dot)), ///
	xsc(r(0.3 1)) xlab(0.3(0.1)1) ///
	yti("Effect on Share Over Cutoff") ///
	xti("White-Share Cutoff") ///
	scale(1.3) legend(off)
graph export "$root/output/diff_in_diff_race_cutoff_robustness.pdf", replace

