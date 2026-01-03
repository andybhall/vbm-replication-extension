
gl root = "~/Dropbox/VBM"

********************************************************************
**** WASHINGTON
********************************************************************

* Clean the data from 1998 to 2006
qui foreach y in 1998 2000 2004 2006 {
	project, original("$root/original data/sen_wa/gen`y'.xlsx")
	import excel "$root/original data/sen_wa/gen`y'.xlsx", clear
	gen county = A if A[_n+1]=="Candidate"
	carryforward county, replace
	drop if B=="" | B=="Party"
	rename (B C) (party votes_)
	drop A
	destring votes_, replace
	keep if inlist(party, "D", "R")
	replace party = "dem" if party=="D"
	replace party = "rep" if party=="R"
	reshape wide votes_, i(county) j(party) s
	gen year = `y'
	if `y'==1998 tempfile wa
	if `y'>1998 append using `wa'
	save `wa', replace
	noi di "`y'"
}

* Clean the 2010 data
project, original("$root/original data/sen_wa/gen2010.xlsx")
import excel "$root/original data/sen_wa/gen2010.xlsx", clear
gen county = A if A[_n+1]=="Patty Murray(Prefers Democratic Party)"
carryforward county, replace
gen party = "dem" if regexm(A, "Democratic")
replace party = "rep" if regexm(A, "Republican")
gen votes_ = real(A) if party[_n-1]!=""
carryforward party, replace
keep if votes!=.
keep county party votes
reshape wide votes_, i(county) j(party) s
gen year = 2010
append using `wa'
save `wa', replace

* Clean the 2012, 2016, and 2018 data
foreach y in 2012 2016 2018 {
	project, original("$root/original data/sen_wa/gen`y'.csv")
	import delim "$root/original data/sen_wa/gen`y'.csv", clear varn(1) delim(",")
	keep if regexm(strlower(race), "senator") & regexm(strlower(race), "united states")
	replace party = "dem" if regexm(strlower(party), "democrat")
	replace party = "rep" if regexm(strlower(party), "republican")
	keep county votes party
	rename votes votes_
	reshape wide votes_, i(county) j(party) s
	gen year = `y'
	append using `wa'
	save `wa', replace
}

* Get the two-party vote share
gen dem_share_sen = votes_dem/(votes_dem + votes_rep)
drop votes*

* Save the Washington file
gen prim_or_gen = "general"
gen state = "WA"
save `wa', replace


********************************************************************
**** UTAH
********************************************************************

project, original("$root/original data/participation_and_results_ut/utah_county_election_results.tsv")
import delim "$root/original data/participation_and_results_ut/utah_county_election_results.tsv", clear
destring vote_*, replace i(",")
gen dem_share_sen = vote_sen_dem/(vote_sen_dem+vote_sen_rep)
gen state = "UT"
keep county prim_or_gen year dem_share_sen state
drop if dem_share==.

********************************************************************
**** JOINT
********************************************************************

* Put together the Utah and Washington data
append using `wa'

* Save the Senate election results
order state county year prim dem
save "$root/modified data/senator.dta", replace
project, creates("$root/modified data/senator.dta")
