/*
Stuthi Iyer 02/13/2022
PAD & Sepsis
*/

log using "/Users/Stuthi/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /Log Binomial Regression.log", replace

use "/Users/Stuthi/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /All Sepsis.dta", clear 

drop dispuniform i10_dx1-i10_dx40 i10_ndx i10_npr i10_pr1-i10_pr25 los prday1-prday25 key_nis pl_nchs totchg hosp_locteach pay1_1-pay1_7 pl_nchs1-pl_nchs7 hosp_locteach1-hosp_locteach4 bysup byinf endosup endoinf fem majamp_1-majamp_25 minamp_1-minamp_25 majamptot minamptot extLOS dispuniform1-dispuniform9

svyset hosp_nis [pw=discwt]

gen zipinc_qrtl_2 = 0
replace zipinc_qrtl_2 = zipinc_qrtl
replace zipinc_qrtl_2 = 1 if zipinc_qrtl_2 == 2
replace zipinc_qrtl_2 = 2 if zipinc_qrtl_2 == 3 | zipinc_qrtl_2 == 4

*For CIs
gen zipinc_qrtl_0_50 =0
replace zipinc_qrtl_0_50=1 if zipinc_qrtl_2==1
gen zipinc_qrtl_50_100 =0
replace zipinc_qrtl_50_100=1 if zipinc_qrtl_2==2
gen zipinc_qrtl_miss=0
replace zipinc_qrtl_miss=1 if zipinc_qrtl_2==5

*Logistic Regression with In-Hospital Mortality
*Count tables
svy: tabulate died allPAD, count format(%20.10f)
*Risk Ratios
svy: glm died i.allPAD, fam(bin) link(log) nolog eform

*Adding in sociodemographic factors
*These are the count tables
svy: mean age if died==1
svy: mean age if died==0
svy: mean elix if died==1
svy: mean elix if died==0
foreach var of varlist race male zipinc_qrtl_2 onlysepticshock {
	svy: tab `var' died ,  count format(%20.10f)
}
svy: glm died i.allPAD age i.race i.male i.zipinc_qrtl_2, fam(bin) link(log) nolog eform

*Get confidence intervals of proportions
foreach var of varlist allPAD white black hispanic asian native race_other male zipinc_qrtl_0_50 zipinc_qrtl_50_100 zipinc_qrtl_miss onlysepticshock {
	svy: prop died if `var'==1
	svy: prop died if `var'==0
} 

*Adding in comorbidities 
svy: glm died i.allPAD age i.race i.male i.zipinc_qrtl_2 elix, fam(bin) link(log) nolog eform
*Sensitivity Analysis 4 - Odds Ratio
svy: glm died i.allPAD age i.race i.male i.zipinc_qrtl_2 elix, fam(bin) nolog eform
*Sensitivity Analysis - Adding in explicit septic shock term
svy: mlogit died i.allPAD age i.race male i.zipinc_qrtl_2 elix i.onlysepticshock, rrr
******************
*Sensitivity analysis 5: e-value--to run once statistical analysis complete!
*ssc install evalue
*specify point estimate when ucl < 1 or lcl > 1
evalue rr 1.137877, lcl(1.006123) ucl(1.286885) true(1)
****************
*Logistic Regression with Amputation
svy: tabulate amputot allPAD, count format(%20.10f)
svy: glm amputot i.allPAD, fam(bin) link(log) nolog eform

*Adding in sociodemographic factors
svy: mean age if amputot==1
svy: mean age if amputot==0
svy: mean elix if amputot==1
svy: mean elix if amputot==0
foreach var of varlist race male zipinc_qrtl_2 {
	svy: tab `var' amputot,  count format(%20.10f)
}
svy: glm amputot i.allPAD age i.race i.male i.zipinc_qrtl_2 , fam(bin) link(log) nolog eform

*Confidence Intervals of proportions
foreach var of varlist allPAD white black hispanic asian native race_other male zipinc_qrtl_0_50 zipinc_qrtl_50_100 zipinc_qrtl_miss {
	svy: prop amputot if `var'==1
	svy: prop amputot if `var'==0
} 

