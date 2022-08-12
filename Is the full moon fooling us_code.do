/*CODE FOR 

Is the full moon fooling us?
Moritz Oberndorfer, Lin Yang, Thomas Waldhoer 11/08/2022

*/
cd "D:\PhD Owncloud\Austrian births lunar cycle\letter WiKliWo\data"
use birth_dta.dta, clear

************ BIRTHS FOREST PLOT********************

*forest plot for waxing crescent for every subgroups

forvalues i=1(1)8 {

poisson count i.wx_cres c.gebdat##c.gebdat##c.gebdat i.weekday i.cal_week i.month if subgroup == `i' , irr

estimates store reg`i'
}

graph set window fontface "Times New Roman"
coefplot ///
(reg1, label(All births (1984 to 2020)) msymbol(O)) ///
(reg3, label(Births ≥37 weeks gestation (1984 to 2020)) msymbol(Oh)) ///
(reg2, label(All spontaneous births (1995 to 2020)) msymbol(D)) ///
(reg4, label(Spontaneous births ≥37 weeks gestation (1995 to 2020)) msymbol(Dh)) ///
(reg5, label(All births in Vienna (1984 to 2020)) msymbol(o)) ///
(reg6, label(Births in Vienna ≥37 weeks gestation (1984 to 2020)) msymbol(oh)) ///
(reg8, label(All spontaneous births in Vienna (1995 to 2020)) msymbol(d)) ///
(reg7, label(Spontaneous births in Vienna ≥37 weeks gestation (1995 to 2020)) msymbol(dh)) ///
,keep(1.wx_cres) eform ///
xlabel(0.985(0.005)1.01 ,angle(horizontal)) ///
xtitle("Incidence rate ratio of daily births (hypothesised lunar phases to other phases)", size(small)) ///
ylabel("") ///
ytitle("Vienna               Austria") ///
xline(1, lcolor(red) lwidth(thin)) ///
yline(1, lcolor(gs10) lwidth(thin) lpattern(dash)) ///
ylabel( , labsize(small)) ///
title("a) Lunar phase: waxing crescent", color(black) size(medium) span) ///
legend(size(vsmall) colfirst col(1) row(8) region(lwidth(none))) ///
graphregion(color(white)) grid(none) ///
name(wx_cres,replace)


forvalues i=1(1)8 {

poisson count i.first_qt c.gebdat##c.gebdat##c.gebdat i.weekday i.cal_week i.month if subgroup == `i' , irr

estimates store reg`i'
}

graph set window fontface "Times New Roman"
coefplot ///
(reg1, label(All) msymbol(O)) ///
(reg3, label(All >37 weeks gestation) msymbol(Oh)) ///
(reg2, label(All spontaneous) msymbol(D)) ///
(reg4, label(Spontaneous>37 weeks gestation) msymbol(Dh)) ///
(reg5, label(All Vienna) msymbol(o)) ///
(reg6, label(All Vienna>37 weeks gestation) msymbol(oh)) ///
(reg8, label(All spontaneous Vienna) msymbol(d)) ///
(reg7, label(Spontaneous>37 weeks gestation Vienna) msymbol(dh)) ///
,keep(1.first_qt) eform ///
xlabel(0.985(0.005)1.01, angle(horizontal)) ///
xtitle("Incidence rate ratio of daily births (first quarter to other phases)", size(small)) ///
ylabel("") ///
ytitle("Vienna               Austria") ///
xline(1, lcolor(red) lwidth(thin)) ///
yline(1, lcolor(gs10) lwidth(thin) lpattern(dash)) ///
ylabel( , labsize(small)) ///
title("b) Lunar phase: first quarter", color(black) size(medium) span) ///
legend(size(small) col(4) row(2) region(lwidth(none))) ///
graphregion(color(white)) grid(none) ///
name(first_qt,replace)


forvalues i=1(1)8 {

poisson count i.wxcres_firstqt c.gebdat##c.gebdat##c.gebdat i.weekday i.cal_week i.month if subgroup == `i', irr

estimates store reg`i'
}

graph set window fontface "Times New Roman"
coefplot ///
(reg1, label(All) msymbol(O)) ///
(reg3, label(All >37 weeks gestation) msymbol(Oh)) ///
(reg2, label(All spontaneous) msymbol(D)) ///
(reg4, label(Spontaneous>37 weeks gestation) msymbol(Dh)) ///
(reg5, label(All Vienna) msymbol(o)) ///
(reg6, label(All Vienna>37 weeks gestation) msymbol(oh)) ///
(reg8, label(All spontaneous Vienna) msymbol(d)) ///
(reg7, label(Spontaneous>37 weeks gestation Vienna) msymbol(dh)) ///
,keep(1.wxcres_firstqt) eform ///
xlabel(0.985(0.005)1.01, angle(horizontal)) ///
xtitle("Incidence rate ratio of daily births (waxing crescent & first quarter to other phases)", size(small)) ///
ylabel("") ///
ytitle("Vienna               Austria") ///
xline(1, lcolor(red) lwidth(thin)) ///
yline(1, lcolor(gs10) lwidth(thin) lpattern(dash)) ///
ylabel( , labsize(small)) ///
title("c) Lunar phase: waxing crescent & first quarter", color(black) size(medium) span) ///
legend(size(small) col(4) row(2) region(lwidth(none))) ///
graphregion(color(white)) grid(none) ///
name(wxcres_firstqt,replace)


grc1leg2 wx_cres first_qt wxcres_firstqt, legendfrom(wx_cres) ///
position(5) ring(0) lyoffset(6) lxoffset(3) ///
 ytsize(small) ///
xtob1title xtsize(small) ///
title("{bf:Estimated incidence rate ratio of daily number of births}" "{bf:during waxing crescent and/or first quarter compared to other phases}" ///
, color(black) size(medsmall)) ///
note("IRR estimated by poisson regression including month dummies, calendar week dummies, weekday dummies, and cubic time trend", size(vsmall)) /// 
graphregion(color(white))

cd "D:\PhD Owncloud\Austrian births lunar cycle\letter WiKliWo\graphs"
graph export births_pois_tif.tif, width(2000) height(1600) replace
graph export births_pois.pdf, replace

****************** FOURIER ANALYSIS ************************

gen s1=sin((2*c(pi)*gebdat)/29.529)
gen c1=cos((2*c(pi)*gebdat)/29.529)

*same model specifcation as TW 2001
bysort subgroup: poisson count s1 c1 c.gebdat##c.gebdat##c.gebdat i.weekday, irr



******************** CONCEPTIONS*************************
cd "D:\PhD Owncloud\Austrian births lunar cycle\letter WiKliWo\data"
use conception_dta.dta, clear

************************* FOREST PLOT ****************
forvalues i=1(1)8 {

poisson count i.full c.konzeptdat##c.konzeptdat##c.konzeptdat i.weekday i.cal_week i.month if subgroup == `i',irr

estimates store reg`i'
}

graph set window fontface "Times New Roman"
coefplot ///
(reg1, label(All conceptions) msymbol(O)) ///
(reg3, label(Conceptions ≥37 weeks gestation) msymbol(Oh)) ///
(reg2, label(All conceptions (spontaneous deliveries)) msymbol(D)) ///
(reg4, label(Conceptions ≥37 weeks gestation (spontaneous deliveries)) msymbol(Dh)) ///
(reg5, label(All conceptions in Vienna) msymbol(o)) ///
(reg6, label(Conceptions in Vienna ≥37 weeks gestation) msymbol(oh)) ///
(reg8, label(All conceptions in Vienna (spontaneous deliveries)) msymbol(d)) ///
(reg7, label(Conceptions in Vienna ≥37 weeks gestation (spontaneous deliveries)) msymbol(dh)) ///
,keep(1.full) eform ///
xlabel(, angle(horizontal)) ///
xtitle("Estimated incidence rate ratio of daily number of conceptions", size(small)) ///
ylabel("") ///
ytitle("Vienna               Austria") ///
xline(1, lcolor(red) lwidth(thin)) ///
yline(1, lcolor(gs10) lwidth(thin) lpattern(dash)) ///
ylabel( , labsize(small)) ///
title("{bf:Estimated incidence rate ratio of daily number of births}" "{bf:comparing full moon compared to other phases} (1/7/2014 to 1/3/2020)" ///
, color(black) size(medsmall)) ///
legend(size(vsmall) colfirst col(2) row(4) region(lwidth(none))) ///
graphregion(color(white)) grid(none) ///
note("IRR estimated by poisson regression including month dummies, calendar week dummies, weekday dummies, and cubic time trend", size(vsmall)) /// 
name(full_moon,replace)

cd "D:\PhD Owncloud\Austrian births lunar cycle\letter WiKliWo\graphs"
graph export conceptions_pois_tif.tif, width(2000) height(1600) replace
graph export conceptions_pois.pdf, replace

********** FOURIER ******************

gen s1=sin((2*c(pi)*konzeptdat)/29.529)
gen c1=cos((2*c(pi)*konzeptdat)/29.529)
*same model specifcation as TW 2001
bysort subgroup: poisson count s1 c1 c.konzeptdat##c.konzeptdat##c.konzeptdat i.weekday, irr


*last line