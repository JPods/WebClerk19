//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method:Method: PKAlertWindow
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//
C_LONGINT:C283(showErrorMessage)
If (showErrorMessage=1)
	Open window:C153(200; 200; 680; 439; 1; "PKAlert"; "Wind_CloseBox")
	DIALOG:C40([Control:1]; "PKAlert")
	CLOSE WINDOW:C154
	errorComment:=""
End if 