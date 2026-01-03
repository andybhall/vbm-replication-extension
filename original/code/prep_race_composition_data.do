
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
drop race_pop pov_pop poverty

* Get the details of the election in separate variables
split election, parse("_")
rename (election1-election4) (prim_or_gen year month day)
destring year, replace

* Make flags for whether the poverty rate in the tract
* is over or under a certain level
qui forval w=34(1)90 {
	gen high_white`w' = 0 if white==.
	replace high_white`w' = white>(`w'/100) if white!=.
}

* Get the share of votes in a county coming from a tracts 
* with larger and smaller white populations across different thresholds
reshape long high_white, i(election census_tract county num_votes state) j(w)
collapse (sum) num_votes, by(state county prim_or_gen year high_white w)
rename num_votes num_votes_high_white_
reshape wide num_votes_high_white_, i(state county prim_or_gen year high_white) j(w)
rename num_votes_high_white_* num_votes_high_white_*_
reshape wide num_votes_high_white_*_, i(state county prim_or_gen year) j(high_white)
egen num_votes = rowtotal(num_votes_high_white_50_*)
qui forval w=34(1)90 {
	gen share_votes_high_white`w' = num_votes_high_white_`w'_1/num_votes
}

* Format the county names to match the other data
replace county = strproper(county)

* Save the output
keep state county year prim_or_gen share_votes* // num_votes
save "$root/modified data/composition_race.dta", replace
project, creates("$root/modified data/composition_race.dta")
