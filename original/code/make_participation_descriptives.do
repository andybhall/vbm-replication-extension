
gl root = "~/Dropbox/VBM"

* Bring in the analysis data
project, uses("$root/modified data/analysis.dta")
use "$root/modified data/analysis.dta", clear

* VBM program participation
// Figure 1
preserve 
collapse (mean) treat_share=treat, by(state year)
twoway (connected treat_share year if state=="CA") ///
	(connected treat_share year if state=="UT") ///
	(connected treat_share year if state=="WA"), ///
	xti("Year") yti("Share of Counties w All-Mail Elections") ///
	xsc(r(1995 2021)) xlab(1996(4)2020) ///
	ysc(r(0 1)) ylab(0(.2)1) ///
	text(.75 2002.5 "Washington") ///
	text(.45 2013 "Utah") ///
	text(.2 2016.8 "California") ///
	legend(off) scale(1.3)
graph export "$root/output/treat_share_gen.pdf", replace
restore

* Vote by mail share over time, general elections, california
// Figure S2
hist vbm_share if prim==0 & state=="CA" & year != 2000, ///
	by(year, note("")) start(0) w(.05) ///
	xti("Mail Votes/Turnout") ///
	yti("Num of Counties") freq
graph export "$root/output/hist_vbm_gen_ca.pdf", replace

* Vote by mail share over time, general elections, washington
// Figure S3
replace vbm_share = 1 if vbm_share > 1 & vbm_share != .
hist vbm_share if prim==0 & state=="WA" & year <= 2010, ///
	by(year, note("")) start(0) w(.05) ///
	xti("Mail Votes/Turnout") ///
	yti("Num of Counties") freq
graph export "$root/output/hist_vbm_gen_wa.pdf", replace
