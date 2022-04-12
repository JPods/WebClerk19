C_POINTER:C301($ptLastTable)
C_BOOLEAN:C305($fillFromPrevious; $doMore)
C_LONGINT:C283($formEvent; $incomingTableNum)
$formEvent:=Form event code:C388
If ($formEvent=On Unload:K2:2)
	UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
	READ WRITE:C146(ptCurTable->)
Else 
	$incomingTableNum:=-1
	If ($formEvent=On Load:K2:1)
		If (vHere>1)  //coming from another table's input layout
			$incomingTableNum:=Table:C252(ptCurTable)
			blockServiceRelate:=True:C214  //keep from wiping out exiting order and proposal// Modified by: williamjames 101020)
			//settings allows Cust_OPiRays (eItemSrvr;0) to wipeout the current order. would also happen in proposals
			If (Is new record:C668([Service:6]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[Service:6])
	//
	$doMore:=False:C215
	Case of 
		: (iLoReturningToLayout)  //set in iLoProcedure only once, returning from other table
			
			//  CHOPPED QA_LoOnEntry(eAnsListService; Table(->[Service]); [Service]customerID; [Service]idNum; [Service]idNumTask)
			List_RaySize(0)
			//  --  CHOPPED  AL_UpdateArrays(eItemSrvr; -2)
		: (iLoRecordNew)  //set in iLoProcedure only once, new record
			
			$doMore:=True:C214
		: (iLoRecordChange)  //set in iLoProcedure only once, existing record
			
			$doMore:=True:C214
	End case 
	If ($doMore)  //action for the form regardless of new or existing record
		
		MESSAGES OFF:C175
		booAccept:=True:C214
		<>aNameID:=1
		C_POINTER:C301(ptFile)
		
		List_RaySize(0)
		
		
		NxPvService($incomingTableNum)
		
		
		ENABLE MENU ITEM:C149(2; 2)
		MESSAGES ON:C181
		myCycle:=0
		$viProcess:=Current process:C322
		HIDE MENU BAR:C432
		SET MENU BAR:C67(iLoMenu; $viProcess; *)
		SHOW MENU BAR:C431
		
		
		
		Before_New(ptCurTable)  //last thing to do
	End if 
	
	
	If (Modified record:C314([Contact:13]))
		SAVE RECORD:C53([Contact:13])
	End if 
	booAccept:=True:C214
End if 

