//%attributes = {"publishedWeb":true}
//Procedure: Tm_FixedArray
//July 8, 1996
C_LONGINT:C283($1; $2; $3; $incRay; $sizeRay)
Case of 
	: ($1=0)
		ARRAY LONGINT:C221(aTimeSlotBegb; 0)
		ARRAY LONGINT:C221(aTimeSlotEndb; 0)
		ARRAY TEXT:C222(aTimeSlotTypeb; 0)
		ARRAY TEXT:C222(aTimeSlotWhatb; 0)
		ARRAY TEXT:C222(aTimeSlotActionb; 0)
		ARRAY LONGINT:C221(aTimeSlotWORecb; 0)
		//
		ARRAY LONGINT:C221(aTimeSlotSelectLinesb; 0)  //;"aLsItemDesc"    
	: ($1>0)
		$sizeRay:=24*<>viTmIncr
		ARRAY LONGINT:C221(aTimeSlotBegb; $sizeRay)
		ARRAY LONGINT:C221(aTimeSlotEndb; $sizeRay)
		ARRAY TEXT:C222(aTimeSlotTypeb; $sizeRay)
		ARRAY TEXT:C222(aTimeSlotWhatb; $sizeRay)
		ARRAY TEXT:C222(aTimeSlotActionb; $sizeRay)
		ARRAY LONGINT:C221(aTimeSlotWORecb; $sizeRay)
		C_LONGINT:C283($increment; $i)
		$sizeRay:=Size of array:C274(aTimeSlotBegb)
		$increment:=3600/<>viTmIncr
		For ($i; 1; $sizeRay)
			aTimeSlotBegb{$i}:=Time:C179(Time string:C180($increment*($i-1)))*1
			aTimeSlotEndb{$i}:=0
			aTimeSlotTypeb{$i}:=""
			aTimeSlotWhatb{$i}:=""
			aTimeSlotActionb{$i}:=""
			aTimeSlotWORecb{$i}:=-1
		End for 
	: ($1=-1)  //delete an element
		DELETE FROM ARRAY:C228(aTimeSlotBegb; $2; $3)
		DELETE FROM ARRAY:C228(aTimeSlotEndb; $2; $3)
		DELETE FROM ARRAY:C228(aTimeSlotWhatb; $2; $3)
		DELETE FROM ARRAY:C228(aTimeSlotActionb; $2; $3)
		DELETE FROM ARRAY:C228(aTimeSlotWORecb; $2; $3)
	: ($1=-3)  //insert an element
		INSERT IN ARRAY:C227(aTimeSlotBegb; $2; $3)
		INSERT IN ARRAY:C227(aTimeSlotEndb; $2; $3)
		INSERT IN ARRAY:C227(aTimeSlotWhatb; $2; $3)
		INSERT IN ARRAY:C227(aTimeSlotActionb; $2; $3)
		INSERT IN ARRAY:C227(aTimeSlotWORecb; $2; $3)
	: ($1=-5)  //array to selection
End case 