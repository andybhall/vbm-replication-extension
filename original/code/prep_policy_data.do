
gl root = "~/Dropbox/VBM"

* Bring in the Washington replication data from Gerber, Huber, and Hill (2013)
// available at https://huber.research.yale.edu/materials/28_replication.7z
project, original("$root/original data/policies/WA-County-VotesCast.csv")
import delim "$root/original data/policies/WA-County-VotesCast.csv", clear
keep county year vbmonly
rename vbmonly treat
gen state = "WA"
gen prim_or_gen = "general"
keep if mod(year, 2)==0
sort county year
by county: gen switch = treat - treat[_n-1]
egen switch_year = max(year*switch), by(county)
gen all_mail2006 = switch_year==2006
drop switch
expand 5 if year==2010
bys county year: replace year = year + 2*(_n-1)
replace treat = 1 if year>2011
tempfile wa
save `wa'

* Bring in the Utah policy data
project, original("$root/original data/policies/utah_counties_vbm_switch.tsv")
import delim "$root/original data/policies/utah_counties_vbm_switch.tsv", clear
rename first ut_all_mail_year
expand 13
bys county: gen year = 1994 + _n*2
gen prim_or_gen = "general"
gen treat = year>=ut_all_mail_year
gen state = "UT"
tempfile ut
save `ut'

* Bring in the CA policy data
project, original("$root/original data/policies/VBM Policies - policies.csv")
import delim "$root/original data/policies/VBM Policies - policies.csv", clear
replace county = strproper(county)
gen state = "CA"

* Make the data into a panel
expand 12
bys county: gen year = 1996 + _n*2
expand 2
bys county year: gen prim_or_gen = "primary" if _n==1
by county year: replace prim_or_gen = "general" if _n==2
drop if year==2020 & prim_or_gen=="general"

* Create the treatment variable
gen treat = (year==2018 & vca18==1) | (year==2020 & vca20==1)
*drop vca*

* Add in the Washington data
append using `ut'
append using `wa'

* Save the output
sort state county year prim_or_gen treat vca* all_mail2006 ut_all_mail*
order state county year prim_or_gen treat vca* all_mail2006
save "$root/modified data/policies.dta", replace
project, creates("$root/modified data/policies.dta")
