//%attributes = {"publishedWeb":true}
//Procedure: Tm_SchFillRays
//July 8, 1996
C_LONGINT:C283($1; $2; $3; $incRay; $sizeRay)
Case of 
	: ($1=0)
		ARRAY LONGINT:C221(aTimeSlotBeg1; 0)
		ARRAY LONGINT:C221(aTimeSlotEnd1; 0)
		ARRAY TEXT:C222(aTimeSlotType1; 0)
		ARRAY TEXT:C222(aTimeSlotWhat1; 0)
		ARRAY TEXT:C222(aTimeSlotAction1; 0)
		ARRAY LONGINT:C221(aTimeSlotWORec1; 0)
		//
		ARRAY LONGINT:C221(aTimeSlotSelectLines1; 0)  //;"aLsItemDesc"    
		//
		ARRAY LONGINT:C221(aTimeSlotBeg2; 0)
		ARRAY LONGINT:C221(aTimeSlotEnd2; 0)
		ARRAY TEXT:C222(aTimeSlotType2; 0)
		ARRAY TEXT:C222(aTimeSlotWhat2; 0)
		ARRAY TEXT:C222(aTimeSlotAction2; 0)
		ARRAY LONGINT:C221(aTimeSlotWORec2; 0)
		//
		ARRAY LONGINT:C221(aTimeSlotSelectLines2; 0)  //;"aLsItemDesc"  
		//
		ARRAY LONGINT:C221(aTimeSlotBeg3; 0)
		ARRAY LONGINT:C221(aTimeSlotEnd3; 0)
		ARRAY TEXT:C222(aTimeSlotType3; 0)
		ARRAY TEXT:C222(aTimeSlotWhat3; 0)
		ARRAY TEXT:C222(aTimeSlotAction3; 0)
		ARRAY LONGINT:C221(aTimeSlotWORec3; 0)
		//
		ARRAY LONGINT:C221(aTimeSlotSelectLines3; 0)  //;"aLsItemDesc"  
		//    
		ARRAY LONGINT:C221(aTimeSlotBeg4; 0)
		ARRAY LONGINT:C221(aTimeSlotEnd4; 0)
		ARRAY TEXT:C222(aTimeSlotType4; 0)
		ARRAY TEXT:C222(aTimeSlotWhat4; 0)
		ARRAY TEXT:C222(aTimeSlotAction4; 0)
		ARRAY LONGINT:C221(aTimeSlotWORec4; 0)
		//
		ARRAY LONGINT:C221(aTimeSlotSelectLines4; 0)  //;"aLsItemDesc"  
		//
		
		//    
		ARRAY LONGINT:C221(aTimeSlotBeg5; 0)
		ARRAY LONGINT:C221(aTimeSlotEnd5; 0)
		ARRAY TEXT:C222(aTimeSlotType5; 0)
		ARRAY TEXT:C222(aTimeSlotWhat5; 0)
		ARRAY TEXT:C222(aTimeSlotAction5; 0)
		ARRAY LONGINT:C221(aTimeSlotWORec5; 0)
		//
		ARRAY LONGINT:C221(aTimeSlotSelectLines5; 0)  //;"aLsItemDesc"  
		//
	: ($1>0)
		//$sizeRay:=24*<>viTmIncr
		C_LONGINT:C283(viWOHours)
		C_TIME:C306(vWOStartTime)
		C_TEXT:C284($strDefault)
		If (viWOHours=0)
			$strDefault:=DefaultSetupsReturnValue("viWOHours")
			Case of 
				: ($strDefault="noRecord")
					
					viWOHours:=11
				: ($strDefault="duplicate")
					ALERT:C41("GoTo the Defaults record and delete duplicate viWOHours values.")
					viWOHours:=11
				Else 
					viWOHours:=Num:C11($strDefault)
			End case 
		End if 
		If (vWOStartTime=?00:00:00?)
			$strDefault:=DefaultSetupsReturnValue("vWOStartTime")
			Case of 
				: ($strDefault="noRecord")
					vWOStartTime:=?07:00:00?
				: ($strDefault="duplicate")
					ALERT:C41("GoTo the Defaults record and delete duplicate vWOStartTime values.")
					vWOStartTime:=?07:00:00?
				Else 
					vWOStartTime:=Time:C179($strDefault)
			End case 
		End if 
		$sizeRay:=viWOHours*<>viTmIncr
		$startTime:=?07:00:00?
		ARRAY LONGINT:C221(aTimeSlotBeg1; $sizeRay)
		ARRAY LONGINT:C221(aTimeSlotEnd1; $sizeRay)
		ARRAY TEXT:C222(aTimeSlotType1; $sizeRay)
		ARRAY TEXT:C222(aTimeSlotWhat1; $sizeRay)
		ARRAY TEXT:C222(aTimeSlotAction1; $sizeRay)
		ARRAY LONGINT:C221(aTimeSlotWORec1; $sizeRay)
		C_LONGINT:C283($increment; $i)
		$sizeRay:=Size of array:C274(aTimeSlotBeg1)
		$increment:=3600/<>viTmIncr
		For ($i; 1; $sizeRay)
			aTimeSlotBeg1{$i}:=vWOStartTime+Time:C179(Time string:C180($increment*($i-1)))*1
			aTimeSlotEnd1{$i}:=0
			aTimeSlotType1{$i}:=""
			aTimeSlotWhat1{$i}:=""
			aTimeSlotAction1{$i}:=""
			aTimeSlotWORec1{$i}:=-1
		End for 
		INSERT IN ARRAY:C227(aTimeSlotBeg1; 1; 1)
		aTimeSlotBeg1{1}:=0
		INSERT IN ARRAY:C227(aTimeSlotEnd1; 1; 1)
		aTimeSlotEnd1{1}:=vWOStartTime-1
		INSERT IN ARRAY:C227(aTimeSlotType1; 1; 1)
		INSERT IN ARRAY:C227(aTimeSlotWhat1; 1; 1)
		INSERT IN ARRAY:C227(aTimeSlotAction1; 1; 1)
		INSERT IN ARRAY:C227(aTimeSlotWORec1; 1; 1)
		
		COPY ARRAY:C226(aTimeSlotBeg1; aTimeSlotBeg2)
		COPY ARRAY:C226(aTimeSlotBeg1; aTimeSlotBeg3)
		COPY ARRAY:C226(aTimeSlotBeg1; aTimeSlotBeg4)
		COPY ARRAY:C226(aTimeSlotBeg1; aTimeSlotBeg5)
		//
		COPY ARRAY:C226(aTimeSlotEnd1; aTimeSlotEnd2)
		COPY ARRAY:C226(aTimeSlotEnd1; aTimeSlotEnd3)
		COPY ARRAY:C226(aTimeSlotEnd1; aTimeSlotEnd4)
		COPY ARRAY:C226(aTimeSlotEnd1; aTimeSlotEnd5)
		//
		COPY ARRAY:C226(aTimeSlotType1; aTimeSlotType2)
		COPY ARRAY:C226(aTimeSlotType1; aTimeSlotType3)
		COPY ARRAY:C226(aTimeSlotType1; aTimeSlotType4)
		COPY ARRAY:C226(aTimeSlotType1; aTimeSlotType5)
		//
		COPY ARRAY:C226(aTimeSlotWhat1; aTimeSlotWhat2)
		COPY ARRAY:C226(aTimeSlotWhat1; aTimeSlotWhat3)
		COPY ARRAY:C226(aTimeSlotWhat1; aTimeSlotWhat4)
		COPY ARRAY:C226(aTimeSlotWhat1; aTimeSlotWhat5)
		//
		COPY ARRAY:C226(aTimeSlotAction1; aTimeSlotAction2)
		COPY ARRAY:C226(aTimeSlotAction1; aTimeSlotAction3)
		COPY ARRAY:C226(aTimeSlotAction1; aTimeSlotAction4)
		COPY ARRAY:C226(aTimeSlotAction1; aTimeSlotAction5)
		//
		COPY ARRAY:C226(aTimeSlotWORec1; aTimeSlotWORec2)
		COPY ARRAY:C226(aTimeSlotWORec1; aTimeSlotWORec3)
		COPY ARRAY:C226(aTimeSlotWORec1; aTimeSlotWORec4)
		COPY ARRAY:C226(aTimeSlotWORec1; aTimeSlotWORec5)
		//    
	: ($1=-1)  //delete an element
		
	: ($1=-3)  //insert an element
		
	: ($1=-5)  //array to selection
End case 