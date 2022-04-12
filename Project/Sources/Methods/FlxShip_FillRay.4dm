//%attributes = {"publishedWeb":true}
//Procedure: FlxShip_FillRay
C_LONGINT:C283($1)
C_LONGINT:C283($2)
Case of 
	: ($1=0)
		ARRAY TEXT:C222(aPartNum; 0)
		ARRAY TEXT:C222(aPartDesc; 0)
		ARRAY REAL:C219(aQtySold; 0)
		ARRAY TEXT:C222(aText1; 0)
		//
		ARRAY LONGINT:C221(aRayLines; 0)
	: ($1>0)
		If (Records in selection:C76([TallyResult:73])=1)
			If ([TallyResult:73]Purpose:2="PackList")
				
				
				
				
				
				
			End if 
		End if 
		//
		ARRAY LONGINT:C221(aRayLines; 0)
	: ($1=-1)
		DELETE FROM ARRAY:C228(aPartNum; $2; $3)
		DELETE FROM ARRAY:C228(aPartDesc; $2; $3)
		DELETE FROM ARRAY:C228(aQtySold; $2; $3)
		DELETE FROM ARRAY:C228(aText1; $2; $3)
		
	: ($1=-3)
		INSERT IN ARRAY:C227(aPartNum; $2; $3)
		INSERT IN ARRAY:C227(aPartDesc; $2; $3)
		INSERT IN ARRAY:C227(aQtySold; $2; $3)
		INSERT IN ARRAY:C227(aText1; $2; $3)
	: ($1=-7)  //update element
		
		
	: ($1=-8)  //update element
		
		
End case 