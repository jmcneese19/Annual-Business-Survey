/* Stata 15.1 Run Do File
*command "version" to check 

Project Goal: 
The goal of this project is to run an oxaca analysis that assess the 
experiential differences in business ownership between black and white 
business owners. Business ownership contines to be the focus of those who intend 
to close the wealth gap. And in these uncertain times, we have seen a growth 
in spcial media support for minorty ownened businesses ath the same time that 
both black and white bsuiness owners experience hard ship during the pandmic. 
Moreover, there have been differential access to recourses and treatment of 
business owners by race. My project hopes to shed a light on the differential 
experinces of bsuienss owners who are alike, by looking at the way value is 
captured amoung these groups in an attempt to help clarify the path to the 
close of the wealth gap. 


Data Overview:
The Annual Business Survey (ABS) provides information on selected economic and 
demographic characteristics for businesses and business owners by sex, 
ethnicity, race, and veteran status.The ABS is conducted jointly by the 
U.S. Census Bureau and the National Center for Science and Engineering 
Statistics within the National Science Foundation.Included are all nonfarm 
employer businesses filing the 941, 944, or 1120 tax forms. The ABS is conducted 
on a company or firm basis rather than an establishment basis. A company or firm 
is a business consisting of one or more domestic establishments that the 
reporting firm specified under its ownership or control. The data is collected 
in 2017 and overship is considered to be those hwo have more than a 50% stake.These
Busnesses are geographically comfined to the Unted States.  

Variables of Interest:
#Dependent variable 
In the beginning I was focuses don profit but after resenting my research in 
different venues there was a concern about the ways in which the profit of 
businesses can be a bias and/or  skewed variable to use. Profit  would include 
both indirect and direct costs of production where as revenue is a income coming 
from direct production or sales. 
#IV- race code 
This data set includes more than just black and white categories so I created a
nonblack category as well as an additional variable of analysis However, this 
variables assess the differences between black and white owned businesses as 
race is the race of the business owner. 
#Control - acquisition
This data set also provides information on how the business was provided, 
including whether it was inherited or there were support from a government 
program etc. These data are helpful in limiting bias in disturbance term by 
accounting for the fact that each busines owner might have obtained their 
businesses in different ways which could speak to why the business is successful. 
#Control - Pay roll 
Each business might vary in size an dthere for may have a smaller or larger 
pay roll. To level th eplayign field my study accounts for the payroll 
differences between those of black and white businessowners. 
#Control - number of employees 
Each business within this data set has a different number of employees 
because women businesses have more than one location. This variable allows 
me to control for the size of the businesses so that I can isolate the race 
variable further. 
#Control - Sex 
This data set also accounts for the sex of the businesswomen. 
Whether they are male, female or both. 
#Control - business type
Thus data set has an array of codes for business type. 72 is the code for 
accommodation and food service businesses which fits the criteria for my 
initial study which was to focuses on restaurants. 
#Control - Geography 
This data set is at the national level. Originally I wanted to focus on 
business corridors however the data was to expense to get commercial data at 
the block group level. The census data was less expensive and contained all of 
the necessary variables I needed in order to complete my study. 
*/
/////////////////////////////////////////Getting Set Up In Stata
set more off
* make stata run everything

clear   
* good to start with a clean slate      

set matsize 800 
* sets your maximum matrix size at 800 instead of 400(the default)

cap log close
*closes the log if it was open 

set logtype text
*log your stats session in text

cd C:\Users\Jazmyne\Desktop\Stata\DISS
* take me to my folder for saving future files

//save "C:\Users\Jazmyne\Desktop\Stata\DISS\workingsampledofile.do", replace
*save stata file and do file

preserve 
*saves my data where it is so if I mess up I can come back (restore puts it back)	

//ssc install ?????, replace
*If I had programs that needed to be installed	

///////////////////////////////////////Pull and Clean (Part1)
use "https://github.com/jmcneese19/DISS/blob/main/abspart1.dta?raw=true", clear
*Part 1 Sample Upload from git hub
//import delimited C:\Users\Jazmyne\Desktop\Stata\DISS\ABSpart1.csv, varnames(1) rowrange(3)

des
sum
gen case_id = _n

