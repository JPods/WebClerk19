//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-08-26T00:00:00, 22:30:04
// ----------------------------------------------------
// Method: jsonTextBlockTojason
// Description
// Modified: 08/26/17
// 
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($working; $0; $1)
C_OBJECT:C1216($Object)
ARRAY OBJECT:C1221($arraySel; 0)
C_TEXT:C284($JsonString)

//  data consists of name/value pairs,
//  data is separated by commas,
//  objects are defined by braces {},
//  arrays are defined by brackets [ ].

//  {
//      "employees": [
//          { "firstName":"John" , "lastName":"Doe" },
//          { "firstName":"Anna" , "lastName":"Smith" },
//          { "firstName":"Peter" , "lastName":"Jones" }
//      ]
//  }

$working:=$1
C_LONGINT:C283($incRow; $cntRow)
C_LONGINT:C283($incRay; $cntRay)
TextToArray($working; ->aText1; "\r")
$cntRow:=Size of array:C274(aText1)
If ($cntRow>0)
	TextToArray(aText1{1}; ->aText2; "\t"; True:C214)  // header row 
	$cntRay:=Size of array:C274(aText2)
	ARRAY TEXT:C222($textArray; 0)
	For ($incRow; 2; $cntRow)  // execute on the number of rows
		TextToArray(aText1{$incRow}; ->aText3; "\t"; True:C214)
		If (Size of array:C274(aText3)=Size of array:C274(aText2))  // make sure data is square 
			For ($incRay; 1; $cntRay)  // process by size of the header array
				OB SET:C1220($Object; aText2{$incRay}; aText3{$incRay})  // header row matched to data under header
			End for 
			$ref_value:=OB Copy:C1225($Object)  //direct copy
			APPEND TO ARRAY:C911($arraySel; $ref_value)
		End if 
	End for 
	$0:=JSON Stringify array:C1228($arraySel; *)
End if 
