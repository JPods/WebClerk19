//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/11/09, 12:01:40
// ----------------------------------------------------
// Method: Text2Base64
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($0; $1)
C_BLOB:C604($theBlob)
TEXT TO BLOB:C554($1; $theBlob; 3)
BASE64 DECODE:C896($theBlob)
$0:=BLOB to text:C555($theBlob; 3)
