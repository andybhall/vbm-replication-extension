gl root = "~/Dropbox/VBM"

********************************************************************
**** CALIFORNIA
********************************************************************

// 1998
project, original("$root/original data/gov/csvs/prim1998.csv")
import delimited using "$root/original data/gov/csvs/prim1998.csv", clear
rename v1 v
gen county = substr(v, 1, 15)
gen second = substr(v, 16, .)
replace county = trim(itrim(county))
replace second = trim(itrim(second))
drop if inlist(county, "Percent, Party", "Percent, Total", "")
drop if _n > 77
drop if _n < 67 & _n > 61
drop if _n < 46 & _n > 40
drop if _n < 26 & _n > 20
drop if _n < 5
drop v
rename second v
split v
foreach var of varlist v1-v9 {
	replace  `var' = subinstr(`var', ",", "", .)
}
destring v1-v9, replace 

egen ballots_cast_dem_gov = rowtotal(v1-v6)
egen ballots_cast_rep_gov = rowtotal(v7-v9)
drop v*
gen prim_or_gen = "primary"
gen year = 1998
gen dem_share_gov = ballots_cast_dem_gov / (ballots_cast_dem_gov + ballots_cast_rep_gov)

tempfile p_1998
save `p_1998'

project, original("$root/original data/gov/csvs/gen1998.csv")
import delimited using "$root/original data/gov/csvs/gen1998.csv", clear

gen county = substr(v, 1, 15)
gen second = substr(v, 16, .)
replace county = trim(itrim(county))
replace second = trim(itrim(second))
drop if inlist(county, "Percent", "")
drop if _n > 72
drop if _n < 60 & _n > 54
drop if _n < 32 & _n > 26
drop if _n < 5
drop v
rename second v
split v
foreach var of varlist v1-v2 {
	replace  `var' = subinstr(`var', ",", "", .)
}
destring v1-v2, replace 

egen ballots_cast_dem_gov = rowtotal(v1)
egen ballots_cast_rep_gov = rowtotal(v2)
drop v*
gen prim_or_gen = "general"
gen year = 1998
gen dem_share_gov = ballots_cast_dem_gov / (ballots_cast_dem_gov + ballots_cast_rep_gov)

tempfile g_1998
save `g_1998'

// 2002
project, original("$root/original data/gov/csvs/prim2002.csv")
import delim using "$root/original data/gov/csvs/prim2002.csv", clear
drop if _n < 10
replace v1 = trim(itrim(v1))
drop v13-v20
drop if inlist(v1, "Percent", "State Totals", "")
rename v1 county
foreach var of varlist v2-v12 {
	replace  `var' = subinstr(`var', ",", "", .)
}
destring v2-v12, replace 

egen ballots_cast_dem_gov = rowtotal(v2-v5)
egen ballots_cast_rep_gov = rowtotal(v6-v12)
drop v*
gen prim_or_gen = "primary"
gen year = 2002
gen dem_share_gov = ballots_cast_dem_gov / (ballots_cast_dem_gov + ballots_cast_rep_gov)

tempfile p_2002
save `p_2002'

project, original("$root/original data/gov/csvs/gen2002.csv")
import delim using "$root/original data/gov/csvs/gen2002.csv", clear
drop if _n < 2
replace v1 = trim(itrim(v1))
drop v4-v17
drop if inlist(v1, "Percent", "State Totals", "")
rename v1 county
foreach var of varlist v2-v3 {
	replace  `var' = subinstr(`var', ",", "", .)
}
destring v2-v3, replace 

egen ballots_cast_dem_gov = rowtotal(v2)
egen ballots_cast_rep_gov = rowtotal(v3)
drop v*
gen prim_or_gen = "general"
gen year = 2002
gen dem_share_gov = ballots_cast_dem_gov / (ballots_cast_dem_gov + ballots_cast_rep_gov)

tempfile g_2002
save `g_2002'

// 2006
project, original("$root/original data/gov/csvs/prim2006.csv")
import delim using "$root/original data/gov/csvs/prim2006.csv", clear
drop if _n < 18
replace v1 = trim(itrim(v1))
drop v14-v17
drop if inlist(v1, "Percent", "State Totals", "")
rename v1 county
foreach var of varlist v2-v13 {
	replace  `var' = subinstr(`var', ",", "", .)
}
destring v2-v13, replace 

