
gl root = "~/Dropbox/VBM"

//////////////////////////////////////
// Prepare data from after 2000
//////////////////////////////////////

* Bring in the annual data
qui foreach f in "_2005_2009" "_2006_2010" "_2008_2012" ///
	"_2010_2014" "_2012_2016" "_2014_2018" {
	project, original("$root/original data/population/cvap_county`f'.csv")
	import delim "$root/original data/population/cvap_county`f'.csv", clear
	keep if lntitle=="Total"
	keep geoname geoid cvap_est cvap_moe
	gen file = "`f'"
	if "`f'"=="_2005_2009" tempfile data
	if "`f'"!="_2005_2009" append using `data'
	save `data', replace
	noi di "`f'"
}

* Extract the fips id from the geoid
split geoid, parse("US")
gen fips = real(geoid2)
drop geoid*

* Extract the year from the file name
split file, parse("_")
gen year = real(file3)
gen start_year = real(file2)
drop file1 file2 file3

* Store the cleaned up data
rename cvap_est cvap
order fips geoname year start_year cvap cvap_moe file
sort fips year
save `data', replace


//////////////////////////////////////
// Prepare data from 2000
//////////////////////////////////////

* Bring in all of the files from 2000
local i = 1
local files: dir "$root/original data/population/2000/" files "*.txt"
qui foreach file in `files' {
	project, original("$root/original data/population/2000/`file'")
	import delim "$root/original data/population/2000/`file'", clear
	gen summary_level = substr(v1, 2, 2)
	gen fips = substr(v1, 6, 5)
	gen fips_county_subdiv = substr(v1, 12, 5)
	gen fips_place = substr(v1, 18, 5)
	gen tract_code = substr(v1, 24, 6)
	gen block_group_code = substr(v1, 31, 1)
	gen citizen_status = substr(v1, 33, 13)
	gen tract = substr(v1, 24, 6)
	gen pop = substr(v1, 263, 8)
	destring summary_level fips* *_code tract pop, replace
	drop v1
	compress
	replace citizen = stritrim(strtrim(citizen))
	keep if summary_level==5 & citizen_status=="Citizen"
	keep fips pop
	rename pop cvap
	gen file = "`file'"
	gen year = 2000
	gen start_year = 2000
	if `i'==1 tempfile _2000
	if `i'>1 append using `_2000'
	save `_2000', replace
	noi di "`file'"
	local i = `i' + 1
}

* Clean up the data
order fips year cvap file start_year
append using `data'


//////////////////////////////////////
// Interpolation and Extrapolation 
//	of Population Estimates
//////////////////////////////////////

* Make a panel with gaps to fill in
tsset fips year
tsfill, full

* For year y without data, find the most recent years
* with data before y and after y that do have data
* and interpolate
sort fips year
gen pre_cvap = cvap
gen pre_year = year if cvap!=.
by fips: carryforward pre_cvap pre_year, replace
gsort fips -year
gen post_cvap = cvap
gen post_year = year if cvap!=.
by fips: carryforward post_cvap post_year, replace
gen coef = (post_cvap - pre_cvap)/(post_year-pre_year) if cvap==.
gen cvap_approx = cvap if cvap!=.
replace cvap_approx = pre_cvap + (year-pre_year)*coef if cvap==.

* For years prior to 2000, take the trend used to interpolate from 2000
* to 2009 to interpolate and  extrapolate back to 1996
expand 5 if year==2000
bys fips year: replace year = year - (_n-1) if year==2000
gsort fips -year
by fips: carryforward post_cvap coef, replace
replace post_year = 2000 if year<2000
replace cvap_approx = post_cvap - coef*(post_year-year) if year<2000

* Duplicate 2018 and assume 2020 pop is the same as 2018 pop
expand 2 if year==2018
bys fips year: replace year = year + 2*(_n-1) if year==2018
gsort fips year
by fips: carryforward coef, replace
replace pre_year = 2018 if year==2020
replace cvap_approx = post_cvap - coef*(post_year-year) if year==2020
keep if mod(year, 2)==0

* Fill in the county and state names
gsort fips -year
carryforward geoname, replace
sort fips year

* Add in the state and county names
preserve
project, original("$root/original data/participation/county_fips.tsv")
import delim "$root/original data/participation/county_fips.tsv", delim(tab) clear
duplicates tag fips, gen(tag)
drop if tag
drop tag
tempfile fips
save `fips'
restore
merge m:1 fips using `fips', keep(3) nogen

* Save the county CVAP panel
keep state county year cvap cvap_moe cvap_approx
order state county year cvap cvap_moe cvap_approx
sort state county year
save "$root/modified data/county_cvap.dta", replace
project, creates("$root/modified data/county_cvap.dta")

* Check the data
*collapse (sum) cvap_approx cvap, by(year)
*replace cvap = . if cvap==0
*format cvap* %12.0fc
*twoway (connected cvap* year)
