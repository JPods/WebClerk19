//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/13/07, 07:57:15
// ----------------------------------------------------
// Method: PrntScripted
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_BOOLEAN:C305($doReset)
C_TEXT:C284($1; $reportName)
If (Count parameters:C259=1)
	C_POINTER:C301($ptTempTable)
	C_LONGINT:C283($vHereTemp)
	$reportName:=$1
	QUERY:C277([UserReport:46]; [UserReport:46]name:2=$reportName)
	If (Records in selection:C76([UserReport:46])#1)
		If (allowAlerts_boo)
			ALERT:C41("No unique UserReport record.")
		End if 
	Else 
		If ((vHere=0) | (ptCurTable=(->[Control:1])))
			$doReset:=True:C214
			$ptTempTable:=ptCurTable
			$vHereTemp:=vHere
			ptCurTable:=Table:C252([UserReport:46]tableNum:3)
			vHere:=1
		End if 
		
		$doReport:=P_vHereBegin  // (->rptRecNum;->doCurFile)
		
		If ($doReport)
			If (URpt_CheckAuthL)
				//If (vHere=0)
				If (([UserReport:46]tableNum:3>0) & ([UserReport:46]creator:6#"EDIx") & ([UserReport:46]scriptBegin:5#""))  //([UserReport]SeachEditor)&
					If (vHere=0)
						jsetDefaultFile(Table:C252([UserReport:46]tableNum:3))  //      ptCurFile:=File([UserReport]ReportonFile)
					End if 
					ExecuteText(0; [UserReport:46]scriptBegin:5)
				End if 
				//End if 
				Prnt_ReportOpts
			End if 
		End if 
		UNLOAD RECORD:C212([UserReport:46])
		READ WRITE:C146([UserReport:46])
		P_vHereEnd(rptRecNum; doCurFile)
		
		If ($doReset)
			ptCurTable:=$ptTempTable
			vHere:=$vHereTemp
		End if 
	End if 
Else 
	If (allowAlerts_boo)
		ALERT:C41("No report named.")
	End if 
End if 