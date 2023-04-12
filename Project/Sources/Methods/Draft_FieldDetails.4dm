//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/27/20, 23:34:57
// ----------------------------------------------------
// Method: Draft_FieldDetails
// Description
//
//FieldProperties_Old
// Parameters
// ----------------------------------------------------
// writeStructure
#DECLARE($table : Variant)->$textAdd : Text
Case of 
	: (Value type:C1509($table)=Is integer:K8:5)
		$tableNum:=$table
	: (Value type:C1509($table)=Is string var:K8:2)
		$tableNum:=ds:C1482[$table].getInfo().tableNumber
	Else 
		
End case 

var $k; $lenField; $numFld; $tableNum; $typeFld : Integer
var $indexed : Boolean
var $strType : Text
var $TList : Text

//

$k:=Get last field number:C255(Table:C252($tableNum)->)

$TList:="ARTPD B*IL H1234567890qweyuosXfghjkzcvnm"
//5 and 10 are missing in from the Field Type number code    "
$textAdd:="Name"+"\t"+"WebTag"+"\t"+"TableNum"+"\t"+"FieldNum"+"\t"+"Type"+"\t"+"Length"+"\t"+"Indexed"+"\r"
For ($i; 1; $k)
	GET FIELD PROPERTIES:C258($tableNum; theFldNum{aFieldLns{$i}}; $typeFld; $lenField; $indexed)  // file #, field #, type, length, index
	If (($typeFld=Is picture:K8:10) | ($typeFld=Is BLOB:K8:12))  // | ($typeFld=Is object)))  // no blobs or pictures
		$webTag:="Not applicable"
		Case of 
			: ($typeFld=Is object:K8:27)
				$strType:="Object"
			: ($typeFld=Is picture:K8:10)
				$strType:="Picture"
			Else 
				$strType:="Blob"
		End case 
		$textAdd:=$textAdd+"["+Table name:C256($tableNum)+"]"+theFields{aFieldLns{$i}}+"\t"+$webTag+"\t"+String:C10($tableNum)+"\t"+String:C10(theFldNum{aFieldLns{$i}})+"\t"+$strType+"\t"+String:C10($lenField)+"\t"+(Num:C11($indexed)*"i")+"\r"
	Else 
		$webTag:=Tag_jit_FromNumbers($tableNum; theFldNum{aFieldLns{$i}})
		$textAdd:=$textAdd+"["+Table name:C256($tableNum)+"]"+theFields{aFieldLns{$i}}+"\t"+$webTag+"\t"+String:C10($tableNum)+"\t"+String:C10(theFldNum{aFieldLns{$i}})+"\t"+($TList[[$typeFld+1]])+"\t"+String:C10($lenField)+"\t"+(Num:C11($indexed)*"i")+"\r"
	End if 
End for 

//vTextSummary:=$textAdd+"\r"+"\r"+vTextSummary