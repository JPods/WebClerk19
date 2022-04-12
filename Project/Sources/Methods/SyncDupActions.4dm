//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1)
C_BOOLEAN:C305($2; $0)
$0:=True:C214  //unique or low risk
Case of 
	: ($1>0)
		ARRAY LONGINT:C221(aFndRecs; $1)
		FIRST RECORD:C50(aSyncFilePt{aSyncCnt}->)
		For ($i; 1; $1)
			aFndRecs{$i}:=Record number:C243(aSyncFilePt{aSyncCnt}->)
			NEXT RECORD:C51(aSyncFilePt{aSyncCnt}->)
		End for 
		FIRST RECORD:C50(aSyncFilePt{aSyncCnt}->)
		//    curRecNum:=Record number(aSyncFilePt{aSyncCnt})
		aFndRecs:=1
		vi3:=1
		SyncLoadArray(aSyncFilePt{aSyncCnt}; aSyncCnt; ->aText1)
		$0:=False:C215
	: (($1=0) & ($2))  //clear aText1 if in the single mode $2)
		ARRAY LONGINT:C221(aFndRecs; 0)
		vi3:=0
		ARRAY TEXT:C222(aText1; 0)
		ARRAY TEXT:C222(aText1; Size of array:C274(aText2))
		$0:=True:C214
		//For ($i;1;Size of array(aText1))
		//aText1{$i}:=""
		//End for 
	: ($1=0)
		ARRAY LONGINT:C221(aFndRecs; 0)
		vi3:=0
		$0:=True:C214
End case 
viRecordsInSelection:=$1