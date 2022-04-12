//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: UtilDocumentLocate
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 

C_TEXT:C284($0; $1; $theDoc; $thePath; $2)
C_LONGINT:C283($cntPara)
$cntPara:=Count parameters:C259

If ($cntPara>0)
	$theDoc:=$1
	If ($cntPara>1)
		$thePath:=$2
	Else 
		$thePath:=Storage:C1525.folder.jitF
	End if 
End if 
myDocName:=$thePath+$theDoc
$myOK:=EI_OpenDoc(->myDocName; ->myDoc; "Open File to Import"; "")
If ($myOK=1)
	CLOSE DOCUMENT:C267(myDoc)
Else 
	myDocName:=""
End if 
$0:=myDocName
//use document to or myDocName