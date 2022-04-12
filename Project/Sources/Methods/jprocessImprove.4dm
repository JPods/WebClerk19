//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/06/10, 12:58:14
// ----------------------------------------------------
// Method: jprocessImprove
// Description
// 
//
// Parameters
// ----------------------------------------------------

//  Process_InitLocal 
// cannot initialize or vHere will be set to zero
C_LONGINT:C283($incomingTableNum)




Case of 
	: ((<>salesTrack) & (ptCurTable=(->[Item:4])) & (vHere=2))
		$doNew:=False:C215
		$doExisting:=False:C215
		SAVE RECORD:C53([Item:4])
		Sr_CustContacts
		If ((myOK=1) | (myOK=2))
			$incomingTableNum:=-1
			Case of 
				: (Records in selection:C76([Customer:2])=1)
					$incomingTableNum:=Table:C252(->[Customer:2])
					QUERY:C277([Service:6]; [Service:6]customerID:1=[Customer:2]customerID:1; *)
					QUERY:C277([Service:6];  & [Service:6]reference:37=[Item:4]itemNum:1)
					If (Records in selection:C76([Service:6])=0)
						$doNew:=True:C214
					Else 
						CONFIRM:C162("Duplicate Service Record for: "+[Customer:2]company:2)
						If (OK=1)
							$doNew:=True:C214
						Else 
							$doExisting:=True:C214
						End if 
					End if 
					//ARRAY LONGINT(<>aPrcRecs;3)
					//<>aPrcRecs{2}:=Record number([Customer])
					//<>aPrcRecs{1}:=-1
					//<>aPrcRecs{3}:=-1
				: (Records in selection:C76([Contact:13])=1)
					$incomingTableNum:=Table:C252(->[Contact:13])
					QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Contact:13]customerID:1)
					QUERY:C277([Service:6]; [Service:6]customerID:1=[Customer:2]customerID:1; *)
					QUERY:C277([Service:6];  & [Service:6]reference:37=[Item:4]itemNum:1)
					If (Records in selection:C76([Service:6])=0)
						$doNew:=True:C214
					Else 
						$doExisting:=True:C214
					End if 
					//ARRAY LONGINT(<>aPrcRecs;3)
					//<>aPrcRecs{3}:=Record number([Contact])
					//<>aPrcRecs{1}:=-1
					//<>aPrcRecs{2}:=-1
				Else 
					ALERT:C41("Must attach customer or contact to use this feature.")
			End case 
			If ($doNew)
				CREATE RECORD:C68([Service:6])
				myCycle:=4
				NxPvServiceNewRec($incomingTableNum)
				
				SAVE RECORD:C53([Service:6])
				$doExisting:=True:C214
			End if 
			If ($doExisting)
				ARRAY LONGINT:C221(<>aPrcRecs; 3)
				UNLOAD RECORD:C212([Customer:2])
				UNLOAD RECORD:C212([Contact:13])
				<>aPrcRecs{1}:=Record number:C243([Service:6])
				UNLOAD RECORD:C212([Service:6])
				<>aPrcRecs{2}:=-1
				<>aPrcRecs{3}:=-1
				$found:=Prs_CheckRunnin("SalesSpecial")
				Case of 
					: ($found>0)
						If (Frontmost process:C327#<>aPrsNum{$found})
							POST OUTSIDE CALL:C329(<>aPrsNum{$found})
							BRING TO FRONT:C326(<>aPrsNum{$found})
						End if 
					: ($found=0)
						<>prcControl:=1
						<>processAlt:=New process:C317("Prs_ShowCallSpecial"; <>tcPrsMemory; "SalesSpecial"; Current process:C322)
						//DB_ShowCurrentSelection  cannot be used here, calling a special input form
				End case 
			End if 
		Else 
			ALERT:C41("Must attach customer or contact to use this feature.")
		End if 
	: ((ptCurTable=(->[Customer:2])) | (ptCurTable=(->[Order:3])) | (ptCurTable=(->[Contact:13])) | (ptCurTable=(->[Proposal:42])) | (ptCurTable=(->[Invoice:26])) & (vHere>1))
		ADD RECORD:C56([Service:6])  //need to transfer data to the Service Record, might be changed by adding a script.
		
	Else 
		
		Process_AddRecord("Service")
End case 