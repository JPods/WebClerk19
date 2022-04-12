//%attributes = {"publishedWeb":true}
//Procedure: TC_FillArrays
C_LONGINT:C283($1; $i; $k; $2; $3)
C_DATE:C307(vdDateBeg; vdDateEnd)
Case of 
	: ($1=0)
		C_LONGINT:C283($1)
		ARRAY TEXT:C222(aTCNameID; $1)  //name rays
		ARRAY TEXT:C222(aTCSignedIN; $1)  //complete bullets
		ARRAY LONGINT:C221(aTCTimeIn; $1)
		ARRAY LONGINT:C221(aTCTimeOut; $1)
		ARRAY DATE:C224(aTCDateIn; $1)
		ARRAY DATE:C224(aTCDateOut; $1)
		ARRAY LONGINT:C221(aTCLapsed; $1)
		ARRAY REAL:C219(aTCHourWage; $1)  //rates
		ARRAY REAL:C219(aTCExtWage; $1)
		ARRAY TEXT:C222(aTCActivity; $1)  //ActRay
		ARRAY LONGINT:C221(aTCOrdNum; $1)
		ARRAY TEXT:C222(aTCComment; $1)
		ARRAY LONGINT:C221(aTCTimeRecs; $1)
		ARRAY TEXT:C222(aTCCause; $1)
		ARRAY LONGINT:C221(aTCOrdLn; $1)
		ARRAY LONGINT:C221(aTCPerCent; $1)
		//
		ARRAY LONGINT:C221(aTCSelLns; 0)
		ARRAY LONGINT:C221(aOrdTimeLns; 0)
	: ($1>0)
		SELECTION TO ARRAY:C260([Time:56]cause:16; aTCCause; [Time:56]nameID:1; aTCNameID; [Time:56]complete:11; aTCSignedIN; [Time:56]timeIn:4; aTCTimeIn; [Time:56]timeOut:5; aTCTimeOut; [Time:56]dateIn:6; aTCDateIn)
		SELECTION TO ARRAY:C260([Time:56]dateOut:7; aTCDateOut; [Time:56]lapseTime:8; aTCLapsed; [Time:56]rate:9; aTCHourWage; [Time:56]totalDollars:12; aTCExtWage; [Time:56]activity:10; aTCActivity)
		SELECTION TO ARRAY:C260([Time:56]orderNum:3; aTCOrdNum; [Time:56]salesOrdLine:17; aTCOrdLn; [Time:56]comment:15; aTCComment; [Time:56]perCentActive:18; aTCPerCent; [Time:56]; aTCTimeRecs)
		//For ($inc;1;$1)
		//aTCTimeIn{$i}:=aTCTimeIn{$i}*1
		//aTCTimeOut{$i}:=aTCTimeOut{$i}*1
		//aTCLapsed{$i}:=aTCLapsed{$i}*1
		//End for 
		//
		ARRAY LONGINT:C221(aTCSelLns; 0)
	: ($1=-4)  //fill specific record
		[Time:56]cause:16:=aTCCause{$2}
		[Time:56]nameID:1:=aTCNameID{$2}
		[Time:56]complete:11:=aTCSignedIN{$2}
		[Time:56]timeIn:4:=aTCTimeIn{$2}
		[Time:56]timeOut:5:=aTCTimeOut{$2}
		[Time:56]dateIn:6:=aTCDateIn{$2}
		[Time:56]dateOut:7:=aTCDateOut{$2}
		If (aTCPerCent{$2}=0)
			aTCPerCent{$2}:=100
		End if 
		[Time:56]perCentActive:18:=aTCPerCent{$2}
		[Time:56]lapseTime:8:=aTCLapsed{$2}
		[Time:56]rate:9:=aTCHourWage{$2}
		aTCExtWage{$2}:=Round:C94(aTCLapsed{$2}/3600*aTCPerCent{$2}*0.01*aTCHourWage{$2}; <>tcDecimalTt)
		[Time:56]totalDollars:12:=aTCExtWage{$2}
		[Time:56]activity:10:=aTCActivity{$2}
		[Time:56]orderNum:3:=aTCOrdNum{$2}
		[Time:56]comment:15:=aTCComment{$2}
		[Time:56]salesOrdLine:17:=aTCOrdLn{$2}
	: ($1=-5)  //array to selection
		
	: ($1=-3)  //add a line, $2 for $3 lines    
		//
		INSERT IN ARRAY:C227(aTCNameID; $2; $3)  //name rays
		INSERT IN ARRAY:C227(aTCSignedIN; $2; $3)  //complete bullets
		INSERT IN ARRAY:C227(aTCTimeIn; $2; $3)
		INSERT IN ARRAY:C227(aTCTimeOut; $2; $3)
		INSERT IN ARRAY:C227(aTCDateIn; $2; $3)
		INSERT IN ARRAY:C227(aTCDateOut; $2; $3)
		INSERT IN ARRAY:C227(aTCLapsed; $2; $3)
		INSERT IN ARRAY:C227(aTCHourWage; $2; $3)  //rates
		INSERT IN ARRAY:C227(aTCExtWage; $2; $3)
		INSERT IN ARRAY:C227(aTCActivity; $2; $3)  //ActRay
		INSERT IN ARRAY:C227(aTCOrdNum; $2; $3)
		INSERT IN ARRAY:C227(aTCComment; $2; $3)
		INSERT IN ARRAY:C227(aTCTimeRecs; $2; $3)
		INSERT IN ARRAY:C227(aTCCause; $2; $3)
		INSERT IN ARRAY:C227(aTCOrdLn; $2; $3)
		INSERT IN ARRAY:C227(aTCPerCent; $2; $3)
		//    
	: ($1=-1)  //delete a line, $2 for $3 lines
	: ($1=-6)  //Show Subset
		Ray_ShowSubSet(->aTCSelLns; ->aTCNameID; ->aTCSignedIN; ->aTCTimeIn; ->aTCTimeOut; ->aTCDateIn; ->aTCDateOut; ->aTCLapsed; ->aTCHourWage)  //rates
		Ray_ShowSubSet(->aTCSelLns; ->aTCExtWage; ->aTCActivity; ->aTCOrdNum; ->aTCComment; ->aTCTimeRecs; ->aTCCause; ->aTCOrdLn; ->aTCPerCent)
		ARRAY LONGINT:C221(aTCSelLns; 0)
		doSearch:=6
	: ($1=-7)  //Omit Subset
		Ray_OmitSubSet(->aTCSelLns; ->aTCNameID; ->aTCSignedIN; ->aTCTimeIn; ->aTCTimeOut; ->aTCDateIn; ->aTCDateOut; ->aTCLapsed; ->aTCHourWage)  //rates
		Ray_OmitSubSet(->aTCSelLns; ->aTCExtWage; ->aTCActivity; ->aTCOrdNum; ->aTCComment; ->aTCTimeRecs; ->aTCCause; ->aTCOrdLn; ->aTCPerCent)
		ARRAY LONGINT:C221(aTCSelLns; 0)
		doSearch:=6
End case 