*Adding in comorbidities
svy: glm amputot i.allPAD age i.race i.male i.zipinc_qrtl_2 elix , fam(bin) link(log) nolog eform

******************
******************
*Sensitivity analysis 2: Making categorical PAD
gen catPAD = 0
replace catPAD = 1 if IC == 1 & RP == 0 & UG == 0
replace catPAD = 2 if IC==0 & RP == 1 & UG == 0
replace catPAD = 3 if IC==0 & RP ==0 & UG == 1 

gen IC_2 = 0
replace IC_2 =1 if catPAD==1
gen RP_2=0
replace RP_2=1 if catPAD==2
gen CLI_2=0
replace CLI_2=1 if catPAD==3

*Logistic Regression with In-Hospital Mortality
*Count tables
svy: tabulate died catPAD , count format(%20.10f)
foreach var of varlist IC_2 RP_2 CLI_2 {
	svy: prop died if `var'==1
	svy: prop died if `var'==0
}
svy: glm died i.catPAD , fam(bin) link(log) nolog eform

*Adding in sociodemographic factors
*These are the count tables
*Use all values from first model
svy: glm died i.catPAD age i.race i.male i.zipinc_qrtl_2 , fam(bin) link(log) nolog eform
svy: glm died i.catPAD age i.race i.male i.zipinc_qrtl_2 elix , fam(bin) link(log) nolog eform

******************
******************
*Sensitivity analysis 3: new hospice
*Logistic Regression with In-Hospital Mortality
svy: tabulate hospice allPAD , count format(%20.10f)
svy: glm hospice i.allPAD , fam(bin) link(log) nolog eform

