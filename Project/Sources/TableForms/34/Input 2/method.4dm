// ### jwm ### 20181214_1543 check this or restore old procedure
// ### bj ### 20181201_1040
C_LONGINT:C283($formEvent)
// $formEvent:=form event
$formEvent:=iLoProcedure(->[Call:34])
$doMore:=False:C215

If (Form event code:C388=On Load:K2:1)
	TallyMasterPopuuScriptsGeneral(->[Customer:2]; "CR_"; ""; "")
	TallyMasterPopuuScriptsGeneral(->[Contact:13]; "CR_"; ""; "aLoScripts2")
End if 

Case of 
	: (iLoReturningToLayout)  //set in iLoProcedure only once, returning from other table
		$doMore:=True:C214
		
	: (iLoRecordNew)  //set in iLoProcedure only once, new record
		$doMore:=True:C214
		
		[Call:34]dtAction:4:=DateTime_DTTo
		[Call:34]dateDocument:17:=Current date:C33
		[Call:34]complete:7:=False:C215
		[Call:34]initiatedBy:23:=Current user:C182
		[Call:34]actionBy:3:=Current user:C182
		[Call:34]tableNum:2:=Table:C252(ptCurTable)
		If (aServiceRecs>Size of array:C274(aServiceTableName))  //protection from overrun
			aServiceRecs:=0
		End if 
		Case of 
				
			: ((ptCurTable=(->[Contact:13])) | ((ptCurTable=(->[Base:1])) & (aServiceTableName{aServiceRecs}="i")))
				[Call:34]customerID:1:=String:C10([Contact:13]idNum:28)
				[Call:34]attention:18:=[Contact:13]nameFirst:2+" "+[Contact:13]nameLast:4
				[Call:34]company:42:=[Contact:13]company:23
				[Call:34]email:38:=[Contact:13]email:35
			: (myCycle=21)
				myCycle:=0
				Case of 
					: (Records in selection:C76([Service:6])=1)
						[Call:34]customerID:1:=String:C10([Service:6]idNum:26)
						[Call:34]tableNum:2:=Table:C252(->[Service:6])
						[Call:34]email:38:=[Service:6]email:64
					: (Records in selection:C76([Contact:13])=1)
						[Call:34]customerID:1:=String:C10([Contact:13]idNum:28)
						[Call:34]tableNum:2:=Table:C252(->[Contact:13])
						[Call:34]email:38:=[Contact:13]email:35
					: (Records in selection:C76([Customer:2])=1)
						[Call:34]customerID:1:=[Customer:2]customerID:1
						[Call:34]tableNum:2:=Table:C252(->[Customer:2])
						[Call:34]email:38:=[Customer:2]email:81
				End case 
				[Call:34]company:42:=[Service:6]company:48
				[Call:34]attention:18:=[Service:6]attention:30
				[Call:34]profile1:26:=[Item:4]type:26
				[Call:34]profile2:27:=[Item:4]profile1:35
				[Call:34]profile3:28:=[Item:4]profile2:36
				[Call:34]profileName1:30:=<>vItemsType
				[Call:34]profileName2:31:=<>vItemsProfile1
				[Call:34]profileName3:32:=<>vItemsProfile2
				//[CallReport]actionDate:=jDateTimeRDate([Item]dtItemDate)
			Else 
				[Call:34]customerID:1:=[Customer:2]customerID:1
				[Call:34]company:42:=[Customer:2]company:2
				If ([Customer:2]individual:72)
					[Call:34]attention:18:=[Customer:2]nameFirst:73+" "+[Customer:2]nameLast:23
				Else 
					[Call:34]attention:18:=[Customer:2]company:2
				End if 
				[Call:34]email:38:=[Customer:2]email:81
		End case 
		
		
	: (iLoRecordChange)  //set in iLoProcedure only once, existing record
		$doMore:=True:C214
		
		
		
	: ($formEvent=On Outside Call:K2:11)
		If (<>prsTableNum=Table:C252(->[Call:34]))
			jSaveRecord
			REDUCE SELECTION:C351([Customer:2]; 0)
			REDUCE SELECTION:C351([Contact:13]; 0)
			//
			GOTO RECORD:C242(Table:C252(<>prsTableNum)->; <>prsRecNum)
			$lockedStatus:=""
			If (Locked:C147([Call:34]))
				$lockedStatus:="LOCKED: "
			End if 
			$uniqueKey:=" _ "+String:C10([Call:34]idNum:22)
			SET WINDOW TITLE:C213($lockedStatus+Table name:C256(->[Call:34])+" - "+aPages{1}+" - "+String:C10(Record number:C243([Call:34]))+$uniqueKey+" - "+<>tcCompany)  //
			<>prsRecNum:=-1
			<>prsTableNum:=-1
			BRING TO FRONT:C326(Current process:C322)
			<>aLastRecNum{Table:C252(ptCurTable)}:=-1  //force a reload
			$curRecNum:=Record number:C243([Call:34])
			$outsideCall:=True:C214
			C_LONGINT:C283(vOrderProcessNum)
			If (vOrderProcessNum>0)
				<>prsTableNum:=-3
				<>prscustomerID:=[Call:34]customerID:1
				POST OUTSIDE CALL:C329(vOrderProcessNum)
			End if 
		Else 
			Prs_OutsideCall
		End if 
		$doMore:=True:C214
