
gl root = "~/Dropbox/VBM"

* Bring in the aggregated voter file
project, original("$root/modified data/ca_votes_by_tract.dta")
project, original("$root/modified data/ut_votes_by_tract.dta")
use "$root/modified data/ca_votes_by_tract.dta", clear
gen state = "CA"
append using "$root/modified data/ut_votes_by_tract.dta"
replace state = "UT" if state==""

* Add in the tract-level census data
project, uses("$root/modified data/census_ses_data.dta") preserve
merge m:1 state county census_tract using "$root/modified data/census_ses_data.dta", keep(1 3) nogen
drop race_pop pov_pop white

* Get the details of the election in separate variables
split election, parse("_")
rename (election1-election4) (prim_or_gen year month day)
destring year, replace

* Make flags for whether the poverty rate in the tract
* is over or under a certain level
qui forval p=4(1)31 {
	gen high_pov`p' = 0 if poverty==.
	replace high_pov`p' = poverty>(`p'/100) if poverty!=.
}

* Get the share of votes in a county coming from a high vs 
* low poverty tract across different thresholds
reshape long high_pov, i(election census_tract county num_votes state) j(p)
collapse (sum) num_votes, by(state county prim_or_gen year high_pov p)
rename num_votes num_votes_high_pov_
reshape wide num_votes_high_pov_, i(state county prim_or_gen year high_pov) j(p)
rename num_votes_high_pov_* num_votes_high_pov_*_
reshape wide num_votes_high_pov_*_, i(state county prim_or_gen year) j(high_pov)
egen num_votes = rowtotal(num_votes_high_pov_10_*)
qui forval p=4(1)31 {
	gen share_votes_high_pov`p' = num_votes_high_pov_`p'_1/num_votes
}

* Format the county names to match the other data
replace county = strproper(county)

* Save the output
keep state county year prim_or_gen share_votes* num_votes
save "$root/modified data/composition_tract.dta", replace
project, creates("$root/modified data/composition_tract.dta")
