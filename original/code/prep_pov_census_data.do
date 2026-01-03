
gl root = "~/Dropbox/VBM"

* Bring in the census tract-level SES data
project, original("$root/original data/census_poverty_race/nhgis0032_ds225_20165_2016_blck_grp.csv")
import delim "$root/original data/census_poverty_race/nhgis0032_ds225_20165_2016_blck_grp.csv", clear

* Clean the variable names
rename (statea countya tracta blkgrpa) ///
	(state_fips county_fips census_tract census_block_group)
gen poverty = af43e002 + af43e003
rename (af2me001 af43e001 af2me002) (race_pop pov_pop white)

* Aggregate up to the tract level
keep state county census_tract race_pop pov_pop poverty white
collapse (sum) race_pop pov_pop poverty white, by(state county census_tract)

* Clean the state and county names
replace state = strupper(substr(state, 1, 2))
replace county = strupper(subinstr(county, " County", "", .))

* Make poverty and white share variables
replace poverty = pover/pov_pop
replace white = white/race_pop

* Save the output
compress
save "$root/modified data/census_ses_data.dta", replace
project, creates("$root/modified data/census_ses_data.dta")
