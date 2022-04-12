//%attributes = {"publishedWeb":true}
//Procedure: Call_FillArrays
C_LONGINT:C283($1; $2; $3; $incRay; $sizeRay)
// $1=0 of clear, >0 to fill, =-1 to delete element, -3 new element
//, -4 update, -5 selection to array
Case of 
	: ($1=0)
		ARRAY TEXT:C222(aCLNameID; $1)
		ARRAY BOOLEAN:C223(aCLLtr; $1)
		ARRAY BOOLEAN:C223(aClPhone; $1)
		ARRAY BOOLEAN:C223(aCLMessage; $1)
		ARRAY BOOLEAN:C223(aCLFax; $1)
		ARRAY BOOLEAN:C223(aCLVisit; $1)
		ARRAY DATE:C224(aCLDate; $1)
		ARRAY TEXT:C222(aCLLtrName; $1)
		ARRAY TEXT:C222(aCLAction; $1)
		ARRAY TEXT:C222(aCLPath; $1)
		ARRAY LONGINT:C221(aCLRec; $1)
		//
		ARRAY LONGINT:C221(aCLRecSel; 0)
		//
	: ($1>0)
		SELECTION TO ARRAY:C260([CallReport:34]KeyText:20; aCLPath; [CallReport:34]DateCreate:17; aCLDate; [CallReport:34]ActionBy:3; aCLNameID; [CallReport:34]Letter:9; aCLLtr; [CallReport:34]PhoneBoolean:8; aClPhone; [CallReport:34]Message:12; aCLMessage; [CallReport:34]FAX:11; aCLFax; [CallReport:34]Visit:13; aCLVisit; [CallReport:34]Subject:14; aCLLtrName; [CallReport:34]Action:15; aCLAction; [CallReport:34]; aCLRec)
	: ($1=-1)
		
		
	: ($1=-3)  //new line
		
	: ($1=-4)  //update existing line in $2
		aCLNameID{$2}:=[CallReport:34]ActionBy:3
		aCLLtr{$2}:=[CallReport:34]Letter:9
		aClPhone{$2}:=[CallReport:34]PhoneBoolean:8
		aCLMessage{$2}:=[CallReport:34]Message:12
		aCLFax{$2}:=[CallReport:34]FAX:11
		aCLVisit{$2}:=[CallReport:34]Visit:13
		aCLLtrName{$2}:=[CallReport:34]Subject:14
		aCLAction{$2}:=[CallReport:34]Action:15
		aCLDate{$2}:=[CallReport:34]DateCreate:17
		aCLPath{$2}:=[CallReport:34]KeyText:20
	: ($1=-5)
		
		
End case 