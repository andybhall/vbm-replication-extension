
gl root = "~/Dropbox/VBM"

project, original("$root/modified data/us_election_results.dta")
use "$root/modified data/us_election_results.dta", clear

// vbm states
gen vbm = inlist(state, "CA", "OR", "HI", "CO", "UT", "WA")

// collapse, keep recent years
collapse (mean) pres_vs_[w=total_votes_], by(year vbm) 
keep if year >= 1990

binscatter pres_vs_ year, ///
	by(vbm) discrete linetype(connect) ///
	xsc(r(1991 2017)) xlab(1992(4)2016) ///
	xti("Year") yti("Dem Vote Share, Pres") scale(1.3) ///
	text(.47 2004 "Non-VBM States") ///
	text(.57 2010.4 "VBM States") legend(off) ///
	lcolor(black) mcolor(black)
graph export "$root/output/statewide_vote_shares.pdf", replace


