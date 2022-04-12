C_LONGINT:C283($error; $i; $sizeSelect)
Case of 
	: (ALProEvt=1)
		ARRAY LONGINT:C221(aFieldLns; 0)
		//  CHOPPED  $error:=AL_GetSelect(eExportFlds; aFieldLns)
	: (ALProEvt=2)
		ARRAY LONGINT:C221(aFieldLns; 0)
		//  CHOPPED  $error:=AL_GetSelect(eExportFlds; aFieldLns)
		If (theTypes{aFieldLns{1}}="z")
			GOTO RECORD:C242([TallyMaster:60]; theFldNum{aFieldLns{1}})
			jExpImpLoad("Export Pattern"; "SYLK")
			//  --  CHOPPED  AL_UpdateArrays(eExportFlds; -2)
			// -- AL_SetSort(eExportFlds; 1)
			
			//  --  CHOPPED  AL_UpdateArrays(eMatchList; -2)
		Else 
			MatchAdd(False:C215; Size of array:C274(aMatchType))
		End if 
	: ((ALProEvt=-5) | (ALProEvt=-1))  //Line has been dragged     
		ARRAY LONGINT:C221(aFieldLns; 0)
		//  CHOPPED  $error:=AL_GetSelect(eExportFlds; aFieldLns)
		//  : (ALProEvt=-1)//Sort Button
	: (ALProEvt=-2)  // AreaList SelectAll commandA Command A
		AL_CmdAll(->theFields; ->aFieldLns)  // array of values in the areaList, selected array
	: (ALProEvt=-3)  //Column Resize    
	: (ALProEvt=-4)  //Column Lock Changed
	: ((ALProEvt=-5) | (ALProEvt=-1))  //Line has been dragged    
	: (ALProEvt=-6)  //User invoked Sort Editor          
		
End case 
ALProEvt:=0

