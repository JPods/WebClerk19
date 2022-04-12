//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/08/10, 13:42:23
// ----------------------------------------------------
// Method: Project_Select
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($processNum)

$processNum:=Frontmost process:C327(*)
If ($processNum>=Size of array:C274(<>aPrsName))
	
End if 

Case of 
		//What is this for???????
		//: (<>aPrsName{$processNum}="Q &A")
		//CONFIRM("Clone Questions through selection.")
	: (ptCurTable=(->[Order:3]))
		//save the current record    
		C_LONGINT:C283($fillerCnt; $i)
		$fillerCnt:=Records in selection:C76([Customer:2])-1
		CONFIRM:C162("Clone this order for the current selection of "+String:C10($fillerCnt; "###,###")+" customers.")
		If (OK=1)
			CREATE EMPTY SET:C140([Order:3]; "<>curSelSet")
			CREATE SET:C116([Customer:2]; "Current")
			ONE RECORD SELECT:C189([Customer:2])
			CREATE SET:C116([Customer:2]; "ThisOne")
			DIFFERENCE:C122("Current"; "ThisOne"; "ThisOne")
			USE SET:C118("ThisOne")
			CLEAR SET:C117("ThisOne")
			TRACE:C157
			FIRST RECORD:C50([Customer:2])
			For ($i; 1; $fillerCnt)
				If (Is new record:C668([Order:3]))
					SAVE RECORD:C53([Order:3])
					ADD TO SET:C119([Order:3]; "<>curSelSet")
					[Order:3]customerID:1:=[Order:3]customerID:1  //force a change to make it fully calculate.
				End if 
				CloneRecord
				LoadCustOrder
				NEXT RECORD:C51([Customer:2])
			End for 
			booSorted:=False:C215
			myCycle:=6  //No Cancel trial
			jAcceptButton(False:C215; False:C215)
			ADD TO SET:C119([Order:3]; "<>curSelSet")
			USE SET:C118("Current")
			CLEAR SET:C117("current")
			jCancelButton(False:C215)
			<>ptCurTable:=(->[Order:3])
			<>prcControl:=1
			REDUCE SELECTION:C351([Order:3]; 0)
			DB_ShowCurrentSelection(<>ptCurTable; ""; 4; "")
			TRACE:C157
		End if 
	: (ptCurTable=(->[Invoice:26]))
		$fillerCnt:=Records in selection:C76([Customer:2])-1
		CONFIRM:C162("Clone this invoice for the current selection of "+String:C10($fillerCnt; "###,###")+" customers.")
		If (OK=1)
			CREATE EMPTY SET:C140([Invoice:26]; "<>curSelSet")
			CREATE SET:C116([Customer:2]; "Current")
			ONE RECORD SELECT:C189([Customer:2])
			CREATE SET:C116([Customer:2]; "ThisOne")
			DIFFERENCE:C122("Current"; "ThisOne"; "ThisOne")
			USE SET:C118("ThisOne")
			CLEAR SET:C117("ThisOne")
			FIRST RECORD:C50([Customer:2])
			For ($i; 1; $fillerCnt)
				If (Is new record:C668([Invoice:26]))
					SAVE RECORD:C53([Invoice:26])
					Ledger_InvSave
					ADD TO SET:C119([Invoice:26]; "<>curSelSet")
					[Invoice:26]customerID:3:=[Invoice:26]customerID:3  //force a change to make it fully calculate.
				End if 
				CloneRecord
				LoadCustomersInvoices
				NEXT RECORD:C51([Customer:2])
			End for 
			booSorted:=False:C215
			myCycle:=6  //No Cancel trial
			jAcceptButton(False:C215; False:C215)
			ADD TO SET:C119([Invoice:26]; "<>curSelSet")
			USE SET:C118("Current")
			CLEAR SET:C117("current")
			jCancelButton(False:C215)
			DB_ShowCurrentSelection(->[Invoice:26]; ""; 4; "")
			REDUCE SELECTION:C351([Invoice:26]; 0)
		End if 
	: (ptCurTable=(->[Service:6]))
		$fillerCnt:=Records in selection:C76([Customer:2])-1
		CONFIRM:C162("Clone this Service record for the current selection of "+String:C10($fillerCnt; "###,###")+" customers.")
		If (OK=1)
			CREATE EMPTY SET:C140([Service:6]; "<>curSelSet")
			CREATE SET:C116([Customer:2]; "Current")
			ONE RECORD SELECT:C189([Customer:2])
			CREATE SET:C116([Customer:2]; "ThisOne")
			DIFFERENCE:C122("Current"; "ThisOne"; "ThisOne")
			USE SET:C118("ThisOne")
			CLEAR SET:C117("ThisOne")
			FIRST RECORD:C50([Customer:2])
			For ($i; 1; $fillerCnt)
				If (Modified record:C314([Service:6]))
					SAVE RECORD:C53([Service:6])
					ADD TO SET:C119([Service:6]; "<>curSelSet")
				End if 
				DUPLICATE RECORD:C225([Service:6])
				
				[Service:6]customerID:1:=[Customer:2]customerID:1
				[Service:6]attention:30:=[Customer:2]nameFirst:73+" "+[Customer:2]nameLast:23
				[Service:6]company:48:=[Customer:2]company:2
				[CallReport:34]email:38:=[Customer:2]email:81
				NEXT RECORD:C51([Customer:2])
			End for 
			booSorted:=False:C215
			SAVE RECORD:C53([Service:6])
			ADD TO SET:C119([Service:6]; "<>curSelSet")
			USE SET:C118("Current")
			CLEAR SET:C117("current")
			jCancelButton(False:C215)
			DB_ShowCurrentSelection(->[Service:6]; ""; 4; "")
			REDUCE SELECTION:C351([Service:6]; 0)
		End if 
	: (ptCurTable=(->[CallReport:34]))
		
		If ([CallReport:34]tableNum:2=Table:C252(->[Lead:48]))
			C_POINTER:C301($masterFile)
			$masterFile:=(->[Lead:48])
		Else 
			$masterFile:=(->[Customer:2])
		End if 
		$fillerCnt:=Records in selection:C76($masterFile->)-1
		CONFIRM:C162("Clone this Call record for the current selection of "+String:C10($fillerCnt; "###,###")+".")
		If (OK=1)
			CREATE EMPTY SET:C140([CallReport:34]; "<>curSelSet")
			CREATE SET:C116($masterFile->; "Current")
			ONE RECORD SELECT:C189($masterFile->)
			CREATE SET:C116($masterFile->; "ThisOne")
			DIFFERENCE:C122("Current"; "ThisOne"; "ThisOne")
			USE SET:C118("ThisOne")
			CLEAR SET:C117("ThisOne")
			FIRST RECORD:C50($masterFile->)
			For ($i; 1; $fillerCnt)
				If (Modified record:C314([CallReport:34]))
					SAVE RECORD:C53([CallReport:34])
					ADD TO SET:C119([CallReport:34]; "<>curSelSet")
				End if 
				DUPLICATE RECORD:C225([CallReport:34])
				If ([CallReport:34]tableNum:2=Table:C252(->[Lead:48]))
					[CallReport:34]actionBy:3:=[Lead:48]salesNameID:13
					[CallReport:34]customerID:1:=String:C10([Lead:48]idNum:32)
					[CallReport:34]attention:18:=[Lead:48]nameFirst:1+" "+[Lead:48]nameLast:2
					[CallReport:34]company:42:=[Lead:48]company:5
					[CallReport:34]phone:36:=[Lead:48]phone:4
					[CallReport:34]email:38:=[Lead:48]email:33
					NEXT RECORD:C51([Lead:48])
				Else 
					[CallReport:34]actionBy:3:=[Customer:2]salesNameID:59
					[CallReport:34]customerID:1:=[Customer:2]customerID:1
					[CallReport:34]company:42:=[Customer:2]company:2
					[CallReport:34]attention:18:=[Customer:2]nameFirst:73+" "+[Customer:2]nameLast:23
					
					[CallReport:34]phone:36:=[Customer:2]phone:13
					[CallReport:34]email:38:=[Customer:2]email:81
					[CallReport:34]emailStatus:45:=[Customer:2]emailStatus:138
					NEXT RECORD:C51([Customer:2])
				End if 
			End for 
			booSorted:=False:C215
			SAVE RECORD:C53([CallReport:34])
			ADD TO SET:C119([CallReport:34]; "<>curSelSet")
			USE SET:C118("Current")
			CLEAR SET:C117("current")
			jCancelButton(False:C215)
			DB_ShowCurrentSelection(->[CallReport:34]; ""; 4; "")
			REDUCE SELECTION:C351([CallReport:34]; 0)
		End if 
	: (ptCurTable=(->[Proposal:42]))
		$fillerCnt:=Records in selection:C76([Customer:2])-1
		CONFIRM:C162("Clone this invoice for the current selection of "+String:C10($fillerCnt; "###,###")+" customers.")
		If (OK=1)
			CREATE EMPTY SET:C140([Proposal:42]; "<>curSelSet")
			CREATE SET:C116([Customer:2]; "Current")
			ONE RECORD SELECT:C189([Customer:2])
			CREATE SET:C116([Customer:2]; "ThisOne")
			DIFFERENCE:C122("Current"; "ThisOne"; "ThisOne")
			USE SET:C118("ThisOne")
			CLEAR SET:C117("ThisOne")
			FIRST RECORD:C50([Customer:2])
			For ($i; 1; $fillerCnt)
				If (Is new record:C668([Proposal:42]))
					SAVE RECORD:C53([Proposal:42])
					ADD TO SET:C119([Proposal:42]; "<>curSelSet")
					[Proposal:42]customerID:1:=[Proposal:42]customerID:1  //force a change to make it fully calculate.
				End if 
				CloneRecord
				ProposalLoadCus
				NEXT RECORD:C51([Customer:2])
			End for 
			booSorted:=False:C215
			myCycle:=6  //No Cancel trial
			jAcceptButton(False:C215; False:C215)
			ADD TO SET:C119([Proposal:42]; "<>curSelSet")
			USE SET:C118("Current")
			CLEAR SET:C117("current")
			jCancelButton(False:C215)
			DB_ShowCurrentSelection(->[Proposal:42]; ""; 4; "")
			REDUCE SELECTION:C351([Proposal:42]; 0)
		End if 
	Else 
		ALERT:C41("This works with Orders, Proposals, Invoices, Service records & Call records.")
End case 