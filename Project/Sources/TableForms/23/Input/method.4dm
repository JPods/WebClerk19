// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-11T00:00:00, 14:17:23
// ----------------------------------------------------
// Method: iloPopups
// Description
// Modified: 08/11/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------



C_POINTER:C301($ptLastTable)
C_BOOLEAN:C305($fillFromPrevious; $doMore)
C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
If ($formEvent=On Unload:K2:2)
	UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
	READ WRITE:C146(ptCurTable->)
Else 
	If ($formEvent=On Load:K2:1)
		If (vHere>1)  //coming from another table's input layout
			If (Is new record:C668([PopUp:23]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
	End if 
	//
	C_LONGINT:C283($formEvent)
	
	// practicing based on Popups
	$formEvent:=iLoProcedure(->[PopUp:23])
	//
	$doMore:=False:C215
	Case of 
		: (iLoRecordNew)  //set in iLoProcedure only once, new record
			
			$doMore:=True:C214
		: (iLoRecordChange)  //set in iLoProcedure only once, existing record
			
			$doMore:=True:C214
	End case 
	If ($doMore)  //action for the form regardless of new or existing record
		
		transactionActive:=False:C215
		If (False:C215)
			If (Not:C34(<>useTransactions))  // was bypassed in $formEvent:=iLoProcedure (->[PopUp]) do to always set transactions
				START TRANSACTION:C239
				SET QUERY AND LOCK:C661(True:C214)
				transactionActive:=True:C214
			End if 
		End if 
		
		$obRec:=ds:C1482.PopUp.query("id = :1 "; [PopUp:23]id:10).first()
		C_OBJECT:C1216(process_o)
		If (process_o=Null:C1517)
			process_o:=New object:C1471("tableName"; "Popup")
		End if 
		If (process_o.currentEntity=Null:C1517)
			process_o.currentEntity:=New object:C1471
		End if 
		process_o.currentEntity:=$obRec
		
		
		
		C_COLLECTION:C1488($cTemp)
		C_OBJECT:C1216($obSel)
		$obSel:=ds:C1482.PopupChoice.query("arrayName = :1"; [PopUp:23]arrayName:3)
		
		
		
		
		$obSel:=$obSel.orderBy("choice")
		$cTemp:=New collection:C1472
		C_COLLECTION:C1488($cFilter)
		$cFilter:=Split string:C1554("choice,alternate,id"; ",")
		$cTemp:=$obSel.toCollection($cFilter)
		
		Form:C1466.cPopupChoice:=$cTemp
		
		
		Before_New(ptCurTable)  //last thing to do
	End if 
	//every cycle
	
	booAccept:=([PopUp:23]listName:4#"")
End if 