egen ballots_cast_dem_gov = rowtotal(v2-v9)
egen ballots_cast_rep_gov = rowtotal(v10-v13)
drop v*
gen prim_or_gen = "primary"
gen year = 2006
gen dem_share_gov = ballots_cast_dem_gov / (ballots_cast_dem_gov + ballots_cast_rep_gov)

tempfile p_2006
save `p_2006'

project, original("$root/original data/gov/csvs/gen2006.csv")
import delim using "$root/original data/gov/csvs/gen2006.csv", clear
drop if _n < 3
replace v1 = trim(itrim(v1))
drop v4-v13
drop if inlist(v1, "Percent", "State Totals", "")
rename v1 county
foreach var of varlist v2-v3 {
	replace  `var' = subinstr(`var', ",", "", .)
}
destring v2-v3, replace 

egen ballots_cast_dem_gov = rowtotal(v2)
egen ballots_cast_rep_gov = rowtotal(v3)
drop v*
gen prim_or_gen = "general"
gen year = 2006
gen dem_share_gov = ballots_cast_dem_gov / (ballots_cast_dem_gov + ballots_cast_rep_gov)

tempfile g_2006
save `g_2006'


// 2010
project, original("$root/original data/gov/csvs/prim2010.csv")
import delim using "$root/original data/gov/csvs/prim2010.csv", clear
drop if _n < 2
replace v1 = trim(itrim(v1))
drop v19-v26
drop if inlist(v1, "Percent", "State Totals", "")
rename v1 county
foreach var of varlist v2-v18 {
	replace  `var' = subinstr(`var', ",", "", .)
}
destring v2-v18, replace 

egen ballots_cast_dem_gov = rowtotal(v2-v9)
egen ballots_cast_rep_gov = rowtotal(v10-v18)
drop v*
gen prim_or_gen = "primary"
gen year = 2010
gen dem_share_gov = ballots_cast_dem_gov / (ballots_cast_dem_gov + ballots_cast_rep_gov)

tempfile p_2010
save `p_2010'

project, original("$root/original data/gov/csvs/gen2010.csv")
import delim using "$root/original data/gov/csvs/gen2010.csv", clear
drop if _n < 3
replace v1 = trim(itrim(v1))
drop v4-v16
drop if inlist(v1, "Percent", "State Totals", "")
rename v1 county
foreach var of varlist v2-v3 {
	replace  `var' = subinstr(`var', ",", "", .)
}
destring v2-v3, replace 

egen ballots_cast_dem_gov = rowtotal(v2)
egen ballots_cast_rep_gov = rowtotal(v3)
drop v*
gen prim_or_gen = "general"
gen year = 2010
gen dem_share_gov = ballots_cast_dem_gov / (ballots_cast_dem_gov + ballots_cast_rep_gov)

tempfile g_2010
save `g_2010'

// 2014
project, original("$root/original data/gov/csvs/prim2014.csv")
import delim using "$root/original data/gov/csvs/prim2014.csv", clear
drop if _n < 7
replace v1 = trim(itrim(v1))
drop v10-v19
drop if inlist(v1, "Percent", "State Totals", "")
rename v1 county
foreach var of varlist v2-v9 {
	replace  `var' = subinstr(`var', ",", "", .)
}
destring v2-v9, replace 

egen ballots_cast_dem_gov = rowtotal(v2-v3)
egen ballots_cast_rep_gov = rowtotal(v4-v9)
drop v*
gen prim_or_gen = "primary"
gen year = 2014
gen dem_share_gov = ballots_cast_dem_gov / (ballots_cast_dem_gov + ballots_cast_rep_gov)

tempfile p_2014
save `p_2014'

project, original("$root/original data/gov/csvs/gen2014.csv")
import delim using "$root/original data/gov/csvs/gen2014.csv", clear
drop if _n < 3
replace v1 = trim(itrim(v1))
// drop v4-v16
drop if inlist(v1, "Percent", "State Totals", "")
rename v1 county
foreach var of varlist v2-v3 {
	replace  `var' = subinstr(`var', ",", "", .)
}
destring v2-v3, replace 

egen ballots_cast_dem_gov = rowtotal(v2)
egen ballots_cast_rep_gov = rowtotal(v3)
drop v*
gen prim_or_gen = "general"
gen year = 2014
gen dem_share_gov = ballots_cast_dem_gov / (ballots_cast_dem_gov + ballots_cast_rep_gov)

