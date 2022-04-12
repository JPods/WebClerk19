//%attributes = {"publishedWeb":true}
If (False:C215)
	//PM:  Txt_GetCharacterCount 
	//Desc.:  Returns number of occurences of a character in passed text
	//NB:      
	//CB:      
	//New:    04/11/2000.nds   
End if 

C_TEXT:C284($1; $Source)
C_TEXT:C284($2; $CharToFind)
C_LONGINT:C283($0; $Count; $theLength)

C_LONGINT:C283($i)

$Source:=$1
$CharToFind:=$2

$Count:=0
$theLength:=Length:C16($Source)
For ($i; 1; $theLength)
	If ($Source[[$i]]=$CharToFind)
		$Count:=$Count+1
	End if 
End for 

$0:=$Count


//End of routine  