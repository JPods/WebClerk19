//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/06/11, 21:36:30
// ----------------------------------------------------
// Method: WC_MetaTagRead
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1)
C_TEXT:C284($0; $2; $workingText)
C_LONGINT:C283($p; $3; $sendErr)
If (Count parameters:C259<3)
	$sendErr:=1
Else 
	$sendErr:=Num:C11($3=1)  //zero pass only the value back, must have ""
End if 
//TRACE
$p:=Position:C15("<Meta name="+Char:C90(34)+$2; $1)
If ($p>0)
	$workingText:=Substring:C12($1; $p)
	$p:=Position:C15(">"; $workingText)
	If ($p>0)
		$workingText:=Substring:C12($workingText; 1; $p-2)
	End if 
	$p:=Position:C15("Content="; $workingText)
	If ($p>0)
		$workingText:=Substring:C12($workingText; $p+9)  //clip beginning quote also    
		$p:=Position:C15("\""; $workingText)
		If ($p>1)
			$workingText:=Substring:C12($workingText; 1; $p-1)
		End if 
		$0:=Replace string:C233($workingText; "\""; "")
	Else 
		$0:=("No content: "+$2)*$sendErr
	End if 
Else 
	$0:=("No Meta: "+$2)*$sendErr
End if 