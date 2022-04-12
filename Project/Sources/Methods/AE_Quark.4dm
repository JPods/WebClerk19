//%attributes = {"publishedWeb":true}
//Procedure: AE_Quark
If (False:C215)
	//02/10/03.prf
	//removed plugin S7P
	//  TCStrong_prf_v144
	TCStrong_prf_v144_S7P
End if 

//C_TEXT($1;$2;$3)
//C_Longint($4)
//C_Longint($i;$k;$error)
//TRACE
//QUERY([TallyResult];[TallyResult]TableNum=$4;*)
//QUERY([TallyResult];&[TallyResult]Name=$1+"@";*)
//QUERY([TallyResult];&[TallyResult]Purpose="Quark")
//$k:=Records in selection([TallyResult])
//FIRST RECORD([TallyResult])
//For ($i;1;$k)
//ExecuteText (->[TallyResult]TextBlk2)
//CLEAR VARIABLE(<>vtSearch)
//If (Not(($error=0)|($error=1)))
//ALERT("Invalid procedure.")
//End if 
//NEXT RECORD([TallyResult])
//End for 

//$error:=0
//vText1:=""
//C_TEXT($theScript)
//QUERY([TallyResult];[TallyResult]TableNum=$4;*)
//QUERY([TallyResult];&[TallyResult]Name=$2;*)
//QUERY([TallyResult];&[TallyResult]Purpose="Quark")
//If (Records in selection([TallyResult])=1)
//$error:=FindAppName ("XPR3";vText1)
//If (IsRunning ("XPR3")=0)
//$error:=Launch ("XPR3";"")
//End if 
//If ($error=0)
//$error:=MakeAddress ("XPR3";vi1)
//If ($error=0)
//$theScript:="tell application "+Char(34)+vText1+Char(34)+"\r"
//$theScript:=$theScript+"	activate"+"\r"
//$theScript:=$theScript+"	set thepath to "+Char(34)+Storage.folder.jitExportsF+Char(34)+"\r"
//$theScript:=$theScript+"	set theFile to "
//+Char(34)+$3+Char(34)+"\r"+[TallyResult]TextBlk1
//$error:=DoScript (vi1;$theScript)
//$error:=AppToFront ("XPR3")
//End if 
//End if 
//End if 
//TRACE
//If ($error#0)
//ALERT("Error "+String($error))
//End if 