//%attributes = {"publishedWeb":true}
//ARRAY TEXT(<>aTechNoteNames;0)
//ARRAY LONGINT(<>aTechNoteRec;0)
//ARRAY LONGINT(<>aTechNoteScroll;0)//
//
C_LONGINT:C283($1; $scroll)
//
If (Count parameters:C259=1)
	$scroll:=$1
Else 
	$scroll:=0
End if 
C_LONGINT:C283($w)
$w:=Find in array:C230(<>aTechNoteRec; Record number:C243([TechNote:58]))
If ($w=-1)
	If (Size of array:C274(<>aTechNoteRec)>14)
		DELETE FROM ARRAY:C228(<>aTechNoteNames; 15; 1)
		DELETE FROM ARRAY:C228(<>aTechNoteRec; 15; 1)
		DELETE FROM ARRAY:C228(<>aTechNoteScroll; 15; 1)
	End if 
Else 
	DELETE FROM ARRAY:C228(<>aTechNoteNames; $w; 1)
	DELETE FROM ARRAY:C228(<>aTechNoteRec; $w; 1)
	DELETE FROM ARRAY:C228(<>aTechNoteScroll; $w; 1)
End if 
INSERT IN ARRAY:C227(<>aTechNoteNames; 1; 1)
INSERT IN ARRAY:C227(<>aTechNoteRec; 1; 1)
INSERT IN ARRAY:C227(<>aTechNoteScroll; 1; 1)
<>aTechNoteNames{1}:=[TechNote:58]Name:2
<>aTechNoteRec{1}:=Record number:C243([TechNote:58])
<>aTechNoteScroll{1}:=$scroll