
gl root = "~/Dropbox/VBM"

* Bring in the aggregated voter file
project, original("$root/modified data/ca_votes_by_group.dta")
use "$root/modified data/ca_votes_by_group.dta", clear
gen state = "CA"
append using "$root/modified data/ut_votes_by_group.dta"
replace state = "UT" if state==""

* Get the details of the election in separate variables
split election, parse("_")
rename (election1-election4) (prim_or_gen year month day)
destring year, replace

* Simplify the parties
gen party = "oth"
replace party = "np" if parties=="Non-Partisan"
replace party = "dem" if parties=="Democratic"
replace party = "rep" if parties=="Republican"

* Get the ages into buckets
gen age = voters_age - (2019 - year) // calculate approx age on election day
gen age_cat = 1
replace age_cat = 18 if inrange(age, 18, 34)
replace age_cat = 35 if inrange(age, 35, 54)
replace age_cat = 55 if age>55 & age!=.

* Make the data wide for a county-election
collapse (sum) num_votes, by(state county prim_or_gen year party age_cat)
rename num_votes num_votes_
reshape wide num_votes_, i(state county prim_or_gen year age_cat) j(party) s
rename num_votes* num_votes*_
reshape wide num_votes_*_, i(state county prim_or_gen year) j(age_cat)

* Get the share of the electorate in each age group and party
egen num_votes = rowtotal(num_votes*)
foreach a in 1 18 35 55 {
	egen num_votes`a' = rowtotal(num_votes_*_`a')
	gen share_votes`a' = num_votes`a'/num_votes
}
foreach p in "dem" "rep" "np" "oth" {
	egen num_votes_`p' = rowtotal(num_votes_`p'_*)
	gen share_votes_`p' = num_votes_`p'/num_votes
}

* Format the county names to match the other data
replace county = strproper(county)

* Save the output
keep state county year prim_or_gen share_votes* num_votes
save "$root/modified data/composition.dta", replace
project, creates("$root/modified data/composition.dta")
