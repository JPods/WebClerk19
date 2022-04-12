//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1)  //Error Number
C_TEXT:C284($2)  //Error String
ELog_NewRecMsg($1; "TIOI Error"; $2)
iTIOProgCtr:=-3  //terminate Run; -3 so that after the immeadiate increment it will be -2