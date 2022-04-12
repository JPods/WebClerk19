//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/27/20, 23:34:57
// ----------------------------------------------------
// Method: Draft_FieldDetails
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($typeFld; $lenField; $numFld; $k)
C_BOOLEAN:C305($indexed)
C_TEXT:C284($strType)
C_TEXT:C284($TList)
$TList:="ARTPD B*IL H1234567890qweyuosXfghjkzcvnm"
//5 and 10 are missing in from the Field Type number code    "
$textAdd:="Name"+"\t"+"WebTag"+"\t"+"TableNum"+"\t"+"FieldNum"+"\t"+"Type"+"\t"+"Length"+"\t"+"Indexed"+"\r"
For ($i; 1; $k)
	GET FIELD PROPERTIES:C258(curTableNum; theFldNum{aFieldLns{$i}}; $typeFld; $lenField; $indexed)  // file #, field #, type, length, index    
	If (($typeFld=Is picture:K8:10) | ($typeFld=Is BLOB:K8:12))  // | ($typeFld=Is object)))  // no blobs or pictures
		$webTag:="Not applicable"
		Case of 
				//: ($typeFld=Is object)
				//$strType:="Object"
			: ($typeFld=Is picture:K8:10)
				$strType:="Picture"
			Else 
				$strType:="Blob"
		End case 
		$textAdd:=$textAdd+"["+Table name:C256(curTableNum)+"]"+theFields{aFieldLns{$i}}+"\t"+$webTag+"\t"+String:C10(curTableNum)+"\t"+String:C10(theFldNum{aFieldLns{$i}})+"\t"+$strType+"\t"+String:C10($lenField)+"\t"+(Num:C11($indexed)*"i")+"\r"
	Else 
		$webTag:=Tag_jit_FromNumbers(curTableNum; theFldNum{aFieldLns{$i}})
		$textAdd:=$textAdd+"["+Table name:C256(curTableNum)+"]"+theFields{aFieldLns{$i}}+"\t"+$webTag+"\t"+String:C10(curTableNum)+"\t"+String:C10(theFldNum{aFieldLns{$i}})+"\t"+($TList[[$typeFld+1]])+"\t"+String:C10($lenField)+"\t"+(Num:C11($indexed)*"i")+"\r"
	End if 
End for 

vTextSummary:=$textAdd+"\r"+"\r"+vTextSummary