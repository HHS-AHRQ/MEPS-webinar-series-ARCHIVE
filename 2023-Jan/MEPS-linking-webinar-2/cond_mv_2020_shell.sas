/*****************************************************************************
Example code linking MEPS-HC Medical Conditions file to the Office-based
 medical visits file, data year 2020:

Event-level estimates:
  - Number of office-based visits for mental health
  - Total expenditures for office-based mental health treatment
  - Mean expenditure per office-based mental health visit

Person-level estimates 
  - Number of people with office-based mental health visits
  - Percent of people with office-based mental health visits
  - Mean expenditure per person for office-based mental health visits
  

Input files:
  - h220g.sas7bdat   (2020 Office-based event file)
  - h222.sas7bdat    (2020 Conditions file)
  - h220if1.sas7bdat (2020 CLNK: Condition-event link file)
  - h224.sas7bdat    (2020 Full-Year Consolidated file)
 
Resources:
 - CCSR codes: 
	 	https://github.com/HHS-AHRQ/MEPS/blob/master/Quick_Reference_Guides/meps_ccsr_conditions.csv

 - MEPS-HC Public Use Files: 
		https://meps.ahrq.gov/mepsweb/data_stats/download_data_files.jsp

 - MEPS-HC data tools: 
		https://datatools.ahrq.gov/meps-hc

/*****************************************************************************/

ods graphics off;


/* Load datasets *************************************************************/
/*  First, download .sas7bdat data sets from MEPS website:                   */
/*   -> https://meps.ahrq.gov > Data Files                                   */




/* Preview files */
title "Office-based visits"; 
title "Conditions";  
title "Condition-event link"; 

/* Keep only needed variables ************************************************/
/*  Browse variables using MEPS-HC data tools variable explorer: 
/*   -> http://datatools.ahrq.gov/meps-hc#varExp                  */ 






/* Filter COND file to only people with Mental Disorders ********************/
/*  >> GitHub: https://github.com/HHS-AHRQ/MEPS 
/* 		> Quick_Reference_Guides 
/* 		> meps_ccsr_conditions.csv                                          */


title "Mental health conditions";




/* Filter CLNK file to only office-based visits ****************************/
/*  >> Data Tools: https://datatools.ahrq.gov/meps-hc#varExp 
/*
/*  >> EVENTYPE:
 	  1 = "Office-based"
 	  2 = "Outpatient" 
 	  3 = "Emergency room"
 	  4 = "Inpatient stay"
 	  7 = "Home health"
 	  8 = "Prescribed medicine"                                            */


title "CLNK Office-based visits only";


/* Merge datasets **********************************************************/

/* Merge conditions file with the conditions-event link file (CLNK) */




title "Example of one condition treated in different events";
proc print data = mh_clnk;
	where CONDIDX = "2320109103009";
run;


title "Example of one event treating multiple Mental Health conditions";
proc print data = mh_clnk;
	where EVNTIDX = "2320051101205101";
run;


/* De-duplicate by event ID ('EVNTIDX'), since someone can have multiple visits 
/* for Mental Health. We don't want to count the same event twice */




/* Merge on event files *****************************************************/



/* QC */
title "ob_mental_health";



/* DO NOT RUN */
/* Survey estimates? Not quite! Need to merge with FYC file first,
/* to get complete Strata (VARSTR) and PSUs (VARPSU) for entire MEPS sample */

/* THIS CODE IS INCLUDED AS AN EXAMPLE OF WHAT NOT TO DO
/* THIS WILL GIVE WRONG SEs:

title "SEs are WRONG!";
proc surveymeans data = ob_mental_health mean sum;
	stratum VARSTR;
	cluster VARPSU;
	weight PERWT20F;
	var mh_ob_visit OBXP20X;
run;

/* END DO NOT RUN */



/* Merge on FYC file for complete Strata, PSUs *****************************/




/* QC */
title "ob_mh_fyc";




/* Reset missing indicators to 0 */





/* Event-level estimates *********************************************************************/
/*  - Number of office-based visits for mental health:       343,810,085 (SE: 22,252,863)
/*  - Total exp. for office-based mental health visits:  $60,209,392,314 (SE: 4,437,433,004)
/*  - Mean exp. per visit:                                       $175.12 (SE: 6.46)          */


title "SEs are STILL WRONG for total exp!";
title2 "What is SAS doing?!?  Hint: Check the Log";




title "Event-level estimates";
title2 "EUREKA!";




/* A note on Telehealth *******************************************************/
/*  - telehealth questions were added to the survey in Fall of 2020           */
/*  - TELEHEALTHFLAG = -15 for events reported before telehealth questions    */
/*  - Recommendation: imputation or sensitivity analysis                      */


ods html close; ods html;
title "Telehealth flag by Month";
title2 "All office-based visits";




/* Person-level estimates ****************************************************
/*  - Number of people with office visit for MH:  29,816,984 (SE: 1,192,676)
/*  - Percent of people with office visit for MH:      9.08% (SE: 0.29%)
/*  - Mean exp per person for office visits for MH: $2019.30 (SE: 126.16) 
/* 
/*  - Number of visits (QC)       343,810,085 (SE: 22,252,863)
/*  - Total exp. (QC)         $60,209,392,314 (SE: 4,437,433,004)
*/


/* Aggregate to person-level */





/* QC: ***********************************************/

	/* - same number of records as fyc file              */
	title "pers_mh vs. fyc";
	

	/*  - mh_pers and mh_ob_visit_pers = 1  OR           */
	/*  - mh_pers and mh_ob_visit_pers = 0               */
	title "pers_mh QC";
	

	/*  - pers_nevents = 0 when mh or mh_ob_visit = 0    */
	title "pers_mh QC";
	


	/* view person with several events */
	

	/* view person with 0 events */
	


/* Run person-level estimates */

title "Person-level estimates";


