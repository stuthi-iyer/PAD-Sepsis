/*
Stuthi Iyer 01/17/2022
PAD & Sepsis
*/

log using "/Users/Stuthi/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /Cohort Def.log", replace

use "/Users/Stuthi/Downloads/2018/NIS_2018_Core.dta", clear 
 
merge m:1 hosp_nis using "/Users/Stuthi/Downloads/2018/NIS_2018_Hospital.dta", nogen

drop age_neonate amonth aweekend dqtr drg drgver drg_nopoa elective hcup_ed mdc mdc_nopoa tran_in tran_out year hosp_region n_disc_u n_hosp_u s_disc_u s_hosp_u total_disc hosp_division hosp_bedsize h_contrl

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

*Distinguishing septic shock
gen onlysepticshock = 0
	replace onlysepticshock = 1 if i10_dx1==("R6521")

**********************************************
* Making implicit sepsis 
gen allsepsis = 0
	replace allsepsis = 1 if i10_dx1==("A001") |i10_dx1==("A009") |i10_dx1==("A0100") |i10_dx1==("A011") |i10_dx1==("A012") |i10_dx1==("A013") |i10_dx1==("A014") |i10_dx1==("A020") |i10_dx1==("A0220") |i10_dx1==("A0221") |i10_dx1==("A0222") |i10_dx1==("A0223") |i10_dx1==("A0224") |i10_dx1==("A0229") |i10_dx1==("A028") |i10_dx1==("A029") |i10_dx1==("A030") |i10_dx1==("A031") |i10_dx1==("A032") |i10_dx1==("A033") |i10_dx1==("A038") |i10_dx1==("A039") |i10_dx1==("A040") |i10_dx1==("A041") |i10_dx1==("A042") |i10_dx1==("A043") |i10_dx1==("A044") |i10_dx1==("A044") |i10_dx1==("A045") |i10_dx1==("A046") |i10_dx1==("A0471") |i10_dx1==("A0472") |i10_dx1==("A048") |i10_dx1==("A048") |i10_dx1==("A048") |i10_dx1==("A048") |i10_dx1==("A048") |i10_dx1==("A049") |i10_dx1==("A049") |i10_dx1==("A050") |i10_dx1==("A051") |i10_dx1==("A052") |i10_dx1==("A053") |i10_dx1==("A054") |i10_dx1==("A055") |i10_dx1==("A058") |i10_dx1==("A059") |i10_dx1==("A080") |i10_dx1==("A0811") |i10_dx1==("A0819") |i10_dx1==("A082") |i10_dx1==("A0831") |i10_dx1==("A0832") |i10_dx1==("A0839") |i10_dx1==("A088") |i10_dx1==("A09") |i10_dx1==("A170") |i10_dx1==("A171") |i10_dx1==("A1781") |i10_dx1==("A1782") |i10_dx1==("A1789") |i10_dx1==("A179") |i10_dx1==("A192") |i10_dx1==("A198") |i10_dx1==("A199") |i10_dx1==("A200") |i10_dx1==("A201") |i10_dx1==("A202") |i10_dx1==("A207") |i10_dx1==("A208") |i10_dx1==("A209") |i10_dx1==("A210") |i10_dx1==("A211") |i10_dx1==("A212") |i10_dx1==("A213") |i10_dx1==("A217") |i10_dx1==("A218") |i10_dx1==("A219") |i10_dx1==("A220") |i10_dx1==("A221") |i10_dx1==("A222") |i10_dx1==("A228") |i10_dx1==("A229") |i10_dx1==("A230") |i10_dx1==("A231") |i10_dx1==("A232") |i10_dx1==("A233") |i10_dx1==("A238") |i10_dx1==("A239") |i10_dx1==("A240") |i10_dx1==("A243") |i10_dx1==("A249") |i10_dx1==("A250") |i10_dx1==("A251") |i10_dx1==("A259") |i10_dx1==("A268") |i10_dx1==("A269") |i10_dx1==("A270") |i10_dx1==("A2781") |i10_dx1==("A2789") |i10_dx1==("A279") |i10_dx1==("A280") |i10_dx1==("A288") |i10_dx1==("A289") |i10_dx1==("A3211") |i10_dx1==("A3212") |i10_dx1==("A3281") |i10_dx1==("A3289") |i10_dx1==("A329") |i10_dx1==("A34") |i10_dx1==("A35") |i10_dx1==("A360") |i10_dx1==("A361") |i10_dx1==("A362") |i10_dx1==("A363") |i10_dx1==("A3681") |i10_dx1==("A3682") |i10_dx1==("A3683") |i10_dx1==("A3684") |i10_dx1==("A3685") |i10_dx1==("A3686") |i10_dx1==("A3689") |i10_dx1==("A3689") |i10_dx1==("A3689") |i10_dx1==("A369") |i10_dx1==("A3700") |i10_dx1==("A3710") |i10_dx1==("A3780") |i10_dx1==("A3790") |i10_dx1==("A389") |i10_dx1==("A390") |i10_dx1==("A391") |i10_dx1==("A394") |i10_dx1==("A3950") |i10_dx1==("A3951") |i10_dx1==("A3952") |i10_dx1==("A3953") |i10_dx1==("A3981") |i10_dx1==("A3982") |i10_dx1==("A3983") |i10_dx1==("A3989") |i10_dx1==("A399") |i10_dx1==("A420") |i10_dx1==("A421") |i10_dx1==("A422") |i10_dx1==("A4281") |i10_dx1==("A4282") |i10_dx1==("A4289") |i10_dx1==("A429") |i10_dx1==("A438") |i10_dx1==("A439") |i10_dx1==("A46") |i10_dx1==("A480") |i10_dx1==("A481") |i10_dx1==("A483") |i10_dx1==("A4851") |i10_dx1==("A4852") |i10_dx1==("A488") |i10_dx1==("A493") |i10_dx1==("A5400") |i10_dx1==("A5401") |i10_dx1==("A5403") |i10_dx1==("A5421") |i10_dx1==("A5422") |i10_dx1==("A5423") |i10_dx1==("A5423") |i10_dx1==("A5424") |i10_dx1==("A5429") |i10_dx1==("A5429") |i10_dx1==("A5431") |i10_dx1==("A5432") |i10_dx1==("A5433") |i10_dx1==("A5439") |i10_dx1==("A5440") |i10_dx1==("A5441") |i10_dx1==("A5442") |i10_dx1==("A5449") |i10_dx1==("A545") |i10_dx1==("A546") |i10_dx1==("A5481") |i10_dx1==("A5483") |i10_dx1==("A5485") |i10_dx1==("A5489") |i10_dx1==("A690") |i10_dx1==("A691") |i10_dx1==("B370") |i10_dx1==("B371") |i10_dx1==("B371") |i10_dx1==("B372") |i10_dx1==("B373") |i10_dx1==("B3742") |i10_dx1==("B3749") |i10_dx1==("B375") |i10_dx1==("B375") |i10_dx1==("B376") |i10_dx1==("B376") |i10_dx1==("B377") |i10_dx1==("B3781") |i10_dx1==("B3781") |i10_dx1==("B3782") |i10_dx1==("B3782") |i10_dx1==("B3783") |i10_dx1==("B3784") |i10_dx1==("B3784") |i10_dx1==("B3789") |i10_dx1==("B3789") |i10_dx1==("B379") |i10_dx1==("B380") |i10_dx1==("B381") |i10_dx1==("B382") |i10_dx1==("B383") |i10_dx1==("B384") |i10_dx1==("B3889") |i10_dx1==("B389") |i10_dx1==("B39") |i10_dx1==("B40") |i10_dx1==("B41") |i10_dx1==("B42") |i10_dx1==("B43") |i10_dx1==("B44") |i10_dx1==("B450") |i10_dx1==("B451") |i10_dx1==("B457") |i10_dx1==("B459") |i10_dx1==("B469") |i10_dx1==("B470") |i10_dx1==("B471") |i10_dx1==("B479") |i10_dx1==("B480") |i10_dx1==("B481") |i10_dx1==("B482") |i10_dx1==("B488") |i10_dx1==("B488") |i10_dx1==("B49") |i10_dx1==("B950") |i10_dx1==("B951") |i10_dx1==("B952") |i10_dx1==("B953") |i10_dx1==("B954") |i10_dx1==("B955") |i10_dx1==("B9561") |i10_dx1==("B9562") |i10_dx1==("B957") |i10_dx1==("B958") |i10_dx1==("B960") |i10_dx1==("B961") |i10_dx1==("B9620") |i10_dx1==("B9621") |i10_dx1==("B9622") |i10_dx1==("B9623") |i10_dx1==("B9629") |i10_dx1==("B963") |i10_dx1==("B964") |i10_dx1==("B965") |i10_dx1==("B966") |i10_dx1==("B967") |i10_dx1==("B9681") |i10_dx1==("B9689") |i10_dx1==("E832") |i10_dx1==("G000") |i10_dx1==("G001") |i10_dx1==("G002") |i10_dx1==("G003") |i10_dx1==("G008") |i10_dx1==("G009") |i10_dx1==("G01") |i10_dx1==("G02") |i10_dx1==("G02") |i10_dx1==("G02") |i10_dx1==("G042") |i10_dx1==("G060") |i10_dx1==("G061") |i10_dx1==("G062") |i10_dx1==("G08") |i10_dx1==("H0500") |i10_dx1==("H05019") |i10_dx1==("H05029") |i10_dx1==("H05039") |i10_dx1==("H05049") |i10_dx1==("H0510") |i10_dx1==("H05119") 
	
	replace allsepsis = 1 if i10_dx1==("H05129") |i10_dx1==("H0520") |i10_dx1==("H05219") |i10_dx1==("H05229") |i10_dx1==("H05239") |i10_dx1==("H05249") |i10_dx1==("H05259") |i10_dx1==("H05269") |i10_dx1==("H0530") |i10_dx1==("H05319") |i10_dx1==("H05329") |i10_dx1==("H05339") |i10_dx1==("H05349") |i10_dx1==("H05359") |i10_dx1==("H05409") |i10_dx1==("H05419") |i10_dx1==("H05429") |i10_dx1==("H0553") |i10_dx1==("H05819") |i10_dx1==("H05829") |i10_dx1==("H0589") |i10_dx1==("H0589") |i10_dx1==("H0589") |i10_dx1==("H0589") |i10_dx1==("H059") |i10_dx1==("H16249") |i10_dx1==("H32") |i10_dx1==("H33129") |i10_dx1==("H44009") |i10_dx1==("H44019") |i10_dx1==("H44029") |i10_dx1==("H44119") |i10_dx1==("H44129") |i10_dx1==("H44139") |i10_dx1==("H4419") |i10_dx1==("H4420") |i10_dx1==("H4421") |i10_dx1==("H4422") |i10_dx1==("H4423") |i10_dx1==("H442A1") |i10_dx1==("H442A2") |i10_dx1==("H442A3") |i10_dx1==("H442A9") |i10_dx1==("H442B1") |i10_dx1==("H442B2") |i10_dx1==("H442B3") |i10_dx1==("H442B9") |i10_dx1==("H442C1") |i10_dx1==("H442C2") |i10_dx1==("H442C3") |i10_dx1==("H442C9") |i10_dx1==("H442D1") |i10_dx1==("H442D2") |i10_dx1==("H442D3") |i10_dx1==("H442D9") |i10_dx1==("H442E1") |i10_dx1==("H442E2") |i10_dx1==("H442E3") |i10_dx1==("H442E9") |i10_dx1==("H4430") |i10_dx1==("H44319") |i10_dx1==("H44329") |i10_dx1==("H44399") |i10_dx1==("H4440") |i10_dx1==("H44419") |i10_dx1==("H44429") |i10_dx1==("H44439") |i10_dx1==("H44449") |i10_dx1==("H4450") |i10_dx1==("H44519") |i10_dx1==("H44529") |i10_dx1==("H44539") |i10_dx1==("H44609") |i10_dx1==("H44619") |i10_dx1==("H44629") |i10_dx1==("H44639") |i10_dx1==("H44649") |i10_dx1==("H44659") |i10_dx1==("H44699") |i10_dx1==("H44709") |i10_dx1==("H44719") |i10_dx1==("H44729") |i10_dx1==("H44739") |i10_dx1==("H44749") |i10_dx1==("H44759") |i10_dx1==("H44799") |i10_dx1==("H44819") |i10_dx1==("H44829") |i10_dx1==("H4489") |i10_dx1==("H449") |i10_dx1==("H6020") |i10_dx1==("I308") |i10_dx1==("I32") |i10_dx1==("I330") |i10_dx1==("I339") |i10_dx1==("I39") |i10_dx1==("I39") |i10_dx1==("J0100") |i10_dx1==("J0110") |i10_dx1==("J0120") |i10_dx1==("J0130") |i10_dx1==("J0140") |i10_dx1==("J0190") |i10_dx1==("J020") |i10_dx1==("J029") |i10_dx1==("J0300") |i10_dx1==("J0390") |i10_dx1==("J040") |i10_dx1==("J0410") |i10_dx1==("J0411") |i10_dx1==("J042") |i10_dx1==("J0430") |i10_dx1==("J0431") |i10_dx1==("J050") |i10_dx1==("J050") |i10_dx1==("J0510") |i10_dx1==("J0511") |i10_dx1==("J060") |i10_dx1==("J069") |i10_dx1==("J13") |i10_dx1==("J14") |i10_dx1==("J150") |i10_dx1==("J151") |i10_dx1==("J1520") |i10_dx1==("J15211") |i10_dx1==("J15212") |i10_dx1==("J1529") |i10_dx1==("J153") |i10_dx1==("J154") |i10_dx1==("J155") |i10_dx1==("J156") |i10_dx1==("J158") |i10_dx1==("J158") |i10_dx1==("J159") |i10_dx1==("J17") |i10_dx1==("J180") |i10_dx1==("J181") |i10_dx1==("J189") |i10_dx1==("J36") |i10_dx1==("J441") |i10_dx1==("J471") |i10_dx1==("J479") |i10_dx1==("J850") |i10_dx1==("J851") |i10_dx1==("J852") |i10_dx1==("J853") |i10_dx1==("J860") |i10_dx1==("J869") |i10_dx1==("K046") |i10_dx1==("K047") |i10_dx1==("K113") |i10_dx1==("K122") |i10_dx1==("K122") |i10_dx1==("K352") |i10_dx1==("K353") |i10_dx1==("K3580") |i10_dx1==("K3589") |i10_dx1==("K36") |i10_dx1==("K37") |i10_dx1==("K5712") |i10_dx1==("K5713") |i10_dx1==("K5732") |i10_dx1==("K5733") |i10_dx1==("K610") |i10_dx1==("K611") |i10_dx1==("K613") |i10_dx1==("K630") |i10_dx1==("K631") |i10_dx1==("K650") |i10_dx1==("K650") |i10_dx1==("K651") |i10_dx1==("K652") |i10_dx1==("K653") |i10_dx1==("K654") |i10_dx1==("K658") |i10_dx1==("K658") |i10_dx1==("K659") |i10_dx1==("K67") |i10_dx1==("K6811") |i10_dx1==("K6812") |i10_dx1==("K6819") |i10_dx1==("K689") |i10_dx1==("K7210") |i10_dx1==("K7290") |i10_dx1==("K7290") |i10_dx1==("K7291") |i10_dx1==("K750") |i10_dx1==("K751") |i10_dx1==("K751") |i10_dx1==("K766") |i10_dx1==("K767") |i10_dx1==("K810") |i10_dx1==("K811") |i10_dx1==("K812") |i10_dx1==("K819") |i10_dx1==("K820") |i10_dx1==("K821") |i10_dx1==("K822") |i10_dx1==("K823") |i10_dx1==("K824") |i10_dx1==("K828") |i10_dx1==("K829") |i10_dx1==("K9081") |i10_dx1==("K9402") |i10_dx1==("L03019") |i10_dx1==("L03029") |i10_dx1==("L03039") |i10_dx1==("L03049") |i10_dx1==("L03119") |i10_dx1==("L03129") |i10_dx1==("L03211") |i10_dx1==("L03212") |i10_dx1==("L03213") |i10_dx1==("L03221") |i10_dx1==("L03222") |i10_dx1==("L03317") |i10_dx1==("L03319") |i10_dx1==("L03329") |i10_dx1==("L03811") |i10_dx1==("L03818") |i10_dx1==("L03891") |i10_dx1==("L03898") |i10_dx1==("L0390") |i10_dx1==("L0391") |i10_dx1==("L049") |i10_dx1==("L0501") |i10_dx1==("L0502") |i10_dx1==("L05091") |i10_dx1==("L0592") |i10_dx1==("L080") |i10_dx1==("L081") |i10_dx1==("L0889") |i10_dx1==("L0889") |i10_dx1==("L089") |i10_dx1==("L88") |i10_dx1==("L980") |i10_dx1==("M0000") |i10_dx1==("M00019") |i10_dx1==("M00029") |i10_dx1==("M00039") |i10_dx1==("M00049") |i10_dx1==("M00059") |i10_dx1==("M00069") |i10_dx1==("M00079") |i10_dx1==("M0008") |i10_dx1==("M0009") |i10_dx1==("M0010") |i10_dx1==("M00119") |i10_dx1==("M00129") |i10_dx1==("M00139") |i10_dx1==("M00149") |i10_dx1==("M00159") |i10_dx1==("M00169") |i10_dx1==("M00179") |i10_dx1==("M0018") |i10_dx1==("M0019") |i10_dx1==("M0020") |i10_dx1==("M00219") |i10_dx1==("M00229") |i10_dx1==("M00239") |i10_dx1==("M00249") |i10_dx1==("M00259") |i10_dx1==("M00269") |i10_dx1==("M00279") |i10_dx1==("M0028") |i10_dx1==("M0029") |i10_dx1==("M0080") |i10_dx1==("M00819") |i10_dx1==("M00829") |i10_dx1==("M00839") |i10_dx1==("M00849") |i10_dx1==("M00859") |i10_dx1==("M00869") |i10_dx1==("M00879") |i10_dx1==("M0088") |i10_dx1==("M0089") |i10_dx1==("M009") |i10_dx1==("M009") |i10_dx1==("M01X0") |i10_dx1==("M01X19") |i10_dx1==("M01X29") |i10_dx1==("M01X39") |i10_dx1==("M01X49") |i10_dx1==("M01X59") |i10_dx1==("M01X69") |i10_dx1==("M01X79") |i10_dx1==("M01X8") |i10_dx1==("M01X9") |i10_dx1==("M0210") |i10_dx1==("M02119") |i10_dx1==("M02129") |i10_dx1==("M02139") |i10_dx1==("M02149") |i10_dx1==("M02159") |i10_dx1==("M02169") |i10_dx1==("M02179") |i10_dx1==("M0218") |i10_dx1==("M0219") |i10_dx1==("M0230") |i10_dx1==("M02319") |i10_dx1==("M02329") |i10_dx1==("M02339") |i10_dx1==("M02349") |i10_dx1==("M02359") |i10_dx1==("M02369") |i10_dx1==("M02379") |i10_dx1==("M0238") |i10_dx1==("M0239") |i10_dx1==("M272") |i10_dx1==("M352") |i10_dx1==("M4620") |i10_dx1==("M4630") |i10_dx1==("M60009") |i10_dx1==("M726") |i10_dx1==("M8610") |i10_dx1==("M86119") |i10_dx1==("M86129") |i10_dx1==("M86139") |i10_dx1==("M86149") |i10_dx1==("M86159") |i10_dx1==("M86169") |i10_dx1==("M86179") |i10_dx1==("M8618") |i10_dx1==("M8619") |i10_dx1==("M8620") |i10_dx1==("M86219") |i10_dx1==("M86229") |i10_dx1==("M86239") |i10_dx1==("M86249") |i10_dx1==("M86259") |i10_dx1==("M86269") |i10_dx1==("M86279") |i10_dx1==("M8628") |i10_dx1==("M8629") |i10_dx1==("M8660") |i10_dx1==("M86619") |i10_dx1==("M86629") 
	
	replace allsepsis = 1 if i10_dx1==("M86639") |i10_dx1==("M86642") |i10_dx1==("M86659") |i10_dx1==("M86669") |i10_dx1==("M86679") |i10_dx1==("M8668") |i10_dx1==("M8669") |i10_dx1==("M869") |i10_dx1==("M8960") |i10_dx1==("M89619") |i10_dx1==("M89629") |i10_dx1==("M89639") |i10_dx1==("M89649") |i10_dx1==("M89659") |i10_dx1==("M89669") |i10_dx1==("M89679") |i10_dx1==("M8968") |i10_dx1==("M8969") |i10_dx1==("M9080") |i10_dx1==("M90819") |i10_dx1==("M90829") |i10_dx1==("M90839") |i10_dx1==("M90849") |i10_dx1==("M90859") |i10_dx1==("M90869") |i10_dx1==("M90879") |i10_dx1==("M9088") |i10_dx1==("M9089") |i10_dx1==("N10") |i10_dx1==("N110") |i10_dx1==("N118") |i10_dx1==("N12") |i10_dx1==("N139") |i10_dx1==("N151") |i10_dx1==("N159") |i10_dx1==("N16") |i10_dx1==("N2884") |i10_dx1==("N2885") |i10_dx1==("N2886") |i10_dx1==("N360") |i10_dx1==("N361") |i10_dx1==("N362") |i10_dx1==("N3641") |i10_dx1==("N3642") |i10_dx1==("N365") |i10_dx1==("N368") |i10_dx1==("N368") |i10_dx1==("N369") |i10_dx1==("N390") |i10_dx1==("N398") |i10_dx1==("N399") |i10_dx1==("N410") |i10_dx1==("N411") |i10_dx1==("N412") |i10_dx1==("N413") |i10_dx1==("N414") |i10_dx1==("N418") |i10_dx1==("N419") |i10_dx1==("N451") |i10_dx1==("N452") |i10_dx1==("N453") |i10_dx1==("N454") |i10_dx1==("N51") |i10_dx1==("N51") |i10_dx1==("N7001") |i10_dx1==("N7002") |i10_dx1==("N7003") |i10_dx1==("N7011") |i10_dx1==("N7012") |i10_dx1==("N7013") |i10_dx1==("N7091") |i10_dx1==("N7092") |i10_dx1==("N7093") |i10_dx1==("N710") |i10_dx1==("N711") |i10_dx1==("N719") |i10_dx1==("N730") |i10_dx1==("N731") |i10_dx1==("N732") |i10_dx1==("N733") |i10_dx1==("N734") |i10_dx1==("N736") |i10_dx1==("N738") |i10_dx1==("N739") |i10_dx1==("N751") |i10_dx1==("N764") | i10_dx1==("R310") |i10_dx1==("R311") |i10_dx1==("R3121") |i10_dx1==("R3129") |i10_dx1==("R319") |i10_dx1==("R7881") |i10_dx1==("T798XXA") |i10_dx1==("T80211A") |i10_dx1==("T80212A") |i10_dx1==("T80219A") |i10_dx1==("T8022XA") |i10_dx1==("T8029XA") |i10_dx1==("T814XXA") |i10_dx1==("T814XXA") |i10_dx1==("T826XXA") |i10_dx1==("T827XXA") |i10_dx1==("T827XXA") |i10_dx1==("T83510A") |i10_dx1==("T83511A") |i10_dx1==("T83512A") |i10_dx1==("T83518A") |i10_dx1==("T83590A") |i10_dx1==("T83591A") |i10_dx1==("T83592A") |i10_dx1==("T83593A") |i10_dx1==("T83598A") |i10_dx1==("T8361XA") |i10_dx1==("T8362XA") |i10_dx1==("T8369XA") |i10_dx1==("T8450XA") |i10_dx1==("T8460XA") |i10_dx1==("T847XXA") |i10_dx1==("T8571XA") |i10_dx1==("T85730A") |i10_dx1==("T85731A") |i10_dx1==("T85732A") |i10_dx1==("T85733A") |i10_dx1==("T85734A") |i10_dx1==("T85735A") |i10_dx1==("T85738A") |i10_dx1==("T8579XA") |i10_dx1==("T8579XA") |i10_dx1==("T880XXA") |i10_dx1==("Z332") |i10_dx1==("Z332") |i10_dx1==("Z332") |i10_dx1==("A000") |i10_dx1==("O0484") | i10_dx1==("A021") | i10_dx1==("A227") | i10_dx1==("A267") | i10_dx1==("A327") | i10_dx1==("A403") | i10_dx1==("A409") | i10_dx1==("A4101") | i10_dx1==("A4102") | i10_dx1==("A411") | i10_dx1==("A412") | i10_dx1==("A413") | i10_dx1==("A414") | i10_dx1==("A4150") | i10_dx1==("A4151") | i10_dx1==("A4152") | i10_dx1==("A4153") | i10_dx1==("A4159") | i10_dx1==("A4189") | i10_dx1==("A419") | i10_dx1==("A5486") | i10_dx1==("B377")

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
svy: tab onlysepticshock if full_cohort==1,  count format(%20.10f)

