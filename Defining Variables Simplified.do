/*
Stuthi Iyer 01/17/2022
PAD & Sepsis
*/

use "/Users/stuthiiyer/Downloads/2016/NIS_2016_Core.dta", clear 
 
merge m:1 hosp_nis using "/Users/stuthiiyer/Downloads/2016/NIS_2016_Hospital.dta", nogen

drop age_neonate amonth aweekend dqtr drg drgver drg_nopoa elective hcup_ed mdc mdc_nopoa tran_in tran_out year hosp_region n_disc_u n_hosp_u s_disc_u s_hosp_u total_disc hosp_division hosp_bedsize h_contrl

save "/Users/stuthiiyer/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /2016.dta", replace

**

use "/Users/stuthiiyer/Downloads/2017/NIS_2017_Core.dta", clear 
 
merge m:1 hosp_nis using "/Users/stuthiiyer/Downloads/2017/NIS_2017_Hospital.dta", nogen

drop age_neonate amonth aweekend dqtr drg drgver drg_nopoa elective hcup_ed mdc mdc_nopoa tran_in tran_out year hosp_region n_disc_u n_hosp_u s_disc_u s_hosp_u total_disc hosp_division hosp_bedsize h_contrl

save "/Users/stuthiiyer/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /2017.dta", replace

**

use "/Users/stuthiiyer/Downloads/2018/NIS_2018_Core.dta", clear 
 
merge m:1 hosp_nis using "/Users/stuthiiyer/Downloads/2018/NIS_2018_Hospital.dta", nogen

drop age_neonate amonth aweekend dqtr drg drgver drg_nopoa elective hcup_ed mdc mdc_nopoa tran_in tran_out year hosp_region n_disc_u n_hosp_u s_disc_u s_hosp_u total_disc hosp_division hosp_bedsize h_contrl

save "/Users/stuthiiyer/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /2018.dta", replace

**

use "/Users/stuthiiyer/Downloads/NIS_2019_Core.dta", clear 
 
merge m:1 hosp_nis using "/Users/stuthiiyer/Downloads/NIS_2019_Hospital.dta", nogen

drop age_neonate amonth aweekend dqtr drg drgver drg_nopoa elective hcup_ed mdc mdc_nopoa tran_in tran_out year hosp_region n_disc_u n_hosp_u s_disc_u s_hosp_u total_disc hosp_division hosp_bedsize h_contrl

save "/Users/stuthiiyer/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /2019.dta", replace

**

use "/Users/stuthiiyer/Downloads/NIS_2020_Core.dta", clear 
 
merge m:1 hosp_nis using "/Users/stuthiiyer/Downloads/NIS_2020_Hospital.dta", nogen

drop age_neonate amonth aweekend dqtr drg drgver drg_nopoa elective hcup_ed mdc mdc_nopoa tran_in tran_out year hosp_region n_disc_u n_hosp_u s_disc_u s_hosp_u total_disc hosp_division hosp_bedsize h_contrl

save "/Users/stuthiiyer/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /2020.dta", replace

****
use "/Users/stuthiiyer/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /2016.dta", clear
log using "/Users/stuthiiyer/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /Cohort Def 2016.log", replace

use "/Users/stuthiiyer/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /2017.dta", clear
log using "/Users/stuthiiyer/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /Cohort Def 2017.log", replace

use "/Users/stuthiiyer/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /2018.dta", clear
log using "/Users/stuthiiyer/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /Cohort Def 2018.log", replace

use "/Users/stuthiiyer/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /2019.dta", clear
log using "/Users/stuthiiyer/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /Cohort Def 2019.log", replace

use "/Users/stuthiiyer/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /2020.dta", clear
log using "/Users/stuthiiyer/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /Cohort Def 2020.log", replace

svyset hosp_nis [pw=discwt]

*Get overall age, sex, race data
gen male = 0
replace male = 1 if female==0

svy: mean age
svy: proportion male
svy: proportion race

*Making explicit sepsis
gen explicitsepsis = 0
	replace explicitsepsis = 1 if i10_dx1==("R6520") | i10_dx1==("R6521")

