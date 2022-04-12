// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/08/10, 08:18:29
// ----------------------------------------------------
// Method: Object Method: eSrchRecs
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($error; $i; $sizeSelect)
Case of 
	: (ALProEvt=1)
		//  CHOPPED  aTmp20Str1:=AL_GetLine(eSrchRecs)
		GOTO RECORD:C242([TallyMaster:60]; aTmpLong1{aTmp20Str1})
		vText1:=[TallyMaster:60]script:9
		UNLOAD RECORD:C212([TallyMaster:60])
		
		KeyModifierCurrent
		If (OptKey=1)
			C_BOOLEAN:C305($inGroup)
			$inGroup:=UserInPassWordGroup("UnlockRecord")
			If ($inGroup=False:C215)
				CANCEL:C270
				ProcessTableOpen(Table:C252(->[TallyMaster:60])*-1)
			End if 
		End if 
		
	: (ALProEvt=2)
		//  CHOPPED  aTmp20Str1:=AL_GetLine(eSrchRecs)
		GOTO RECORD:C242([TallyMaster:60]; aTmpLong1{aTmp20Str1})
		ExecuteText(0; [TallyMaster:60]script:9)
		booSorted:=True:C214
		CANCEL:C270
		//: ((ALProEvt=-5)|(ALProEvt=-1))//Line has been dragged        
End case 
ALProEvt:=0