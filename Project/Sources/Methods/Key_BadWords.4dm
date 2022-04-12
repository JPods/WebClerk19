//%attributes = {"publishedWeb":true}
//Procedure: Key_BadWords
C_TEXT:C284($1)
C_POINTER:C301($2)
//
C_TIME:C306($myDoc)
C_TEXT:C284($thePath)
C_LONGINT:C283($p; $i; $k)
//  ARRAY TEXT(aBadWords;0)  do not set to empty so it can be run only once for a group of records
// Modified by: William James (2013-08-22T00:00:00)

ARRAY TEXT:C222(aText1; 0)
ARRAY TEXT:C222(aBadWords; 0)

If (False:C215)
	// See:  KeywordsSelectedToBadWords
End if 
C_LONGINT:C283($k)
QUERY:C277([TallyResult:73]; [TallyResult:73]purpose:2="BadKeyWords"; *)
QUERY:C277([TallyResult:73];  | [TallyResult:73]purpose:2="BadWords")
QUERY:C277([TallyResult:73];  & [TallyResult:73]name:1=$1)
$k:=Records in selection:C76([TallyResult:73])
If ($k=0)
	CREATE RECORD:C68([TallyResult:73])
	
	[TallyResult:73]name:1:=$1
	[TallyResult:73]purpose:2:="BadKeyWords"
	[TallyResult:73]textBlk1:5:="shit,fuck,slut,the,a,is,was,and,an"
	SAVE RECORD:C53([TallyResult:73])
	DB_ShowCurrentSelection(->[TallyResult:73])
Else   //  
	If ($k>1)
		DB_ShowCurrentSelection(->[TallyResult:73]; ""; 0; "Duplicates, Reduce to 1"; 1)
		REDUCE SELECTION:C351([TallyResult:73]; 1)
		LOAD RECORD:C52([TallyResult:73])
	End if 
	[TallyResult:73]textBlk1:5:=Replace string:C233([TallyResult:73]textBlk1:5; "\r"; ",")
	[TallyResult:73]textBlk1:5:=Replace string:C233([TallyResult:73]textBlk1:5; ";"; ",")
	[TallyResult:73]textBlk1:5:=Replace string:C233([TallyResult:73]textBlk1:5; ", "; ",")
	TextToArray([TallyResult:73]textBlk1:5; ->aText1; ",")
End if 
UNLOAD RECORD:C212([TallyResult:73])
If (Size of array:C274(aBadWords)=0)
	COPY ARRAY:C226(aText1; aBadWords)
Else 
	$k:=Size of array:C274(aText1)
	For ($i; 1; $k)
		$p:=Find in array:C230(aBadWords; aText1{$i})
		If ($p<1)
			APPEND TO ARRAY:C911(aBadWords; aText1{$i})
		End if 
	End for 
End if 

//  bill - james

