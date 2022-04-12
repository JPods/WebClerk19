Case of 
	: ((ALProEvt=1) | (ALProEvt=2))
		C_LONGINT:C283($error; $col; $row)
		
		// old method
		////  CHOPPED  AL_GetCurrCell (eSrchPat;$col;$row)
		//aQueryFieldNames:=$row
		//: ((ALProEvt=-5)|(ALProEvt=-1))//Line has been dragged  
		// ### jwm ### 20150807_1221
		ARRAY LONGINT:C221(aRows; 0)
		//  CHOPPED  $error:=AL_GetObjects(eSrchPat; ALP_Object_Selection; aRows)  //get the rows selected by userARRAY LONGINT(aRows;0)
		If (Size of array:C274(aRows)>0)
			aQueryFieldNames:=aRows{1}  // set selected Row of aaray
			$row:=aRows{1}
		End if 
		
End case 
ALProEvt:=0