*Delete those who have age less than 18
replace full_cohort = 0 if age<18
svy: tab full_cohort, count format(%20.10f)
svy: tab onlysepticshock if full_cohort==1,  count format(%20.10f)

*Delete those who have missing mortality data
replace full_cohort = 0 if died==.
svy: tab full_cohort, count format(%20.10f)
svy: tab onlysepticshock if full_cohort==1,  count format(%20.10f)

*Delete those who have missing age data
replace age = . if age==0
replace full_cohort = 0 if age==. 
svy: tab full_cohort, count format(%20.10f)
svy: tab onlysepticshock if full_cohort==1,  count format(%20.10f)

*Delete those who have missing sex data
replace full_cohort = 0 if female==.
svy: tab full_cohort, count format(%20.10f)
svy: tab onlysepticshock if full_cohort==1,  count format(%20.10f)

*Delete those who have missing race/ethnicity data
replace full_cohort = 0 if race==.
svy: tab full_cohort, count format(%20.10f)
svy: tab onlysepticshock if full_cohort==1,  count format(%20.10f)

*Get age, sex, race info
svy: proportion full_cohort
svy: mean age if full_cohort==1
svy: proportion male if full_cohort==1
svy: proportion race if full_cohort==1

save "/Users/Stuthi/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /Full Cohort.dta", replace
log close

