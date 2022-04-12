// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 08/04/15, 14:26:10
// ----------------------------------------------------
// Method: [Default].DiaSearch.Variable8
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20150731_1355 change actions on single click


C_LONGINT:C283($error; $i; $sizeSelect)
Case of 
	: (ALProEvt=AL Single click event)
		ARRAY LONGINT:C221(aFieldLns; 0)
		//  CHOPPED  $error:=AL_GetSelect(eSrchFlds; aFieldLns)
		KeyModifierCurrent
		
		// ### jwm ### 20150731_1355 change actions on single click
		Case of 
			: (OptKey=1)
				doSearch:=12  // Value =  [Table]Field
			: (ShftKey=1)
				doSearch:=3  // Relace Field
			Else 
				doSearch:=8  // No Change
		End case 
		
		If (False:C215)
			If (OptKey=0)
				doSearch:=3  // ### jwm ### 20150731_1355 
			Else 
				doSearch:=12
			End if 
		End if 
		
		vText1:=""
	: (ALProEvt=AL Double click event)
		ARRAY LONGINT:C221(aFieldLns; 0)
		//  CHOPPED  $error:=AL_GetSelect(eSrchFlds; aFieldLns)
		doSearch:=2
		vText1:=""
		//: ((ALProEvt=-5)|(ALProEvt=-1))//Line has been dragged  
		
		
End case 
ALProEvt:=0