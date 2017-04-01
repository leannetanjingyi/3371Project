
set more off  
insheet using "C:\Users\Leanne\Desktop\EC3371\WDI_Data.csv", clear 

forval j = 1/61 { 
     local try = strtoname(v`j'[1]) 
     capture rename v`j'  `try' 
}

*ignore the error, just continue

keep if !missing(v58)

keep Country_Name Country_Code Indicator_Name Indicator_Code v58 
drop in 1
drop Country_Name Indicator_Name
gen indc = subinstr(Indicator_Code, ".", "",.) 

rename v58 v
sort Country_Code Indicator_Code
drop Indicator_Code

reshape wide v, i(Country_Code) j(indc) string

foreach var of varlist v* {
   	local newname = substr("`var'", 2, .)
   	rename `var' `newname'
}

gen logGDP2013 = log(NYGDPPCAPKD)
graph twoway (lfit  logGDP2013 ENATMPM25MCM3) (scatter logGDP2013 ENATMPM25MCM3)

