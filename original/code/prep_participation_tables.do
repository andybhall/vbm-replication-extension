
gl root = "~/Dropbox/VBM"


//////////////////////////////////////
// CA Participation Data Cleaning
//////////////////////////////////////

* Bring in the data that didn't require cleaning
local i = 1
qui foreach f in "gen1998-page-1" "gen2002-page-1" "gen2004-page-1" "gen2004-page-2" ///
	"gen2006-page-1" "gen2006-page-2" "gen2008-page-1" "gen2010-page-1" ///
	"gen2012-page-1" "gen2014-page-1" "gen2016-page-1" "gen2018-page-1" {
	project, original("$root/original data/participation/csvs/`f'-table-1.csv")
	import delim "$root/original data/participation/csvs/`f'-table-1.csv", clear
	gen file = "`f'"
	if `i'==1 tempfile data
	if `i'>1 append using `data'
	save `data', replace
	noi di "`f'"
	local i = `i' + 1
}

* Bring in the files that required cleaning
qui foreach f in "gen2000-page-1" { 
	project, original("$root/original data/participation/csvs/`f'-table-1_clean.xlsx")
	import excel "$root/original data/participation/csvs/`f'-table-1_clean.xlsx", clear
	rename (A-G) (v1 v2 v3 v4 v5 v6 v7)
	gen file = "`f'"
	append using `data'
	save `data', replace
	noi di "`f'"
}

* Clean the variable names
rename (v1-v7) (county num_precincts eligible registered precinct_voters vbm ballots_cast)
keep file county num_precincts eligible registered precinct_voters vbm ballots_cast
order file county num_precincts eligible registered precinct_voters vbm ballots_cast

* Fix the data types
qui foreach v of varlist num_precincts eligible registered precinct_voters vbm ballots_cast {
	replace `v' = subinstr(`v', ",", "", .)
	replace `v' = subinstr(`v', "*", "", .)
	destring `v', replace force
}

* Remove the variable name rows and the state totals
drop if num_precincts==.
drop if regexm(strlower(county), "state")

* Fix a few county name issues
replace county = subinstr(county, "*", "", .)
replace county = "San Bernardino" if county=="San"
replace county = "San Luis Obispo" if county=="San Luis"

* Get the election year and type
gen year = real(substr(regexr(file, "prim|gen", ""), 1, 4))
gen prim_or_gen = "primary" if regexm(file, "prim")
replace prim_or_gen = "general" if regexm(file, "gen")
drop file

* Fill in the gaps on the eligible population
replace eligible = 1196914 if county=="San Bernardino" & prim_or_gen=="general" & year==2006
replace eligible = 188646 if county=="San Luis Obispo" & prim_or_gen=="general" & year==2006
sort county year prim_or_gen
by county: carryforward eligible, replace

* Save this file in memory
gen state = "CA"
tempfile ca
save `ca'


//////////////////////////////////////
// WA Participation Data Cleaning
//////////////////////////////////////

* Bring in the Washington replication data from Gerber, Huber, and Hill (2013)
// available at https://huber.research.yale.edu/materials/28_replication.7z
project, original("$root/original data/policies/WA-County-VotesCast.csv")
import delim "$root/original data/policies/WA-County-VotesCast.csv", clear
keep county year cast registered absenteecast
rename (cast absenteecast) (ballots_cast vbm)
gen state = "WA"
gen prim_or_gen = "general"
keep if mod(year, 2)==0 // remove odd-year elections

* Save this file in memory
tempfile wa
save `wa'


//////////////////////////////////////
// UT Participation Data Cleaning
//////////////////////////////////////

* Bring in the Utah data
project, original("$root/original data/participation_and_results_ut/utah_county_election_results.tsv")
import delim "$root/original data/participation_and_results_ut/utah_county_election_results.tsv", clear
keep county year prim_or_gen registered ballots_cast
destring registered ballots_cast, replace i(",")
gen state = "UT"
tempfile ut
save `ut'


//////////////////////////////////////
// Joined Participation Data Cleaning
//////////////////////////////////////

* Add CA to the WA data
append using `ca'
append using `wa'

* Merge in the estimated voting-age population
merge m:1 state county year using "$root/modified data/county_cvap.dta", keep(1 3) nogen

* Create the participation outcomes
gen vbm_share = vbm/ballots_cast
gen in_person_share = 1 - vbm_share
gen turnout_share = ballots_cast/cvap_approx
gen turnout_of_reg = ballots_cast/registered

* 
drop if year==2000 & state=="CA" // something weird with the num of ballots cast by mode
// br if vbm+precinct!=ballots_cast

* Save the combined participation file
save "$root/modified data/participation.dta", replace
project, creates("$root/modified data/participation.dta")
