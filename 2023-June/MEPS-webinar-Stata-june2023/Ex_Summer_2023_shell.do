* MEPS-HC: Prescribed medicine utilization and expenditures for 
* the treatment of hyperlipidemia
* 
* This example code shows how to link the MEPS-HC Medical Conditions file, 
* the Prescribed Medicines file, and the Full-Year Consolidated file for 
* data year 2020 in order to estimate the following:
*
*   - Total number of people with one or more rx fills for hyperlipidemia
*   - Total rx fills for the treatment of hyperlipidemia
*   - Total rx expenditures for the treatment of hyperlipidemia 
*   - Mean number of Rx fills for hyperlipidemia per person, among those with any, by sex and household income
*   - Mean expenditures on Rx fills for hyperlipidemia per person, among those with any, by sex and household income
* 
* Input files:
*   - h220a.dta        (2020 Prescribed Medicines file)
*   - h222.dta         (2020 Conditions file)
*   - h220if1.dta      (2020 CLNK: Condition-Event Link file)
*   - h224.dta         (2020 Full-Year Consolidated file)
* 
* Resources:
*   - CCSR codes: 
*   https://github.com/HHS-AHRQ/MEPS/blob/master/Quick_Reference_Guides/meps_ccsr_conditions.csv
* 
*   - MEPS-HC Public Use Files: 
*   https://meps.ahrq.gov/mepsweb/data_stats/download_data_files.jsp
* 
*   - MEPS-HC online data tools: 
*   https://datatools.ahrq.gov/meps-hc
*
* -----------------------------------------------------------------------------

clear
set more off
capture log close
cd C:\MEPS
log using Ex_Summer_2023.log, replace 

/* Get data from web (you can also download manually) */
copy "https://meps.ahrq.gov/mepsweb/data_files/pufs/h220a/h220adta.zip" "h220adta.zip", replace
unzipfile "h220adta.zip", replace 
copy "https://meps.ahrq.gov/mepsweb/data_files/pufs/h222/h222dta.zip" "h222dta.zip", replace
unzipfile "h222dta.zip", replace 
copy "https://meps.ahrq.gov/mepsweb/data_files/pufs/h220i/h220if1dta.zip" "h220if1dta.zip", replace
unzipfile "h220if1dta.zip", replace 
copy "https://meps.ahrq.gov/mepsweb/data_files/pufs/h224/h224dta.zip" "h224dta.zip", replace
unzipfile "h224dta.zip", replace 

/* linkage file */

// inspect file, save



/* FY condolidated file, person-level */

// create 0/1 variable identifying people ever diagnosed with HL */

// inspect file, save 



/* PMED file, Rx fill-level */

// inspect file, save




/* Conditions file, condition-level, subset to hyperlipidemia */

// keep only records for HL

// inspect file, save 



/* merge conditions to CLNK file by condidx, drop unmatched */

// drop observations that do not match

// inspect file

// drop duplicate fills--- fills that would otherwise be counted twice */

// inspect file after de-duplication



/* merge to prescribed meds file by evntidx, drop unmatched */

// drop observations for that do not match

// inspect file




/* collapse to person-level (DUPERSID), sum to get number of fills and expenditures */


/* merge to FY file, create flag for any Rx fill for HL */


/* Set survey options */


/* Compare people ever diagnosed with hyperlipidemia (CHOLDX == 1) with those that have treated hyperlipidemia */


/* total number of people with 1+ Rx fills for HL */


/* Total rx fills for the treatment of hyperlipidemia */


/* Total rx expenditures for the treatment of hyperlipidemia */


/* Percent with any Rx fills for hyperlipidemia, by sex and race */


/* Mean number of Rx fills for hyperlipidemia per person, among those with any, by race and sex */


/* mean expenditures on Rx fills for hyperlipidemia per person, among those with any by sex and race */


