//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: UtilFillMarkerLine
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
If (Count parameters:C259=0)
	$0:="\r"+"\r"+"//////"+"\r"+"\r"
Else 
	$0:="\r"+"\r"+"/// "+$1+" ///"+"\r"+"\r"
End if 