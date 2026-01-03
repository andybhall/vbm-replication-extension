
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

* Get the ages into buckets
gen age = voters_age - (2019 - year) // calculate approx age on election day
replace age = 1 if age<18
replace age = 65 if age>65 & age!=.

* Make the data wide for a county-election
collapse (sum) num_votes, by(state county prim_or_gen year age)
rename num_votes num_votes
drop if age==.
reshape wide num_votes, i(state county prim_or_gen year) j(age)

* Get the share of the electorate in each age group and party
egen num_votes = rowtotal(num_votes*)
qui forval a=30/64 {
	*gen num_votes_above`a' = 0
	*forval b=`a'/65 {
	*	replace num_votes_above`a' = num_votes_above`a' + ///
	*		num_votes`b' if num_votes`b'!=.
	*		noi di "`a' `b'"
	*}
	egen num_votes_above`a' = rowtotal(num_votes`a' - num_votes65)
	gen share_votes_above`a' = num_votes_above`a'/num_votes
}

* Format the county names to match the other data
replace county = strproper(county)

* Save the output
keep state county year prim_or_gen share_votes_above*
save "$root/modified data/composition_age_robustness.dta", replace
project , creates("$root/modified data/composition_age_robustness.dta")
