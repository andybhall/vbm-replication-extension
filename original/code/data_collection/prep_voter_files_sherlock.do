
gl ind_root = "/oak/stanford/groups/andyhall/industry_mobilization/L2_Data_June_2019"
gl vbm_root = "/oak/stanford/groups/andyhall/vbm"

* Loop over California and Utah
foreach s in "ca" "ut" {

	* Limit the demographics to just the party, age, census block, and census tract
	* loading the data in three-million-line chunks
	local test = 0
	local i = 0
	while `test'==0 {
		local min_row = 3000000*`i' + 1
		local i = `i' + 1
		local max_row = 3000000*`i'
		noi di "`s' started `i' " c(current_date) " " c(current_time)
		import delim "$ind_root/demog/`s'_demog.tab", ///
			clear delim(tab) varn(1) rowr(`min_row':`max_row')
		if _N==0 local test = 1
		keep lalvoterid voters_active county parties_desc voters_age ///
			residence_addresses_censusblock residence_addresses_censustract
		rename (residence_addresses_censusblock residence_addresses_censustract) ///
			(census_block census_tract)
		save "$vbm_root/tmp`i'.dta", replace
		noi di "`s' completed `i' " c(current_date) " " c(current_time)
	}
	
	* Put all of the temporary files together
	use "$vbm_root/tmp1.dta", clear
	forval c=2/`i' {
		append using "$vbm_root/tmp`c'.dta"
	}
	
	* Save the combines demographics file
	save "$vbm_root/`s'_demog_stripped.dta", replace
	noi di "`s' demog done " c(current_date) " " c(current_time)

	* Limit the vote history to just the generals, primaries, and runoffs
	import delim "$ind_root/vote_history/`s'_vote_history.tab", ///
		clear delim(tab) varn(1)
	keep lalvoter general* primary*
	noi di "`s' hist loaded " c(current_date) " " c(current_time)
	
	* Put the demographics together with the vote history data
	merge 1:1 lalvoter using "$vbm_root/`s'_demog_stripped.dta"
	compress
	save "$vbm_root/`s'_hist_w_demog.dta", replace
	noi di "`s' completed " c(current_date) " " c(current_time)

	* Get the vote totals by county, election, demographic group, and tract
	use lalvoterid gen* prim* using "$vbm_root/`s'_hist_w_demog.dta", clear
	rename prim* votedprim*
	rename gen* votedgen*
	reshape long voted, i(lalvoterid) j(election) s
	keep if voted=="Y"
	replace voted = "1"
	destring voted, force replace
	merge m:1 lalvoterid using "$vbm_root/`s'_demog_stripped.dta", keep(1 3) nogen
	collapse (sum) num_votes=voted, ///
		by(election county voters_age parties_desc census_block census_tract)
	save "$vbm_root/`s'_votes_by_group_tract.dta", replace

	* Get the vote totals by county, election, and tract
	use "$vbm_root/`s'_votes_by_group_tract.dta", clear
	collapse (sum) num_votes, ///
		by(election county census_tract)
	save "$vbm_root/`s'_votes_by_tract.dta", replace

	* Get the vote totals by county, election, and demographic group
	use "$vbm_root/`s'_votes_by_group_tract.dta", clear
	collapse (sum) num_votes, ///
		by(election county voters_age parties_desc)
	save "$vbm_root/`s'_votes_by_group.dta", replace
}
