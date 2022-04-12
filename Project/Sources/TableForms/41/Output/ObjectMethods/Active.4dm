
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-07-07T00:00:00, 11:26:41
// ----------------------------------------------------
// Method: [Counter].Output.Active
// Description
// Modified: 07/07/17
// 
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20180209_1514 check this for rewrite using STR_GetUniqueFieldNum

C_LONGINT:C283($rayInc; $rayCnt; $found)


$found:=0
$rayCnt:=Size of array:C274(<>aUniqueFieldNum)
For ($rayInc; 1; $rayCnt)
	If (<>aUniqueFieldNum{$rayInc}<0)
		QUERY:C277([QQQCounter:41]; [QQQCounter:41]TableName:2=Table name:C256($rayInc); *)
	Else 
		QUERY:C277([QQQCounter:41];  | ; [QQQCounter:41]TableName:2=Table name:C256($rayInc); *)
	End if 
End for 
QUERY:C277([QQQCounter:41])

