
gl root = "~/Dropbox/VBM"

////////////////////////////////////
// Prepare and analysis file with leads
////////////////////////////////////

* Bring in the analysis data
use "$root/modified data/analysis.dta", clear

* Produce the leads
sort county_type_id year
by county_type_id: gen switch = treat - treat[_n-1]
by county_type_id: gen lead1 = switch[_n+1]
by county_type_id: gen lead2 = switch[_n+2]
by county_type_id: gen lead3 = switch[_n+3]
replace lead1 = 0 if lead1==.
replace lead2 = 0 if lead2==.
replace lead3 = 0 if lead3==.

* Save the analysis dataset with leads
tempfile data_w_leads
save `data_w_leads'


////////////////////////////////////
// Dem Turnout Share Leads Plot (Figure S5, Left Panel)
////////////////////////////////////

* Bring in the data with leads
use `data_w_leads', clear

* Run the reg and store the leads and treatment variable
reghdfe share_votes_dem lead3 lead2 lead1 treat, ///
	a(county_id state_year) ///
	vce(clust county_id)
gen t = _n-4 if _n<=4
gen b = _b[lead3] if t==-3
replace b = _b[lead2] if t==-2
replace b = _b[lead1] if t==-1
replace b = _b[treat] if t==0
gen se = _se[lead3] if t==-3
replace se = _se[lead2] if t==-2
replace se = _se[lead1] if t==-1
replace se = _se[treat] if t==0
gen lower = b - 1.96*se
gen upper = b + 1.96*se

* Plot the leads
// Figure S5, Left Panel
twoway (rcap lower upper t if t<0, lc(gs10) mc(gs10)) ///
	(scatter b t if t<0, mc(gs10) m(Oh)) ///
	(rcap lower upper t if t==0, lc(gs2) mc(gs2)) ///
	(scatter b t if t==0, mc(gs2) m(Oh)), legend(off) scale(1.3) ///
	xsc(r(-3.5 0.5)) xlab(-3(1)0) ///
	xti("Elections Since Treatment") ///
	yti("Within-County Diff in Dem Turnout Share")
graph export "$root/output/share_votes_dem_leads.pdf", replace


////////////////////////////////////
// Dem Vote Share Leads Plot (Figure S5, Right Panel)
////////////////////////////////////

* Bring in the data with leads
use `data_w_leads', clear

* Stack presidential, gubernatiorial, and senate races
keep state county county_id year year2 state_year dem_share* treat lead* 
reshape long dem_share, i(state county year) j(office) s

* Run the reg and store the leads and treatment variable
reghdfe dem_share lead3 lead2 lead1 treat, ///
	a(county_id state_year) ///
	vce(clust county_id)
gen t = _n-4 if _n<=4
gen b = _b[lead3] if t==-3
replace b = _b[lead2] if t==-2
replace b = _b[lead1] if t==-1
replace b = _b[treat] if t==0
gen se = _se[lead3] if t==-3
replace se = _se[lead2] if t==-2
replace se = _se[lead1] if t==-1
replace se = _se[treat] if t==0
gen lower = b - 1.96*se
gen upper = b + 1.96*se

* Plot the leads
// Figure S5, Right Panel
twoway (rcap lower upper t if t<0, lc(gs10) mc(gs10)) ///
	(scatter b t if t<0, mc(gs10) m(Oh)) ///
	(rcap lower upper t if t==0, lc(gs2) mc(gs2)) ///
	(scatter b t if t==0, mc(gs2) m(Oh)), legend(off) scale(1.3) ///
	xsc(r(-3.5 0.5)) xlab(-3(1)0) ///
	xti("Elections Since Treatment") ///
	yti("Within-County Diff in Dem Vote Share")
graph export "$root/output/dem_share_leads.pdf", replace


////////////////////////////////////
// Turnout Leads Plot (Figure S6)
////////////////////////////////////

* Bring in the data with leads
use `data_w_leads', clear

* Run the reg and store the leads and treatment variable
reghdfe turnout_share lead3 lead2 lead1 treat, ///
	a(county_id state_year) ///
	vce(clust county_id)
gen t = _n-4 if _n<=4
gen b = _b[lead3] if t==-3
replace b = _b[lead2] if t==-2
replace b = _b[lead1] if t==-1
replace b = _b[treat] if t==0
gen se = _se[lead3] if t==-3
replace se = _se[lead2] if t==-2
replace se = _se[lead1] if t==-1
replace se = _se[treat] if t==0
gen lower = b - 1.96*se
gen upper = b + 1.96*se

* Plot the leads
// Figure S6
twoway (rcap lower upper t if t<0, lc(gs10) mc(gs10)) ///
	(scatter b t if t<0, mc(gs10) m(Oh)) ///
	(rcap lower upper t if t==0, lc(gs2) mc(gs2)) ///
	(scatter b t if t==0, mc(gs2) m(Oh)), legend(off) scale(1.3) ///
	xsc(r(-3.5 0.5)) xlab(-3(1)0) ///
	xti("Elections Since Treatment") ///
	yti("Within-County Diff in Turnout Rate")
graph export "$root/output/turnout_share_leads.pdf", replace
