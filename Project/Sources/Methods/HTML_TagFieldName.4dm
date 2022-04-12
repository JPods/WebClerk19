//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: HTML_TagFieldName
	//Date: 07/01/02
	//Who: Bill
	//Description: for checking tags
End if 


C_TEXT:C284($0)
C_TEXT:C284($1; $2)
C_LONGINT:C283($numTable; $numField; $err)
$numTable:=Num:C11($1)
$numField:=Num:C11($2)

Case of 
	: ($1="begin")
		$0:="Beginning of Loop for: "+$2
	: ($1="end")
		$0:="End of Loop"
	: ($1="0")
		$foundTag:=Find in array:C230(aText1; $2)
		Case of 
			: ($foundTag>0)
				$0:=$2+";  Listed: "
			: (($2="vlBeenHere") | ($2="vleventID") | ($2="vlBeenHere"))
				$0:=$2+"; OK: "
			Else 
				$0:=$2+"; Not Listed: "
		End case 
		ptVar:=Get pointer:C304($2)
		theText:="//script"+"\r"+"vi9:=num(undefined(ptVar->))"
		ExecuteText(0; theText)
		If (vi9=1)  //$0:=$0+("fff: BAD DEFINITION"*vi9)+("Defined"*Num(vi9=0))
			$0:=$0+"fff: BAD DEFINITION"
		Else 
			$0:=$0+"Defined"
		End if 
	: (($numTable>0) & ($numTable<=Get last table number:C254))
		Case of 
			: ($numField=0)
				$0:="Selection Count, Table "+Table name:C256($numTable)
			: ($numField=-2)
				$0:="Record Count, Table "+Table name:C256($numTable)
			: (($numField>0) & ($numField<=Get last field number:C255($numTable)))
				$0:="["+Table name:C256($numTable)+"]"+Field name:C257(Field:C253($numTable; $numField))
			Else 
				$0:="Field not define for "+Table name:C256($numTable)
		End case 
	: ($numTable=-1)
		$0:="Array"
	: ($numTable=-2)
		$0:="Array Element"
	: ($numTable=-3)
		$0:="jitObject"
	Else 
		$0:="Tags not defined"
End case 
//
//Case of 
//: (($1>0)&($1<=Count tables))
//If (($2>0)&($2<=Count fields(Table($1)->)))
//$0:=Field name($1;$2)
//Else 
//$0:=String($2)+" not valid for Table "+Table name($1)
//End if 
//
//
//
//
//
//Else 
//$0:=String(1)+" not valid Table"
//End case 
//
//