End case 

If ($doMore)  //action for the form regardless of new or existing record
	
	// related records not addressed by (P) RelatedGet
	// form calculations
	
	
	If ([Call:34]profileName1:30="")
		[Call:34]profileName1:30:="Profile1"
	End if 
	If ([Call:34]profileName2:31="")
		[Call:34]profileName2:31:="Profile2"
	End if 
	If ([Call:34]profileName3:32="")
		[Call:34]profileName3:32:="Profile3"
	End if 
	C_DATE:C307(vDateCRAction)
	C_TIME:C306(vTimeCRAction)
	DateTime_DTFrom([Call:34]dtAction:4; ->vDateCRAction; ->vTimeCRAction)
	DateTime_DTFrom([Call:34]dtComplete:33; ->vDateCRCompleted; ->vTimeCRCompleted)
	
	If ((bEDI_Pass) & ([Customer:2]alertMessage:79#""))  //(<>aLastRecNum{2}#Record number([Customer]))&
		ALERT:C41([Customer:2]alertMessage:79)
	End if 
	curRecNum:=Selected record number:C246([Customer:2])
	If ([Call:34]actionBy:3="")
		[Call:34]actionBy:3:=Current user:C182
	End if 
	Case of 
		: ([Call:34]tableNum:2=2)
			If ([Customer:2]customerID:1#[Call:34]customerID:1)
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Call:34]customerID:1)
				QUERY:C277([Contact:13]; [Contact:13]customerID:1=[Call:34]customerID:1)
			End if 
		: ([Call:34]tableNum:2=13)
			If ([Contact:13]idNum:28#Num:C11([Call:34]customerID:1))
				QUERY:C277([Contact:13]; [Contact:13]idNum:28=Num:C11([Call:34]customerID:1))
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Contact:13]customerID:1)
			End if 
	End case 
	// ### bj ### 20191204_2024  
	// $doContactArray was not declared or defined above
	C_BOOLEAN:C305($doContactArray)
	If (bEDI_Pass)  // & ($doContactArray))
		//  CHOPPED FillContactArrays(Records in selection([Contact]); 0; 0; eContactsCallReports)
	End if 
	If (([Call:34]tableNum:2=2) & ([Call:34]contactID:44#0))
		QUERY:C277([Contact:13]; [Contact:13]idNum:28=[Call:34]contactID:44)
	End if 
	srDisplayEmail:=[Customer:2]email:81
	
End if 

booAccept:=True:C214  // no madatory fields








C_LONGINT:C283($formEvent; $curRecNum)
C_LONGINT:C283(<>prsTableNum)
If (<>prsTableNum=0)
	<>prsTableNum:=1
End if 
$formEvent:=Form event code:C388
$curRecNum:=Record number:C243([Call:34])
$outsideCall:=False:C215
If ($formEvent=On Unload:K2:2)
	UNLOAD RECORD:C212(ptCurTable->)
	READ WRITE:C146([Customer:2])
Else 
	Case of 
		: ($formEvent=On Outside Call:K2:11)
			If (<>prsTableNum=Table:C252(->[Call:34]))
				jSaveRecord
				REDUCE SELECTION:C351([Customer:2]; 0)
				REDUCE SELECTION:C351([Contact:13]; 0)
				//
				GOTO RECORD:C242(Table:C252(<>prsTableNum)->; <>prsRecNum)
				$lockedStatus:=""
				If (Locked:C147([Call:34]))
					$lockedStatus:="LOCKED: "
				End if 
				$uniqueKey:=" _ "+String:C10([Call:34]idNum:22)
				SET WINDOW TITLE:C213($lockedStatus+Table name:C256(->[Call:34])+" - "+aPages{1}+" - "+String:C10(Record number:C243([Call:34]))+$uniqueKey+" - "+<>tcCompany)  //
				<>prsRecNum:=-1
				<>prsTableNum:=-1
				BRING TO FRONT:C326(Current process:C322)
				<>aLastRecNum{Table:C252(ptCurTable)}:=-1  //force a reload
				$curRecNum:=Record number:C243([Call:34])
				$outsideCall:=True:C214
				C_LONGINT:C283(vOrderProcessNum)
				If (vOrderProcessNum>0)
					<>prsTableNum:=-3
					<>prscustomerID:=[Call:34]customerID:1
					POST OUTSIDE CALL:C329(vOrderProcessNum)
				End if 
			Else 
				Prs_OutsideCall
			End if 
		: ($formEvent=On Load:K2:1)  //|(booPreNext))//(Before)
			ARRAY LONGINT:C221(aExtendedProcesses; 0)  //clear and ready list of related windows
			//Console_Log ("TEST: On Load")
			C_BOOLEAN:C305($booGo)
			MESSAGES OFF:C175
			oLo20Str1:=""
			booAccept:=True:C214
			
			If (Is new record:C668([Call:34]))
				
				[Call:34]dtAction:4:=DateTime_DTTo
				[Call:34]dateDocument:17:=Current date:C33
				[Call:34]complete:7:=False:C215
				[Call:34]initiatedBy:23:=Current user:C182
				[Call:34]actionBy:3:=Current user:C182
				[Call:34]tableNum:2:=Table:C252(ptCurTable)
				If (aServiceRecs>Size of array:C274(aServiceTableName))  //protection from overrun
					aServiceRecs:=0
				End if 
				Case of 
						
					: ((ptCurTable=(->[Contact:13])) | ((ptCurTable=(->[Base:1])) & (aServiceTableName{aServiceRecs}="i")))
						[Call:34]customerID:1:=String:C10([Contact:13]idNum:28)
						[Call:34]attention:18:=[Contact:13]nameFirst:2+" "+[Contact:13]nameLast:4
						[Call:34]company:42:=[Contact:13]company:23
						[Call:34]email:38:=[Contact:13]email:35
					: (myCycle=21)
						myCycle:=0
						Case of 
							: (Records in selection:C76([Service:6])=1)
								[Call:34]customerID:1:=String:C10([Service:6]idNum:26)
								[Call:34]tableNum:2:=Table:C252(->[Service:6])
								[Call:34]email:38:=[Service:6]email:64
							: (Records in selection:C76([Contact:13])=1)
								[Call:34]customerID:1:=String:C10([Contact:13]idNum:28)
								[Call:34]tableNum:2:=Table:C252(->[Contact:13])
								[Call:34]email:38:=[Contact:13]email:35
							: (Records in selection:C76([Customer:2])=1)
								[Call:34]customerID:1:=[Customer:2]customerID:1
								[Call:34]tableNum:2:=Table:C252(->[Customer:2])
								[Call:34]email:38:=[Customer:2]email:81
						End case 
						[Call:34]company:42:=[Service:6]company:48
						[Call:34]attention:18:=[Service:6]attention:30
						[Call:34]profile1:26:=[Item:4]type:26
						[Call:34]profile2:27:=[Item:4]profile1:35
						[Call:34]profile3:28:=[Item:4]profile2:36
						[Call:34]profileName1:30:=<>vItemsType
						[Call:34]profileName2:31:=<>vItemsProfile1
						[Call:34]profileName3:32:=<>vItemsProfile2
						//[CallReport]actionDate:=jDateTimeRDate([Item]dtItemDate)
					Else 
						[Call:34]customerID:1:=[Customer:2]customerID:1
						[Call:34]company:42:=[Customer:2]company:2
						If ([Customer:2]individual:72)
							[Call:34]attention:18:=[Customer:2]nameFirst:73+" "+[Customer:2]nameLast:23
						Else 
							[Call:34]attention:18:=[Customer:2]company:2
						End if 
						[Call:34]email:38:=[Customer:2]email:81
				End case 
			End if 
			
			TallyMasterPopuuScriptsGeneral(->[Customer:2]; "CR_"; ""; "")
			TallyMasterPopuuScriptsGeneral(->[Contact:13]; "CR_"; ""; "aLoScripts2")
			If (False:C215)
				If (Record number:C243([Call:34])>-1)
					Case of 
						: ([Call:34]tableNum:2=2)
							If ([Customer:2]customerID:1#[Call:34]customerID:1)
								QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Call:34]customerID:1)
								QUERY:C277([Contact:13]; [Contact:13]customerID:1=[Call:34]customerID:1)
							End if 
						: ([Call:34]tableNum:2=13)
							If ([Contact:13]idNum:28#Num:C11([Call:34]customerID:1))
								QUERY:C277([Contact:13]; [Contact:13]idNum:28=Num:C11([Call:34]customerID:1))
								QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Contact:13]customerID:1)
							End if 
					End case 
					$doContactArray:=False:C215
					
					
					If (bEDI_Pass)
						//  CHOPPED FillContactArrays(Records in selection([Contact]); 0; 0; eContactsCallReports)
					End if 
					If (([Call:34]tableNum:2=2) & ([Call:34]contactID:44#0))
						QUERY:C277([Contact:13]; [Contact:13]idNum:28=[Call:34]contactID:44)
					End if 
				End if 
			End if 
			If ([Call:34]profileName1:30="")
				[Call:34]profileName1:30:="Profile1"
			End if 
			If ([Call:34]profileName2:31="")
				[Call:34]profileName2:31:="Profile2"
			End if 
			If ([Call:34]profileName3:32="")
				[Call:34]profileName3:32:="Profile3"
			End if 
			C_DATE:C307(vDateCRAction)
			C_TIME:C306(vTimeCRAction)
			DateTime_DTFrom([Call:34]dtAction:4; ->vDateCRAction; ->vTimeCRAction)
			DateTime_DTFrom([Call:34]dtComplete:33; ->vDateCRCompleted; ->vTimeCRCompleted)
			Before_New(->[Call:34])
			TimeWindowOpen  //Set window characteristic for automatic closing
	End case 
	
	//replacement for During Phase Record Change
	If (ptCurTable#(->[Call:34]))  //must be ahead of the next call
		jsetDuringIncl(->[Call:34])
		Case of 
			: ([Call:34]tableNum:2=2)
				If ([Customer:2]customerID:1#[Call:34]customerID:1)
					QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Call:34]customerID:1)
					QUERY:C277([Contact:13]; [Contact:13]customerID:1=[Call:34]customerID:1)
				End if 
			: ([Call:34]tableNum:2=13)
				If ([Contact:13]idNum:28#Num:C11([Call:34]customerID:1))
					QUERY:C277([Contact:13]; [Contact:13]idNum:28=Num:C11([Call:34]customerID:1))
					QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Contact:13]customerID:1)
				End if 
		End case 
		If (bEDI_Pass)
			//  CHOPPED FillContactArrays(Records in selection([Contact]); 0; 0; eContactsCallReports)
		End if 
		If (([Call:34]tableNum:2=2) & ([Call:34]contactID:44#0))
			QUERY:C277([Contact:13]; [Contact:13]idNum:28=[Call:34]contactID:44)
		End if 
		
	End if 
	
	If ($formEvent=On After Keystroke:K2:26)  //manage time feature based on user action.
		TimeWindowKeyStroke
	End if 
	$doContactArray:=True:C214
	Case of 
		: (($curRecNum>-1) | ($outsideCall))
			If ((<>aLastRecNum{Table:C252(ptCurTable)}#$curRecNum) | ($formEvent=On Load:K2:1))
				<>aLastRecNum{Table:C252(ptCurTable)}:=$curRecNum
				jNxPvButtonSet
				If ((bEDI_Pass) & ([Customer:2]alertMessage:79#""))  //(<>aLastRecNum{2}#Record number([Customer]))&
					ALERT:C41([Customer:2]alertMessage:79)
				End if 
				Before_New(->[Customer:2])
				//Console_Log ("TEST: Before_New")
				//  Put  the formating in the form  jFormatPhone(->[Customer]phone; ->[Customer]fax; ->[Customer]phoneCell)
				//  Put  the formating in the form  jFormatPhone(->[Contact]phone; ->[Contact]fax; ->[Contact]phoneCell)
				If (([Customer:2]zone:57=-1) & ([Customer:2]zip:8#"") & ([Customer:2]shipVia:12#""))  //should this not be done
					Find Ship Zone(->[Customer:2]zip:8; ->[Customer:2]zone:57; ->[Customer:2]shipVia:12; ->[Customer:2]country:9; ->[Customer:2]siteID:106)
				End if 
				curRecNum:=Selected record number:C246([Customer:2])
				If ([Call:34]actionBy:3="")
					[Call:34]actionBy:3:=Current user:C182
				End if 
				Case of 
					: ([Call:34]tableNum:2=2)
						If ([Customer:2]customerID:1#[Call:34]customerID:1)
							QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Call:34]customerID:1)
							QUERY:C277([Contact:13]; [Contact:13]customerID:1=[Call:34]customerID:1)
						End if 
					: ([Call:34]tableNum:2=13)
						If ([Contact:13]idNum:28#Num:C11([Call:34]customerID:1))
							QUERY:C277([Contact:13]; [Contact:13]idNum:28=Num:C11([Call:34]customerID:1))
							QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Contact:13]customerID:1)
						End if 
				End case 
				DateTime_DTFrom([Call:34]dtAction:4; ->vDateCRAction; ->vTimeCRAction)
				DateTime_DTFrom([Call:34]dtComplete:33; ->vDateCRCompleted; ->vTimeCRCompleted)
				If ((bEDI_Pass) & ($doContactArray))
					//  CHOPPED FillContactArrays(Records in selection([Contact]); 0; 0; eContactsCallReports)
				End if 
				If (([Call:34]tableNum:2=2) & ([Call:34]contactID:44#0))
					QUERY:C277([Contact:13]; [Contact:13]idNum:28=[Call:34]contactID:44)
				End if 
				srDisplayEmail:=[Customer:2]email:81
				Before_New(->[Call:34])
			End if 
			//allowing this will allow changes to be displayed by then the current selected lines are lost
			//: ($formEvent=On Losing Focus)
			//<>vPricePoint:=[Customer]TypeSale
		: ($formEvent=On Deactivate:K2:10)
			<>vPricePoint:=[Customer:2]typeSale:18
			//: ($formEvent=On Activate)
			//<>vPricePoint:=[Customer]TypeSale
			//: ($formEvent=On Getting Focus)
			//<>vPricePoint:=[Customer]TypeSale
		: ($formEvent=On Close Detail:K2:24)
			READ WRITE:C146([Customer:2])
			
	End case 
	
End if 