**********************************************
* Making implicit sepsis 
gen allsepsis = 0
	replace allsepsis = 1 if i10_dx1==("A001") |i10_dx1==("A009") |i10_dx1==("A0100") |i10_dx1==("A011") |i10_dx1==("A012") |i10_dx1==("A013") |i10_dx1==("A014") |i10_dx1==("A020") |i10_dx1==("A0220") |i10_dx1==("A0221") |i10_dx1==("A0222") |i10_dx1==("A0223") |i10_dx1==("A0224") |i10_dx1==("A0229") |i10_dx1==("A028") |i10_dx1==("A029") |i10_dx1==("A030") |i10_dx1==("A031") |i10_dx1==("A032") |i10_dx1==("A033") |i10_dx1==("A038") |i10_dx1==("A039") |i10_dx1==("A040") |i10_dx1==("A041") |i10_dx1==("A042") |i10_dx1==("A043") |i10_dx1==("A044") |i10_dx1==("A044") |i10_dx1==("A045") |i10_dx1==("A046") |i10_dx1==("A0471") |i10_dx1==("A0472") |i10_dx1==("A048") |i10_dx1==("A048") |i10_dx1==("A048") |i10_dx1==("A048") |i10_dx1==("A048") |i10_dx1==("A049") |i10_dx1==("A049") |i10_dx1==("A050") |i10_dx1==("A051") |i10_dx1==("A052") |i10_dx1==("A053") |i10_dx1==("A054") |i10_dx1==("A055") |i10_dx1==("A058") |i10_dx1==("A059") |i10_dx1==("A080") |i10_dx1==("A0811") |i10_dx1==("A0819") |i10_dx1==("A082") |i10_dx1==("A0831") |i10_dx1==("A0832") |i10_dx1==("A0839") |i10_dx1==("A088") |i10_dx1==("A09") |i10_dx1==("A170") |i10_dx1==("A171") |i10_dx1==("A1781") |i10_dx1==("A1782") |i10_dx1==("A1789") |i10_dx1==("A179") |i10_dx1==("A192") |i10_dx1==("A198") |i10_dx1==("A199") |i10_dx1==("A200") |i10_dx1==("A201") |i10_dx1==("A202") |i10_dx1==("A207") |i10_dx1==("A208") |i10_dx1==("A209") |i10_dx1==("A210") |i10_dx1==("A211") |i10_dx1==("A212") |i10_dx1==("A213") |i10_dx1==("A217") |i10_dx1==("A218") |i10_dx1==("A219") |i10_dx1==("A220") |i10_dx1==("A221") |i10_dx1==("A222") |i10_dx1==("A228") |i10_dx1==("A229") |i10_dx1==("A230") |i10_dx1==("A231") |i10_dx1==("A232") |i10_dx1==("A233") |i10_dx1==("A238") |i10_dx1==("A239") |i10_dx1==("A240") |i10_dx1==("A243") |i10_dx1==("A249") |i10_dx1==("A250") |i10_dx1==("A251") |i10_dx1==("A259") |i10_dx1==("A268") |i10_dx1==("A269") |i10_dx1==("A270") |i10_dx1==("A2781") |i10_dx1==("A2789") |i10_dx1==("A279") |i10_dx1==("A280") |i10_dx1==("A288") |i10_dx1==("A289") |i10_dx1==("A3211") |i10_dx1==("A3212") |i10_dx1==("A3281") |i10_dx1==("A3289") |i10_dx1==("A329") |i10_dx1==("A34") |i10_dx1==("A35") |i10_dx1==("A360") |i10_dx1==("A361") |i10_dx1==("A362") |i10_dx1==("A363") |i10_dx1==("A3681") |i10_dx1==("A3682") |i10_dx1==("A3683") |i10_dx1==("A3684") |i10_dx1==("A3685") |i10_dx1==("A3686") |i10_dx1==("A3689") |i10_dx1==("A3689") |i10_dx1==("A3689") |i10_dx1==("A369") |i10_dx1==("A3700") |i10_dx1==("A3710") |i10_dx1==("A3780") |i10_dx1==("A3790") |i10_dx1==("A389") |i10_dx1==("A390") |i10_dx1==("A391") |i10_dx1==("A394") |i10_dx1==("A3950") |i10_dx1==("A3951") |i10_dx1==("A3952") |i10_dx1==("A3953") |i10_dx1==("A3981") |i10_dx1==("A3982") |i10_dx1==("A3983") |i10_dx1==("A3989") |i10_dx1==("A399") |i10_dx1==("A420") |i10_dx1==("A421") |i10_dx1==("A422") |i10_dx1==("A4281") |i10_dx1==("A4282") |i10_dx1==("A4289") |i10_dx1==("A429") |i10_dx1==("A438") |i10_dx1==("A439") |i10_dx1==("A46") |i10_dx1==("A480") |i10_dx1==("A481") |i10_dx1==("A483") |i10_dx1==("A4851") |i10_dx1==("A4852") |i10_dx1==("A488") |i10_dx1==("A493") |i10_dx1==("A5400") |i10_dx1==("A5401") |i10_dx1==("A5403") |i10_dx1==("A5421") |i10_dx1==("A5422") |i10_dx1==("A5423") |i10_dx1==("A5423") |i10_dx1==("A5424") |i10_dx1==("A5429") |i10_dx1==("A5429") |i10_dx1==("A5431") |i10_dx1==("A5432") |i10_dx1==("A5433") |i10_dx1==("A5439") |i10_dx1==("A5440") |i10_dx1==("A5441") |i10_dx1==("A5442") |i10_dx1==("A5449") |i10_dx1==("A545") |i10_dx1==("A546") |i10_dx1==("A5481") |i10_dx1==("A5483") |i10_dx1==("A5485") |i10_dx1==("A5489") |i10_dx1==("A690") |i10_dx1==("A691") |i10_dx1==("B370") |i10_dx1==("B371") |i10_dx1==("B371") |i10_dx1==("B372") |i10_dx1==("B373") |i10_dx1==("B3742") |i10_dx1==("B3749") |i10_dx1==("B375") |i10_dx1==("B375") |i10_dx1==("B376") |i10_dx1==("B376") |i10_dx1==("B377") |i10_dx1==("B3781") |i10_dx1==("B3781") |i10_dx1==("B3782") |i10_dx1==("B3782") |i10_dx1==("B3783") |i10_dx1==("B3784") |i10_dx1==("B3784") |i10_dx1==("B3789") |i10_dx1==("B3789") |i10_dx1==("B379") |i10_dx1==("B380") |i10_dx1==("B381") |i10_dx1==("B382") |i10_dx1==("B383") |i10_dx1==("B384") |i10_dx1==("B3889") |i10_dx1==("B389") |i10_dx1==("B39") |i10_dx1==("B40") |i10_dx1==("B41") |i10_dx1==("B42") |i10_dx1==("B43") |i10_dx1==("B44") |i10_dx1==("B450") |i10_dx1==("B451") |i10_dx1==("B457") |i10_dx1==("B459") |i10_dx1==("B469") |i10_dx1==("B470") |i10_dx1==("B471") |i10_dx1==("B479") |i10_dx1==("B480") |i10_dx1==("B481") |i10_dx1==("B482") |i10_dx1==("B488") |i10_dx1==("B488") |i10_dx1==("B49") |i10_dx1==("B950") |i10_dx1==("B951") |i10_dx1==("B952") |i10_dx1==("B953") |i10_dx1==("B954") |i10_dx1==("B955") |i10_dx1==("B9561") |i10_dx1==("B9562") |i10_dx1==("B957") |i10_dx1==("B958") |i10_dx1==("B960") |i10_dx1==("B961") |i10_dx1==("B9620") |i10_dx1==("B9621") |i10_dx1==("B9622") |i10_dx1==("B9623") |i10_dx1==("B9629") |i10_dx1==("B963") |i10_dx1==("B964") |i10_dx1==("B965") |i10_dx1==("B966") |i10_dx1==("B967") |i10_dx1==("B9681") |i10_dx1==("B9689") |i10_dx1==("E832") |i10_dx1==("G000") |i10_dx1==("G001") |i10_dx1==("G002") |i10_dx1==("G003") |i10_dx1==("G008") |i10_dx1==("G009") |i10_dx1==("G01") |i10_dx1==("G02") |i10_dx1==("G02") |i10_dx1==("G02") |i10_dx1==("G042") |i10_dx1==("G060") |i10_dx1==("G061") |i10_dx1==("G062") |i10_dx1==("G08") |i10_dx1==("H0500") |i10_dx1==("H05019") |i10_dx1==("H05029") |i10_dx1==("H05039") |i10_dx1==("H05049") |i10_dx1==("H0510") |i10_dx1==("H05119") 
	
	replace allsepsis = 1 if i10_dx1==("H05129") |i10_dx1==("H0520") |i10_dx1==("H05219") |i10_dx1==("H05229") |i10_dx1==("H05239") |i10_dx1==("H05249") |i10_dx1==("H05259") |i10_dx1==("H05269") |i10_dx1==("H0530") |i10_dx1==("H05319") |i10_dx1==("H05329") |i10_dx1==("H05339") |i10_dx1==("H05349") |i10_dx1==("H05359") |i10_dx1==("H05409") |i10_dx1==("H05419") |i10_dx1==("H05429") |i10_dx1==("H0553") |i10_dx1==("H05819") |i10_dx1==("H05829") |i10_dx1==("H0589") |i10_dx1==("H0589") |i10_dx1==("H0589") |i10_dx1==("H0589") |i10_dx1==("H059") |i10_dx1==("H16249") |i10_dx1==("H32") |i10_dx1==("H33129") |i10_dx1==("H44009") |i10_dx1==("H44019") |i10_dx1==("H44029") |i10_dx1==("H44119") |i10_dx1==("H44129") |i10_dx1==("H44139") |i10_dx1==("H4419") |i10_dx1==("H4420") |i10_dx1==("H4421") |i10_dx1==("H4422") |i10_dx1==("H4423") |i10_dx1==("H442A1") |i10_dx1==("H442A2") |i10_dx1==("H442A3") |i10_dx1==("H442A9") |i10_dx1==("H442B1") |i10_dx1==("H442B2") |i10_dx1==("H442B3") |i10_dx1==("H442B9") |i10_dx1==("H442C1") |i10_dx1==("H442C2") |i10_dx1==("H442C3") |i10_dx1==("H442C9") |i10_dx1==("H442D1") |i10_dx1==("H442D2") |i10_dx1==("H442D3") |i10_dx1==("H442D9") |i10_dx1==("H442E1") |i10_dx1==("H442E2") |i10_dx1==("H442E3") |i10_dx1==("H442E9") |i10_dx1==("H4430") |i10_dx1==("H44319") |i10_dx1==("H44329") |i10_dx1==("H44399") |i10_dx1==("H4440") |i10_dx1==("H44419") |i10_dx1==("H44429") |i10_dx1==("H44439") |i10_dx1==("H44449") |i10_dx1==("H4450") |i10_dx1==("H44519") |i10_dx1==("H44529") |i10_dx1==("H44539") |i10_dx1==("H44609") |i10_dx1==("H44619") |i10_dx1==("H44629") |i10_dx1==("H44639") |i10_dx1==("H44649") |i10_dx1==("H44659") |i10_dx1==("H44699") |i10_dx1==("H44709") |i10_dx1==("H44719") |i10_dx1==("H44729") |i10_dx1==("H44739") |i10_dx1==("H44749") |i10_dx1==("H44759") |i10_dx1==("H44799") |i10_dx1==("H44819") |i10_dx1==("H44829") |i10_dx1==("H4489") |i10_dx1==("H449") |i10_dx1==("H6020") |i10_dx1==("I308") |i10_dx1==("I32") |i10_dx1==("I330") |i10_dx1==("I339") |i10_dx1==("I39") |i10_dx1==("I39") |i10_dx1==("J0100") |i10_dx1==("J0110") |i10_dx1==("J0120") |i10_dx1==("J0130") |i10_dx1==("J0140") |i10_dx1==("J0190") |i10_dx1==("J020") |i10_dx1==("J029") |i10_dx1==("J0300") |i10_dx1==("J0390") |i10_dx1==("J040") |i10_dx1==("J0410") |i10_dx1==("J0411") |i10_dx1==("J042") |i10_dx1==("J0430") |i10_dx1==("J0431") |i10_dx1==("J050") |i10_dx1==("J050") |i10_dx1==("J0510") |i10_dx1==("J0511") |i10_dx1==("J060") |i10_dx1==("J069") |i10_dx1==("J13") |i10_dx1==("J14") |i10_dx1==("J150") |i10_dx1==("J151") |i10_dx1==("J1520") |i10_dx1==("J15211") |i10_dx1==("J15212") |i10_dx1==("J1529") |i10_dx1==("J153") |i10_dx1==("J154") |i10_dx1==("J155") |i10_dx1==("J156") |i10_dx1==("J158") |i10_dx1==("J158") |i10_dx1==("J159") |i10_dx1==("J17") |i10_dx1==("J180") |i10_dx1==("J181") |i10_dx1==("J189") |i10_dx1==("J36") |i10_dx1==("J441") |i10_dx1==("J471") |i10_dx1==("J479") |i10_dx1==("J850") |i10_dx1==("J851") |i10_dx1==("J852") |i10_dx1==("J853") |i10_dx1==("J860") |i10_dx1==("J869") |i10_dx1==("K046") |i10_dx1==("K047") |i10_dx1==("K113") |i10_dx1==("K122") |i10_dx1==("K122") |i10_dx1==("K352") |i10_dx1==("K353") |i10_dx1==("K3580") |i10_dx1==("K3589") |i10_dx1==("K36") |i10_dx1==("K37") |i10_dx1==("K5712") |i10_dx1==("K5713") |i10_dx1==("K5732") |i10_dx1==("K5733") |i10_dx1==("K610") |i10_dx1==("K611") |i10_dx1==("K613") |i10_dx1==("K630") |i10_dx1==("K631") |i10_dx1==("K650") |i10_dx1==("K650") |i10_dx1==("K651") |i10_dx1==("K652") |i10_dx1==("K653") |i10_dx1==("K654") |i10_dx1==("K658") |i10_dx1==("K658") |i10_dx1==("K659") |i10_dx1==("K67") |i10_dx1==("K6811") |i10_dx1==("K6812") |i10_dx1==("K6819") |i10_dx1==("K689") |i10_dx1==("K7210") |i10_dx1==("K7290") |i10_dx1==("K7290") |i10_dx1==("K7291") |i10_dx1==("K750") |i10_dx1==("K751") |i10_dx1==("K751") |i10_dx1==("K766") |i10_dx1==("K767") |i10_dx1==("K810") |i10_dx1==("K811") |i10_dx1==("K812") |i10_dx1==("K819") |i10_dx1==("K820") |i10_dx1==("K821") |i10_dx1==("K822") |i10_dx1==("K823") |i10_dx1==("K824") |i10_dx1==("K828") |i10_dx1==("K829") |i10_dx1==("K9081") |i10_dx1==("K9402") |i10_dx1==("L03019") |i10_dx1==("L03029") |i10_dx1==("L03039") |i10_dx1==("L03049") |i10_dx1==("L03119") |i10_dx1==("L03129") |i10_dx1==("L03211") |i10_dx1==("L03212") |i10_dx1==("L03213") |i10_dx1==("L03221") |i10_dx1==("L03222") |i10_dx1==("L03317") |i10_dx1==("L03319") |i10_dx1==("L03329") |i10_dx1==("L03811") |i10_dx1==("L03818") |i10_dx1==("L03891") |i10_dx1==("L03898") |i10_dx1==("L0390") |i10_dx1==("L0391") |i10_dx1==("L049") |i10_dx1==("L0501") |i10_dx1==("L0502") |i10_dx1==("L05091") |i10_dx1==("L0592") |i10_dx1==("L080") |i10_dx1==("L081") |i10_dx1==("L0889") |i10_dx1==("L0889") |i10_dx1==("L089") |i10_dx1==("L88") |i10_dx1==("L980") |i10_dx1==("M0000") |i10_dx1==("M00019") |i10_dx1==("M00029") |i10_dx1==("M00039") |i10_dx1==("M00049") |i10_dx1==("M00059") |i10_dx1==("M00069") |i10_dx1==("M00079") |i10_dx1==("M0008") |i10_dx1==("M0009") |i10_dx1==("M0010") |i10_dx1==("M00119") |i10_dx1==("M00129") |i10_dx1==("M00139") |i10_dx1==("M00149") |i10_dx1==("M00159") |i10_dx1==("M00169") |i10_dx1==("M00179") |i10_dx1==("M0018") |i10_dx1==("M0019") |i10_dx1==("M0020") |i10_dx1==("M00219") |i10_dx1==("M00229") |i10_dx1==("M00239") |i10_dx1==("M00249") |i10_dx1==("M00259") |i10_dx1==("M00269") |i10_dx1==("M00279") |i10_dx1==("M0028") |i10_dx1==("M0029") |i10_dx1==("M0080") |i10_dx1==("M00819") |i10_dx1==("M00829") |i10_dx1==("M00839") |i10_dx1==("M00849") |i10_dx1==("M00859") |i10_dx1==("M00869") |i10_dx1==("M00879") |i10_dx1==("M0088") |i10_dx1==("M0089") |i10_dx1==("M009") |i10_dx1==("M009") |i10_dx1==("M01X0") |i10_dx1==("M01X19") |i10_dx1==("M01X29") |i10_dx1==("M01X39") |i10_dx1==("M01X49") |i10_dx1==("M01X59") |i10_dx1==("M01X69") |i10_dx1==("M01X79") |i10_dx1==("M01X8") |i10_dx1==("M01X9") |i10_dx1==("M0210") |i10_dx1==("M02119") |i10_dx1==("M02129") |i10_dx1==("M02139") |i10_dx1==("M02149") |i10_dx1==("M02159") |i10_dx1==("M02169") |i10_dx1==("M02179") |i10_dx1==("M0218") |i10_dx1==("M0219") |i10_dx1==("M0230") |i10_dx1==("M02319") |i10_dx1==("M02329") |i10_dx1==("M02339") |i10_dx1==("M02349") |i10_dx1==("M02359") |i10_dx1==("M02369") |i10_dx1==("M02379") |i10_dx1==("M0238") |i10_dx1==("M0239") |i10_dx1==("M272") |i10_dx1==("M352") |i10_dx1==("M4620") |i10_dx1==("M4630") |i10_dx1==("M60009") |i10_dx1==("M726") |i10_dx1==("M8610") |i10_dx1==("M86119") |i10_dx1==("M86129") |i10_dx1==("M86139") |i10_dx1==("M86149") |i10_dx1==("M86159") |i10_dx1==("M86169") |i10_dx1==("M86179") |i10_dx1==("M8618") |i10_dx1==("M8619") |i10_dx1==("M8620") |i10_dx1==("M86219") |i10_dx1==("M86229") |i10_dx1==("M86239") |i10_dx1==("M86249") |i10_dx1==("M86259") |i10_dx1==("M86269") |i10_dx1==("M86279") |i10_dx1==("M8628") |i10_dx1==("M8629") |i10_dx1==("M8660") |i10_dx1==("M86619") |i10_dx1==("M86629") 
	
	replace allsepsis = 1 if i10_dx1==("M86639") |i10_dx1==("M86642") |i10_dx1==("M86659") |i10_dx1==("M86669") |i10_dx1==("M86679") |i10_dx1==("M8668") |i10_dx1==("M8669") |i10_dx1==("M869") |i10_dx1==("M8960") |i10_dx1==("M89619") |i10_dx1==("M89629") |i10_dx1==("M89639") |i10_dx1==("M89649") |i10_dx1==("M89659") |i10_dx1==("M89669") |i10_dx1==("M89679") |i10_dx1==("M8968") |i10_dx1==("M8969") |i10_dx1==("M9080") |i10_dx1==("M90819") |i10_dx1==("M90829") |i10_dx1==("M90839") |i10_dx1==("M90849") |i10_dx1==("M90859") |i10_dx1==("M90869") |i10_dx1==("M90879") |i10_dx1==("M9088") |i10_dx1==("M9089") |i10_dx1==("N10") |i10_dx1==("N110") |i10_dx1==("N118") |i10_dx1==("N12") |i10_dx1==("N139") |i10_dx1==("N151") |i10_dx1==("N159") |i10_dx1==("N16") |i10_dx1==("N2884") |i10_dx1==("N2885") |i10_dx1==("N2886") |i10_dx1==("N360") |i10_dx1==("N361") |i10_dx1==("N362") |i10_dx1==("N3641") |i10_dx1==("N3642") |i10_dx1==("N365") |i10_dx1==("N368") |i10_dx1==("N368") |i10_dx1==("N369") |i10_dx1==("N390") |i10_dx1==("N398") |i10_dx1==("N399") |i10_dx1==("N410") |i10_dx1==("N411") |i10_dx1==("N412") |i10_dx1==("N413") |i10_dx1==("N414") |i10_dx1==("N418") |i10_dx1==("N419") |i10_dx1==("N451") |i10_dx1==("N452") |i10_dx1==("N453") |i10_dx1==("N454") |i10_dx1==("N51") |i10_dx1==("N51") |i10_dx1==("N7001") |i10_dx1==("N7002") |i10_dx1==("N7003") |i10_dx1==("N7011") |i10_dx1==("N7012") |i10_dx1==("N7013") |i10_dx1==("N7091") |i10_dx1==("N7092") |i10_dx1==("N7093") |i10_dx1==("N710") |i10_dx1==("N711") |i10_dx1==("N719") |i10_dx1==("N730") |i10_dx1==("N731") |i10_dx1==("N732") |i10_dx1==("N733") |i10_dx1==("N734") |i10_dx1==("N736") |i10_dx1==("N738") |i10_dx1==("N739") |i10_dx1==("N751") |i10_dx1==("N764") | i10_dx1==("R310") |i10_dx1==("R311") |i10_dx1==("R3121") |i10_dx1==("R3129") |i10_dx1==("R319") |i10_dx1==("R7881") |i10_dx1==("T798XXA") |i10_dx1==("T80211A") |i10_dx1==("T80212A") |i10_dx1==("T80219A") |i10_dx1==("T8022XA") |i10_dx1==("T8029XA") |i10_dx1==("T814XXA") |i10_dx1==("T814XXA") |i10_dx1==("T826XXA") |i10_dx1==("T827XXA") |i10_dx1==("T827XXA") |i10_dx1==("T83510A") |i10_dx1==("T83511A") |i10_dx1==("T83512A") |i10_dx1==("T83518A") |i10_dx1==("T83590A") |i10_dx1==("T83591A") |i10_dx1==("T83592A") |i10_dx1==("T83593A") |i10_dx1==("T83598A") |i10_dx1==("T8361XA") |i10_dx1==("T8362XA") |i10_dx1==("T8369XA") |i10_dx1==("T8450XA") |i10_dx1==("T8460XA") |i10_dx1==("T847XXA") |i10_dx1==("T8571XA") |i10_dx1==("T85730A") |i10_dx1==("T85731A") |i10_dx1==("T85732A") |i10_dx1==("T85733A") |i10_dx1==("T85734A") |i10_dx1==("T85735A") |i10_dx1==("T85738A") |i10_dx1==("T8579XA") |i10_dx1==("T8579XA") |i10_dx1==("T880XXA") |i10_dx1==("Z332") |i10_dx1==("Z332") |i10_dx1==("Z332") |i10_dx1==("A000") |i10_dx1==("O0484") | i10_dx1==("A021") | i10_dx1==("A227") | i10_dx1==("A267") | i10_dx1==("A327") | i10_dx1==("A403") | i10_dx1==("A409") | i10_dx1==("A4101") | i10_dx1==("A4102") | i10_dx1==("A411") | i10_dx1==("A412") | i10_dx1==("A413") | i10_dx1==("A414") | i10_dx1==("A4150") | i10_dx1==("A4151") | i10_dx1==("A4152") | i10_dx1==("A4153") | i10_dx1==("A4159") | i10_dx1==("A4189") | i10_dx1==("A419") | i10_dx1==("A5486") | i10_dx1==("B377")

