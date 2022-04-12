//%attributes = {"publishedWeb":true}
C_LONGINT:C283($k)
C_POINTER:C301($1)
C_BOOLEAN:C305($2)
MESSAGES OFF:C175
OBJECT SET ENABLED:C1123(bSubAdd; True:C214)
If (vHere>2)
	vHere:=vHere-1
Else 
	vHere:=2
End if 
iLoPagePopUpMenuBar($1)
jNxPvButtonSet

ARRAY LONGINT:C221(aPagePath; Get last table number:C254)
If (aPagePath{Table:C252(ptCurTable)}>0)
	aPages:=aPagePath{Table:C252(ptCurTable)}
Else 
	aPagePath{Table:C252(ptCurTable)}:=1
	aPages:=1
	FORM GOTO PAGE:C247(1)
End if 

If (ptCurTable#(->[Control:1]))
	Set_Window_Title($1)
End if 
If (vHere<=2)
	vInclTrue:=False:C215
End if 
SET MENU BAR:C67(iLoMenu; Current process:C322)  //;*)


MESSAGES ON:C181
curRecNum:=Selected record number:C246($1->)
//  End if 
booDuringDo:=True:C214
