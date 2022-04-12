//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: XML_DraftList
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//
C_TEXT:C284($1; $fileID)
C_TEXT:C284($returnText; $0)

$fileID:=$1
$k:=Size of array:C274(aFieldLns)
$textAdd:="<!--  _jit_begin_"+String:C10(curTableNum)+"_1"+<>endTag+"  -->"+"\r"
$textAdd:=$textAdd+"<jitList Table="+Table name:C256(Num:C11($fileID))+" siteID="+Storage:C1525.default.idPrefix+">"+"\r"
$textAdd:=$textAdd+"<jitRecord Table="+Table name:C256(Num:C11($fileID))+" siteID="+Storage:C1525.default.idPrefix+">"+"\r"
For ($i; 1; $k)
	$textAdd:=$textAdd+XMLWriteOut(theFields{aFieldLns{$i}}; HTML_jitTagMake(1; $fileID; String:C10(theFldNum{aFieldLns{$i}}); theFields{aFieldLns{$i}}); ""; "")
End for 
$textAdd:=$textAdd+"</jitRecord Table="+Table name:C256(Num:C11($fileID))+">"+"\r"
$textAdd:=$textAdd+"</jitList Table="+Table name:C256(Num:C11($fileID))+" siteID="+Storage:C1525.default.idPrefix+">"+"\r"
$textAdd:=$textAdd+"<!--  "+<>jitTag+"end"+<>midTag+<>endTag+"  -->"+"\r"

Case of 
	: (is4DWriteUser<1)
		vTextSummary:=$textAdd+"\r"+"\r"+vTextSummary
		$0:=$textAdd
	: (is4DWriteUser=3)
		//**WR INSERT TEXT (eLetterArea;$textAdd)
	Else 
		vTextSummary:=$textAdd+"\r"+"\r"+vTextSummary
End case 

