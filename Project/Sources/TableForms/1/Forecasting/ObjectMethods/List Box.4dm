C_LONGINT:C283($i; $error)
Case of 
	: (Size of array:C274(aFCItem)=0)
		// trap and drop out
	: (ALProEvt=0)
	: (ALProEvt=1)
		ARRAY LONGINT:C221(aFCSelect; 0)
		//  CHOPPED  $error:=AL_GetSelect(eForeCast; aFCSelect)
		//aFCRecNum:=aFCSelect{Size of array(aFCSelect)}//GetAreaLine (eService
		//)     
		For ($i; 1; 11)
			$ptVar:=Get pointer:C304("vR"+String:C10($i))
			$ptVar->:=0
		End for 
		vL1:=0
		vL2:=0
		$firstDay:=Date_ThisMon(aFCActionDt{aFCSelect{1}}; 0)
		If (vCalendarBegin#$firstDay)
			//   CHOPPED CS_SetRange(eSerCal; $firstDay; !00-00-00!)
			vCalendarBegin:=$firstDay
		End if 
		If (aFCActionDt{aFCSelect{1}}#!00-00-00!)
			clickDate:=aFCActionDt{aFCSelect{1}}
			//  CHOPPED  CS_SetSelect(eSerCal; clickDate; clickDate; 1; aSerDtRay)
			//  CHOPPED   Area_Refresh(eSerCal)
		End if 
	: (ALProEvt=2)
		ARRAY LONGINT:C221(aFCSelect; 0)
		//  CHOPPED  $error:=AL_GetSelect(eForeCast; aFCSelect)
		//aFCRecNum:=aFCSelect{1}//GetAreaLine (eService)     
		Case of 
			: (aFCTypeTran{aFCSelect{1}}="Pp")
				REDUCE SELECTION:C351([Proposal:42]; 0)
				GOTO RECORD:C242([Proposal:42]; aFCRecNum{aFCSelect{1}})
				//MODIFY RECORD([Proposal])
				ProcessTableOpen(Table:C252(->[Proposal:42])*-1)
				doSearch:=1
			: (aFCTypeTran{aFCSelect{1}}="SO")
				REDUCE SELECTION:C351([Order:3]; 0)
				GOTO RECORD:C242([Order:3]; aFCRecNum{aFCSelect{1}})
				//MODIFY RECORD([Order])
				ProcessTableOpen(Table:C252(->[Order:3])*-1)
				doSearch:=1
			: (aFCTypeTran{aFCSelect{1}}="PO")
				REDUCE SELECTION:C351([PO:39]; 0)
				GOTO RECORD:C242([POLine:40]; aFCRecNum{aFCSelect{1}})
				QUERY:C277([PO:39]; [PO:39]idNum:5=[POLine:40]idNumPO:1)
				If (Records in selection:C76([PO:39])=1)
					//MODIFY RECORD([PO])
					ProcessTableOpen(Table:C252(->[PO:39])*-1)
				End if 
				doSearch:=1
			: (aFCTypeTran{aFCSelect{1}}="IT")
				REDUCE SELECTION:C351([Item:4]; 0)
				GOTO RECORD:C242([Item:4]; aFCRecNum{aFCSelect{1}})
				//MODIFY RECORD([Item])
				ProcessTableOpen(Table:C252(->[Item:4])*-1)
				doSearch:=1
			: (aFCTypeTran{aFCSelect{1}}="IV")
				REDUCE SELECTION:C351([Invoice:26]; 0)
				GOTO RECORD:C242([Invoice:26]; aFCRecNum{aFCSelect{1}})
				//MODIFY RECORD([Invoice])
				ProcessTableOpen(Table:C252(->[Invoice:26])*-1)
				doSearch:=1
			: (aFCTypeTran{aFCSelect{1}}="Sv")
				REDUCE SELECTION:C351([Service:6]; 0)
				GOTO RECORD:C242([Service:6]; aFCRecNum{aFCSelect{1}})
				//MODIFY RECORD([Service])
				ProcessTableOpen(Table:C252(->[Service:6])*-1)
				doSearch:=1
			: (aFCTypeTran{aFCSelect{1}}="WO")
				REDUCE SELECTION:C351([WorkOrder:66]; 0)
				GOTO RECORD:C242([WorkOrder:66]; aFCRecNum{aFCSelect{1}})
				//MODIFY RECORD([WorkOrder])
				ProcessTableOpen(Table:C252(->[WorkOrder:66])*-1)
				doSearch:=1
			: (aFCTypeTran{aFCSelect{1}}="Tr")
				REDUCE SELECTION:C351([TallyResult:73]; 0)
				GOTO RECORD:C242([TallyResult:73]; aFCRecNum{aFCSelect{1}})
				//MODIFY RECORD([TallyResult])
				ProcessTableOpen(Table:C252(->[TallyResult:73])*-1)
				doSearch:=1
		End case 
		ARRAY LONGINT:C221(aFCSelect; 0)
		//  CHOPPED  $error:=AL_GetSelect(eForeCast; aFCSelect)
	: (ALProEvt=-1)
	: (ALProEvt=-2)
		AL_CmdAll(->aFCRecNum; ->aFCSelect)
End case 
ALProEvt:=0