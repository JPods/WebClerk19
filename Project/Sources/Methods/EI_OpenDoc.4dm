//%attributes = {"publishedWeb":true}
//Procedure: EI_OpenDoc
//  $myOK:=EI_OpenDoc (myDocName;myDoc;"Prompt";"Type";jitExportsF)
var $0 : Integer
var $1; $2 : Pointer
var $5 : Variant
var $3 : Text
var $4 : Text
If (Count parameters:C259>4)
	Case of 
		: (Value type:C1509($1)=Is text:K8:3)
			Path_Set($5)
		: (Value type:C1509($1)=Is pointer:K8:14)
			Path_Set($5->)
	End case 
End if 
$1->:=Get_FileName($3; "")  //$4)
If ($1->#"")
	$2->:=Open document:C264($1->; Read mode:K24:5)
	$0:=1
Else 
	$0:=0
End if 