log using "/Users/Stuthi/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /Table 1.log", replace
use "/Users/Stuthi/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /Full Cohort.dta", clear
/*Moving on to Table 1 creation
Making PAD*/

drop if full_cohort == 0

gen allPAD = 0
foreach num of numlist 2/40 {
	replace allPAD = 1 if inlist(i10_dx`num', "I70211",  "I70212",  "I70213",  "I70221",  "I70222") | inlist(i10_dx`num', "I70223",  "I70231",  "I70232",  "I70233", "I70234") | inlist(i10_dx`num', "I70235",  "I70241",  "I70245",  "I70242",  "I70243") | inlist(i10_dx`num', "I70244",  "I70261",  "I70262",  "I70263",  "I70291") | inlist(i10_dx`num', "I70292",  "I70293",  "I70301",  "I70302",  "I70303") | inlist(i10_dx`num', "I70311",  "I70312",  "I70313",  "I70321",  "I70322") | inlist(i10_dx`num', "I70323",  "I70331",  "I70332",  "I70333 ",  "I70334") | inlist(i10_dx`num', "I70335",  "I70341",  "I70342",  "I70343",  "I70344") | inlist(i10_dx`num', "I70345",  "I70361",  "I70362",  "I70363",  "I70391") | inlist(i10_dx`num', "I70392",  "I70393",  "I70401",  "I70402",  "I70403") | inlist(i10_dx`num', "I70411",  "I70412",  "I70413",  "I70421",  "I70423") | inlist(i10_dx`num', "I70431",  "I70432",  "I70433",  "I70434",  "I70441") | inlist(i10_dx`num', "I70442",  "I70443",  "I70444",  "I70445",  "I70461") | inlist(i10_dx`num', "I70462",  "I70463",  "I70491",  "I70492",  "I70493") | inlist(i10_dx`num', "I70501",  "I70502",  "I70503",  "I70511",  "I70512") | inlist(i10_dx`num', "I70513",  "I70521",  "I70522",  "I70523",  "I70531") | inlist(i10_dx`num', "I70532",  "I70533",  "I70534",  "I70541",  "I70542") | inlist(i10_dx`num', "I70543",  "I70544",  "I70561",  "I70562",  "I70563") | inlist(i10_dx`num', "I70591",  "I70592",  "I70593",  "I70601",  "I70602") | inlist(i10_dx`num', "I70603",  "I70611",  "I70612",  "I70613",  "I70621") | inlist(i10_dx`num', "I70622",  "I70623",  "I70631",  "I70632",  "I70633") | inlist(i10_dx`num', "I70634",  "I70641",  "I70642",  "I70643",  "I70644") | inlist(i10_dx`num', "I70661",  "I70662",  "I70663",  "I70691",  "I70692") | inlist(i10_dx`num', "I70693",  "I70701",  "I70702",  "I70703",  "I70711") | inlist(i10_dx`num', "I70712",  "I70713",  "I70721",  "I70722",  "I70723") | inlist(i10_dx`num', "I70731",  "I70732",  "I70733",  "I70734",  "I70735") | inlist(i10_dx`num', "I70741",  "I70742",  "I70743",  "I70744",  "I70745") | inlist(i10_dx`num', "I70761",  "I70762",  "I70763",  "I70791",  "I70792") | inlist(i10_dx`num', "Z95820")
} 
svy: tab allPAD, count format(%20.10f)
svy: proportion allPAD

svy: tab onlysepticshock allPAD, count format (%20.10f) pearson
svy: prop onlysepticshock if allPAD==1
svy: prop onlysepticshock if allPAD==0

*Intermittent Claudication
gen IC = 0
foreach num of numlist 2/40 {
	replace IC = 1 if inlist(i10_dx`num', "I70211",  "I70212",  "I70213",  "I70311",  "I70312") | inlist(i10_dx`num', "I70313",  "I70411",  "I70412",  "I70413",  "I70511") | inlist(i10_dx`num', "I70512",  "I70513",  "I70611",  "I70612",  "I70613") | inlist(i10_dx`num', "I70711",  "I70712",  "I70713")
}

*Rest Pain
gen RP = 0
foreach num of numlist 2/40 {
	replace RP = 1 if inlist(i10_dx`num', "I70221",  "I70222",  "I70223",  "I70321",  "I70322") | inlist(i10_dx`num', "I70323",  "I70421",  "I70422",  "I70423",  "I70521") | inlist(i10_dx`num', "I70522",  "I70523",  "I70621",  "I70622",  "I70623") | inlist(i10_dx`num', "I70721",  "I70722",  "I70723")
}

*Ulceration & gangrene = Wounds
gen UG = 0
foreach num of numlist 2/40 {
	replace UG = 1 if inlist(i10_dx`num', "I70231",  "I70232",  "I70233",  "I70234",  "I70241") | inlist(i10_dx`num', "I70242",  "I70243",  "I70244",  "I70235",  "I70261") | inlist(i10_dx`num', "I70262",  "I70263",  "I70331",  "I70332",  "I70333") | inlist(i10_dx`num', "I70334",  "I70341",  "I70342") | inlist(i10_dx`num', "I70343",  "I70344",  "I70348",  "I70361",  "I70362") | inlist(i10_dx`num', "I70363",  "I70431",  "I70432",  "I70433",  "I70434") | inlist(i10_dx`num', "I70441",  "I70442",  "I70443", "I70444", "I70535") | inlist(i10_dx`num', "I70461",  "I70462",  "I70463",  "I70531",  "I70532") | inlist(i10_dx`num', "I70533",  "I70534",  "I70541",  "I70542",  "I70543") | inlist(i10_dx`num', "I70544",  "I70635",  "I70561", "I70562", "I70563") | inlist(i10_dx`num', "I70631",  "I70632",  "I70633",  "I70634",  "I70641") | inlist(i10_dx`num', "I70642",  "I70643",  "I70644",  "I70648",  "I70661") | inlist(i10_dx`num', "I70662",  "I70663",  "I70731", "I70732", "I70733") | inlist(i10_dx`num', "I70734",  "I70741",  "I70742",  "I70743",  "I70744") | inlist(i10_dx`num', "I70735",  "I70761",  "I70762",  "I70763", "I70238") | inlist(i10_dx`num', "I70245",  "I70248",  "I70335",  "I70338", "I70345") | inlist(i10_dx`num', "I70435",  "I70438",  "I70445",  "I70448", "I70345") | inlist(i10_dx`num', "I70538",  "I70545",  "I70548",  "I70638", "I70645") | inlist(i10_dx`num', "I70738", "I70745",  "I70748", "I70345")
}

foreach var of varlist IC RP UG{
	svy: tab `var' allPAD,  count format(%20.10f) pearson
}
svy: prop IC RP UG if allPAD==1
svy: prop IC RP UG if allPAD==0

*Making age
svy: mean age if allPAD==1
*use summarize age if allPAD==1 & full_cohort==1 if need SD instead
svy: mean age if allPAD==0
*use summarize age if allPAD==1 & full_cohort==0
svy:regress age allPAD

*Making male sex
svy: tab male allPAD,  count format(%20.10f) pearson
svy: proportion male if allPAD==1
svy: proportion male if allPAD==0

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
svy: prop race if allPAD==1
svy: prop race if allPAD==0
svy: tab race allPAD,  count format(%20.10f) pearson

*Defining median income categories
foreach n of numlist 1/4 {
gen income_q`n' = 0
replace income_q`n' = 1 if zipinc_qrtl==`n'
}
gen income_q_miss = 0
replace income_q_miss=1 if zipinc_qrtl==.

foreach var of varlist income_q1 income_q2 income_q3 income_q4 income_q_miss {
	svy: tab `var' allPAD,  count format(%20.10f) pearson
}

svy: prop zipinc_qrtl if allPAD==1
svy: prop zipinc_qrtl if allPAD==0

replace zipinc_qrtl = 5 if zipinc_qrtl == .
svy: tab zipinc_qrtl allPAD,  count format(%20.10f) pearson

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
svy: prop pay1 if allPAD==1
svy: prop pay1 if allPAD==0
svy: tab pay1 allPAD,  count format(%20.10f) pearson

*Making patient location variable
replace pl_nchs = 7 if pl_nchs==.
label define pl_nchs 1 "Central" 2 "Fringe" 3 "Large Metro" 4 "Small Metro" 5 "Micro" 6 "Not Metro/Micro" 7 "missing"
label value pl_nchs pl_nchs

foreach n of numlist 1/7 {
gen pl_nchs`n' = 0
replace pl_nchs`n' = 1 if pl_nchs ==`n'
}

foreach var of varlist pl_nchs1 pl_nchs2 pl_nchs3 pl_nchs4 pl_nchs5 pl_nchs6 pl_nchs7{
	svy: tab `var' allPAD,  count format(%20.10f) pearson
}
svy: prop pl_nchs if allPAD==1
svy: prop pl_nchs if allPAD==0
svy: tab pl_nchs allPAD,  count format(%20.10f) pearson


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
svy: prop hosp_locteach if allPAD==1
svy: prop hosp_locteach if allPAD==0
svy: tab hosp_locteach allPAD,  count format(%20.10f) pearson

*Figuring out comorbidities
*Elixhauser Comorbidity Index
elixhauser i10_dx1-i10_dx40, index(10)
gen elix = 0
replace elix = elixsum-ynel5

svy: mean elix if allPAD==1
svy: mean elix if allPAD==0

*Diabetes
gen dm = 0
replace dm = 1 if ynel10==1 | ynel11==1

*Tobacco Use
gen smoke = 0
foreach num of numlist 2/40 {
replace smoke = 1 if inlist(i10_dx`num', "Z87891", "F17200", "F17201", "F17203") | inlist(i10_dx`num', "F17208", "F17209", "F17210", "F17211", "F17213") | inlist(i10_dx`num', "F17218", "F17219", "F17220", "F17290", "F17299") | inlist(i10_dx`num', "T65211A", "T65211S",  "T65211D" , "T65212", "T65212A") | inlist(i10_dx`num', "T65212D", "T65212S",  "T65213A" , "T65213D", "T65213S") | inlist(i10_dx`num', "T65214A", "T65214D",  "T65214S" , "T65221A", "T65221D") | inlist(i10_dx`num', "T65221S", "T65222A",  "T65222D" , "T65222S", "T65223A") | inlist(i10_dx`num', "T65223D", "T65223S",  "T65224A" , "T65224D", "T65224S") | inlist(i10_dx`num', "T65291A", "T65291D",  "T65291S" , "T65292A", "T65292D") | inlist(i10_dx`num', "T65292S", "T65293A",  "T65293D" , "T65293S", "T65294A") | inlist(i10_dx`num', "T65294D", "T65294S", "F17221", "F17223", "F17228") | inlist(i10_dx`num', "T65294D", "T65294S", "F17291", "F17293", "F17298")
}

*ESRD
gen esrd = 0
replace esrd = 1 if ynel13==1

*HTN
gen htn = 0
replace htn = 1 if ynel6==1 | ynel31==1

*Coronary Artery Disease
gen cad = 0
foreach num of numlist 2/40 {
replace cad = 1 if inlist(i10_dx`num', "I200", "I201", "I202", "I208", "I209") | inlist(i10_dx`num', "I210", "I2101", "I2102", "I2109", "I211") | inlist(i10_dx`num', "I2111", "I2119", "I212", "I2121", "I2129") | inlist(i10_dx`num', "I213", "I214", "I219", "I21A1", "I256") | inlist(i10_dx`num', "I21A9", "I220", "I221", "I222", "I228") | inlist(i10_dx`num', "I229", "I230", "I231", "I232", "I233") | inlist(i10_dx`num', "I234", "I235", "I236", "I237", "I238") | inlist(i10_dx`num', "I240", "I241", "I248", "I249", "I250") | inlist(i10_dx`num', "I2510", "I25110", "I25111") | inlist(i10_dx`num', "I25112", "I25118", "I25119", "I252", "I25700") | inlist(i10_dx`num', "I25701", "I25702", "I25708", "I25709", "I25710") | inlist(i10_dx`num', "I25711", "I25712", "I25718", "I25719", "I25720") | inlist(i10_dx`num', "I25721", "I25728", "I25729", "I25730", "I25731") | inlist(i10_dx`num', "I25732", "I25738", "I25739", "I25750", "I25751") | inlist(i10_dx`num', "I25752", "I25758", "I25759", "I25760", "I25761") | inlist(i10_dx`num', "I25762", "I25768", "I25769", "I25790", "I25791") | inlist(i10_dx`num', "I25792", "I25798", "I25799", "I25810", "I2582") | inlist(i10_dx`num', "I2583", "I2584", "I2589", "I259", "I255")
}

*Dyslipidemia
gen dys = 0
foreach num of numlist 2/40 {
replace dys = 1 if inlist(i10_dx`num', "E7800") | inlist(i10_dx`num', "E7801", "E781", "E782", "E783", "E7849") | inlist(i10_dx`num', "E7841", "E785", "E786")
}

*Obesity
gen obese = 0
replace obese = 1 if ynel22==1

foreach var of varlist dm smoke esrd htn cad dys obese {
	svy: tab `var' allPAD,  count format(%20.10f) pearson
}
svy: prop dm smoke esrd htn cad dys obese if allPAD==1
svy: prop dm smoke esrd htn cad dys obese if allPAD==0

*Defining outcomes for Table 2
*Making in-hospital mortality (primary outcome)
svy: tab died, count format (%20.10f)
svy: prop died if allPAD==1
svy: prop died if allPAD==0
svy: tab died allPAD,  count format(%20.10f) pearson

*New Hospice Var for Sensitivity Analyses
gen hospice = 0 
foreach num of numlist 1/40 {
   replace hospice = 1 if i10_dx`num' == "Z515"
}
replace hospice = 1 if died == 1

*Making all PAD interventions
*Suprainguinal + Infrainguinal Bypasses
gen bysup = 0 
foreach num of numlist 1/25 {
replace bysup = 1 if inlist(i10_pr`num', "041K09J", "041K09K", "041K0AJ", "041K0JJ", "041K0JK") | inlist(i10_pr`num', "041K0KJ") | inlist(i10_pr`num', "041K0KK", "041K0ZJ", "041K0ZK") | inlist(i10_pr`num', "041K49J", "041K49K", "041K4AJ", "041K4AK", "041K4JJ") | inlist(i10_pr`num', "041K4JK", "041K4KJ", "041K4KK", "041K4ZJ", "041K4ZK") | inlist(i10_pr`num', "041L09K", "041L0AH", "041L0AK", "041L0JH", "041L0JK") | inlist(i10_pr`num', "041L0KH", "041L0KK", "041L0ZH", "041L0ZK", "041L49H") | inlist(i10_pr`num', "041L49K", "041L4AH", "041L4AK", "041L4JH", "041L4JK") | inlist(i10_pr`num', "041L4KH", "041L4KK", "041L4ZH", "041L4ZK", "041K09H") | inlist(i10_pr`num', "041K09L", "041K09M", "041K09N", "041K09P", "041K09Q") | inlist(i10_pr`num', "041K09S", "041K0AH", "041K0AL", "041K0AM", "041K0AN") | inlist(i10_pr`num', "041K0AP", "041K0AQ", "041K0AS", "041K0JH", "041K0JL") | inlist(i10_pr`num', "041K0JM", "041K0JN", "041K0JP", "041K0JQ", "041K0JS") | inlist(i10_pr`num', "041K0KH", "041K0KL", "041K0KM", "041K0KN", "041K0KP") | inlist(i10_pr`num', "041K0KQ", "041K0KS", "041K0ZH", "041K0ZL", "041K0ZM") | inlist(i10_pr`num', "041K0ZN", "041K0ZP", "041K0ZQ", "041K0ZS", "041K49H") | inlist(i10_pr`num', "041K49L", "041K49M", "041K49N", "041K49P", "041K49Q") | inlist(i10_pr`num', "041K49S", "041K4AH", "041K4AL", "041K4AM", "041K4AN") | inlist(i10_pr`num', "041K4AP", "041K4AQ", "041K4AS", "041K4JH", "041K4JL") | inlist(i10_pr`num', "041K4JM", "041K4JN", "041K4JP", "041K4JQ", "041K4JS") | inlist(i10_pr`num', "041K4KH", "041K4KL", "041K4KM", "041K4KN", "041K4KP") | inlist(i10_pr`num', "041K4KQ", "041K4KS", "041K4ZH", "041K4ZL", "041K4ZM") | inlist(i10_pr`num', "041K4ZN", "041K4ZP", "041K4ZQ", "041K4ZS", "041L09J") | inlist(i10_pr`num', "041L09L", "041L09M", "041L09N", "041L09P", "041L09Q") | inlist(i10_pr`num', "041L09S", "041L0AJ", "041L0AL", "041L0AM", "041L0AN") | inlist(i10_pr`num', "041L0AP", "041L0AQ", "041L0AS", "041L0JJ", "041L0JL") | inlist(i10_pr`num', "041L0JM", "041L0JN", "041L0JP", "041L0JQ", "041L0JS") | inlist(i10_pr`num', "041L0KJ", "041L0KL", "041L0KM", "041L0KN", "041L0KP") | inlist(i10_pr`num', "041L0KQ", "041L0KS", "041L0ZJ", "041L0ZL", "041L0ZM") | inlist(i10_pr`num', "041L0ZN", "041L0ZP", "041L0ZQ", "041L0ZS", "041L49J") | inlist(i10_pr`num', "041L49L", "041L49M", "041L49N", "041L49P", "041L49Q") | inlist(i10_pr`num', "041L49S", "041L4AJ", "041L4AL", "041L4AM", "041L4AN") | inlist(i10_pr`num', "041L4AP", "041L4AQ", "041L4AS", "041L4JJ", "041L4JL") | inlist(i10_pr`num', "041L4JM", "041L4JN", "041L4JP", "041L4JQ", "041L4JQ") | inlist(i10_pr`num', "041L4JS", "041L4KJ", "041L4KL", "041L4KM", "041L4KN") | inlist(i10_pr`num', "041L4KP", "041L4KQ", "041L4KS", "041L4ZJ", "041L4ZL") | inlist(i10_pr`num', "041L4ZM", "041L4ZN", "041L4ZP", "041L4ZQ", "041L4ZS") | inlist(i10_pr`num', "041M09L", "041M09M", "041M09P", "041M09Q", "041M09S") | inlist(i10_pr`num', "041M0AL", "041M0AM", "041M0AP", "041M0AQ", "041M0AS") | inlist(i10_pr`num', "041M0JL", "041M0JM", "041M0JP", "041M0JQ", "041M0JS") | inlist(i10_pr`num', "041M0KL", "041M0KM", "041M0KP", "041M0KQ", "041M0KS") | inlist(i10_pr`num', "041M0ZL", "041M0ZM", "041M0ZP", "041M0ZQ", "041M0ZS") | inlist(i10_pr`num', "041M49L", "041M49M", "041M49P", "041M49Q", "041M49S") | inlist(i10_pr`num', "041M4AL", "041M4AM", "041M4AP", "041M4AQ", "041M4AS") | inlist(i10_pr`num', "041M4JL", "041M4JM", "041M4JP", "041M4JQ", "041M4JS") | inlist(i10_pr`num', "041M4KL", "041M4KM", "041M4KP", "041M4KQ", "041M4KS") | inlist(i10_pr`num', "041M4ZL", "041M4ZM", "041M4ZP", "041M4ZQ", "041M4ZS") | inlist(i10_pr`num', "041N09L", "041N09M", "041N09P", "041N09Q", "041N09S") | inlist(i10_pr`num', "041N0AL", "041N0AM", "041N0AP", "041N0AQ", "041N0AS") | inlist(i10_pr`num', "041N0JL", "041N0JM", "041N0JP", "041N0JQ", "041N0JS") | inlist(i10_pr`num', "041N0KL", "041N0KM", "041N0KP", "041N0KQ", "041N0KS") | inlist(i10_pr`num', "041N0ZL", "041N0ZM", "041N0ZP", "041N0ZQ", "041N0ZS") | inlist(i10_pr`num', "041N49L", "041N49M", "041N49P", "041N49Q", "041N49S") | inlist(i10_pr`num', "041N4AL", "041N4AM", "041N4AP", "041N4AQ", "041N4AS") | inlist(i10_pr`num', "041N4JL", "041N4JM", "041N4JP", "041N4JQ", "041N4JS") | inlist(i10_pr`num', "041N4KL", "041N4KM", "041N4KP", "041N4KQ", "041N4KS") | inlist(i10_pr`num', "041N4ZL", "041N4ZM", "041N4ZP", "041N4ZQ", "041N4ZS") | inlist(i10_pr`num', "04RK07Z", "04RK0JZ", "04RK0KZ", "04RK47Z", "04RK4JZ") | inlist(i10_pr`num', "04RK4KZ", "04RL07Z", "04RL0JZ", "04RL0KZ", "04RL47Z") | inlist(i10_pr`num', "04RL4JZ", "04RL4KZ", "04RM07Z", "04RM0JZ", "04RM0KZ") | inlist(i10_pr`num', "04RM47Z", "04RM4JZ", "04RM4KZ", "04RN07Z", "04RN0JZ") | inlist(i10_pr`num', "04RN0KZ", "04RN47Z", "04RN4JZ", "04RN4KZ", "04RP07Z") | inlist(i10_pr`num', "04RP0JZ", "04RP0KZ", "04RP47Z", "04RP4JZ", "04RP4KZ") | inlist(i10_pr`num', "04RQ07Z", "04RQ0JZ", "04RQ0KZ", "04RQ47Z", "04RQ4JZ") | inlist(i10_pr`num', "04RQ4KZ", "04RR07Z", "04RR0JZ", "04RR0KZ", "04RR47Z") | inlist(i10_pr`num', "04RR4JZ", "04RR4KZ", "04RS07Z", "04RS0JZ", "04RS0KZ") | inlist(i10_pr`num', "04RS47Z", "04RS4JZ", "04RS4KZ", "04RT07Z", "04RT0JZ") | inlist(i10_pr`num', "04RT0KZ", "04RT47Z", "04RT4JZ", "04RT4KZ", "04RU07Z") | inlist(i10_pr`num', "04RU0JZ", "04RU0KZ", "04RU47Z", "04RU4JZ", "04RU4KZ") | inlist(i10_pr`num', "04RV07Z", "04RV0JZ", "04RV0KZ", "04RV47Z", "04RV4JZ") | inlist(i10_pr`num', "04RV4KZ", "04RW07Z", "04RW0JZ", "04RW0KZ", "04RW47Z") | inlist(i10_pr`num', "04RW4JZ", "04RW4KZ", "04RY07Z", "04RY0JZ", "04RY0KZ") | inlist(i10_pr`num', "04RY47Z", "04RY4JZ", "04RY4KZ","041P0JQ", "041P0JS") | inlist(i10_pr`num', "041P3JQ", "041P3JS", "041P4JQ", "041P4JS", "041W09P") | inlist(i10_pr`num', "041W09Q", "041W09S", "041W0AP", "041W0AQ", "041W0AS") | inlist(i10_pr`num', "041W0JP", "041W0JQ", "041W0JS", "041W0KP", "041W0KQ") | inlist(i10_pr`num', "041W0KS", "041W0ZP", "041W0ZQ", "041W0ZS", "041W3JQ") | inlist(i10_pr`num', "041W3JS", "041W49P", "041W49Q", "041W49S", "041W4AP") | inlist(i10_pr`num', "041W4AQ", "041W4AS", "041W4JP", "041W4JQ", "041W4JS") | inlist(i10_pr`num', "041W4KP", "041W4KQ", "041W4KS", "041W4ZP", "041W4ZQ") | inlist(i10_pr`num', "041W4ZS", "041V09P", "041V09Q", "041V09S", "041V0AP") | inlist(i10_pr`num', "041V0AQ", "041V0AS", "041V0JP", "041V0JQ", "041V0JS") | inlist(i10_pr`num', "041V0KP", "041V0KQ", "041V0KS", "041V0ZP", "041V0ZQ") | inlist(i10_pr`num', "041V0ZS", "041V3JQ", "041V3JS", "041V49P", "041V49Q") | inlist(i10_pr`num', "041V49S", "041V4AP", "041V4AQ", "041V4AS", "041V4JP") | inlist(i10_pr`num', "041V4JQ", "041V4JS", "041V4KP", "041V4KQ", "041V4KS") | inlist(i10_pr`num', "041V4ZP", "041V4ZQ", "041V4ZS", "041U09P", "041U09Q") | inlist(i10_pr`num', "041U09S", "041U0AP", "041U0AQ", "041U0AS", "041U0JP") | inlist(i10_pr`num', "041U0JQ", "041U0JS", "041U0KP", "041U0KQ", "041U0KS") | inlist(i10_pr`num', "041U0ZP", "041U0ZQ", "041U0ZS", "041U3JQ", "041U3JS") | inlist(i10_pr`num', "041U49P", "041U49Q", "041U49S", "041U4AP", "041U4AQ") | inlist(i10_pr`num', "041U4AS", "041U4JP", "041U4JQ", "041U4JS", "041U4KP") | inlist(i10_pr`num', "041U4KQ", "041U4KS", "041U4ZP", "041U4ZQ", "041U4ZS") | inlist(i10_pr`num', "041T09P", "041T09Q", "041T09S", "041T0AP", "041T0AQ") | inlist(i10_pr`num', "041T0KQ", "041T0KS", "041T0ZP", "041T0ZQ", "041T0ZS") | inlist(i10_pr`num', "041T3JQ", "041T3JS", "041T49P", "041T49Q", "041T49S") | inlist(i10_pr`num', "041T4AP", "041T4AQ", "041T4AS", "041T4JP", "041T4JQ") | inlist(i10_pr`num', "041T4JS", "041T4KP", "041T4KQ", "041T4KS", "041T4ZP") | inlist(i10_pr`num', "041T4ZQ", "041T4ZS", "041S0JQ", "041S0JS", "041S3JQ") | inlist(i10_pr`num', "041S3JS", "041S4JQ", "041S4JS", "041R0JQ", "041R0JS") | inlist(i10_pr`num', "041R3JQ", "041R3JS", "041R4JQ", "041R4JS", "041Q0JQ") | inlist(i10_pr`num', "041Q0JS", "041Q3JQ", "041Q3JS", "041Q4JQ", "041Q4JS")
}

gen byinf = 0 
foreach num of numlist 1/25 {
replace byinf = 1 if inlist(i10_pr`num', "041H099", "041H09B", "041H09C", "041H09D", "041H09F") | inlist(i10_pr`num', "041H09G", "041H0A9", "041H09B", "041H09C", "041H0AD") | inlist(i10_pr`num', "041H09H", "041H09J", "041H09K", "041H09P", "041H09Q") | inlist(i10_pr`num', "041H0AF", "041H0AG", "041H0AH", "041H0AJ", "041H0AK") | inlist(i10_pr`num', "041H0AP", "041H0AQ", "041H0J9", "041H0JB", "041H0JC") | inlist(i10_pr`num', "041H0JD", "041H0JF", "041H0JG", "041H0JH", "041H0JJ") | inlist(i10_pr`num', "041H0JK", "041H0JP", "041H0JQ", "041H0K9", "041H0KB") | inlist(i10_pr`num', "041H0KC", "041H0KD", "041H0KF", "041H0KG", "041H0KH") | inlist(i10_pr`num', "041H0KJ", "041H0KK", "041H0KP", "041H0KQ", "041H0Z9") | inlist(i10_pr`num', "041H0ZB", "041H0ZC", "041H0ZD", "041H0ZF", "041H0ZG") | inlist(i10_pr`num', "041H0ZH", "041H0ZJ", "041H0ZK", "041H0ZP", "041H0ZQ") | inlist(i10_pr`num', "041H499", "041H49B", "041H49C", "041H49D", "041H49F") | inlist(i10_pr`num', "041H49G", "041H49H", "041H49J", "041H49K", "041H49P") | inlist(i10_pr`num', "041H49Q", "041H4A9", "041H4AB", "041H4AC", "041H4AD") | inlist(i10_pr`num', "041H4AF", "041H4AG", "041H4AH", "041H4AJ", "041H4AK") | inlist(i10_pr`num', "041H4AP", "041H4AQ", "041H4J9", "041H4JB", "041H4JC") | inlist(i10_pr`num', "041H4JD", "041H4JF", "041H4JG", "041H4JH", "041H4JJ") | inlist(i10_pr`num', "041H4JK", "041H4JP", "041H4JQ", "041H4K9", "041H4KB") | inlist(i10_pr`num', "041H4KC", "041H4KD", "041H4KF", "041H4KG", "041H4KH") | inlist(i10_pr`num', "041H4KJ", "041H4KK", "041H4KP", "041H4KQ", "041H4Z9") | inlist(i10_pr`num', "041H4ZB", "041H4ZC", "041H4ZD", "041H4ZF", "041H4ZG") | inlist(i10_pr`num', "041H4ZH", "041H4ZJ", "041H4ZK", "041H4ZP", "041H4ZQ") | inlist(i10_pr`num', "041J099", "041J09B", "041J09C", "041J09F", "041J09J") | inlist(i10_pr`num', "041J09P", "041J09Q", "041J0A9", "041J0AB", "041J0AC") | inlist(i10_pr`num', "041J0AF", "041J0AJ", "041J0AP", "041J0AQ", "041J0J9") | inlist(i10_pr`num', "041J0JB", "041J0JC", "041J0JF", "041J0JJ", "041J0JP") | inlist(i10_pr`num', "041J0JQ", "041J0K9", "041J0KB", "041J0KC", "041J0KF") | inlist(i10_pr`num', "041J0KJ", "041J0KP", "041J0KQ", "041J0Z9", "041J0ZB") | inlist(i10_pr`num', "041J0ZC", "041J0ZF", "041J0ZJ", "041J0ZP", "041J0ZQ") | inlist(i10_pr`num', "041J499", "041J49B", "041J49C", "041J49F", "041J49J") | inlist(i10_pr`num', "041J49P", "041J49Q", "041J4A9", "041J4AB", "041J4AC") | inlist(i10_pr`num', "041J4AF", "041J4AJ", "041J4AP", "041J4AQ", "041J4J9") | inlist(i10_pr`num', "041J4JB", "041J4JC", "041J4JF", "041J4JJ", "041J4JP") | inlist(i10_pr`num', "041J4JQ", "041J094K9", "041J4KB", "041J4KC", "041J4KF") | inlist(i10_pr`num', "041J4KJ", "041J4KP", "041J4KQ", "041J4Z9", "041J4ZB") | inlist(i10_pr`num', "041J4ZC", "041J4ZF", "041J4ZJ", "041J4ZP", "041J4ZQ") | inlist(i10_pr`num', "041J09D", "041J09G", "041J09H", "041J09K", "041J0AD") | inlist(i10_pr`num', "041J0AG", "041J0AH", "041J0AK", "041J0JD", "041J0JG") | inlist(i10_pr`num', "041J0JH", "041J0JK", "041J0KD", "041J0KG", "041J0KH") | inlist(i10_pr`num', "041J0KK", "041J0ZD", "041J0ZG", "041J0ZH", "041J0ZK") | inlist(i10_pr`num', "041J49D", "041J49G", "041J49H", "041J49K", "041J4AD") | inlist(i10_pr`num', "041J4AG", "041J4AH", "041J4AK", "041J4JD", "041J4JG") | inlist(i10_pr`num', "041J4JH", "041J4JK", "041J4KD", "041J4KG", "041J4KH") | inlist(i10_pr`num', "041J4KK", "041J4ZD", "041J4ZG", "041J4ZH", "041J4ZK") | inlist(i10_pr`num', "0315096", "0315097", "0315098", "0315099", "0316096") | inlist(i10_pr`num', "0316097", "0316098", "0316099", "0410096", "0410097") | inlist(i10_pr`num', "0410098", "0410099", "0410496", "0410497", "0410498") | inlist(i10_pr`num', "0410499", "041E099", "031509B", "031509C", "03150A6") | inlist(i10_pr`num', "03150A7", "03150A8", "03150A9", "03150AB", "03150AC") | inlist(i10_pr`num', "03150J6", "03150J7", "03150J8", "03150J9", "03150JB") | inlist(i10_pr`num', "03150JC", "03150K6", "03150K7", "03150K8", "03150K9") | inlist(i10_pr`num', "03150KB", "03150KC", "03150Z6", "03150Z7", "03150Z8") | inlist(i10_pr`num', "03150Z9", "03150ZB", "03150ZC", "031609B", "031609C") | inlist(i10_pr`num', "03160A6", "03160A7", "03160A8", "03160A9", "03160AB") | inlist(i10_pr`num', "03160AC", "03160J6", "03160J7", "03160J8", "03160J9") | inlist(i10_pr`num', "03160JB", "03160JC", "03160Z6", "03160Z7", "03160Z8") | inlist(i10_pr`num', "03160Z9", "03160ZB", "03160ZC", "041009B", "041009C") | inlist(i10_pr`num', "041009D", "041009F", "041009G", "041009H", "041009J") | inlist(i10_pr`num', "041009K", "041009Q", "041009R", "04100A6", "04100A7") | inlist(i10_pr`num', "04100A8", "04100A9", "04100AB", "04100AC", "04100AD") | inlist(i10_pr`num', "04100AF", "04100AG", "04100AH", "04100AJ", "04100AK") | inlist(i10_pr`num', "04100AQ", "04100AR", "04100J6", "04100J7", "04100J8") | inlist(i10_pr`num', "04100J9", "04100JB", "04100JC", "04100JD", "04100JF") | inlist(i10_pr`num', "04100JG", "04100JH", "04100JJ", "04100JK", "04100JQ") | inlist(i10_pr`num', "04100JR", "04100K6", "04100K7", "04100K8", "04100K9") | inlist(i10_pr`num', "04100KB", "04100KC", "04100KD", "04100KF", "04100KG") | inlist(i10_pr`num', "04100KH", "04100KJ", "04100KK", "04100KQ", "04100KR") | inlist(i10_pr`num', "04100Z6", "04100Z7", "04100Z8", "04100Z9", "04100ZB") | inlist(i10_pr`num', "04100ZC", "04100ZD", "04100ZF", "04100ZG", "04100ZH") | inlist(i10_pr`num', "04100ZJ", "04100ZK", "04100ZQ", "04100ZR", "041049B") | inlist(i10_pr`num', "041049C", "041049D", "041049F", "041049G", "041049H") | inlist(i10_pr`num', "041049J", "041049K", "041049Q", "041049R", "04104A6") | inlist(i10_pr`num', "04104A7", "04104A8", "04104A9", "04104AB", "04104AC") | inlist(i10_pr`num', "04104AD", "04104AF", "04104AG", "04104AH", "04104AJ") | inlist(i10_pr`num', "04104AK", "04104AQ", "04104AR", "04104J6", "04104J7") | inlist(i10_pr`num', "04104J8", "04104J9", "04104JB", "04104JC", "04104JD")
}

*cont byinf
foreach num of numlist 1/25 {
replace byinf = 1 if inlist(i10_pr`num', "04104JF", "04104JG", "04104JH", "04104JJ", "04104JK") | inlist(i10_pr`num', "04104JQ", "04104JR", "04104K6", "04104K7", "04104K8") | inlist(i10_pr`num', "04104K9", "04104KB", "04104KC", "04104KD", "04104KF") | inlist(i10_pr`num', "04104ZB", "04104ZC", "04104ZD", "04104ZF", "04104ZG") | inlist(i10_pr`num', "04104ZH", "04104ZJ", "04104ZK", "04104ZQ", "04104ZR") | inlist(i10_pr`num', "041C096", "041C097", "041C098", "041C099", "041C09B") | inlist(i10_pr`num', "041C09C", "041C09D", "041C09F", "041C09G", "041C09H") | inlist(i10_pr`num', "041C09J", "041C09K", "041C09Q", "041C09R", "041C0A6") | inlist(i10_pr`num', "041C0A7", "041C0A8", "041C0A9", "041C0AB", "041C0AC") | inlist(i10_pr`num', "041C0AD", "041C0AF", "041C0AG", "041C0AH", "041C0AJ") | inlist(i10_pr`num', "041C0AK", "041C0AQ", "041C0AR", "041C0J6", "041C0J7") | inlist(i10_pr`num', "041C0J8", "041C0J9", "041C0JB", "041C0JC", "041C0JD") | inlist(i10_pr`num', "041C0JF", "041C0JG", "041C0JH", "041C0JJ", "041C0JK") | inlist(i10_pr`num', "041C0JQ", "041C0JR", "041C0K6", "041C0K7", "041C0K8") | inlist(i10_pr`num', "041C0K9", "041C0KB", "041C0KC", "041C0KD", "041C0KF") | inlist(i10_pr`num', "041C0KG", "041C0KH", "041C0KJ", "041C0KK", "041C0KQ") | inlist(i10_pr`num', "041C0KR", "041C0Z6", "041C0Z7", "041C0Z8", "041C0Z9") | inlist(i10_pr`num', "041C0ZB", "041C0ZC", "041C0ZD", "041C0ZF", "041C0ZG") | inlist(i10_pr`num', "041C0ZH", "041C0ZJ", "041C0ZK", "041C0ZQ", "041C0ZR") | inlist(i10_pr`num', "041C496", "041C497", "041C498", "041C499", "041C49B") | inlist(i10_pr`num', "041C49C", "041C49D", "041C49F", "041C49G", "041C49H") | inlist(i10_pr`num', "041C49J", "041C49K", "041C49Q", "041C49R", "041C4A6") | inlist(i10_pr`num', "041C4A7", "041C4A8", "041C4A9", "041C4AB", "041C4AC") | inlist(i10_pr`num', "041C4AD", "041C4AF", "041C4AG", "041C4AH", "041C4AJ") | inlist(i10_pr`num', "041C4AK", "041C4AQ", "041C4AR", "041C4J6", "041C4J7") | inlist(i10_pr`num', "041C4J8", "041C4J9", "041C4JB", "041C4JC", "041C4JD") | inlist(i10_pr`num', "041C4JF", "041C4JG", "041C4JH", "041C4JJ", "041C4JK") | inlist(i10_pr`num', "041C4JQ", "041C4JR", "041C4K6", "041C4K7", "041C4K8") | inlist(i10_pr`num', "041C4K9", "041C4KB", "041C4KC", "041C4KD", "041C4KF") | inlist(i10_pr`num', "041C4KG", "041C4KH", "041C4KJ", "041C4KK", "041C4KQ") | inlist(i10_pr`num', "041C4KR", "041C4Z6", "041C4Z7", "041C4Z8", "041C4Z9") | inlist(i10_pr`num', "041C4ZB", "041C4ZC", "041C4ZD", "041C4ZF", "041C4ZG") | inlist(i10_pr`num', "041C4ZH", "041C4ZJ", "041C4ZK", "041C4ZQ", "041C4ZR") | inlist(i10_pr`num', "041D096", "041D097", "041D098", "041D099", "041D09B") | inlist(i10_pr`num', "041D09C", "041D09D", "041D09F", "041D09G", "041D09H") | inlist(i10_pr`num', "041D09J", "041D09K", "041D09Q", "041D09R", "041D0A6") | inlist(i10_pr`num', "041D0A7", "041D0A8", "041D0A9", "041D0AB", "041D0AC") | inlist(i10_pr`num', "041D0AD", "041D0AF", "041D0AG", "041D0AH", "041D0AJ") | inlist(i10_pr`num', "041D0AK", "041D0AQ", "041D0AR", "041D0J6", "041D0J7") | inlist(i10_pr`num', "041D0J8", "041D0J9", "041D0JB", "041D0JC", "041D0JD") | inlist(i10_pr`num', "041D0JF", "041D0JG", "041D0JH", "041D0JJ", "041D0JK") | inlist(i10_pr`num', "041D0JQ", "041D0JR", "041D0K6", "041D0K7", "041D0K8") | inlist(i10_pr`num', "041D0K9", "041D0KB", "041D0KC", "041D0KD", "041D0KF") | inlist(i10_pr`num', "041D0KG", "041D0KH", "041D0KJ", "041D0KK", "041D0KQ") | inlist(i10_pr`num', "041D0KR", "041D0Z6", "041D0Z7", "041D0Z8", "041D0Z9") | inlist(i10_pr`num', "041D0ZB", "041D0ZC", "041D0ZD", "041D0ZF", "041D0ZG") | inlist(i10_pr`num', "041D0ZH", "041D0ZJ", "041D0ZK", "041D0ZQ", "041D0ZR") | inlist(i10_pr`num', "041D496", "041D497", "041D498", "041D499", "041D49B") | inlist(i10_pr`num', "041D49C", "041D49D", "041D49F", "041D49G", "041D49H") | inlist(i10_pr`num', "04104AD", "04104AF", "04104AG", "04104AH", "04104AJ") | inlist(i10_pr`num', "041D49J", "041D49K", "041D49Q", "041D49R", "041D4A6") | inlist(i10_pr`num', "041D4A7", "041D4A8", "041D4A9", "041D4AB", "041D4AC") | inlist(i10_pr`num', "041D4AD", "041D4AF", "041D4AG", "041D4AH", "041D4AJ") | inlist(i10_pr`num', "041D4AK", "041D4AQ", "041D4AR", "041D4J6", "041D4J7") | inlist(i10_pr`num', "041D4J8", "041D4J9", "041D4JB", "041D4JC", "041D4JD") | inlist(i10_pr`num', "041D4JF", "041D4JG", "041D4JH", "041D4JJ", "041D4JK") | inlist(i10_pr`num', "041D4JQ", "041D4JR", "041D4K6", "041D4K7", "041D4K8")
}

*cont byinf
foreach num of numlist 1/25 {
replace byinf = 1 if inlist(i10_pr`num', "041D4K9", "041D4KB", "041D4KC", "041D4KD", "041D4KF") | inlist(i10_pr`num', "041D4KG", "041D4KH", "041D4KJ", "041D4KK", "041D4KQ") | inlist(i10_pr`num', "041D4KR", "041D4Z6", "041D4Z7", "041D4Z8", "041D4Z9") | inlist(i10_pr`num', "041D4ZB", "041D4ZC", "041D4ZD", "041D4ZF", "041D4ZG") | inlist(i10_pr`num', "041D4ZH", "041D4ZJ", "041D4ZK", "041D4ZQ", "041D4ZR") | inlist(i10_pr`num', "041E09B", "041E09C", "041E09D", "041E09F", "041E09G") | inlist(i10_pr`num', "041E09H", "041E09J", "041E09K", "041E09P", "041E09Q") | inlist(i10_pr`num', "041E0A9", "041E0AB", "041E0AC", "041E0AD", "041E0AF") | inlist(i10_pr`num', "041E0AG", "041E0AH", "041E0AJ", "041E0AK", "041E0AP") | inlist(i10_pr`num', "041E0AQ", "041E0J9", "041E0JB", "041E0JC", "041E0JD") | inlist(i10_pr`num', "041E0JF", "041E0JG", "041E0JH", "041E0JJ", "041E0JK") | inlist(i10_pr`num', "041E0JP", "041E0JQ", "041E0K9", "041E0KB", "041E0KC") | inlist(i10_pr`num', "041E0KD", "041E0KF", "041E0KG", "041E0KH", "041E0KJ") | inlist(i10_pr`num', "041E0KK", "041E0KP", "041E0KQ", "041E0Z9", "041E0ZB") | inlist(i10_pr`num', "041E0ZC", "041E0ZD", "041E0ZF", "041E0ZG", "041E0ZH") | inlist(i10_pr`num', "041E0ZJ", "041E0ZK", "041E0ZP", "041E0ZQ", "041E499") | inlist(i10_pr`num', "041E49B", "041E49C", "041E49D", "041E49F", "041E49G") | inlist(i10_pr`num', "041E49H", "041E49J", "041E49K", "041E49P", "041E49Q") | inlist(i10_pr`num', "041E4A9", "041E4AB", "041E4AC", "041E4AD", "041E4AF") | inlist(i10_pr`num', "041E4AG", "041E4AH", "041E4AJ", "041E4AK", "041E4AP") | inlist(i10_pr`num', "041E4AQ", "041E4J9", "041E4JB", "041E4JC", "041E4JD") | inlist(i10_pr`num', "041E4JF", "041E4JG", "041E4JH", "041E4JJ", "041E4JK") | inlist(i10_pr`num', "041E4JP", "041E4JQ", "041E4K9", "041E4KB", "041E4KC") | inlist(i10_pr`num', "041E4KD", "041E4KF", "041E4KG", "041E4KH", "041E4KJ") | inlist(i10_pr`num', "041E4KK", "041E4KP", "041E4KQ", "041E4Z9", "041E4ZB") | inlist(i10_pr`num', "041E4ZC", "041E4ZD", "041E4ZF", "041E4ZG", "041E4ZH") | inlist(i10_pr`num', "041E4ZJ", "041E4ZK", "041E4ZP", "041E4ZQ", "041F099") | inlist(i10_pr`num', "041F09B", "041F09C", "041F09D", "041F09F", "041F09G") | inlist(i10_pr`num', "041F09H", "041F09J", "041F09K", "041F09P", "041F09Q") | inlist(i10_pr`num', "041F0A9", "041F0AB", "041F0AC", "041F0AD", "041F0AF") | inlist(i10_pr`num', "041F0AG", "041F0AH", "041F0AJ", "041F0AK", "041F0AP") | inlist(i10_pr`num', "041F0AQ", "041F0J9", "041F0JB", "041F0JC", "041F0JD") | inlist(i10_pr`num', "041F0JF", "041F0JG", "041F0JH", "041F0JJ", "041F0JK") | inlist(i10_pr`num', "041F0JP", "041F0JQ", "041F0K9", "041F0KB", "041F0KC") | inlist(i10_pr`num', "041F0KD", "041F0KF", "041F0KG", "041F0KH", "041F0KJ") | inlist(i10_pr`num', "041F0KK", "041F0KP", "041F0KQ", "041F0Z9", "041F0ZB") | inlist(i10_pr`num', "041F0ZC", "041F0ZD", "041F0ZF", "041F0ZG", "041F0ZH") | inlist(i10_pr`num', "041F0ZJ", "041F0ZK", "041F0ZP", "041F0ZQ", "041F499") | inlist(i10_pr`num', "041F49B", "041F49C", "041F49D", "041F49F", "041F49G") | inlist(i10_pr`num', "041F49H", "041F49J", "041F49K", "041F49P", "041F49Q") | inlist(i10_pr`num', "041F4A9", "041F4AB", "041F4AC", "041F4AD", "041F4AF") | inlist(i10_pr`num', "041F4AG", "041F4AH", "041F4AJ", "041F4AK", "041F4AP") | inlist(i10_pr`num', "041F4AQ", "041F4J9", "041F4JB", "041F4JC", "041F4JD") | inlist(i10_pr`num', "041F4JF", "041F4JG", "041F4JH", "041F4JJ", "041F4JK") | inlist(i10_pr`num', "041F4JP", "041F4JQ", "041F4K9", "041F4KB", "041F4KC") | inlist(i10_pr`num', "041F4KD", "041F4KF", "041F4KG", "041F4KH", "041F4KJ") | inlist(i10_pr`num', "041F4KK", "041F4KP", "041F4KQ", "041F4Z9", "041F4ZB") | inlist(i10_pr`num', "041F4ZJ", "041F4ZK", "041F4ZP", "041F4ZQ")
}

*Endovascular Suprainguinal + Infrainguinal Revascularization
gen endosup = 0 
foreach num of numlist 1/25 {
replace endosup = 1 if inlist(i10_pr`num', "047C041", "047C04Z", "047C05Z", "047C06Z", "047C07Z") | inlist(i10_pr`num', "047C0D1") | inlist(i10_pr`num', "047C0DZ", "047C0EZ", "047C0FZ") | inlist(i10_pr`num', "047C0GZ", "047C0Z1", "047C0ZZ", "047C341", "047C34Z") | inlist(i10_pr`num', "047C35Z", "047C36Z", "047C37Z", "047C3D1", "047C3DZ") | inlist(i10_pr`num', "047C3EZ", "047C3FZ", "047C3GZ", "047C3Z1", "047C3ZZ") | inlist(i10_pr`num', "047C441", "047C44Z", "047C45Z", "047C46Z", "047C47Z") | inlist(i10_pr`num', "047C4D1", "047C4DZ", "047C4EZ", "047C4FZ", "047C4GZ") | inlist(i10_pr`num', "047C4Z1", "047C4ZZ", "047D041", "047D04Z", "047D05Z") | inlist(i10_pr`num', "047D06Z", "047D07Z", "047D0D1", "047D0DZ", "047D0EZ") | inlist(i10_pr`num', "047D0FZ", "047D0GZ", "047D0Z1", "047D0ZZ", "047D341") | inlist(i10_pr`num', "047D34Z", "047D35Z", "047D36Z", "047D37Z", "047D3D1") | inlist(i10_pr`num', "047D3DZ", "047D3EZ", "047D3FZ", "047D3GZ", "047D3Z1") | inlist(i10_pr`num', "047D3ZZ", "047D441", "047D44Z", "047D45Z", "047D46Z") | inlist(i10_pr`num', "047D47Z", "047D4D1", "047D4DZ", "047D4EZ", "047D4FZ") | inlist(i10_pr`num', "047D4GZ", "047D4Z1", "047D4ZZ", "047E041", "047E04Z") | inlist(i10_pr`num', "047E05Z", "047E06Z", "047E07Z", "047E0D1", "047E0DZ") | inlist(i10_pr`num', "047E0EZ", "047E0FZ", "047E0GZ", "047E0Z1", "047E0ZZ") | inlist(i10_pr`num', "047E341", "047E34Z", "047E35Z", "047E36Z", "047E37Z") | inlist(i10_pr`num', "047E3D1", "047E3DZ", "047E3EZ", "047E3FZ", "047E3GZ") | inlist(i10_pr`num', "047E3Z1", "047E3ZZ", "047E441", "047E44Z", "047E45Z") | inlist(i10_pr`num', "047E46Z", "047E47Z", "047E4D1", "047E4DZ", "047E4EZ") | inlist(i10_pr`num', "047E4FZ", "047E4GZ", "047E4Z1", "047E4ZZ", "047F041") | inlist(i10_pr`num', "047F04Z", "047F05Z", "047F06Z", "047F07Z", "047F0D1") | inlist(i10_pr`num', "047F0DZ", "047F0EZ", "047F0FZ", "047F0GZ", "047F0Z1") | inlist(i10_pr`num', "047F0ZZ", "047F341", "047F34Z", "047F35Z", "047F36Z") | inlist(i10_pr`num', "047F37Z", "047F3D1", "047F3DZ", "047F3EZ", "047F3FZ") | inlist(i10_pr`num', "047F3GZ", "047F3Z1", "047F3ZZ", "047F441", "047F44Z") | inlist(i10_pr`num', "047F45Z", "047F46Z", "047F47Z", "047F4D1", "047F4DZ") | inlist(i10_pr`num', "047F4EZ", "047F4FZ", "047F4GZ", "047F4Z1", "047F4ZZ") | inlist(i10_pr`num', "047H041", "047H04Z", "047H05Z", "047H06Z", "047H07Z") | inlist(i10_pr`num', "047H0D1", "047H0DZ", "047H0EZ", "047H0FZ", "047H0GZ") | inlist(i10_pr`num', "047H0Z1", "047H0ZZ", "047H341", "047H34Z", "047H35Z") | inlist(i10_pr`num', "047H36Z", "047H37Z", "047H3D1", "047H3DZ", "047H3EZ") | inlist(i10_pr`num', "047H3FZ", "047H3GZ", "047H3Z1", "047H3ZZ", "047H441") | inlist(i10_pr`num', "047H44Z", "047H45Z", "047H46Z", "047H47Z", "047H4D1") | inlist(i10_pr`num', "047H4DZ", "047H4EZ", "047H4FZ", "047H4GZ", "047H4Z1") | inlist(i10_pr`num', "047H4ZZ", "047J041", "047J04Z", "047J05Z", "047J06Z") | inlist(i10_pr`num', "047J07Z", "047J0D1", "047J0DZ", "047J0EZ", "047J0FZ") | inlist(i10_pr`num', "047J0GZ", "047J0Z1", "047J0ZZ", "047J341", "047J34Z") | inlist(i10_pr`num', "047J35Z", "047J36Z", "047J37Z", "047J3D1", "047J3DZ") | inlist(i10_pr`num', "047J3EZ", "047J3FZ", "047J3GZ", "047J3Z1", "047J3ZZ") | inlist(i10_pr`num', "047J441", "047J44Z", "047J45Z", "047J46Z", "047J47Z") | inlist(i10_pr`num', "047J4D1", "047J4DZ", "047J4EZ", "047J4FZ", "047J4GZ") | inlist(i10_pr`num', "047J4Z1", "047J4ZZ")
}

gen endoinf = 0 
foreach num of numlist 1/25 {
replace endoinf = 1 if inlist(i10_pr`num', "047K041", "047K04Z", "047K05Z", "047K06Z", "047K07Z") | inlist(i10_pr`num', "047K0D1") | inlist(i10_pr`num', "047K0DZ", "047K0EZ", "047K0FZ") | inlist(i10_pr`num', "047K0GZ", "047K0Z1", "047K0ZZ", "047K341", "047K34Z") | inlist(i10_pr`num', "047K35Z", "047K36Z", "047K37Z", "047K3D1", "047K3DZ") | inlist(i10_pr`num', "047K3EZ", "047K3FZ", "047K3GZ", "047K3Z1", "047K3ZZ") | inlist(i10_pr`num', "047K441", "047K44Z", "047K45Z", "047K46Z", "047K47Z") | inlist(i10_pr`num', "047K4D1", "047K4DZ", "047K4EZ", "047K4FZ", "047K4GZ") | inlist(i10_pr`num', "047K4Z1", "047K4ZZ", "047L041", "047L04Z", "047L05Z") | inlist(i10_pr`num', "047L06Z", "047L07Z", "047L0D1", "047L0DZ", "047L0EZ") | inlist(i10_pr`num', "047L0FZ", "047L0GZ", "047L0Z1", "047L0ZZ", "047L341") | inlist(i10_pr`num', "047L34Z", "047L35Z", "047L36Z", "047L37Z", "047L3D1") | inlist(i10_pr`num', "047L3DZ", "047L3EZ", "047L3FZ", "047L3GZ", "047L3Z1") | inlist(i10_pr`num', "047L3ZZ", "047L441", "047L44Z", "047L45Z", "047L46Z") | inlist(i10_pr`num', "047L47Z", "047L4D1", "047L4DZ", "047L4EZ", "047L4FZ") | inlist(i10_pr`num', "047L4GZ", "047L4Z1", "047L4ZZ", "047M041", "047M04Z") | inlist(i10_pr`num', "047M05Z", "047M06Z", "047M07Z", "047M0D1", "047M0DZ") | inlist(i10_pr`num', "047M0EZ", "047M0FZ", "047M0GZ", "047M0Z1", "047M0ZZ") | inlist(i10_pr`num', "047M341", "047M34Z", "047M35Z", "047M36Z", "047M37Z") | inlist(i10_pr`num', "047M3D1", "047M3DZ", "047M3EZ", "047M3FZ", "047M3GZ") | inlist(i10_pr`num', "047M3Z1", "047M3ZZ", "047M441", "047M44Z", "047M45Z") | inlist(i10_pr`num', "047M46Z", "047M47Z", "047M4D1", "047M4DZ", "047M4EZ") | inlist(i10_pr`num', "047M4FZ", "047M4GZ", "047M4Z1", "047M4ZZ", "047N041") | inlist(i10_pr`num', "047N04Z", "047N05Z", "047N06Z", "047N07Z", "047N0D1") | inlist(i10_pr`num', "047N0DZ", "047N0EZ", "047N0FZ", "047N0GZ", "047N0Z1") | inlist(i10_pr`num', "047N0ZZ", "047N341", "047N34Z", "047N35Z", "047N36Z") | inlist(i10_pr`num', "047N37Z", "047N3D1", "047N3DZ", "047N3EZ", "047N3FZ") | inlist(i10_pr`num', "047N3GZ", "047N3Z1", "047N3ZZ", "047N441", "047N44Z") | inlist(i10_pr`num', "047N45Z", "047N46Z", "047N47Z", "047N4D1", "047N4DZ") | inlist(i10_pr`num', "047N4EZ", "047N4FZ", "047N4GZ", "047N4Z1", "047N4ZZ") | inlist(i10_pr`num', "047P041", "047P04Z", "047P05Z", "047P06Z", "047P07Z") | inlist(i10_pr`num', "047P0D1", "047P0DZ", "047P0EZ", "047P0FZ", "047P0GZ") | inlist(i10_pr`num', "047P0Z1", "047P0ZZ", "047P341", "047P34Z", "047P35Z") | inlist(i10_pr`num', "047P36Z", "047P37Z", "047P3D1", "047P3DZ", "047P3EZ") | inlist(i10_pr`num', "047P3FZ", "047P3GZ", "047P3Z1", "047P3ZZ", "047P441") | inlist(i10_pr`num', "047P44Z", "047P45Z", "047P46Z", "047P47Z", "047P4D1") | inlist(i10_pr`num', "047P4DZ", "047P4EZ", "047P4FZ", "047P4GZ", "047P4Z1") | inlist(i10_pr`num', "047P4ZZ", "047Q041", "047Q04Z", "047Q05Z", "047Q06Z") | inlist(i10_pr`num', "047Q07Z", "047Q0D1", "047Q0DZ", "047Q0EZ", "047Q0FZ") | inlist(i10_pr`num', "047Q0GZ", "047Q0Z1", "047Q0ZZ", "047Q341", "047Q34Z") | inlist(i10_pr`num', "047Q35Z", "047Q36Z", "047Q37Z", "047Q3D1", "047Q3DZ") | inlist(i10_pr`num', "047Q3EZ", "047Q3FZ", "047Q3GZ", "047Q3Z1", "047Q3ZZ") | inlist(i10_pr`num', "047Q441", "047Q44Z", "047Q45Z", "047Q46Z", "047Q47Z") | inlist(i10_pr`num', "047Q4D1", "047Q4DZ", "047Q4EZ", "047Q4FZ", "047Q4GZ") | inlist(i10_pr`num', "047Q4Z1", "047Q4ZZ") | inlist(i10_pr`num', "047R041", "047R04Z", "047R05Z", "047R06Z", "047R07Z") | inlist(i10_pr`num', "047R0D1") | inlist(i10_pr`num', "047R0DZ", "047R0EZ", "047R0FZ") | inlist(i10_pr`num', "047R0GZ", "047R0Z1", "047R0ZZ", "047R341", "047R34Z") | inlist(i10_pr`num', "047R35Z", "047R36Z", "047R37Z", "047R3D1", "047R3DZ") | inlist(i10_pr`num', "047R3EZ", "047R3FZ", "047R3GZ", "047R3Z1", "047R3ZZ") | inlist(i10_pr`num', "047R441", "047R44Z", "047R45Z", "047R46Z", "047R47Z") | inlist(i10_pr`num', "047R4D1", "047R4DZ", "047R4EZ", "047R4FZ", "047R4GZ") | inlist(i10_pr`num', "047R4Z1", "047R4ZZ", "047S041", "047S04Z", "047S05Z") | inlist(i10_pr`num', "047S06Z", "047S07Z", "047S0D1", "047S0DZ", "047S0EZ") | inlist(i10_pr`num', "047S0FZ", "047S0GZ", "047S0Z1", "047S0ZZ", "047S341") | inlist(i10_pr`num', "047S34Z", "047S35Z", "047S36Z", "047S37Z", "047S3D1") | inlist(i10_pr`num', "047S3DZ", "047S3EZ", "047S3FZ", "047S3GZ", "047S3Z1") | inlist(i10_pr`num', "047S3ZZ", "047S441", "047S44Z", "047S45Z", "047S46Z") | inlist(i10_pr`num', "047S47Z", "047S4D1", "047S4DZ", "047S4EZ", "047S4FZ") | inlist(i10_pr`num', "047S4GZ", "047S4Z1", "047S4ZZ", "047T041", "047T04Z") | inlist(i10_pr`num', "047T05Z", "047T06Z", "047T07Z", "047T0D1", "047T0DZ") | inlist(i10_pr`num', "047T0EZ", "047T0FZ", "047T0GZ", "047T0Z1", "047T0ZZ") | inlist(i10_pr`num', "047T341", "047T34Z", "047T35Z", "047T36Z", "047T37Z") | inlist(i10_pr`num', "047T3D1", "047T3DZ", "047T3EZ", "047T3FZ", "047T3GZ") | inlist(i10_pr`num', "047T3Z1", "047T3ZZ", "047T441", "047T44Z", "047T45Z") | inlist(i10_pr`num', "047T46Z", "047T47Z", "047T4D1", "047T4DZ", "047T4EZ") | inlist(i10_pr`num', "047T4FZ", "047T4GZ", "047T4Z1", "047T4ZZ", "047U041") | inlist(i10_pr`num', "047U04Z", "047U05Z", "047U06Z", "047U07Z", "047U0D1") | inlist(i10_pr`num', "047U0DZ", "047U0EZ", "047U0FZ", "047U0GZ", "047U0Z1") | inlist(i10_pr`num', "047U0ZZ", "047U341", "047U34Z", "047U35Z", "047U36Z") | inlist(i10_pr`num', "047U37Z", "047U3D1", "047U3DZ", "047U3EZ", "047U3FZ") | inlist(i10_pr`num', "047U3GZ", "047U3Z1", "047U3ZZ", "047U441", "047U44Z") | inlist(i10_pr`num', "047U45Z", "047U46Z", "047U47Z", "047U4D1", "047U4DZ") | inlist(i10_pr`num', "047U4EZ", "047U4FZ", "047U4GZ", "047U4Z1", "047U4ZZ") | inlist(i10_pr`num', "047V041", "047V04Z", "047V05Z", "047V06Z", "047V07Z") | inlist(i10_pr`num', "047V0D1", "047V0DZ", "047V0EZ", "047V0FZ", "047V0GZ") | inlist(i10_pr`num', "047V0Z1", "047V0ZZ", "047V341", "047V34Z", "047V35Z") | inlist(i10_pr`num', "047V36Z", "047V37Z", "047V3D1", "047V3DZ", "047V3EZ") | inlist(i10_pr`num', "047V3FZ", "047V3GZ", "047V3Z1", "047V3ZZ", "047V441") | inlist(i10_pr`num', "047V44Z", "047V45Z", "047V46Z", "047V47Z", "047V4D1") | inlist(i10_pr`num', "047V4DZ", "047V4EZ", "047P4FZ", "047P4GZ", "047V4Z1") | inlist(i10_pr`num', "047V4ZZ", "047W041", "047W04Z", "047W05Z", "047W06Z") | inlist(i10_pr`num', "047W07Z", "047W0D1", "047W0DZ", "047W0EZ", "047W0FZ") | inlist(i10_pr`num', "047W0GZ", "047W0Z1", "047W0ZZ", "047W341", "047W34Z") | inlist(i10_pr`num', "047W35Z", "047W36Z", "047W37Z", "047W3D1", "047W3DZ") | inlist(i10_pr`num', "047W3EZ", "047W3FZ", "047W3GZ", "047W3Z1", "047W3ZZ") | inlist(i10_pr`num', "047W441", "047W44Z", "047W45Z", "047W46Z", "047W47Z") | inlist(i10_pr`num', "047W4D1", "047W4DZ", "047W4EZ", "047W4FZ", "047W4GZ") | inlist(i10_pr`num', "047W4Z1", "047W4ZZ") | inlist(i10_pr`num',  "047Y041", "047Y04Z") | inlist(i10_pr`num', "047Y0D1", "047Y0DZ") | inlist(i10_pr`num', "047Y0Z1", "047Y0ZZ", "047Y341", "047Y34Z") | inlist(i10_pr`num', "047Y3D1", "047Y3DZ") | inlist(i10_pr`num', "047Y3Z1", "047Y3ZZ") | inlist(i10_pr`num', "047Y441", "047Y44Z") | inlist(i10_pr`num', "047Y4D1", "047Y4DZ") | inlist(i10_pr`num', "047Y4Z1", "047Y4ZZ")
}

*Femoral Endarterectomy
gen fem = 0
foreach num of numlist 1/25 {
replace fem = 1 if inlist(i10_pr`num', "047K0ZZ", "04CLOZZ")
}

*Making overall amputation variable
foreach num of numlist 1/25 {
	gen ampu_`num' = 0
	replace ampu_`num' = 1 if inlist(i10_pr`num', "0Y620ZZ", "0Y630ZZ", "0Y640ZZ", "0Y670ZZ", "0Y680ZZ") | inlist(i10_pr`num', "0Y6C0Z1", "0Y6C0Z2", "0Y6C0Z3", "0Y6D0Z1", "0Y6D0Z2") | inlist(i10_pr`num', "Y6D0Z3", "0Y6F0ZZ", "0Y6G0ZZ", "0Y6H0Z1", "0Y6H0Z2") | inlist(i10_pr`num', "0Y6H0Z3", "0Y6J0Z1",  "0Y6J0Z2" , "0Y6J0Z3") | inlist(i10_pr`num', "0Y6M0Z0", "0Y6M0Z4" , "0Y6M0Z5", "0Y6M0Z6", "0Y6M0Z7", "0Y6M0Z8") | inlist(i10_pr`num', "0Y6M0Z9", "0Y6M0ZB" , "0Y6M0ZC", "0Y6M0ZD", "0Y6M0ZF", "0Y6N0Z0") | inlist(i10_pr`num', "0Y6N0Z4", "0Y6N0Z5" , "0Y6N0Z6", "0Y6N0Z7", "0Y6N0Z8", "0Y6N0Z9")  | inlist(i10_pr`num', "0Y6N0ZB", "0Y6N0ZC" , "0Y6N0ZD", "0Y6N0ZF")
}

foreach num of numlist 1/25 {
	replace ampu_`num'= 0 if prday`num' > 2
}

gen amputot = 0
foreach num of numlist 1/25 {
	replace amputot= 1 if ampu_`num'==1
}

   *Major/minor amputations
foreach num of numlist 1/25 {
	gen majamp_`num' = 0
	gen minamp_`num' = 0
	replace majamp_`num' = 1 if inlist(i10_pr`num', "0Y620ZZ", "0Y630ZZ", "0Y640ZZ", "0Y670ZZ", "0Y680ZZ") | inlist(i10_pr`num', "0Y6C0Z1", "0Y6C0Z2", "0Y6C0Z3", "0Y6D0Z1", "0Y6D0Z2") | inlist(i10_pr`num', "Y6D0Z3", "0Y6F0ZZ", "0Y6G0ZZ", "0Y6H0Z1", "0Y6H0Z2") | inlist(i10_pr`num', "0Y6H0Z3", "0Y6J0Z1",  "0Y6J0Z2" , "0Y6J0Z3")
	replace minamp_`num' = 1 if inlist(i10_pr`num', "0Y6M0Z0", "0Y6M0Z4" , "0Y6M0Z5", "0Y6M0Z6", "0Y6M0Z7", "0Y6M0Z8") | inlist(i10_pr`num', "0Y6M0Z9", "0Y6M0ZB" , "0Y6M0ZC", "0Y6M0ZD", "0Y6M0ZF", "0Y6N0Z0") | inlist(i10_pr`num', "0Y6N0Z4", "0Y6N0Z5" , "0Y6N0Z6", "0Y6N0Z7", "0Y6N0Z8", "0Y6N0Z9")  | inlist(i10_pr`num', "0Y6N0ZB", "0Y6N0ZC" , "0Y6N0ZD", "0Y6N0ZF")
}	
foreach num of numlist 1/25 {
	replace majamp_`num'= 0 if prday`num' > 2
	replace minamp_`num'= 0 if prday`num' > 2
}

gen majamptot = 0
gen minamptot = 0
foreach num of numlist 1/25 {
	replace majamptot= 1 if majamp_`num'==1
	replace minamptot= 1 if minamp_`num'==1
}
foreach var of varlist majamptot minamptot amputot bysup byinf endosup endoinf fem {
	svy: tab `var' allPAD,  count format(%20.10f) pearson
}
svy: prop majamptot minamptot bysup byinf endosup endoinf fem if allPAD==1
svy: prop majamptot minamptot bysup byinf endosup endoinf fem if allPAD==0

*Create categorical variables and run test
gen catamp=0
replace catamp=1 if minamptot==1
replace catamp=2 if majamptot==1
svy: tab catamp allPAD, count format (%20.10f) pearson

gen catproc=0
replace catproc=1 if bysup ==1
replace catproc=2 if endosup ==1
replace catproc=3 if endoinf ==1
replace catproc=4 if endosup ==1
replace catproc=5 if fem ==1
svy: tab catproc allPAD, count format (%20.10f) pearson

*Hosp LOS (mean + SD)
*extended LOS is days above median LOS
gen extLOS = 0 
summarize los, detail
replace extLOS = los-r(p50) if los >r(p50)

svy: mean extLOS if allPAD==1
svy: mean extLOS if allPAD==0
svy:regress extLOS allPAD

*Making Location of Hospital Discharges
replace dispuniform = 3 if dispuniform==.
replace dispuniform = 4 if dispuniform==20
replace dispuniform = 8 if dispuniform==21
replace dispuniform = 9 if dispuniform==99
label define dispuniform 1 "Routine" 2 "Transfer to short-term hospital" 3 "Missing" 4 "Died in hospital" 5 "Transfer other" 6 "HHC" 7 "AMA"  8"Discharged to court/law enforcement" 9 "Discharged alive, destination unknown (may have expired elsewhere)"
label value dispuniform dispuniform

foreach n of numlist 1/9 {
gen dispuniform`n' = 0
replace dispuniform`n' = 1 if dispuniform ==`n'
}

foreach var of varlist dispuniform1 dispuniform2 dispuniform3 dispuniform4 dispuniform5 dispuniform6 dispuniform7 dispuniform8 dispuniform9{
	svy: tab `var' allPAD,  count format(%20.10f) pearson
}
svy: prop dispuniform if allPAD==1
svy: prop dispuniform if allPAD==0
svy: tab dispuniform allPAD, count format(%20.10f) pearson

*Hospital Charges (mean + SD)
svy: mean totchg if allPAD==1 
svy: mean totchg if allPAD==0
svy:regress totchg allPAD

save "/Users/Stuthi/Documents/Stuthi/Year 2 Pitt MPH/Work-Related/CLI:Sepsis /All Sepsis.dta", replace

log close
