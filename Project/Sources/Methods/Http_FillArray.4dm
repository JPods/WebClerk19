//%attributes = {"publishedWeb":true}

If (False:C215)
	//Procedure: Http_FillArray 
	//Date: 07/01/02
	//Who: Bill
	//Description: Fill arrays be allow first entry to be skipped
End if 

C_TEXT:C284($0; $3)
C_POINTER:C301($1)
C_LONGINT:C283($2; $startPoint)
$selectOption:=""
If (Count parameters:C259>1)
	$startPoint:=$2
	If (Count parameters:C259>2)
		C_TEXT:C284($selectOption)
		$selectOption:=$3
	Else 
		$startPoint:=1
	End if 
End if 
$0:=""
//
C_LONGINT:C283($i; $k)
C_TEXT:C284($delim)


$k:=Size of array:C274($1->)
If ($k>0)
	For ($i; $startPoint; $k)
		$0:=$0+"\r"+"<option value="+Txt_Quoted($1->{$i})+">"+$1->{$i}+"</option>"
	End for 
Else 
	ConsoleMessage("Array pointed to has no values.")
End if 
If ($selectOption#"")
	C_TEXT:C284($targetText)
	//$targetText:="<option selected="+Txt_Quoted ("selected")+" value="+Txt_Quoted ("_jit_"+$selectOption+"jj")+">"+"_jit_"+$selectOption+"jj</option>"
	If ($targetText="tjit_@")
		C_TEXT:C284($jitTag)
		$jitTag:=Replace string:C233($targetText; "tjit_"; "_jit_")
		$targetText:="<option selected value="+Txt_Quoted($jitTag)+">"+$jitTag+"</option>"
		// Else 
		// $targetText:="<option selected value="+Txt_Quoted ($targetText)+">"+"_jit_"+$selectOption+"jj</option>"
	End if 
	$0:=$targetText+"\r"+$0
End if 