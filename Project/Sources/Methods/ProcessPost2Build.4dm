//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/04/06, 11:14:27
// ----------------------------------------------------
// Method: ProcessPost2Build
// Description
// 
//
// Parameters
// ----------------------------------------------------



Prs_ListActive
ARRAY TEXT:C222(iLoaText1; 0)
ARRAY LONGINT:C221(iLoaLongInt1; 0)
$cntRay:=Size of array:C274(<>aPrsName)
For ($incRay; 1; $cntRay)
	Case of 
		: (<>aPrsName{$incRay}="Processes")
			
			
			
		: ((<>aPrsName{$incRay}="Sales@") | (<>aPrsName{$incRay}="Productio@") | (<>aPrsName{$incRay}="Admin@"))
			INSERT IN ARRAY:C227(iLoaText1; 1; 1)
			INSERT IN ARRAY:C227(iLoaLongInt1; 1; 1)
			iLoaText1{1}:=<>aPrsName{$incRay}
			iLoaLongInt1{1}:=<>aPrsNum{$incRay}
		: ((<>aPrsName{$incRay}="@item@") | (<>aPrsName{$incRay}="@ord@") | (<>aPrsName{$incRay}="@So@") | (<>aPrsName{$incRay}="@purch@") | (<>aPrsName{$incRay}="@PO@") | (<>aPrsName{$incRay}="@Pro@") | (<>aPrsName{$incRay}="@PP@"))
			INSERT IN ARRAY:C227(iLoaText1; 1; 1)
			INSERT IN ARRAY:C227(iLoaLongInt1; 1; 1)
			iLoaText1{1}:=<>aPrsName{$incRay}
			iLoaLongInt1{1}:=<>aPrsNum{$incRay}
	End case 
End for 
SORT ARRAY:C229(iLoaText1; iLoaLongInt1)
INSERT IN ARRAY:C227(iLoaText1; 1; 1)
INSERT IN ARRAY:C227(iLoaLongInt1; 1; 1)
iLoaText1{1}:="Post to:"
iLoaLongInt1{1}:=-1