tempfile g_2014
save `g_2014'

// 2018
project, original("$root/original data/gov/csvs/prim2018.csv")
import delim using "$root/original data/gov/csvs/prim2018.csv", clear
drop if _n < 8
replace v1 = trim(itrim(v1))
drop v19-v33
drop if inlist(v1, "Percent", "State Totals", "")
rename v1 county
foreach var of varlist v2-v18 {
	replace  `var' = subinstr(`var', ",", "", .)
}
destring v2-v18, replace 

egen ballots_cast_dem_gov = rowtotal(v2-v13)
egen ballots_cast_rep_gov = rowtotal(v14-v18)
drop v*
gen prim_or_gen = "primary"
gen year = 2018
gen dem_share_gov = ballots_cast_dem_gov / (ballots_cast_dem_gov + ballots_cast_rep_gov)

tempfile p_2018
save `p_2018'

project, original("$root/original data/gov/csvs/gen2018.csv")
import delim using "$root/original data/gov/csvs/gen2018.csv", clear
drop if _n < 5
replace v1 = trim(itrim(v1))
// drop v4-v16
drop if inlist(v1, "Percent", "State Totals", "")
rename v1 county
foreach var of varlist v2-v3 {
	replace  `var' = subinstr(`var', ",", "", .)
}
destring v2-v3, replace 

egen ballots_cast_dem_gov = rowtotal(v2)
egen ballots_cast_rep_gov = rowtotal(v3)
drop v*
gen prim_or_gen = "general"
gen year = 2018
gen dem_share_gov = ballots_cast_dem_gov / (ballots_cast_dem_gov + ballots_cast_rep_gov)

append using `p_1998'
append using `g_1998'
append using `p_2002'
append using `g_2002'
append using `p_2006'
append using `g_2006'
append using `p_2010'
append using `g_2010'
append using `p_2014'
append using `g_2014'
append using `p_2018'

sort county prim_or_gen year
gen state = "CA"

tempfile ca_temp
save `ca_temp'


********************************************************************
**** WASHINGTON
********************************************************************


// 1992
project, original("$root/original data/gov_wa/gen1992.csv")
import delimited using "$root/original data/gov_wa/gen1992.csv", clear
replace v1 = "Adams" if _n == 1
rename v1 county 
rename v2 party 
rename v3 votes
drop if county == "Candidate"
replace county = county[_n-1] if mod(_n, 3) == 2
replace county = county[_n-1] if mod(_n, 3) == 0
drop if party == ""
destring votes, replace
reshape wide votes, i(county) j(party) string
rename votesD ballots_cast_dem_gov
rename votesR ballots_cast_rep_gov
gen prim_or_gen = "general"
gen year = 1992
gen dem_share_gov = ballots_cast_dem_gov / (ballots_cast_dem_gov + ballots_cast_rep_gov)

tempfile g_1992
save `g_1992'

// 1996
project, original("$root/original data/gov_wa/gen1996.csv")
import delimited using "$root/original data/gov_wa/gen1996.csv", clear
replace v1 = "Adams" if _n == 1
rename v1 county 
rename v2 party 
rename v3 votes
drop if county == "Candidate"
replace county = county[_n-1] if mod(_n, 3) == 2
replace county = county[_n-1] if mod(_n, 3) == 0
drop if party == ""
destring votes, replace
reshape wide votes, i(county) j(party) string
rename votesD ballots_cast_dem_gov
rename votesR ballots_cast_rep_gov
gen prim_or_gen = "general"
gen year = 1996
gen dem_share_gov = ballots_cast_dem_gov / (ballots_cast_dem_gov + ballots_cast_rep_gov)

tempfile g_1996
save `g_1996'

// 2000
project, original("$root/original data/gov_wa/gen2000.csv")
import delimited using "$root/original data/gov_wa/gen2000.csv", clear
replace v1 = "Adams" if _n == 1
rename v1 county 
rename v2 party 
rename v3 votes
drop if county == "Candidate"
drop if party == "L"
replace county = county[_n-1] if mod(_n, 3) == 2
replace county = county[_n-1] if mod(_n, 3) == 0
drop if party == ""
destring votes, replace
reshape wide votes, i(county) j(party) string
rename votesD ballots_cast_dem_gov
rename votesR ballots_cast_rep_gov
gen prim_or_gen = "general"
gen year = 2000
gen dem_share_gov = ballots_cast_dem_gov / (ballots_cast_dem_gov + ballots_cast_rep_gov)

