
gl root = "~/Dropbox/VBM"

//////////////////////////////////////
// CA Pres Election Data Cleaning
//////////////////////////////////////

// 2000
project, original("$root/original data/pres/csvs/gen2000.csv")
import delimited using "$root/original data/pres/csvs/gen2000.csv", clear
drop if _n < 7
gen county = substr(v1, 1, 15)
gen v = substr(v1, 16, .)
drop v1
split v
replace county = trim(itrim(county))
drop if inlist(county, "Percent", "State Totals", "")
drop if _n > 127
drop if _n < 111 & _n > 103
drop if _n < 104 & _n > 76
drop if _n < 57 & _n > 21
drop v v3-v9
foreach var of varlist v1-v2 {
	replace  `var' = subinstr(`var', ",", "", .)
}
destring v1-v2, replace 

egen ballots_cast_dem_pres = rowtotal(v1)
egen ballots_cast_rep_pres = rowtotal(v2)
drop v*
gen prim_or_gen = "general"
gen year = 2000
gen dem_share_pres = ballots_cast_dem_pres / (ballots_cast_dem_pres + ballots_cast_rep_pres)

tempfile g_2000
save `g_2000'

// 2004
project, original("$root/original data/pres/csvs/gen2004.csv")
import delimited using "$root/original data/pres/csvs/gen2004.csv", clear

drop if _n < 3
replace v1 =  trim(itrim(v1))
drop if inlist(v1, "Percent", "", "State Totals")
foreach var of varlist v2-v3 {
	replace  `var' = subinstr(`var', ",", "", .)
}

destring v2-v3, replace 
rename v1 county

egen ballots_cast_dem_pres = rowtotal(v2)
egen ballots_cast_rep_pres = rowtotal(v3)
drop v*
gen prim_or_gen = "general"
gen year = 2004
gen dem_share_pres = ballots_cast_dem_pres / (ballots_cast_dem_pres + ballots_cast_rep_pres)

tempfile g_2004
save `g_2004'

// 2008
project, original("$root/original data/pres/csvs/gen2008.csv")
import delimited using "$root/original data/pres/csvs/gen2008.csv", clear

drop if _n < 3
replace v1 =  trim(itrim(v1))
drop if inlist(v1, "Percent", "", "State Totals")
foreach var of varlist v2-v3 {
	replace  `var' = subinstr(`var', ",", "", .)
}

destring v2-v3, replace 
rename v1 county

egen ballots_cast_dem_pres = rowtotal(v2)
egen ballots_cast_rep_pres = rowtotal(v3)
drop v*
gen prim_or_gen = "general"
gen year = 2008
gen dem_share_pres = ballots_cast_dem_pres / (ballots_cast_dem_pres + ballots_cast_rep_pres)

tempfile g_2008
save `g_2008'

// 2012
project, original("$root/original data/pres/csvs/gen2012.csv")
import delimited using "$root/original data/pres/csvs/gen2012.csv", clear

drop if _n < 7
replace v1 =  trim(itrim(v1))
drop if inlist(v1, "Percent", "", "State Totals")
foreach var of varlist v2-v3 {
	replace  `var' = subinstr(`var', ",", "", .)
}

destring v2-v3, replace 
rename v1 county

egen ballots_cast_dem_pres = rowtotal(v2)
egen ballots_cast_rep_pres = rowtotal(v3)
drop v*
gen prim_or_gen = "general"
gen year = 2012
gen dem_share_pres = ballots_cast_dem_pres / (ballots_cast_dem_pres + ballots_cast_rep_pres)
compress

tempfile g_2012
save `g_2012'

// 2016

project, original("$root/original data/pres/csvs/gen2016.csv")
import delimited using "$root/original data/pres/csvs/gen2016.csv", clear

drop if _n < 6
replace v1 =  trim(itrim(v1))
drop if inlist(v1, "Percent", "", "State Totals")
foreach var of varlist v2-v3 {
	replace  `var' = subinstr(`var', ",", "", .)
}

destring v2-v3, replace 
rename v1 county

egen ballots_cast_dem_pres = rowtotal(v2)
egen ballots_cast_rep_pres = rowtotal(v3)
drop v*
gen prim_or_gen = "general"
gen year = 2016
gen dem_share_pres = ballots_cast_dem_pres / (ballots_cast_dem_pres + ballots_cast_rep_pres)
compress

tempfile g_2016
save `g_2016'

append using `g_2000'
append using `g_2004'
append using `g_2008'
append using `g_2012'

gen state = "CA"

tempfile ca
save `ca'


//////////////////////////////////////
// WA Pres Election Data Cleaning
//////////////////////////////////////

* Bring in the WA presidential election results
* abh note: shouldn't this be stored in original data?
project, original("$root/modified data/wa_preselec.csv")
import delim "$root/modified data/wa_preselec.csv", clear

* Fix the party variable
replace party = "dem" if inlist(party, "D", "Democratic Party")
replace party = "rep" if inlist(party, "R", "Republican Party")
replace party = "oth" if !inlist(party, "dem", "rep")

* Get the data to the county-year-party level
collapse (sum) votes_=votes, by(county year party)
reshape wide votes_, i(county year) j(party) s

* Calculate the dem vote share
gen dem_share_pres = votes_dem/(votes_dem + votes_rep)
drop votes_*

* Note the state and election type
gen state = "WA"
gen prim_or_gen = "general"
tempfile wa
save `wa'


//////////////////////////////////////
// UT Pres Election Data Cleaning
//////////////////////////////////////

* Bring in the WA presidential election results
project, original("$root/original data/participation_and_results_ut/utah_county_election_results.tsv")
import delim "$root/original data/participation_and_results_ut/utah_county_election_results.tsv", clear
destring vote*, replace i(",")
gen dem_share_pres = vote_pres_dem/(vote_pres_dem+vote_pres_rep)
gen state = "UT"
keep county year dem_share_pres state prim_or_gen


//////////////////////////////////////
// Joined Pres Election Data Cleaning
//////////////////////////////////////

* Add in the CA and WA data
append using `ca'
append using `wa'

* Clean up the data
order state county prim_or_gen year
sort state county prim_or_gen year
compress

* Save the combined pres file
save "$root/modified data/president.dta", replace
project, creates("$root/modified data/president.dta")
