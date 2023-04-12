C_POINTER:C301($ptLastTable)
C_BOOLEAN:C305($fillFromPrevious; $doMore; $bAuthorized)
C_LONGINT:C283($formEvent)

$bAuthorized:=False:C215
$formEvent:=Form event code:C388
$bAuthorized:=UserInPassWordGroup("AdminControl")
If ($bAuthorized)
	If (Locked:C147([Counter:41]))
		READ WRITE:C146([Counter:41])
		LOAD RECORD:C52([Counter:41])
	End if 
End if 
If (Not:C34($bAuthorized))
	CANCEL:C270
	UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
	READ WRITE:C146(ptCurTable->)
Else 
	
	If ($formEvent=On Load Record:K2:38)
		
	End if 
	If ($formEvent=On Load:K2:1)
		C_LONGINT:C283($formEvent)
		$doMore:=False:C215
	End if 
	$formEvent:=iLoProcedure(->[Counter:41])
	Case of 
		: (changeRecord=1)
			$doMore:=True:C214
			changeRecord:=0
		: (iLoRecordNew)  //set in iLoProcedure only once, new record
			
			$doMore:=True:C214
		: (iLoRecordChange)  //set in iLoProcedure only once, existing record
			
			$doMore:=True:C214
	End case 
End if 
If ($doMore)  //action for the form regardless of new or existing record
	
	READ ONLY:C145([CounterPending:135])
	QUERY:C277([CounterPending:135]; [CounterPending:135]tableNum:3=[Counter:41]tableNum:4; *)
	QUERY:C277([CounterPending:135];  & [CounterPending:135]status:7=1)
	ORDER BY:C49([CounterPending:135]; [CounterPending:135]pendingNum:4; >)
	FIRST RECORD:C50([CounterPending:135])
	iLoLongInt1:=[CounterPending:135]pendingNum:4
	LAST RECORD:C200([CounterPending:135])
	iLoLongInt2:=[CounterPending:135]pendingNum:4
	iLoLongInt3:=Records in selection:C76([CounterPending:135])
	REDUCE SELECTION:C351([CounterPending:135]; 0)
	READ WRITE:C146([CounterPending:135])
	iLoLongint4:=0
	iLoLongInt5:=iLoLongint4
	iLoText1:=""
	OBJECT SET ENABLED:C1123(b11; True:C214)
	OBJECT SET ENABLED:C1123(b12; True:C214)
	OBJECT SET ENABLED:C1123(b21; False:C215)
	OBJECT SET ENABLED:C1123(b22; False:C215)
	OBJECT SET ENTERABLE:C238(iLoLongint5; False:C215)
	Case of 
		: (([Counter:41]tableName:2="Customer") | ([Counter:41]tableName:2="Invoice") | ([Counter:41]tableName:2="Vendor"))
			
		: (([Counter:41]tableName:2="Item") | ([Counter:41]tableName:2="Order") | ([Counter:41]tableName:2="WorkOrder"))
			
		: (([Counter:41]tableName:2="PO") | ([Counter:41]tableName:2="Proposal") | ([Counter:41]tableName:2="Rep"))
			
		Else 
			OBJECT SET ENABLED:C1123(b11; False:C215)
			OBJECT SET ENABLED:C1123(b12; False:C215)
			OBJECT SET ENABLED:C1123(b21; True:C214)
			OBJECT SET ENABLED:C1123(b22; True:C214)
			OBJECT SET ENTERABLE:C238(iLoLongint5; True:C214)
			If ([Counter:41]tableNum:4=0)
				CANCEL:C270
				ALERT:C41("Zero table values are not permitted.")
			Else 
				CREATE RECORD:C68(Table:C252([Counter:41]tableNum:4)->)
				$fieldNum:=STR_GetUniqueFieldNum(Table name:C256([Counter:41]tableNum:4))
				$ptField:=Field:C253([Counter:41]tableNum:4; $fieldNum)
				iLoLongint4:=$ptField->
				iLoLongInt5:=iLoLongint4
				REDUCE SELECTION:C351(Table:C252([Counter:41]tableNum:4)->; 0)
			End if 
	End case 
	
	
	Before_New(ptCurTable)  //last thing to do
End if 
//every cycle

booAccept:=True:C214


