//%attributes = {"publishedWeb":true}
//SEARCH([TallyMaster];[TallyMaster]DTNextStart<DateTime_Enter)
//$k:=Records in selection([TallyMaster])
//C_LONGINT($k;$i)
//FIRST RECORD([TallyMaster])
//For ($i;1;$k)
//LOAD RECORD([TallyMaster])
//If (Not(Locked([TallyMaster])))
//
//End if 
//NEXT RECORD([TallyMaster])
//End for 


//CONFIRM("Tally weekly and monthly management reports.")
//jDateTimeUserCl //vdStDate vdEndDate
//SEARCH([TallyResult];[TallyResult]DTReport>=)
//SEARCH([TallyResult];&[TallyResult]DTReport>=)