
gl root = "~/Dropbox/VBM"

* Bring in the analysis data
project, uses("$root/modified data/analysis.dta")
use "$root/modified data/analysis.dta", clear

* Plot the trend in turnout for CA
preserve
keep if mod(year,4)==2 & prim==0 & state=="CA"
collapse turnout_share, by(vca18 year)
twoway (connected turnout_share year if vca18==0) ///
	(connected turnout_share year if vca18==1), ///
	xli(2016) legend(off) ///
	xsc(r(1997 2019)) xlab(1998(4)2018) ///
	xti("Year") yti("Turnout / Voting-Age Pop") scale(1.3) ///
	text(.43 2003 "Treated Counties") ///
	text(.378 2007 "Control Counties") ///
	ti("California")
graph export "$root/output/diff_in_diff_turnout.pdf", replace
restore

* Plot the trend in turnout for UT
preserve
keep if state=="UT" & mod(year,4)==0 & prim==0
gen ut_switch_btwn_12_16 = inlist(ut_all_mail_year,2014,2016)
drop if ut_all_mail_year<2014
collapse turnout_share, by(ut_switch_btwn_12_16 year)
twoway (connected turnout_share year if ut_switch_btwn_12_16==0) ///
	(connected turnout_share year if ut_switch_btwn_12_16==1), ///
	xli(2014) legend(off) ///
	xsc(r(1995 2017)) xlab(1996(4)2016) ///
	xti("Year") yti("Turnout / Voting-Age Pop") scale(1.3) ///
	text(.576 2003 "Treated Counties") ///
	text(.627 1998 "Control Counties") ///
	ti("Utah")
graph export "$root/output/diff_in_diff_turnout_ut.pdf", replace
restore

* Plot the trend in turnout for WA
preserve
keep if (mod(year,4)==0 & prim==0 & state=="WA" & ///
	inlist(switch_year, 0, 2006, 2010))
collapse turnout_share, by(all_mail2006 year)
twoway (connected turnout_share year if all_mail2006==0) ///
	(connected turnout_share year if all_mail2006==1), ///
	xli(2006) legend(off) ///
	xsc(r(1995 2009)) xlab(1996(4)2008) ///
	xti("Year") yti("Turnout / Voting-Age Pop") scale(1.3) ///
	text(.593 1998 "Treated Counties") ///
	text(.575 2003 "Control Counties") ///
	ti("Washington")
graph export "$root/output/diff_in_diff_turnout_wa.pdf", replace
restore


/*
/////////////////////////////
// Archive
/////////////////////////////

* Plot the trend in turnout for CA and WA
preserve
keep if (mod(year,4)==0 & prim==0 & ///
	state=="WA" & inlist(switch_year, 0, 2006, 2010)) | ///
	(mod(year,4)==2 & prim==0 & state=="CA")
gen switcher = all_mail2006==1 | vca18==1
collapse turnout_share (count) obs=turnout_share, by(state year switcher)
reshape wide turnout_share obs, i(state year) j(switcher)
egen wt = rowtotal(obs*)
gen period = year - 2006*(state=="WA") - 2016*(state=="CA")
collapse turnout_share* [fw=wt], by(period)
twoway (connected turnout_share0 period if period>=-10) ///
	(connected turnout_share1 period if period>=-10), ///
	xli(0) xsc(r(-11 3)) xlab(-10(2)2) ///
	xti("Years Since VBM Expansion") ///
	yti("Turnout / Voting-Age Pop") scale(1.3) ///
	text(.5 -8.5 "Treated Counties") ///
	text(.44 -5.5 "Control Counties") ///
	legend(off)
graph export "$root/output/diff_in_diff_turnout_combined.pdf", replace
restore

* Plot the trend in turnout for CA
preserve
keep if mod(year,4)==2 & prim==0 & state=="CA"
collapse turnout_share, by(vca18 year)
reshape wide turnout_share, i(year) j(vca18)
gen diff = turnout_share1-turnout_share0
graph twoway connected diff year, xli(2016) ///
	ytitle("Diff in Turnout Share, Treat Minus Control") ///
	 xsc(r(1997 2019)) xlab(1998(4)2018) ///
	 xti("Year") scale(1.3) ///
	 text(.018 2006 "Treat Minus Control")
graph export "$root/output/turnout_plot_andy.pdf", replace
restore

* Plot the trend in turnout for WA
preserve
keep if mod(year,4)==0 & prim==0 & state=="WA"
collapse turnout_share, by(all_mail2006 year)
reshape wide turnout_share, i(year) j(all_mail2006)
gen diff = turnout_share1-turnout_share0
graph twoway connected diff year, xli(2006) ///
	ytitle("Diff in Turnout Share, Treat Minus Control") ///
	 xsc(r(1995 2009)) xlab(1996(4)2008) ///
	 xti("Year") scale(1.3) ///
	 text(-.005 2000 "Treat Minus Control")
graph export "$root/output/turnout_diff_wa.pdf", replace
restore

* Plot the trend in turnout for UT
preserve
keep if state=="UT" & mod(year,4)==0 & prim==0
gen ut_switch_btwn_12_16 = inlist(ut_all_mail_year,2014,2016)
drop if ut_all_mail_year<2014
collapse turnout_share, by(ut_switch_btwn_12_16 year)
reshape wide turnout_share, i(year) j(ut_switch_btwn_12_16)
gen diff = turnout_share1-turnout_share0
graph twoway connected diff year, xli(2014) ///
	ytitle("Diff in Turnout Share, Treat Minus Control") ///
	 xsc(r(1995 2017)) xlab(1996(4)2016) ///
	 xti("Year") scale(1.3) ///
	 text(-.005 2000 "Treat Minus Control")
graph export "$root/output/turnout_diff_ut.pdf", replace
restore

* Plot the diff in turnout for CA and WA
preserve
keep if (mod(year,4)==0 & prim==0 & ///
	state=="WA" & inlist(switch_year, 0, 2006, 2010)) | ///
	(mod(year,4)==2 & prim==0 & state=="CA")
gen switcher = all_mail2006==1 | vca18==1
collapse turnout_share (count) obs=turnout_share, by(state year switcher)
reshape wide turnout_share obs, i(state year) j(switcher)
egen wt = rowtotal(obs*)
gen period = year - 2006*(state=="WA") - 2016*(state=="CA")
collapse turnout_share* [fw=wt], by(period)
gen turnout_share_diff = turnout_share1 - turnout_share0
twoway (connected turnout_share_diff period if period>=-10), ///
	xli(0) xsc(r(-11 3)) xlab(-10(2)2) ///
	xti("Years Since VBM Expansion") ///
	yti("Turnout / Voting-Age Pop") scale(1.3) ///
	text(.013 -7 "Treat Minus Control")
graph export "$root/output/turnout_diff_combined.pdf", replace
restore

* Plot the trend in VBM share
preserve
keep if mod(year,4)==2 & prim==0 & state=="CA"
collapse vbm_share, by(vca18 year)
twoway (connected vbm_share year if vca18==0) ///
	 (connected vbm_share year if vca18==1), ///
	 xli(2016) legend(order(1 "Control" 2 "Treat")) ///
	 xsc(r(1997 2019)) xlab(1998(4)2018) ///
	 xti("Year") yti("Mail Ballot Share")
graph export "$root/output/diff_in_diff_vbm_share.pdf", replace
restore
*/
