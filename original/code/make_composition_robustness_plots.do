
gl root = "~/Dropbox/VBM"

set scheme plotplain

* Bring in the analysis data
project, uses("$root/modified data/analysis.dta")
project, uses("$root/modified data/composition_age_robustness.dta")
use "$root/modified data/analysis.dta", clear
keep if inlist(state,"CA","UT")
merge 1:1 state county year prim_or_gen ///
	using "$root/modified data/composition_age_robustness.dta", keep(1 3)
tempfile data
save `data'


/*
Check robustness to years included in the estimation (Figures S4 and S7)
*/

* Run regressions, limiting the data to years closer and closer to the policy change
matrix define output = J(9, 5, .)
local r = 1
qui forval y=1998(2)2014 {
	noi di `y'
	reghdfe share_votes_rep treat if year>=`y', ///
		a(county_id state_year) vce(clust county_id)
	matrix output[`r',1] = _b[treat]
	matrix output[`r',2] = _se[treat]
	reghdfe share_votes_dem treat if year>=`y', ///
		a(county_id state_year) vce(clust county_id)
	matrix output[`r',3] = _b[treat]
	matrix output[`r',4] = _se[treat]
	matrix output[`r',5] = `y'
	local r = `r' + 1
}

* Prepare the output from the regressions for coefficient plots
svmat output
keep output*
rename (output*) (b_rep se_rep b_dem se_dem year)
drop if b_rep==.
gen upper_rep = b_rep + se_rep*1.96
gen lower_rep = b_rep - se_rep*1.96
gen upper_dem = b_dem + se_dem*1.96
gen lower_dem = b_dem - se_dem*1.96

* Plot the dem turnout share results after restricting the data 
* to fewer and fewer elections
// Figure S4
twoway (rcap lower_dem upper_dem year) ///
	(scatter b_dem year, m(dot)), ///
	xsc(r(1997 2014)) xlab(1998(4)2015) ///
	yti("Effect on Dem Share of Electorate") ///
	xti("First Year Included in Regression") ///
	scale(1.3) legend(off)
graph export "$root/output/diff_in_diff_dem_year_robustness.pdf", replace

* Plot the rep turnout share results after restricting the data 
* to fewer and fewer elections
// Figure S7
twoway (rcap lower_rep upper_rep year) ///
	(scatter b_rep year, m(dot)), ///
	xsc(r(1997 2015)) xlab(1998(4)2014) ///
	yti("Effect on Rep Share of Electorate") ///
	xti("First Year Included in Regression") ///
	scale(1.3) legend(off)
graph export "$root/output/diff_in_diff_rep_year_robustness.pdf", replace


/*
Check robustness to age used as cutoff for defining older voters (Figures S8)
*/

* Run regressions changing the age cutoff above which the change in turnout might be located
use `data', clear
matrix define output = J(100, 3, .)
local r = 1
qui forval a=30(1)64 {
	noi di `a'
	reghdfe share_votes_above`a' treat, ///
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
rename (output*) (b se age)
drop if b==.
gen upper = b + se*1.96
gen lower = b - se*1.96

* Plot the change in turnout across age
// Figure S8
twoway (rcap lower upper age) ///
	(scatter b age, m(dot)), ///
	xsc(r(28 67)) xlab(30(5)65) ///
	ysc(r(-0.04 0.02)) ylab(-0.04(0.01)0.02) ///
	yti("Effect on Share Over Age Cutoff") ///
	xti("Age Cutoff") ///
	scale(1.3) legend(off)
graph export "$root/output/diff_in_diff_age_cutoff_robustness.pdf", replace

