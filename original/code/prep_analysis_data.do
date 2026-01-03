
gl root = "~/Dropbox/VBM"

* Bring in the policy data
project, uses("$root/modified data/policies.dta")
use "$root/modified data/policies.dta", clear

* Add in the participation outcomes
project, uses("$root/modified data/participation.dta") preserve
merge 1:1 state county year prim_or_gen using "$root/modified data/participation.dta", keep(1 3) nogen

* Add in the gubernatorial vote outcomes
project, uses("$root/modified data/governor.dta") preserve
merge 1:1 state county year prim_or_gen using "$root/modified data/governor.dta", keep(1 3) nogen

* Add in the gubernatorial vote outcomes
project, uses("$root/modified data/president.dta") preserve
merge 1:1 state county year prim_or_gen using "$root/modified data/president.dta", keep(1 3) nogen

* Add in the senatorial vote outcomes
project, uses("$root/modified data/senator.dta") preserve
merge 1:1 state county year prim_or_gen using "$root/modified data/senator.dta", keep(1 3) nogen

* Add in the composition outcomes
project, uses("$root/modified data/composition.dta") preserve
merge 1:1 state county year prim_or_gen using "$root/modified data/composition.dta", keep(1 3) nogen

* Add in the poverty outcomes
project, uses("$root/modified data/composition_tract.dta") preserve
merge 1:1 state county year prim_or_gen using "$root/modified data/composition_tract.dta", keep(1 3) nogen

* Add in the race-specific outcomes
project, uses("$root/modified data/composition_race.dta") preserve
merge 1:1 state county year prim_or_gen using "$root/modified data/composition_race.dta", keep(1 3) nogen

* Flag and remove the primaries
gen prim = prim_or_gen=="primary"
drop if prim==1

* Create the ids
gen pres = mod(year, 4)==0
egen county_id = group(state county)
egen state_year_id = group(state year)
egen election_id = group(state year prim_or_gen pres)
egen county_type_id = group(state county prim_or_gen pres)

*
gen year2 = year^2
gen year3 = year^3

* Save the analysis file
compress
keep if year<2020
save "$root/modified data/analysis.dta", replace
project, creates("$root/modified data/analysis.dta")
