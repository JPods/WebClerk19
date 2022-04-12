//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/07/10, 18:45:22
// ----------------------------------------------------
// Method: jArrowPagePrv
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($cnt; $curPageNum; $allowedPageNum)
$allowedPageNum:=Size of array:C274(aPages)-1
$curPageNum:=aPages
If ($allowedPageNum>2)
	If ($curPageNum>1)
		$cnt:=FORM Get current page:C276-1
	Else 
		$cnt:=$allowedPageNum
	End if 
	vbNxPvPage:=True:C214
	viPageChange:=aPages
	aPages:=$cnt
	aPagePath{Table:C252(ptCurTable)}:=$cnt
	FORM GOTO PAGE:C247($cnt)
	Set_Window_Title
Else 
	BEEP:C151
End if 