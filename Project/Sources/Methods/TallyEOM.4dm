//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/08/10, 14:28:59
// ----------------------------------------------------
// Method: TallyEOM
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_DATE:C307($begDate; $endDate)
C_LONGINT:C283($1)
C_TEXT:C284(vSJName; vCJName; vPJName)

//test for user privelege
$doChange:=UserInPassWordGroup("OnlyTally")
If (Not:C34($doChange))
	ALERT:C41("Access Denied")
	CANCEL:C270
Else   //valid user
	
	If (<>prcControl=1)
		<>prcControl:=0
		Process_InitLocal
		ptCurTable:=(->[Control:1])
	End if 
	jCenterWindow(420; 320; 1)
	//End if 
	DIALOG:C40([Control:1]; "EOM")
	CLOSE WINDOW:C154
	If (OK=1)
		//TRACE
		//QUERY([dCash];[dCash]DateEvent<(Current date-120))
		//If (Records in selection([dCash])>0)
		//DELETE SELECTION([dCash])
		//End if 
		$begDate:=vdDateBeg
		$endDate:=vdDateEnd
		//  ON EVENT CALL("jotcCmdQAction")
		
		// Tally_EventLogs (0)
		
		If (b1=1)
			vdDateBeg:=$begDate
			vdDateEnd:=$endDate
			TallyInventory
		End if 
		//  
		If (b2=1)
			vdDateBeg:=$begDate
			vdDateEnd:=$endDate
			TallyEOMInvento(vdDateBeg)
		End if 
		//
		If (b4=1)
			vdDateBeg:=$begDate
			vdDateEnd:=$endDate
			TallySalesHist($begDate; $endDate)
		End if 
		//
		If (b3=1)
			vdDateBeg:=$begDate
			vdDateEnd:=$endDate
			TallyDelete_dIn(vdDateBeg)
		End if 
		//
		If (b6=1)
			vdDateBeg:=$begDate
			vdDateEnd:=$endDate
			ALL RECORDS:C47([Customer:2])
			TallyPastDueLoo(True:C214)
		End if 
		//  
		If (b7=1)
			vdDateBeg:=$begDate
			vdDateEnd:=$endDate
			GL_JrnlSale(True:C214)
		End if 
		CLEAR VARIABLE:C89(sumDoc)
		//  
		If (b8=1)
			vdDateBeg:=$begDate
			vdDateEnd:=$endDate
			GL_JrnlCash(True:C214)
		End if 
		CLEAR VARIABLE:C89(sumDoc)
		//  
		If (b9=1)
			vdDateBeg:=$begDate
			vdDateEnd:=$endDate
			GL_JrnlPrch(True:C214)
		End if 
		CLEAR VARIABLE:C89(sumDoc)
		//  
		//  If (b10=1)
		//  End if 
		//  
		If (b11=1)
			vdDateBeg:=$begDate
			vdDateEnd:=$endDate
			TallyAdLoop  //(True)  add some time to update
		End if 
		//  
		UNLOAD RECORD:C212([Customer:2])
		UNLOAD RECORD:C212([Item:4])
		UNLOAD RECORD:C212([Order:3])
		UNLOAD RECORD:C212([Invoice:26])
		UNLOAD RECORD:C212([Ledger:30])
		UNLOAD RECORD:C212([PO:39])
		UNLOAD RECORD:C212([InventoryStack:29])
		UNLOAD RECORD:C212([Usage:5])
		UNLOAD RECORD:C212([UsageSummary:33])
		//
		// ON EVENT CALL("")
	End if 
	For ($i; 1; 11)
		$ptBut:=Get pointer:C304("b"+String:C10($i))
		$ptBut->:=0
	End for 
	v1:=""
	v2:=""
	v3:=""
	v4:=""
End if   //for PW_Test