tempfile g_2000
save `g_2000'

// 2004
project, original("$root/original data/gov_wa/gen2004.csv")
import delimited using "$root/original data/gov_wa/gen2004.csv", clear
replace v1 = "Adams" if _n == 1
rename v1 county 
rename v2 party 
rename v3 votes
drop if county == "Candidate"
drop if party == "L"
replace county = county[_n-1] if mod(_n, 3) == 2
replace county = county[_n-1] if mod(_n, 3) == 0
drop if party == ""
destring votes, replace
reshape wide votes, i(county) j(party) string
rename votesD ballots_cast_dem_gov
rename votesR ballots_cast_rep_gov
gen prim_or_gen = "general"
gen year = 2004
gen dem_share_gov = ballots_cast_dem_gov / (ballots_cast_dem_gov + ballots_cast_rep_gov)

tempfile g_2004
save `g_2004'

// 2008
clear all 
set obs 1
gen county = ""
tempfile g_2008
save `g_2008' 

local files : dir "$root/original data/gov_wa/gen2008" files "*.csv"

foreach file in `files' {
	project, original("$root/original data/gov_wa/gen2008/`file'")
	import delim using "$root/original data/gov_wa/gen2008/`file'", clear
	gen county = subinstr(substr("`file'", 10, .), ".csv", "", .)
	keep if race == "Washington State Governor"
	compress
	replace party = "D" if party == "(Prefers Democratic Party)"
	replace party = "R" if party == "(Prefers G.O.P. Party)"
	keep county party votes
	compress
	reshape wide votes, i(county) j(party) string
	rename votesD ballots_cast_dem_gov
	rename votesR ballots_cast_rep_gov
	gen prim_or_gen = "general"
	gen year = 2008
	gen dem_share_gov = ballots_cast_dem_gov / (ballots_cast_dem_gov + ballots_cast_rep_gov)
	append using `g_2008'
	tempfile g_2008
	save `g_2008'
}


// 2012
project, original("$root/original data/gov_wa/gen2012.csv")
import delimited using "$root/original data/gov_wa/gen2012.csv", clear
keep if race == "Washington State Governor"
replace party = "D" if party == "(Prefers Democratic Party)"
replace party = "R" if party == "(Prefers Republican Party)"
keep county party votes
compress
reshape wide votes, i(county) j(party) string
rename votesD ballots_cast_dem_gov
rename votesR ballots_cast_rep_gov
gen prim_or_gen = "general"
gen year = 2012
gen dem_share_gov = ballots_cast_dem_gov / (ballots_cast_dem_gov + ballots_cast_rep_gov)

tempfile g_2012
save `g_2012'

// 2016
project, original("$root/original data/gov_wa/gen2016.csv")
import delimited using "$root/original data/gov_wa/gen2016.csv", clear
keep if race == "Washington State Governor"
replace party = "D" if party == "(Prefers Democratic Party)"
replace party = "R" if party == "(Prefers Republican Party)"
keep county party votes
compress
reshape wide votes, i(county) j(party) string
rename votesD ballots_cast_dem_gov
rename votesR ballots_cast_rep_gov
gen prim_or_gen = "general"
gen year = 2016
gen dem_share_gov = ballots_cast_dem_gov / (ballots_cast_dem_gov + ballots_cast_rep_gov)

append using `g_1992'
append using `g_1996'
append using `g_2000'
append using `g_2004'
append using `g_2008'
append using `g_2012'
drop if county == ""
replace county = "Grays Harbor" if county == "GraysHarbor"
replace county = "Pend Oreille" if county == "PendOreille"
replace county = "San Juan" if county == "SanJuan"
replace county = "Walla Walla" if county == "WallaWalla"
gen state = "WA"
tempfile wa_temp
save `wa_temp'


********************************************************************
**** UTAH
********************************************************************

project, original("$root/original data/participation_and_results_ut/utah_county_election_results.tsv")
import delim "$root/original data/participation_and_results_ut/utah_county_election_results.tsv", clear
destring vote_*, replace i(",")
gen dem_share_gov = vote_gov_dem/(vote_gov_dem+vote_gov_rep)
gen state = "UT"
rename (vote_gov_dem vote_gov_rep) (ballots_cast_dem_gov ballots_cast_rep_gov)
keep county prim_or_gen year dem_share_gov state ballots_cast_dem_gov ballots_cast_rep_gov


********************************************************************
**** JOINED
********************************************************************

append using `ca_temp'
append using `wa_temp'

sort state county prim_or_gen year
compress

* Save the combined gov file
save "$root/modified data/governor.dta", replace
project, creates("$root/modified data/governor.dta")



