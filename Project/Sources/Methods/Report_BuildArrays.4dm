//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/21/11, 22:34:20
// ----------------------------------------------------
// Method: Report_BuildArrays
// Description
// 
//
// Parameters
// ----------------------------------------------------

vi2:=Records in selection:C76([Invoice:26])
ORDER BY:C49([Invoice:26]; [Invoice:26]salesNameID:23)
FIRST RECORD:C50([Invoice:26])
ARRAY TEXT:C222(aText1; 0)
ARRAY REAL:C219(aReal1; 0)
ARRAY REAL:C219(aReal2; 0)
ARRAY REAL:C219(aReal3; 0)
ARRAY REAL:C219(aReal4; 0)
ARRAY REAL:C219(aReal5; 0)
ARRAY REAL:C219(aReal6; 0)
vi1:=0
Repeat 
	vText1:=[Invoice:26]salesNameID:23  //control calculation based on [Invoice]SalesName
	APPEND TO ARRAY:C911(aText1; vText1)
	APPEND TO ARRAY:C911(aReal1; 0)
	APPEND TO ARRAY:C911(aReal2; 0)
	APPEND TO ARRAY:C911(aReal3; 0)
	APPEND TO ARRAY:C911(aReal4; 0)
	APPEND TO ARRAY:C911(aReal5; 0)
	APPEND TO ARRAY:C911(aReal6; 0)
	vi3:=Size of array:C274(aText1)
	Repeat 
		vi1:=vi1+1
		aReal1{vi3}:=aReal1{vi3}+1  //count of invoices
		aReal2{vi3}:=aReal2{vi3}+[Invoice:26]amount:14
		aReal3{vi3}:=aReal3{vi3}+[Invoice:26]total:18
		aReal4{vi3}:=aReal4{vi3}+[Invoice:26]totalCost:37
		aReal5{vi3}:=aReal5{vi3}+[Invoice:26]total:18-[Invoice:26]totalCost:37  //margin $
		aReal6{vi3}:=aReal6{vi3}+[Invoice:26]balanceDue:44
		NEXT RECORD:C51([Invoice:26])
	Until (([Invoice:26]salesNameID:23#vText1) | (vi1=vi2))
Until (vi1=vi2)
