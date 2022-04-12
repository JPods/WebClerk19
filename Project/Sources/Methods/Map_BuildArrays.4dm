//%attributes = {"publishedWeb":true}
C_TEXT:C284($1; $2)  //("Bio";"HTML")
C_LONGINT:C283($0)
//Method: Map_BuildArrays
//Map_BuildArrays("Bio";"HTML")
ARRAY TEXT:C222(aMapBeginTag; 0)
ARRAY TEXT:C222(aMapEndTag; 0)
ARRAY TEXT:C222(aMapControlTag; 0)
If ($1#"")
	QUERY:C277([Map:84]; [Map:84]Category:12=$1)
	Case of 
		: ($2="HTML")
			SELECTION TO ARRAY:C260([Map:84]HTMLTag:2; aMapBeginTag; [Map:84]endingHTML:8; aMapEndTag; [Map:84]Value:13; aMapControlTag)
		: ($2="XTAGS")
			SELECTION TO ARRAY:C260([Map:84]ControllingTag:1; aMapBeginTag; [Map:84]endingXtag:7; aMapEndTag; [Map:84]Value:13; aMapControlTag)
		: ($2="rtf")
			SELECTION TO ARRAY:C260([Map:84]Path:3; aMapBeginTag; [Map:84]endingRTF:9; aMapEndTag; [Map:84]Value:13; aMapControlTag)
	End case 
End if 
$0:=Size of array:C274(aMapBeginTag)