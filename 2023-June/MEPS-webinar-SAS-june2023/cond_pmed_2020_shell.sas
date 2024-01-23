/* ----------------------------------------------------------------------------------------------------------------

MEPS-HC: Prescribed medicine utilization and expenditures for the treatment of hyperlipidemia

This example code shows how to link the MEPS-HC Medical Conditions file to the Prescribed Medicines file for data year 
2020 in order to estimate the following:

National totals:
   - Total number of people w/ at least one PMED fill for hyperlipidemia (HL)
   - Total PMED fills for HL
   - Total PMED expenditures for HL 

Per-person averages among people with at least one PMED fill for HL:
   - Avg PMED fills for HL, by sex and poverty (POVCAT20)
   - Avg PMED expenditures for HL, by sex and poverty (POVCAT20)

Input files:
  - h220a.sas7bdat        (2020 Prescribed Medicines file)
  - h222.sas7bdat         (2020 Conditions file)
  - h220if1.sas7bdat      (2020 CLNK: Condition-Event Link file)
  - h224.sas7bdat         (2020 Full-Year Consolidated file)

Resources:
  - CCSR codes: 
    https://github.com/HHS-AHRQ/MEPS/blob/master/Quick_Reference_Guides/meps_ccsr_conditions.csv

  - MEPS-HC Public Use Files: 
    https://meps.ahrq.gov/mepsweb/data_stats/download_data_files.jsp

  - MEPS-HC online data tools: 
    https://datatools.ahrq.gov/meps-hc

---------------------------------------------------------------------------------------------------------------- */


/**** Read in data files --------------------------------------------------------------------------------------- */ 

/* Set libname for where MEPS SAS data files are saved on your computer */




/* Read in PUFs and keep only needed variables */

/* PMED file (record = rx fill or refill for a person) */





/* Conditions file (record = medical condition for a person) */





/* Conditions-event link file (crosswalk between conditions and medical events, including PMEDs) */




/* Full-year consolidated (person-level) file (record = MEPS sample member) */





/**** Prepare data for estimation --------------------------------------------------------------------------------- */

/* Subset conditions file to only hyperlipidemia records (any CCSR = "END010") */





/* Example to show someone with 'duplicate' hyperlipidemia conditions with different CONDIDXs */ 
/* Example person: dupersid = '2320134102' */





/* Get EVNTIDX values for hyperlipidemia records from CLNK file */
/* Remember that our hl file still contains duplicates! */ 







/* Revisit duplicate example after merging to CLNK. */ 
/* Example person: dupersid = '2320134102' */





/* De-duplicate clnk_hl by EVNTIDX because we don't want to double-count the same PMEDs for our 'duplicate'
hyperlipidemia records */






/* Revisit duplicate example after de-duplicating */
/* Example person: dupersid = '2320134102' */





/* Look at our data to see different event types */






/* Sort pmed20 data to prepare for merge */





/* Get PMED events (and NOT other event types) linked to hyperlipidemia */
/* Our hl_merged data file is now at the PMED FILL level */ 






/* QC: Make sure all events have EVNTYPE = 8 (for PMED event) */ 





/* QC: Look at top PMEDs (by unweighted # fills) for hyperlipidemia to see if they make sense */





/* Create dummy variable for each unique fill (this will be summed within each person to get total fills per person) */





/* Roll up to person level by summing number of fills and pmed expenditures linked to hyperlipidemia within each person */





/* Merge person-level totals back to FYC and create flag for whether a person has any pmed fills for hyperlipidemia */





/* QC: compare adults *ever* diagnosed with hyperlipidemia (CHOLDX = 1) with people who have PMEDs for hyperlipidemia 
in 2020 (hl_pmed_flag = 1).  */





/* QC: check counts of hl_pmed_flag=1 and compare to the number of rows in drugs_by_pers (n=3912).  
Confirm there are no missing values */





/* QC: There should be no records where hl_pmed_flag=0 and (hl_drug_exp > 0 or n_hl_fills > 0) */





/*** ESTIMATION -------------------------------------------------------------------------------------------------- */ 

/* Optional - suppress graphics */




/**** National Totals */

/* Estimates for the following national totals:
	- sum of hl_pmed_flag = 1 -> total people with any rx fills for HL
	- sum of n_hl_fills -> total number of rx fills for HL
	- sum of hl_drug_exp -> total rx expenditures for HL */






/**** Per-person averages for people with at least one PMED fill for hyperlipidemia (hl_pmed_flag = 1), by sex
and by poverty */ 

/* Estimates for:
	- mean of n_hl_fills = avg number of fills for HL per person with any rx fills for HL
	- mean of hl_drug_exp = avg expenditures per person on rx drugs for HL among people with rx fills for HL */

