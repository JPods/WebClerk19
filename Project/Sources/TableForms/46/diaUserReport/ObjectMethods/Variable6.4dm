Case of 
	: (ALProEvt=0)  // no action
	: (ALProEvt=1)  // single click
		//  CHOPPED  $error:=AL_GetSelect(eReportList; aRptLines)
	: (ALProEvt=2)  // double click
		KeyModifierCurrent
		//  CHOPPED  $error:=AL_GetSelect(eReportList; aRptLines)
		CANCEL:C270
		If ((OptKey=1) & (aWhens{aRptLines{1}}#"Internal"))
			myOK:=3
		Else 
			myOK:=1
		End if 
	: (ALProEvt=-1)  // user Sort Button
	: (ALProEvt=-2)  // Edit Menu Select All
	: (ALProEvt=-3)  // user resizes a column
	: (ALProEvt=-4)  // column lock changed
	: (ALProEvt=-5)  // Row dragged
	: (ALProEvt=-6)  // Sort Editor
	: (ALProEvt=-7)  // Column Dragged
	: (ALProEvt=-8)  // Cell Dragged
	: (ALProEvt=-9)  // Object and window resized
End case 
ALProEvt:=0