/*Use for 2016 data
gen organdys = 0
foreach num of numlist 2/30 {
	replace organdys = 1 if inlist(i10_dx`num', "D65",  "D688",  "D689",  "D6951",  "D6959") | inlist(i10_dx`num', "D696",  "F05",  "G931",  "G9340", "G9341") | inlist(i10_dx`num', "G9349",  "I6783",  "I952",  "I953",  "I9581") | inlist(i10_dx`num', "I9589",  "J80",  "J9600",  "J9610",  "J9620") | inlist(i10_dx`num', "J9690",  "J984",  "K7200",  "K762",  "K763") | inlist(i10_dx`num', "N170",  "N171",  "N172",  "N178",  "N179") | inlist(i10_dx`num', "R0603",  "R0681",  "R092",  "R570",  "R571") | inlist(i10_dx`num', "R578",  "R579",  "R6521",  "I951") 
}*/

*Use for past 2016 data
gen organdys = 0
foreach num of numlist 2/40 {
	replace organdys = 1 if inlist(i10_dx`num', "D65",  "D688",  "D689",  "D6951",  "D6959") | inlist(i10_dx`num', "D696",  "F05",  "G931",  "G9340", "G9341") | inlist(i10_dx`num', "G9349",  "I6783",  "I952",  "I953",  "I9581") | inlist(i10_dx`num', "I9589",  "J80",  "J9600",  "J9610",  "J9620") | inlist(i10_dx`num', "J9690",  "J984",  "K7200",  "K762",  "K763") | inlist(i10_dx`num', "N170",  "N171",  "N172",  "N178",  "N179") | inlist(i10_dx`num', "R0603",  "R0681",  "R092",  "R570",  "R571") | inlist(i10_dx`num', "R578",  "R579",  "R6521",  "I951") 
} 
		
replace allsepsis = 0 if organdys==0
replace allsepsis = 1 if explicitsepsis==1
*************************

*See how many have sepsis
gen full_cohort=0
replace full_cohort = 1 if allsepsis==1
svy: tab allsepsis, count format(%20.10f)

*Delete those who have age less than 18
replace full_cohort = 0 if age<18
svy: tab full_cohort, count format(%20.10f)

*Delete those who have missing mortality data
replace full_cohort = 0 if died==.
svy: tab full_cohort, count format(%20.10f)

*Delete those who have missing age data
replace age = . if age==0
replace full_cohort = 0 if age==. 
svy: tab full_cohort, count format(%20.10f)

*Delete those who have missing sex data
replace full_cohort = 0 if female==.
svy: tab full_cohort, count format(%20.10f)

*Delete those who have missing race/ethnicity data
replace full_cohort = 0 if race==.
svy: tab full_cohort, count format(%20.10f)

*Get age, sex, race info for sepsis cohort
svy: proportion full_cohort
svy: mean age if full_cohort==1
svy: proportion male if full_cohort==1
svy: proportion race if full_cohort==1

*Find proportion of PAD in all patients, not just among those with sepsis

*Elixhauser Comorbidity Index
*ssc install elixhauser
*Use for 2016 data
*elixhauser i10_dx2-i10_dx30, index(10)
*Use for after 2016
elixhauser i10_dx2-i10_dx40, index(10)
gen elix = 0
replace elix = elixsum-ynel5

gen allPAD=0
replace allPAD=1 if ynel5==1

/*What proportion of all NIS patients have PAD?
svy: tab allPAD if age >17, count format(%20.10f)
svy: proportion allPAD if age>17*/

*Save only sepsis cohort
drop if full_cohort == 0

save "/Users/stuthiiyer/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /2016sepsiscohort.dta", replace
log close

save "/Users/stuthiiyer/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /2017sepsiscohort.dta", replace
log close

save "/Users/stuthiiyer/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /2018sepsiscohort.dta", replace
log close

save "/Users/stuthiiyer/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /2019sepsiscohort.dta", replace
log close

save "/Users/stuthiiyer/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /2020sepsiscohort.dta", replace
log close
*
*
****Merge all five files****

use "/Users/stuthiiyer/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /2016sepsiscohort.dta"
append using "/Users/stuthiiyer/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /2017sepsiscohort.dta"
append using "/Users/stuthiiyer/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /2018sepsiscohort.dta"
append using "/Users/stuthiiyer/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /2019sepsiscohort.dta"
append using "/Users/stuthiiyer/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /2020sepsiscohort.dta"

save "/Users/stuthiiyer/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /2016-2020.dta", replace
*
*
log using "/Users/stuthiiyer/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /Table 1.log", replace
use "/Users/stuthiiyer/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /2016-2020.dta", clear
*Moving on to Table 1 creation

svyset hosp_nis [pw=discwt]

*Proportion of sepsis hospitalizations that died
svy: prop died

*Proportion PAD among sepsis hospitalizations
svy: tab allPAD, count format(%20.10f)
svy: proportion allPAD

*Coronary Artery Disease
gen cad = 0
foreach num of numlist 2/40 {
replace cad = 1 if inlist(i10_dx`num', "I200", "I201", "I202", "I208", "I209") | inlist(i10_dx`num', "I210", "I2101", "I2102", "I2109", "I211") | inlist(i10_dx`num', "I2111", "I2119", "I212", "I2121", "I2129") | inlist(i10_dx`num', "I213", "I214", "I219", "I21A1", "I256") | inlist(i10_dx`num', "I21A9", "I220", "I221", "I222", "I228") | inlist(i10_dx`num', "I229", "I230", "I231", "I232", "I233") | inlist(i10_dx`num', "I234", "I235", "I236", "I237", "I238") | inlist(i10_dx`num', "I240", "I241", "I248", "I249", "I250") | inlist(i10_dx`num', "I2510", "I25110", "I25111") | inlist(i10_dx`num', "I25112", "I25118", "I25119", "I252", "I25700") | inlist(i10_dx`num', "I25701", "I25702", "I25708", "I25709", "I25710") | inlist(i10_dx`num', "I25711", "I25712", "I25718", "I25719", "I25720") | inlist(i10_dx`num', "I25721", "I25728", "I25729", "I25730", "I25731") | inlist(i10_dx`num', "I25732", "I25738", "I25739", "I25750", "I25751") | inlist(i10_dx`num', "I25752", "I25758", "I25759", "I25760", "I25761") | inlist(i10_dx`num', "I25762", "I25768", "I25769", "I25790", "I25791") | inlist(i10_dx`num', "I25792", "I25798", "I25799", "I25810", "I2582") | inlist(i10_dx`num', "I2583", "I2584", "I2589", "I259", "I255")
}

svy: tab allPAD cad,  count format(%20.10f)
svy: proportion cad
svy: proportion cad if allPAD==1
svy: proportion cad if allPAD==0

*Now focus on people with PAD & CAD
gen pnc = 0
replace pnc=1 if allPAD ==1 & cad==1
*Make a variable that includes PAD/PAD+CAD/CAD as categories to look at the revasc outcomes
gen cat=0
replace cat = 1 if allPAD == 1 & pnc==0
replace cat = 2 if pnc==1
replace cat = 3 if cad==1 & pnc==0

svy: tab cat, count format(%20.10f)
svy: prop cat

svy: tab allPAD, count format(%20.10f)
svy: proportion allPAD

*Elixhauser
svy: mean elix
svy: mean elix if allPAD==1
svy: mean elix if allPAD==0
svy: regress elix allPAD

svy: mean elix if cat==3
svy: mean elix if cat==2
svy: mean elix if cat==1
svy: mean elix if cat==0
svy:regress elix cat

*Making age
svy: mean age
svy: mean age if allPAD==1
svy: mean age if allPAD==0
svy:regress age allPAD

svy: mean age if cat==3
svy: mean age if cat==2
svy: mean age if cat==1
svy: mean age if cat==0
svy:regress age cat

*Making sex

foreach var of varlist allPAD cat {
	svy: tab `var' male,  count format(%20.10f)
}
svy: proportion male if allPAD==1
svy: proportion male if allPAD==0

svy: proportion male if cat==3
svy: proportion male if cat==2
svy: proportion male if cat==1
svy: proportion male if cat==0

*Defining race categories, where ethnicity is when race=3...can make a separate variable
label define race 1 "White" 2 "Black" 3 "Hispanic" 4 "Asian or Pacific Islander" 5 "Native American" 6 "Other", replace
label value race race 

gen white = 0 
replace white = 1 if race==1
gen black = 0 
replace black = 1 if race==2
gen hispanic = 0
replace hispanic = 1 if race==3
gen asian = 0 
replace asian = 1 if race==4
gen native = 0
replace native = 1 if race==5
gen race_other = 0 
replace race_other = 1 if race==6

foreach var of varlist white black hispanic asian native race_other {
	svy: tab `var' allPAD,  count format(%20.10f) pearson
}
svy: tab race allPAD,  count format(%20.10f) pearson
svy: prop race
svy: proportion race if allPAD==1
svy: proportion race if allPAD==0

foreach var of varlist white black hispanic asian native race_other {
	svy: tab `var' cat,  count format(%20.10f) pearson
}
svy: tab race cat,  count format(%20.10f) pearson
svy: proportion race if cat==3
svy: proportion race if cat==2
svy: proportion race if cat==1
svy: proportion race if cat==0

*Defining median income categories
foreach n of numlist 1/4 {
gen income_q`n' = 0
replace income_q`n' = 1 if zipinc_qrtl==`n'
}
gen income_q_miss = 0
replace income_q_miss=1 if zipinc_qrtl==.
replace zipinc_qrtl=5 if zipinc_qrtl==.

foreach var of varlist income_q1 income_q2 income_q3 income_q4 income_q_miss {
	svy: tab `var' allPAD,  count format(%20.10f) pearson
}
svy: tab zipinc_qrtl allPAD,  count format(%20.10f) pearson
svy: proportion zipinc_qrtl if allPAD==1
svy: proportion zipinc_qrtl if allPAD==0

foreach var of varlist income_q1 income_q2 income_q3 income_q4 income_q_miss {
	svy: tab `var' cat,  count format(%20.10f) pearson
}
svy: tab zipinc_qrtl cat,  count format(%20.10f) pearson
svy: proportion zipinc_qrtl if cat==3
svy: proportion zipinc_qrtl if cat==2
svy: proportion zipinc_qrtl if cat==1
svy: proportion zipinc_qrtl if cat==0

*Making expected primary payer
replace pay1 = 7 if pay1==.
label define pay1 1 "Medicare" 2 "Medicaid" 3 "Private" 4 "self-pay" 5 "no charge" 6 "other" 7 "missing"
label value pay1 pay1

foreach n of numlist 1/7 {
gen pay1_`n' = 0
replace pay1_`n' = 1 if pay1 ==`n'
}

foreach var of varlist pay1_1 pay1_2 pay1_3 pay1_4 pay1_5 pay1_6 pay1_7{
	svy: tab `var' allPAD,  count format(%20.10f) pearson
}
svy: tab pay1 allPAD,  count format(%20.10f) pearson
svy: proportion pay1 if allPAD==1
svy: proportion pay1 if allPAD==0

foreach var of varlist pay1_1 pay1_2 pay1_3 pay1_4 pay1_5 pay1_6 pay1_7{
	svy: tab `var' allPAD,  count format(%20.10f) pearson
}
svy: tab pay1 cat,  count format(%20.10f) pearson
svy: proportion pay1 if cat==3
svy: proportion pay1 if cat==2
svy: proportion pay1 if cat==1
svy: proportion pay1 if cat==0

*Making hospital location variable
replace hosp_locteach = 4 if hosp_locteach==.
label define hosp_locteach 1 "Rural" 2 "Urban Nonteaching" 3 "Urban Teaching" 4 "Missing"
label value hosp_locteach hosp_locteach

foreach n of numlist 1/4 {
gen hosp_locteach`n' = 0
replace hosp_locteach`n' = 1 if hosp_locteach ==`n'
}

foreach var of varlist hosp_locteach1 hosp_locteach2 hosp_locteach3 hosp_locteach4 {
	svy: tab `var' allPAD,  count format(%20.10f) pearson
}
svy: tab hosp_locteach allPAD,  count format(%20.10f) pearson
svy: proportion hosp_locteach if allPAD==1
svy: proportion hosp_locteach if allPAD==0

foreach var of varlist hosp_locteach1 hosp_locteach2 hosp_locteach3 hosp_locteach4 {
	svy: tab `var' cat,  count format(%20.10f) pearson
}
svy: tab hosp_locteach cat,  count format(%20.10f) pearson
svy: proportion hosp_locteach if cat==3
svy: proportion hosp_locteach if cat==2
svy: proportion hosp_locteach if cat==1
svy: proportion hosp_locteach if cat==0

*Comorbidities

*Making uncomplicated diabetes variable without Type 1 codes
gen cm_dm = 0 
foreach num of numlist 2/40 {
replace cm_dm = 1 if inlist(i10_dx`num', "E0821", "E0822", "E0829", "E08311", "E08319") | inlist(i10_dx`num', "E08321", "E083211", "E083212", "E083213", "E083219") | inlist(i10_dx`num', "E08329", "E083291", "E083292", "E083293", "E083299") | inlist(i10_dx`num', "E08331", "E083311", "E083312", "E083313", "E083319") | inlist(i10_dx`num', "E08339", "E083391", "E083392", "E083393", "E083399") | inlist(i10_dx`num', "E08341", "E083411", "E083412", "E083413", "E083419") | inlist(i10_dx`num', "E08349", "E083491", "E083492", "E083493", "E083499") | inlist(i10_dx`num', "E08351", "E083511", "E083512", "E083513", "E083519") | inlist(i10_dx`num', "E083521", "E083522", "E083523", "E083529", "E083531") | inlist(i10_dx`num', "E083532", "E083533", "E083539", "E083541", "E083542") | inlist(i10_dx`num', "E083543", "E083549", "E083551", "E083552", "E083553") | inlist(i10_dx`num', "E083559", "E08359", "E083591", "E083592", "E083593") | inlist(i10_dx`num', "E083599", "E0836", "E0837X1", "E0837X2", "E0837X3") | inlist(i10_dx`num', "E0837X9", "E0839", "E0840", "E0841", "E0842") | inlist(i10_dx`num', "E0843", "E0844", "E0849", "E0851", "E0852") | inlist(i10_dx`num', "E0859", "E08610", "E08618", "E08620", "E08621") | inlist(i10_dx`num', "E08622", "E08628", "E08630", "E08638", "E08641") | inlist(i10_dx`num', "E08649", "E0865", "E0869", "E088", "E0921") | inlist(i10_dx`num', "E0922", "E0929", "E09311", "E09319", "E09321") | inlist(i10_dx`num', "E093211", "E093212", "E093213", "E093219", "E09329") | inlist(i10_dx`num', "E093291", "E093292", "E093293", "E093299", "E09331") | inlist(i10_dx`num', "E093311", "E093312", "E093313", "E093319", "E09339") | inlist(i10_dx`num', "E093391", "E093392", "E093393", "E093399", "E09341") | inlist(i10_dx`num', "E093411", "E093412", "E093413", "E093419", "E09349") | inlist(i10_dx`num', "E093491", "E093492", "E093493", "E093499", "E09351") | inlist(i10_dx`num', "E093511", "E093512", "E093513", "E093519", "E093521") | inlist(i10_dx`num', "E093522", "E093523", "E093529", "E093531", "E093532") | inlist(i10_dx`num', "E093533", "E093539", "E093541", "E093542", "E093543") | inlist(i10_dx`num', "E093549", "E093551", "E093552", "E093553", "E093559") | inlist(i10_dx`num', "E09359", "E093591", "E093592", "E093593", "E093599") | inlist(i10_dx`num', "E0936", "E0937X1", "E0937X2", "E0937X3", "E0937X9") | inlist(i10_dx`num', "E0939", "E0940", "E0941", "E0942", "E0943") | inlist(i10_dx`num', "E0944", "E0949", "E0951", "E0952", "E0959") | inlist(i10_dx`num', "E09610", "E09618", "E09620", "E09621", "E09622") | inlist(i10_dx`num', "E09628", "E09630", "E09638", "E09641", "E09649") | inlist(i10_dx`num', "E0965", "E0969", "E098") | inlist(i10_dx`num', "E1121", "E1122", "E1129") | inlist(i10_dx`num', "E11311", "E11319", "E11321", "E113211", "E113212") | inlist(i10_dx`num', "E113213", "E113219", "E11329", "E113291", "E113292") | inlist(i10_dx`num', "E113293", "E113299", "E11331", "E113311", "E113312") | inlist(i10_dx`num', "E113313", "E113319", "E11339", "E113391", "E113392") | inlist(i10_dx`num', "E113393", "E113399", "E11341", "E113411", "E113412") | inlist(i10_dx`num', "E113413", "E113419", "E11349", "E113491", "E113492") | inlist(i10_dx`num', "E113493", "E113499", "E11351", "E113511", "E113512") | inlist(i10_dx`num', "E113513", "E113519", "E113521", "E113522", "E113523") | inlist(i10_dx`num', "E113529", "E113531", "E113532", "E113533", "E113539") | inlist(i10_dx`num', "E113541", "E113542", "E113543", "E113549", "E113551") | inlist(i10_dx`num', "E113552", "E113553", "E113559", "E11359", "E113591") | inlist(i10_dx`num', "E113592", "E113593", "E113599", "E1136", "E1137X1") | inlist(i10_dx`num', "E1137X2", "E1137X3", "E1137X9", "E1139", "E1140") | inlist(i10_dx`num', "E1141", "E1142", "E1143", "E1144", "E1149") | inlist(i10_dx`num', "E1151", "E1152", "E1159", "E11610", "E11618") | inlist(i10_dx`num', "E11620", "E11621", "E11622", "E11628", "E11630") | inlist(i10_dx`num', "E11638", "E11641", "E11649", "E1165", "E1169") | inlist(i10_dx`num', "E118", "E1321", "E1322", "E1329", "E13311") | inlist(i10_dx`num', "E13319", "E13321", "E133211", "E133212", "E133213") | inlist(i10_dx`num', "E133219", "E13329", "E133291", "E133292", "E133293") | inlist(i10_dx`num', "E133299", "E13331", "E133311", "E133312", "E133313") | inlist(i10_dx`num', "E133319", "E13339", "E133391", "E133392", "E133393") | inlist(i10_dx`num', "E133399", "E13341", "E133411", "E133412", "E133413") | inlist(i10_dx`num', "E133419", "E13349", "E133491", "E133492", "E133493") | inlist(i10_dx`num', "E133499", "E13351", "E133511", "E133512", "E133513") | inlist(i10_dx`num', "E133519", "E133521", "E133522", "E133523", "E133529") | inlist(i10_dx`num', "E133531", "E133532", "E133533", "E133539", "E133541") | inlist(i10_dx`num', "E133542", "E133543", "E133549", "E133551", "E133552") | inlist(i10_dx`num', "E133553", "E133559", "E13359", "E133591", "E133592") | inlist(i10_dx`num', "E133593", "E133599", "E1336", "E1337X1", "E1337X2") | inlist(i10_dx`num', "E1337X3", "E1337X9", "E1339", "E1340", "E1341") | inlist(i10_dx`num', "E1342", "E1343", "E1344", "E1349", "E1351") | inlist(i10_dx`num', "E1352", "E1359", "E13610", "E13618", "E13620") | inlist(i10_dx`num', "E13621", "E13622", "E13628", "E13630", "E13638") | inlist(i10_dx`num', "E13641", "E13649", "E1365", "E1369", "E138") | inlist(i10_dx`num', "E0800", "E0801", "E0810", "E0811", "E089") | inlist(i10_dx`num', "E0900", "E0901", "E0910", "E0911", "E099") | inlist(i10_dx`num', "E1100", "E1101") | inlist(i10_dx`num', "E1110", "E1111", "E119", "E1300", "E1301") | inlist(i10_dx`num', "E1310", "E1311", "E139", "O24011", "O24012") | inlist(i10_dx`num', "O24013", "O24019", "O2402", "O2403", "O24111") | inlist(i10_dx`num', "O24112", "O24113", "O24119", "O2412", "O2413") | inlist(i10_dx`num', "O24311", "O24312", "O24313", "O24319", "O2432") | inlist(i10_dx`num', "O2433", "O24410", "O24414", "O24415", "O24419") | inlist(i10_dx`num', "O24420", "O24424", "O24425", "O24429", "O24430") | inlist(i10_dx`num', "O24434", "O24435", "O24439", "O24811", "O24812") | inlist(i10_dx`num', "O24813", "O24819", "O2482", "O2483", "O24911") | inlist(i10_dx`num', "O24912", "O24913", "O24919", "O2492", "O2493")
}

foreach var of varlist allPAD cat {
	svy: tab `var' cm_dm,  count format(%20.10f)
}

svy: proportion cm_dm if allPAD==1
svy: proportion cm_dm if allPAD==0

svy: proportion cm_dm if cat==3
svy: proportion cm_dm if cat==2
svy: proportion cm_dm if cat==1
svy: proportion cm_dm if cat==0

*Cerebrovascular disease (CVD)
gen cvd = 0
foreach num of numlist 2/40 {
replace cvd = 1 if inlist(i10_dx`num', "I6000", "I6001", "I6002", "I6010", "I6011") | inlist(i10_dx`num', "I602", "I6030", "I6031", "I6032", "I604") | inlist(i10_dx`num', "I6050", "I6051", "I606", "I607", "I608") | inlist(i10_dx`num', "I609", "I601", "I611", "I612", "I613") | inlist(i10_dx`num', "I614", "I615", "I616", "I617", "I618") | inlist(i10_dx`num', "I619", "G459") | inlist(i10_dx`num', "I6300", "I63011", "I63012") | inlist(i10_dx`num', "I63013", "I63019", "I6302", "I63031", "I63032") | inlist(i10_dx`num', "I63033", "I63039", "I6309") | inlist(i10_dx`num', "I6310", "I63111", "I63112", "I63113", "I63119") | inlist(i10_dx`num', "I6312", "I63131", "I63132", "I63133", "I63139") | inlist(i10_dx`num', "I6319", "I6320", "I63211", "I63212", "I63213") | inlist(i10_dx`num', "I63219", "I6322", "I63231", "I63232", "I63233") | inlist(i10_dx`num', "I63239", "I6329", "I6330", "I63311", "I63312") | inlist(i10_dx`num', "I63313", "I63319", "I63321", "I63322", "I63323") | inlist(i10_dx`num', "I63329", "I63331", "I63332", "I63333", "I63339") | inlist(i10_dx`num', "I63341", "I63342", "I63343", "I63343", "I63349") | inlist(i10_dx`num', "I6339", "I6349", "I63411", "I63412", "I63413") | inlist(i10_dx`num', "I63419", "I63421", "I63422", "I63423", "I63429") | inlist(i10_dx`num', "I63431", "I63432", "I63433", "I63439", "I63441") | inlist(i10_dx`num', "I63442", "I63443", "I63449", "I6349", "I6350") | inlist(i10_dx`num', "I63511", "I63512", "I63513", "I63519", "I63521") | inlist(i10_dx`num', "I63522", "I63523", "I63529", "I63531", "I63532") | inlist(i10_dx`num', "I63533", "I63539", "I63541", "I63542", "I63543") | inlist(i10_dx`num', "I63549", "I6359", "I636", "I6381", "I6389") | inlist(i10_dx`num', "I639", "I6501", "I6502", "I6503", "I6509") | inlist(i10_dx`num', "I651", "I6521", "I6522") | inlist(i10_dx`num', "I6523", "I6529", "I658", "I659", "I6601") | inlist(i10_dx`num', "I6602", "I6603", "I6609", "I6611", "I6612")| inlist(i10_dx`num', "I6613", "I6619", "I6621", "I6622", "I6623") | inlist(i10_dx`num', "I6629", "I663", "I668", "I669", "I670") | inlist(i10_dx`num', "I671", "I672", "I673", "I674", "I675") | inlist(i10_dx`num', "I676", "I677", "I6781", "I6782", "I6783") | inlist(i10_dx`num', "I67841", "I67848", "I67850", "I67858", "I6789") | inlist(i10_dx`num', "I679", "I6900") | inlist(i10_dx`num', "I69010", "I69011", "I69012", "I69013", "I69014") | inlist(i10_dx`num', "I69015", "I69018", "I69019", "I69020", "I69021") | inlist(i10_dx`num', "I69022", "I69023", "I69028") | inlist(i10_dx`num', "I69031", "I69032", "I69033", "I69034", "I69039") | inlist(i10_dx`num', "I69041", "I69042", "I69043", "I69044", "I69049") | inlist(i10_dx`num', "I69051", "I69052", "I69053", "I69054", "I69059") | inlist(i10_dx`num', "I69061", "I69062", "I69063", "I69064", "I69065") | inlist(i10_dx`num', "I69069", "I69090", "I69091", "I69092", "I69093") | inlist(i10_dx`num', "I69098", "I6910", "I69110", "I69111", "I69112") | inlist(i10_dx`num', "I69113", "I69114", "I69115", "I69118", "I69119") | inlist(i10_dx`num', "I69120", "I69121", "I69122", "I69123", "I69128") | inlist(i10_dx`num', "I69131", "I69132", "I69133", "I69134", "I69139") | inlist(i10_dx`num', "I69141", "I69142", "I69143", "I69144", "I69149") | inlist(i10_dx`num', "I69151", "I69152", "I69153") | inlist(i10_dx`num', "I69154", "I69159", "I69161", "I69162", "I69163") | inlist(i10_dx`num', "I69164", "I69165", "I69169", "I69190", "I69191") | inlist(i10_dx`num', "I69192", "I69193", "I69198", "I6920", "I69210") | inlist(i10_dx`num', "I69211", "I69212", "I69213", "I69214", "I69215") | inlist(i10_dx`num', "I69218", "I69219", "I69220", "I69221", "I69222") | inlist(i10_dx`num', "I69223", "I69228", "I69231", "I69232", "I69233") | inlist(i10_dx`num', "I69234", "I69239", "I69241", "I69242", "I69243") | inlist(i10_dx`num', "I69244", "I69249", "I69251", "I69252", "I69253") | inlist(i10_dx`num', "I69254", "I69259", "I69261", "I69262", "I69263") | inlist(i10_dx`num', "I69264", "I69265", "I69269", "I69290", "I69291") | inlist(i10_dx`num', "I69292", "I69293", "I69298") | inlist(i10_dx`num', "I6930", "I69310", "I69311", "I69312", "I69313") | inlist(i10_dx`num', "I69314", "I69315", "I69318", "I69319", "I69320") | inlist(i10_dx`num', "I69321", "I69322", "I69323", "I69328", "I69331") | inlist(i10_dx`num', "I69332", "I69333", "I69334", "I69339", "I69341") | inlist(i10_dx`num', "I69342", "I69343", "I69344", "I69349", "I69351") | inlist(i10_dx`num', "I69352", "I69353", "I69354", "I69359", "I69361") | inlist(i10_dx`num', "I69362", "I69363", "I69364", "I69365", "I69369") | inlist(i10_dx`num', "I69390", "I69391", "I69392", "I69393", "I69398") | inlist(i10_dx`num', "I6980", "I69810", "I69811", "I69812", "I69813") | inlist(i10_dx`num', "I69814", "I69815", "I69818", "I69819", "I69820") | inlist(i10_dx`num', "I69821", "I69822", "I69823") | inlist(i10_dx`num', "I69828", "I69831", "I69832", "I69833", "I69834") | inlist(i10_dx`num', "I69839", "I69841", "I69842", "I69843", "I69844") | inlist(i10_dx`num', "I69849", "I69851", "I69852", "I69853", "I69854") | inlist(i10_dx`num', "I69859", "I69861", "I69862", "I69863", "I69864") | inlist(i10_dx`num', "I69869", "I69890", "I69891", "I69892", "I69893") | inlist(i10_dx`num', "I69898", "I6990", "I69910", "I69911", "I69912") | inlist(i10_dx`num', "I69913", "I69914", "I69915", "I69918", "I69919") | inlist(i10_dx`num', "I69920", "I69921", "I69922", "I69923", "I69928") | inlist(i10_dx`num', "I69931", "I69932", "I69933", "I69934", "I69939") | inlist(i10_dx`num', "I69941", "I69942", "I69943") | inlist(i10_dx`num', "I69944", "I69949", "I69951", "I69952", "I69953") | inlist(i10_dx`num', "I69954", "I69959", "I69961", "I69962", "I69963") | inlist(i10_dx`num', "I69964", "I69965", "I69969", "I69990", "I69991") | inlist(i10_dx`num', "I69992", "I69993", "I69998") |  inlist(i10_dx`num', "H3410", "H3411", "H3412", "H3413", "G450") | inlist(i10_dx`num', "G451", "G452", "G453", "G454", "G458")
}

foreach var of varlist allPAD cat{
	svy: tab `var' cvd,  count format(%20.10f)
}

svy: proportion cvd if allPAD==1
svy: proportion cvd if allPAD==0

svy: proportion cvd if cat==3
svy: proportion cvd if cat==2
svy: proportion cvd if cat==1
svy: proportion cvd if cat==0

*ESRD
gen esrd = 0
replace esrd = 1 if ynel13==1

foreach var of varlist allPAD cat{
	svy: tab `var' esrd,  count format(%20.10f)
}

svy: proportion esrd if allPAD==1
svy: proportion esrd if allPAD==0

svy: proportion esrd if cat==3
svy: proportion esrd if cat==2
svy: proportion esrd if cat==1
svy: proportion esrd if cat==0

*HTN
gen htn = 0
replace htn = 1 if ynel6==1 | ynel31==1

foreach var of varlist allPAD cat{
	svy: tab `var' htn,  count format(%20.10f)
}

svy: proportion htn if allPAD==1
svy: proportion htn if allPAD==0

svy: proportion htn if cat==3
svy: proportion htn if cat==2
svy: proportion htn if cat==1
svy: proportion htn if cat==0

*Anticoagulants and antiplatelets
gen chronic_ac=0
foreach num of numlist 1/40{
	replace chronic_ac=1 if inlist(i10_dx`num', "Z7901")
}

gen chronic_ap=0
foreach num of numlist 1/40{
	replace chronic_ap=1 if inlist(i10_dx`num', "Z7902")
}
*Create one binary variable
gen chronic_at=0
replace chronic_at=1 if chronic_ac==1 | chronic_ap==1

foreach var of varlist allPAD cat {
	svy: tab `var' chronic_ac,  count format(%20.10f)
	svy: tab `var' chronic_ap,  count format(%20.10f)
}
svy: proportion chronic_ac if allPAD==1
svy: proportion chronic_ac if allPAD==0

svy: proportion chronic_ac if cat==3
svy: proportion chronic_ac if cat==2
svy: proportion chronic_ac if cat==1
svy: proportion chronic_ac if cat==0

svy: proportion chronic_ap if allPAD==1
svy: proportion chronic_ap if allPAD==0

svy: proportion chronic_ap if cat==3
svy: proportion chronic_ap if cat==2
svy: proportion chronic_ap if cat==1
svy: proportion chronic_ap if cat==0

*Defining outcomes (Manuscript/Table 2)
*Mortality here, but amp in Logistic Regression .do file
svy: prop died if allPAD==0
svy: prop died if allPAD==1
svy: tab allPAD died

svy: prop died if cat==3
svy: prop died if cat==2
svy: prop died if cat==1
svy: prop died if cat==0
svy: tab cat died

*New Hospice Var for Sensitivity Analyses
gen hospice = 0 
foreach num of numlist 1/40 {
   replace hospice = 1 if i10_dx`num' == "Z515"
}
replace hospice = 1 if died == 1

svy: prop hospice

svy: tab allPAD hospice,  count format(%20.10f)

svy: proportion hospice if allPAD==1
svy: proportion hospice if allPAD==0

*Hosp LOS (mean + SD)
*extended LOS is days above median LOS
gen extLOS = 0 
summarize los, detail
replace extLOS = 1 if los >r(p50)

foreach var of varlist allPAD cat{
	svy: tab `var' extLOS,  count format(%20.10f)
}

svy: proportion extLOS if allPAD==1
svy: proportion extLOS if allPAD==0

svy: proportion extLOS if cat==3
svy: proportion extLOS if cat==2
svy: proportion extLOS if cat==1
svy: proportion extLOS if cat==0

*Making Location of Hospital Discharges--Decide what data we want to present later!
*Combine HHC + Routine
replace dispuniform = 1 if dispuniform==6
*Missing
replace dispuniform = 3 if dispuniform==.
*Died
replace dispuniform = 4 if dispuniform==20
**Combine AMA with discharged alive, destination unknown(may have expired elsewhere)
replace dispuniform = 6 if dispuniform==99
replace dispuniform = 6 if dispuniform==7
*Combine transfer other with transfer to short-term hospital
replace dispuniform = 6 if dispuniform==2
label define dispuniform 1 "Routine" 3 "Missing" 4 "Died in hospital" 5 "Transfer other (SNF)" 6 "AMA, Discharged alive with unknown destination, Transfer to short-term hospital"

gen dispuniform1 = 0
replace dispuniform1 = 1 if dispuniform ==1

gen dispuniform5 = 0
replace dispuniform5 = 1 if dispuniform ==5

gen dispuniform6 = 0
replace dispuniform6 = 1 if dispuniform ==6

foreach var of varlist dispuniform1 dispuniform5 dispuniform6 {
	svy: tab `var' allPAD,  count format(%20.10f) pearson
}
svy: tab dispuniform allPAD,  count format(%20.10f) pearson
svy: proportion dispuniform if allPAD==1
svy: proportion dispuniform if allPAD==0

*How many people had routine discharge overall
svy: tab dispuniform1,  count format(%20.10f)
svy: prop dispuniform1

foreach var of varlist dispuniform1 dispuniform5 dispuniform6 {
	svy: tab `var' cat,  count format(%20.10f) pearson
}
svy: tab dispuniform cat,  count format(%20.10f) pearson
svy: proportion dispuniform if cat==3
svy: proportion dispuniform if cat==2
svy: proportion dispuniform if cat==1
svy: proportion dispuniform if cat==0

dtable age i.male i.race elix i.zipinc_qrtl i.pay1 i.cad i.cm_dm i.cvd i.esrd i.htn i.chronic_ac i.chronic_ap i.chronic_at i.died i.hospice extLOS i.dispuniform, svy by(allPAD, tests)

save "/Users/stuthiiyer/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /All Sepsis.dta", replace

log close