encode naics2017_label, gen(nacislN) 
encode sex_label, gen(sexlN)
encode eth_group_label, gen(ethglN)
encode race_group_label, gen(racglN)
encode vet_group_label, gen(vetglN)
encode rcppdemp, gen(revbythoN)
encode emp, gen(numempN)
encode payann, gen(annpaybythoN)
encode firmpdemp, gen(empfirmN)

drop geo_id
drop geo_id_f
drop name
drop naics2017
drop subsector
drop sector
drop indlevel
drop naics2017_f
drop indgroup
drop sex
drop eth_group
drop race_group
drop vet_group
drop year
drop firmpdemp_s
drop rcppdemp_s
drop emp_s 
drop payann_s
drop naics2017_label
drop sex_label
drop eth_group_label
drop race_group_label
drop vet_group_label
drop rcppdemp
drop emp
drop payann
drop firmpdemp

des
sum
save abspart1clean.dta, replace
clear

//////////////////////////////////////////Pull and Clean (Part2)
//use "https://github.com/jmcneese19/DISS/blob/main/abspart2clean.dta?raw=true", clear
*Part 2 Sample Upload from git hub
import delimited C:\Users\Jazmyne\Desktop\Stata\DISS\ABSpart2.csv, varnames(1) rowrange(3)
 
des
sum
 
encode owner_sex_label, gen(ownsexlN) 
encode owner_eth_label, gen(ownethlN) 
encode owner_race_label, gen(ownraclN) 
encode owner_vet_label, gen(ownvetlN)
encode qdesc_label, gen(qdesclN) 
encode ownchar_label, gen(owncharlN)
encode ownpdemp_pct, gen(ownemppctN)
encode ownpdemp, gen(ownempN)

drop geo_id 
drop geo_id_f 
drop naics2017_f 
drop year  
drop name 
drop naics2017 
drop naics2017_label 
drop indgroup 
drop subsector 
drop sector 
drop indlevel 
drop owner_sex 
drop owner_eth 
drop owner_race 
drop owner_vet 
drop qdesc 
drop ownchar 
drop owner_sex_label 
drop owner_eth_label 
drop owner_race_label 
drop owner_vet_label 
drop qdesc_label 
drop ownchar_label
drop ownpdemp_pct
drop ownpdemp_s 
drop ownpdemp_pct_s 
drop ownpdemp 

des
sum
save abspart2clean.dta, replace
clear
 
///////////////////////////////////////////Merge Part 1 & Part 2
use abspart1clean.dta
append using abspart2clean.dta

save abs12clean.dta, replace
clear

////////////////////////////////////////// Descriptive program
//use "https://github.com/jmcneese19/DISS/blob/main/abs12clean.dta?raw=true", clear
use "abs12clean.dta"
*mereges sample upload

des

codebook 

tab racglN sexlN 
* black = 40 White= 30 
*1= total 2=feamle 3=male 4 equally male female 


*revbythoN = revenue by the thousands 
*sex = 1 total 2 female 3 male 4 Equally male female 96 classifiable 98 unclassifiable 
*sectorcode = 72 Accommodation and food services  53 realestate   0 all 

////////////////////////////////////END//////////////////////////////////////////






/*

//////////////////////////////////////// General Descritives program to pull from 
des [var-name]
* descirptive stats 

sum [var-name]
*summary stats

scatter [var-name] [var-name]
*scatter plot

hist [var-name]
*histogram

sum [var-name], detail 
*detailed summary 

histogram [var-name], freq
*histogram based on frequency

//Note that Stata output will appear jumbled unless you use a fixed width font, 
such as Courier New. A font size of 9 will keep the lines from breaking.

// run summary stats detailed and non 
sum 
sum pe, detail 

// run histrogram 
histogram per, freq

// 4. Run simple bivariate regression on (dont forget to change varible)
reg juvenile_1 four_day 

// 5. Run same regression, but add district and year FEs  (dont forget to change variable)
areg j fo i.year, absorb(id) vce(cluster id) 

 // 6. unique ->the command you use to identify what the unique values are in your data and the otal amount of bervations 
example:
Unique codist
Number of unique values of codist is  538
Number of records is  4184

//7. Duplicats lst- This command tells you what values in your data are duplicates 
. duplicates list codist year

Duplicates in terms of codist year

(0 observations are duplicates)

//8. this command tells you to look for a certain dirtitc id in this case (codist)
.  browse if codist == "10I027"

//9. This command tells you to look for a certain ditriyc id and the years it associates with 
. . browse if codist == "10I027" & year==20


*/ 