*Adding in sociodemographic factors
svy: mean age if hospice ==1
svy: mean age if hospice ==0
svy: mean elix if hospice==1
svy: mean elix if hospice==0
foreach var of varlist race male zipinc_qrtl_2 {
	svy: tab `var' hospice,  count format(%20.10f)
}
foreach var of varlist allPAD white black hispanic asian native race_other male zipinc_qrtl_0_50 zipinc_qrtl_50_100 zipinc_qrtl_miss {
	svy: prop hospice if `var'==1
	svy: prop hospice if `var'==0
} 
svy: glm hospice i.allPAD age i.race i.male i.zipinc_qrtl_2 , fam(bin) link(log) nolog eform

*Adding in comorbidities
*svy: glm hospice i.allPAD age i.race i.male i.zipinc_qrtl_2 elix, fam(bin) link(log) nolog eform
*Glm model did not converge, so used logistic and found the risk ratios
svy: mlogit hospice i.allPAD age i.race male i.zipinc_qrtl_2 elix, rrr

log close

log using "/Users/Stuthi/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /Sensitivity Analysis 1.log", replace

use "/Users/Stuthi/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /Full Cohort.dta", clear 

drop dispuniform i10_ndx i10_npr i10_pr1-i10_pr25 los prday1-prday25 key_nis pl_nchs totchg hosp_locteach

gen sens_cohort = 0
replace sens_cohort = 1 if explicitsepsis==1
replace sens_cohort = 0 if age<18 & died==. & age==. & male==. & race==.

drop if sens_cohort == 0

svyset hosp_nis [pw=discwt]

gen zipinc_qrtl_2 = 0
replace zipinc_qrtl_2 = zipinc_qrtl
replace zipinc_qrtl_2 = 1 if zipinc_qrtl_2 == 2
replace zipinc_qrtl_2 = 2 if zipinc_qrtl_2 == 3 | zipinc_qrtl_2 == 4

*For CIs
gen zipinc_qrtl_0_50 =0
replace zipinc_qrtl_0_50=1 if zipinc_qrtl_2==1
gen zipinc_qrtl_50_100 =0
replace zipinc_qrtl_50_100=1 if zipinc_qrtl_2==2
gen zipinc_qrtl_miss=0
replace zipinc_qrtl_miss=1 if zipinc_qrtl_2==5

*Defined PAD
gen allPAD = 0
foreach num of numlist 2/40 {
	replace allPAD = 1 if inlist(i10_dx`num', "I70211",  "I70212",  "I70213",  "I70221",  "I70222") | inlist(i10_dx`num', "I70223",  "I70231",  "I70232",  "I70233", "I70234") | inlist(i10_dx`num', "I70235",  "I70241",  "I70245",  "I70242",  "I70243") | inlist(i10_dx`num', "I70244",  "I70261",  "I70262",  "I70263",  "I70291") | inlist(i10_dx`num', "I70292",  "I70293",  "I70301",  "I70302",  "I70303") | inlist(i10_dx`num', "I70311",  "I70312",  "I70313",  "I70321",  "I70322") | inlist(i10_dx`num', "I70323",  "I70331",  "I70332",  "I70333 ",  "I70334") | inlist(i10_dx`num', "I70335",  "I70341",  "I70342",  "I70343",  "I70344") | inlist(i10_dx`num', "I70345",  "I70361",  "I70362",  "I70363",  "I70391") | inlist(i10_dx`num', "I70392",  "I70393",  "I70401",  "I70402",  "I70403") | inlist(i10_dx`num', "I70411",  "I70412",  "I70413",  "I70421",  "I70423") | inlist(i10_dx`num', "I70431",  "I70432",  "I70433",  "I70434",  "I70441") | inlist(i10_dx`num', "I70442",  "I70443",  "I70444",  "I70445",  "I70461") | inlist(i10_dx`num', "I70462",  "I70463",  "I70491",  "I70492",  "I70493") | inlist(i10_dx`num', "I70501",  "I70502",  "I70503",  "I70511",  "I70512") | inlist(i10_dx`num', "I70513",  "I70521",  "I70522",  "I70523",  "I70531") | inlist(i10_dx`num', "I70532",  "I70533",  "I70534",  "I70541",  "I70542") | inlist(i10_dx`num', "I70543",  "I70544",  "I70561",  "I70562",  "I70563") | inlist(i10_dx`num', "I70591",  "I70592",  "I70593",  "I70601",  "I70602") | inlist(i10_dx`num', "I70603",  "I70611",  "I70612",  "I70613",  "I70621") | inlist(i10_dx`num', "I70622",  "I70623",  "I70631",  "I70632",  "I70633") | inlist(i10_dx`num', "I70634",  "I70641",  "I70642",  "I70643",  "I70644") | inlist(i10_dx`num', "I70661",  "I70662",  "I70663",  "I70691",  "I70692") | inlist(i10_dx`num', "I70693",  "I70701",  "I70702",  "I70703",  "I70711") | inlist(i10_dx`num', "I70712",  "I70713",  "I70721",  "I70722",  "I70723") | inlist(i10_dx`num', "I70731",  "I70732",  "I70733",  "I70734",  "I70735") | inlist(i10_dx`num', "I70741",  "I70742",  "I70743",  "I70744",  "I70745") | inlist(i10_dx`num', "I70761",  "I70762",  "I70763",  "I70791",  "I70792") | inlist(i10_dx`num', "Z95820")
} 

*Count tables
svy: tabulate died allPAD, count format(%20.10f)
*Nobody with PAD died so no further analyses conducted
*Risk Ratios
svy: glm died i.allPAD, fam(bin) link(log) nolog eform

*Adding in sociodemographic factors
*These are the count tables
svy: mean age if died ==1
svy: mean age if died ==0
svy: mean elix if died==1
svy: mean elix if died==0
foreach var of varlist race male zipinc_qrtl_2 {
	svy: tab `var' died,  count format(%20.10f)
}
foreach var of varlist allPAD white black hispanic asian native race_other male zipinc_qrtl_0_50 zipinc_qrtl_50_100 zipinc_qrtl_miss {
	svy: prop died if `var'==1
	svy: prop died if `var'==0
} 
svy: glm died i.allPAD age i.race i.male i.zipinc_qrtl_2 , fam(bin) link(log) nolog eform

*Adding in comorbidities
svy: glm died i.allPAD age i.race i.male i.zipinc_qrtl_2 elix, fam(bin) link(log) nolog eform
*Sensitivity Analysis - adding in explicit septic shock
svy: glm died i.allPAD age i.race i.male i.zipinc_qrtl i.dm i.smoke i.esrd i.htn i.cad i.dys i.obese i.onlysepticshock, fam(bin) link(log) nolog eform

log close
