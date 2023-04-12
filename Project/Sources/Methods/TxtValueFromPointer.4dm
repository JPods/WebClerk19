//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 05/16/11, 13:20:16
// ----------------------------------------------------
// Method: Method: TxtValueFromPointer
// Description
// 
//
// Parameters
// ----------------------------------------------------

//Is Alpha Field 	0
//Is Text 	2
//Is Real 	1
//Is Integer	8
//Is LongInt 	9
//Is Date 	4
//Is Time 	11
//Is Boolean 	6
//Is Picture 	3
//Is Subtable 	7
//Is BLOB	30

C_POINTER:C301($1)
C_TEXT:C284($2; $formatString)
C_LONGINT:C283($typeField)
C_TEXT:C284($0; $strFormat)

If (Count parameters:C259>1)
	$formatString:=$2
End if 

GET FIELD PROPERTIES:C258($1; $typeField)
Case of 
	: ($typeField=Is text:K8:3)  //2)//text            
		$0:=$1->
	: (($typeField=Is alpha field:K8:1) | ($typeField=24))  //string and strings
		$myText:=$1->
		Case of 
			: (Position:C15("email"; Field name:C257($1))>0)
				$myText:=Replace string:C233($myText; "&~"; "@")
			: (($formatString="fone@") | ($formatString="phone"))
				$myText:=Format_Phone($myText)
		End case 
		$0:=$myText
	: ($typeField=Is real:K8:4)  //real      
		If ($2="")
			$0:=String:C10($1->)
		Else 
			$0:=String:C10($1->; $2)
		End if 
	: ($typeField=Is picture:K8:10)  // 3)//Place the reference for the pict
		$0:="Picture Field"
	: ($typeField=Is date:K8:7)  //   4)//date
		$0:=String:C10($1->; 1)
	: ($typeField=Is boolean:K8:9)  //6)//boolean      
		If ($1->=True:C214)
			$0:="true"
		Else 
			$0:="false"
		End if 
	: ($typeField=Is integer:K8:5)  //8)//integer
		Case of 
			: (($2="Rating") & ($1->=0))
				$0:="Not Rated"
			: (($strFormat="Null") & ($1->=0))
				$0:=""
			Else 
				$0:=String:C10($1->)
		End case 
	: ($typeField=Is longint:K8:6)  //9)//Longint
		If (Field name:C257($1)="DT@")
			DateTime_DTFrom($1->; ->vDate1; ->vTime1)
			Case of 
				: ($2="DateOnly")
					$0:=String:C10(vDate1; 1)
				: ($2="TimeOnly")
					$0:=String:C10(vTime1; 1)
				Else 
					$0:=String:C10(vDate1; 1)+" "+String:C10(vTime1; 1)
			End case 
		Else 
			$0:=String:C10($1->)
		End if 
	: ($typeField=Is time:K8:8)  //11)//time
		$0:=String:C10($1->; 5)
End case 