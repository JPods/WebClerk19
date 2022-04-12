//%attributes = {}

C_VARIANT:C1683($vvResult)
C_TEXT:C284($vtResult)
C_LONGINT:C283($viNum)
$viNum:=100
$vvResult:=Convert_TextToValue($viNum; Is text:K8:3)
$vvResult:=Convert_TextToValue("08/16/2021"; Is date:K8:7)
$vvResult:=Convert_TextToValue(String:C10(Current time:C178); Is time:K8:8)

If (False:C215)
	$now_d:=Current date:C33
	$now_h:=Current time:C178
	$stamp_t:=String:C10($now_d; ISO date:K1:8; $now_h)+"+01:00"  //France is UTC+1
	
	ASSERT:C1129(Date:C102($stamp_t)=$now_d)
	ASSERT:C1129(Time:C179($stamp_t)=$now_h)
End if 