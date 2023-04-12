//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/05/18, 10:06:24
// ----------------------------------------------------
// Method: WO_FillArrays
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ### bj ### 20181205_1006
// WorkOrders are connected by taskID so they can
// float between Proposals, Orders, Invoices

C_LONGINT:C283($1; $2; $3; $incRay; $sizeRay; $diff)
Case of 
	: ($1=0)
		ARRAY TEXT:C222(aWoDescrpt; 0)
		ARRAY LONGINT:C221(aWoDTNeed; 0)
		ARRAY LONGINT:C221(aWoDTCmpltd; 0)
		ARRAY TEXT:C222(aWoNameID; 0)
		ARRAY TEXT:C222(aWoActivity; 0)
		ARRAY REAL:C219(aWoRate; 0)
		ARRAY TEXT:C222(aWoComment; 0)
		ARRAY LONGINT:C221(aWoTimeNd; 0)
		ARRAY DATE:C224(aWoDateNd; 0)
		ARRAY LONGINT:C221(aWoTimeCmp; 0)
		ARRAY DATE:C224(aWoDateCmp; 0)
		ARRAY TEXT:C222(aWoCodeSeq; 0)
		ARRAY LONGINT:C221(aWoOrdertaskID; 0)
		ARRAY REAL:C219(aWoDurationPlan; 0)
		ARRAY LONGINT:C221(aWoNature; 0)  //code ID
		ARRAY LONGINT:C221(aWoSeq; 0)
		ARRAY LONGINT:C221(aWoRecNum; 0)
		ARRAY TEXT:C222(aWoCause; 0)
		ARRAY LONGINT:C221(aWoOrdLn; 0)
		ARRAY LONGINT:C221(aWoPublish; 0)
		ARRAY REAL:C219(aWoDurationPlan; 0)
		ARRAY LONGINT:C221(aWoTemplateUniqueID; 0)
		ARRAY TEXT:C222(aWOAddress1; 0)
		ARRAY TEXT:C222(aWOCompany; 0)
		
		ARRAY LONGINT:C221(aWoNum; 0)
		//
		ARRAY LONGINT:C221(aWoStepLns; 0)  //selection array
	: ($1>0)
		SELECTION TO ARRAY:C260([WorkOrder:66]cause:27; aWoCause; [WorkOrder:66]idNumTask:22; aWoOrdertaskID; [WorkOrder:66]seq:26; aWoSeq; [WorkOrder:66]rate:23; aWoRate; [WorkOrder:66]processCodes:24; aWoCodeSeq; [WorkOrder:66]description:3; aWoDescrpt; [WorkOrder:66]dtAction:5; aWoDTNeed; [WorkOrder:66]dtComplete:6; aWoDTCmpltd; [WorkOrder:66]ideTemplate:57; aWoTemplateUniqueID)
		SELECTION TO ARRAY:C260([WorkOrder:66]actionBy:8; aWoNameID; [WorkOrder:66]activity:7; aWoActivity; [WorkOrder:66]comment:17; aWoComment; [WorkOrder:66]idNumTask:22; aWoOrdertaskID; [WorkOrder:66]durationPlanned:10; aWoDurationPlan; [WorkOrder:66]codeID:25; aWoNature; [WorkOrder:66]lineRefNum:20; aWoOrdLn; [WorkOrder:66]; aWoRecNum; [WorkOrder:66]publish:30; aWoPublish)
		SELECTION TO ARRAY:C260([WorkOrder:66]company:36; aWOCompany; [WorkOrder:66]address1:50; aWOAddress1; [WorkOrder:66]idNum:29; aWoNum)
		UNLOAD RECORD:C212([WorkOrder:66])
		ARRAY LONGINT:C221(aWoTimeNd; $1)
		ARRAY DATE:C224(aWoDateNd; $1)
		ARRAY LONGINT:C221(aWoTimeCmp; $1)
		ARRAY DATE:C224(aWoDateCmp; $1)
		ARRAY TEXT:C222(aWoCodeSeq; $1)
		For ($i; 1; $1)
			DateTime_DTFrom(aWoDTNeed{$i}; ->aWoDateNd{$i}; ->aWoTimeNd{$i})
			aWoTimeNd{$i}:=aWoTimeNd{$i}*1
			DateTime_DTFrom(aWoDTCmpltd{$i}; ->aWoDateCmp{$i}; ->aWoTimeCmp{$i})
			aWoTimeCmp{$i}:=aWoTimeCmp{$i}*1
		End for 
		ARRAY LONGINT:C221(aWoStepLns; 0)
		UNLOAD RECORD:C212([WorkOrder:66])
	: (($1=-1) | ($1=-2))  //delete an element
		//-2  delete an element in array only
		If (($1>-1) & (aWoRecNum{$2}>-1))
			READ WRITE:C146([WorkOrder:66])
			GOTO RECORD:C242([WorkOrder:66]; aWoRecNum{$2})
			DELETE RECORD:C58([WorkOrder:66])
			READ ONLY:C145([WorkOrder:66])
		End if 
		DELETE FROM ARRAY:C228(aWoDescrpt; $2; $3)
		DELETE FROM ARRAY:C228(aWoDTNeed; $2; $3)
		DELETE FROM ARRAY:C228(aWoDTCmpltd; $2; $3)
		DELETE FROM ARRAY:C228(aWoNameID; $2; $3)
		DELETE FROM ARRAY:C228(aWoActivity; $2; $3)
		DELETE FROM ARRAY:C228(aWoRate; $2; $3)
		DELETE FROM ARRAY:C228(aWoComment; $2; $3)
		DELETE FROM ARRAY:C228(aWoTimeNd; $2; $3)
		DELETE FROM ARRAY:C228(aWoDateNd; $2; $3)
		DELETE FROM ARRAY:C228(aWoTimeCmp; $2; $3)
		DELETE FROM ARRAY:C228(aWoDateCmp; $2; $3)
		DELETE FROM ARRAY:C228(aWoCodeSeq; $2; $3)
		DELETE FROM ARRAY:C228(aWoOrdertaskID; $2; $3)
		DELETE FROM ARRAY:C228(aWoDurationPlan; $2; $3)
		DELETE FROM ARRAY:C228(aWoNature; $2; $3)
		DELETE FROM ARRAY:C228(aWoSeq; $2; $3)
		DELETE FROM ARRAY:C228(aWoRecNum; $2; $3)
		DELETE FROM ARRAY:C228(aWoCause; $2; $3)
		DELETE FROM ARRAY:C228(aWoOrdLn; $2; $3)
		DELETE FROM ARRAY:C228(aWoPublish; $2; $3)
		DELETE FROM ARRAY:C228(aWoTemplateUniqueID; $2; $3)
		DELETE FROM ARRAY:C228(aWOAddress1; $2; $3)
		DELETE FROM ARRAY:C228(aWOCompany; $2; $3)
		//
	: ($1=-3)  //insert an element
		INSERT IN ARRAY:C227(aWoDescrpt; $2; $3)
		INSERT IN ARRAY:C227(aWoDTNeed; $2; $3)
		INSERT IN ARRAY:C227(aWoDTCmpltd; $2; $3)
		INSERT IN ARRAY:C227(aWoNameID; $2; $3)
		INSERT IN ARRAY:C227(aWoActivity; $2; $3)
		INSERT IN ARRAY:C227(aWoRate; $2; $3)
		INSERT IN ARRAY:C227(aWoComment; $2; $3)
		INSERT IN ARRAY:C227(aWoTimeNd; $2; $3)
		INSERT IN ARRAY:C227(aWoDateNd; $2; $3)
		INSERT IN ARRAY:C227(aWoTimeCmp; $2; $3)
		INSERT IN ARRAY:C227(aWoDateCmp; $2; $3)
		INSERT IN ARRAY:C227(aWoCodeSeq; $2; $3)
		INSERT IN ARRAY:C227(aWoOrdertaskID; $2; $3)
		INSERT IN ARRAY:C227(aWoDurationPlan; $2; $3)
		INSERT IN ARRAY:C227(aWoNature; $2; $3)
		INSERT IN ARRAY:C227(aWoSeq; $2; $3)
		INSERT IN ARRAY:C227(aWoRecNum; $2; $3)
		INSERT IN ARRAY:C227(aWoCause; $2; $3)
		INSERT IN ARRAY:C227(aWoOrdLn; $2; $3)
		INSERT IN ARRAY:C227(aWoPublish; $2; $3)
		INSERT IN ARRAY:C227(aWoTemplateUniqueID; $2; $3)
		INSERT IN ARRAY:C227(aWOAddress1; $2; $3)
		INSERT IN ARRAY:C227(aWOCompany; $2; $3)
		
	: ($1=-4)  //Fill a record
		[WorkOrder:66]cause:27:=aWoCause{$2}
		[WorkOrder:66]idNumTask:22:=aWoOrdertaskID{$2}
		[WorkOrder:66]seq:26:=aWoSeq{$2}
		[WorkOrder:66]rate:23:=aWoRate{$2}
		[WorkOrder:66]processCodes:24:=aWoCodeSeq{$2}
		[WorkOrder:66]description:3:=aWoDescrpt{$2}
		aWoDTNeed{$2}:=DateTime_DTTo(aWoDateNd{$2}; aWoTimeNd{$2})
		aWoDTCmpltd{$2}:=DateTime_DTTo(aWoDateCmp{$2}; aWoTimeCmp{$2})
		[WorkOrder:66]dtAction:5:=aWoDTNeed{$2}
		[WorkOrder:66]dtComplete:6:=aWoDTCmpltd{$2}
		[WorkOrder:66]actionBy:8:=aWoNameID{$2}
		[WorkOrder:66]activity:7:=aWoActivity{$2}
		[WorkOrder:66]comment:17:=aWoComment{$2}
		[WorkOrder:66]durationPlanned:10:=aWoDurationPlan{$2}
		[WorkOrder:66]codeID:25:=aWoNature{$2}
		[WorkOrder:66]lineRefNum:20:=aWoOrdLn{$2}
		[WorkOrder:66]publish:30:=aWoPublish{$2}
		[WorkOrder:66]ideTemplate:57:=aWoTemplateUniqueID{$2}
		//
		[WorkOrder:66]company:36:=aWOCompany{$2}
		[WorkOrder:66]address1:50:=aWOAddress1{$2}
		//
	: ($1=-5)  //array to selection
		READ WRITE:C146([WorkOrder:66])
		
		C_TEXT:C284($custID)
		C_LONGINT:C283($taskID)
		
		
		ARRAY LONGINT:C221(aWoDTNeed; $sizeRay)
		ARRAY LONGINT:C221(aWoDTCmpltd; $sizeRay)
		ARRAY TEXT:C222(aTmp10Str1; $sizeRay)
		ARRAY LONGINT:C221(aTmpLong1; $sizeRay)
		If ($sizeRay>0)
			For ($incRay; 1; $sizeRay)
				// aTmp10Str1{$incRay}:=
				aWoOrdertaskID{$incRay}:=[Order:3]idNum:2
				aWoDTNeed{$incRay}:=DateTime_DTTo(aWoDateNd{$incRay}; aWoTimeNd{$incRay})
				aWoDTCmpltd{$incRay}:=DateTime_DTTo(aWoDateCmp{$incRay}; aWoTimeCmp{$incRay})
				aTmpLong1{$incRay}:=CounterNew(->[WorkOrder:66])
				
				//ARRAY TO SELECTION(aWoCause;[WorkOrder]Cause;aWoOrdertaskID;[WorkOrder]taskID;aWoSeq;[WorkOrder]Sequence;aWoRate;[WorkOrder]Rate;aWoCodeSeq;[WorkOrder]ProcessCodes;aWoDescrpt;[WorkOrder]Description;aWoDTNeed;[WorkOrder]DTAction;aWoDTCmpltd;[WorkOrder]DTCompleted;aWoPublish;[WorkOrder]Publish;aWoTemplateUniqueID;[WorkOrder]TemplateUniqueID)
				//ARRAY TO SELECTION(aWoNameID;[WorkOrder]NameActionNext;aWoActivity;[WorkOrder]Activity;aWoOrdLn;[WorkOrder]LineRefNum;aWoComment;[WorkOrder]Comment;aWoOrdertaskID;[WorkOrder]taskID;aWoDurationPlan;[WorkOrder]DurationPlanned;aWoNature;[WorkOrder]codeID;aTmp10Str1;[WorkOrder]customerID;aTmpLong1;[WorkOrder]WONum)
				//ARRAY TO SELECTION(aWOCompany;[WorkOrder]Company;aWOAddress1;[WorkOrder]Address1)
				
				//. aWoOrdertaskID
				[WorkOrder:66]customerID:28:=$custID
				[WorkOrder:66]idNumTask:22:=$taskID
				
				
				[WorkOrder:66]activity:7:=aWoActivity{$incRay}
				[WorkOrder:66]address1:50:=aWoAddress1{$incRay}
				[WorkOrder:66]cause:27:=aWoCause{$incRay}
				[WorkOrder:66]codeID:25:=aWoNature{$incRay}
				[WorkOrder:66]comment:17:=aWoComment{$incRay}
				[WorkOrder:66]company:36:=aWOCompany{$incRay}
				[WorkOrder:66]description:3:=aWoDescrpt{$incRay}
				[WorkOrder:66]dtAction:5:=aWoDTNeed{$incRay}
				[WorkOrder:66]dtComplete:6:=aWoDTCmpltd{$incRay}
				[WorkOrder:66]durationPlanned:10:=aWoDurationPlan{$incRay}
				[WorkOrder:66]lineRefNum:20:=aWoOrdLn{$incRay}
				[WorkOrder:66]actionBy:8:=aWoNameID{$incRay}
				[WorkOrder:66]processCodes:24:=aWoCodeSeq{$incRay}
				[WorkOrder:66]publish:30:=aWoPublish{$incRay}
				[WorkOrder:66]rate:23:=aWoRate{$incRay}
				[WorkOrder:66]seq:26:=aWoSeq{$incRay}
				[WorkOrder:66]ideTemplate:57:=aWoTemplateUniqueID{$incRay}
				// [WorkOrder]WONum:=aTmpLong1{$incRay}
				
			End for 
			
			SELECTION TO ARRAY:C260([WorkOrder:66]; aWoRecNum)
		End if 
		ARRAY TEXT:C222(aTmp10Str1; 0)
		READ ONLY:C145([WorkOrder:66])
		UNLOAD RECORD:C212([WorkOrder:66])
		//
	: ($1=-15)  //array to selection
		C_LONGINT:C283($taskID)
		C_TEXT:C284($customerID)
		READ WRITE:C146([WorkOrder:66])
		$customerID:=[Customer:2]customerID:1
		$sizeRay:=Size of array:C274(aWoRecNum)
		If ($sizeRay>0)
			For ($incRay; 1; $sizeRay)
				
				CREATE RECORD:C68([WorkOrder:66])
				
				Case of 
					: (aWoOrdertaskID{$incRay}#0)
					: ((ptCurTable=(->[Order:3])) | (ptCurTable=(->[Base:1])))
						TaskIDAssign(->[Order:3]idNumTask:85)
						aWoOrdertaskID{$incRay}:=[Order:3]idNumTask:85
						$customerID:=[Order:3]customerID:1
					: (ptCurTable=(->[Proposal:42]))
						TaskIDAssign(->[Proposal:42]idNumTask:70)
						aWoOrdertaskID{$incRay}:=[Proposal:42]idNumTask:70
						$customerID:=[Proposal:42]customerID:1
				End case 
				//aWoOrdertaskID{$incRay}:=[Order]OrderNum
				aWoDTNeed{$incRay}:=DateTime_DTTo(aWoDateNd{$incRay}; aWoTimeNd{$incRay})
				aWoDTCmpltd{$incRay}:=DateTime_DTTo(aWoDateCmp{$incRay}; aWoTimeCmp{$incRay})
				
				// [WorkOrder]WONum:=
				[WorkOrder:66]customerID:28:=$customerID
				
				[WorkOrder:66]cause:27:=aWoCause{$incRay}
				[WorkOrder:66]idNumTask:22:=aWoOrdertaskID{$incRay}
				[WorkOrder:66]seq:26:=aWoSeq{$incRay}
				[WorkOrder:66]rate:23:=aWoRate{$incRay}
				[WorkOrder:66]processCodes:24:=aWoCodeSeq{$incRay}
				[WorkOrder:66]description:3:=aWoDescrpt{$incRay}
				[WorkOrder:66]dtAction:5:=aWoDTNeed{$incRay}
				[WorkOrder:66]dtComplete:6:=aWoDTCmpltd{$incRay}
				[WorkOrder:66]publish:30:=aWoPublish{$incRay}
				[WorkOrder:66]ideTemplate:57:=aWoTemplateUniqueID{$incRay}
				[WorkOrder:66]actionBy:8:=aWoNameID{$incRay}
				[WorkOrder:66]activity:7:=aWoActivity{$incRay}
				[WorkOrder:66]lineRefNum:20:=aWoOrdLn{$incRay}
				[WorkOrder:66]comment:17:=aWoComment{$incRay}
				[WorkOrder:66]idNumTask:22:=aWoOrdertaskID{$incRay}
				[WorkOrder:66]durationPlanned:10:=aWoDurationPlan{$incRay}
				[WorkOrder:66]codeID:25:=aWoNature{$incRay}
				
				[WorkOrder:66]company:36:=aWOCompany{$incRay}
				[WorkOrder:66]address1:50:=aWoAddress1{$incRay}
			End for 
			
			SELECTION TO ARRAY:C260([WorkOrder:66]; aWoRecNum)
		End if 
		C_LONGINT:C283($incWO; $cntWO; $sizeRay)
		$cntWO:=Size of array:C274(aWoRecNum)
		
		For ($incWO; 1; $cntWO)
			GOTO RECORD:C242([WorkOrder:66]; aWoRecNum{$incWO})
			Case of 
				: ((ptCurTable=(->[Order:3])) | (ptCurTable=(->[Base:1])))
					If ([WorkOrder:66]idNumTask:22=0)
						TaskIDAssign(->[Order:3]idNumTask:85)
						[WorkOrder:66]idNumTask:22:=[Order:3]idNumTask:85
					End if 
					WoAddressLoad("Order")
				: (ptCurTable=(->[Proposal:42]))
					If ([WorkOrder:66]idNumTask:22=0)
						TaskIDAssign(->[Proposal:42]idNumTask:70)
						[WorkOrder:66]idNumTask:22:=[Proposal:42]idNumTask:70
					End if 
					WoAddressLoad("Proposal")
			End case 
			SAVE RECORD:C53([WorkOrder:66])
			//If (aWoTemplateUniqueID{$incWO}>0)
			
			//WOTemplate2Tasks ([WorkOrder]WONum;aWoTemplateUniqueID{$incWO})
			
		End for 
		ARRAY TEXT:C222(aTmp10Str1; 0)
		READ ONLY:C145([WorkOrder:66])
		UNLOAD RECORD:C212([WorkOrder:66])
		//
	: ($1=-6)  //Update an array
		aWoCause{$2}:=[WorkOrder:66]cause:27
		aWoOrdertaskID{$2}:=[WorkOrder:66]idNumTask:22
		aWoSeq{$2}:=[WorkOrder:66]seq:26
		aWoRate{$2}:=[WorkOrder:66]rate:23
		aWoCodeSeq{$2}:=[WorkOrder:66]processCodes:24
		aWoDescrpt{$2}:=[WorkOrder:66]description:3
		aWoDTNeed{$2}:=[WorkOrder:66]dtAction:5
		aWoDTCmpltd{$2}:=[WorkOrder:66]dtComplete:6
		aWoNameID{$2}:=[WorkOrder:66]actionBy:8
		aWoActivity{$2}:=[WorkOrder:66]activity:7
		aWoComment{$2}:=[WorkOrder:66]comment:17
		aWoOrdertaskID{$2}:=[WorkOrder:66]idNumTask:22
		aWoDurationPlan{$2}:=[WorkOrder:66]durationPlanned:10
		aWoNature{$2}:=[WorkOrder:66]codeID:25
		aWoOrdLn{$2}:=[WorkOrder:66]lineRefNum:20
		aWoPublish{$2}:=[WorkOrder:66]publish:30
		aWoTemplateUniqueID{$2}:=[WorkOrder:66]ideTemplate:57
		aWOCompany{$2}:=[WorkOrder:66]company:36
		aWOAddress1{$2}:=[WorkOrder:66]address1:50
		
		DateTime_DTFrom(aWoDTNeed{$2}; ->aWoDateNd{$2}; ->aWoTimeNd{$2})
		DateTime_DTFrom(aWoDTCmpltd{$2}; ->aWoDateCmp{$2}; ->aWoTimeCmp{$2})
		
		
	: ($1=-7)
		If (Size of array:C274(aWoTimeNd)>0)
			//If (Is macOS)
			//COPY ARRAY(aWoTimeNd;aTmpLong1)
			////      DA_Sort(">";aWoTimeNd;aWoCause;aWoOrdertaskID;aWoSeq;aWoRate
			//;aWoCodeSeq;aWoDesc
			////     DA_Sort(">";aTmpLong1;aWoActivity;aWoComment;aWoOrdertaskID
			//;aWoDurationPlan;aWoNature;aW
			//ARRAY LONGINT(aTmpLong1;0)
			//Else 
			COPY ARRAY:C226(aWoTimeNd; aTmpLong1)
			SORT ARRAY:C229(aWoTimeNd; aWoCause; aWoOrdertaskID; aWoSeq; aWoRate; aWoCodeSeq; aWoDescrpt; aWoNameID; aWoDateNd; aWoPublish; aWoDurationPlan; aWOCompany)
			SORT ARRAY:C229(aTmpLong1; aWoActivity; aWoComment; aWoOrdertaskID; aWoNature; aWoOrdLn; aWoRecNum; aWoDateCmp; aWoTimeCmp; aWoTemplateUniqueID; aWOAddress1)
			ARRAY LONGINT:C221(aTmpLong1; 0)
			//End if 
		End if 
	: ($1=-8)
		WoAddressLoad("Order")
		[WorkOrder:66]actionBy:8:=<>aNameID{<>aNameID}
		[WorkOrder:66]activity:7:=<>aActivities{<>aActivities}
		//
		[WorkOrder:66]seq:26:=1
		[WorkOrder:66]rate:23:=[WOTemplate:69]rate:5
		[WorkOrder:66]unitCost:19:=[Item:4]priceA:2
		[WorkOrder:66]phone:56:=[Order:3]phone:67
		[WorkOrder:66]publish:30:=1
		//
		[WorkOrder:66]dtAction:5:=DateTime_DTTo(vDate9; vTime9)
		//[WorkOrder]codeID:="p"
		[WorkOrder:66]customerID:28:=[Order:3]customerID:1
		SAVE RECORD:C53([WorkOrder:66])
		If ((schWOTypeNum>1) & (schWOTypeNum<=Size of array:C274(<>aWoTypes)))
			WOTemplate2Tasks([WorkOrder:66]idNum:29; <>aWoTypes{schWOTypeNum})
		End if 
End case 
