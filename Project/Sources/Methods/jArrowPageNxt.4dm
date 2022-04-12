//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/07/10, 18:49:25
// ----------------------------------------------------
// Method: jArrowPageNxt
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($cnt; $curPageNum; $allowedPageNum)
$allowedPageNum:=Size of array:C274(aPages)-1
$curPageNum:=aPages
If ($allowedPageNum>2)  //there are multiple pages in this layout
	If (aPages<$allowedPageNum)
		$cnt:=FORM Get current page:C276+1
	Else 
		$cnt:=1
	End if 
	vbNxPvPage:=True:C214
	aPages:=$cnt
	FORM GOTO PAGE:C247($cnt)
	aPagePath{Table:C252(ptCurTable)}:=$cnt
	Set_Window_Title
Else 
	BEEP:C151
End if 