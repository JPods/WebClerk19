//%attributes = {"publishedWeb":true}
If (False:C215)
	//PM:  Txt_ClearLastTab 
	//Desc.:  
	//NB:      
	//CB:      
	//New:    04/11/2000.nds   
End if 

C_TEXT:C284($1; $0; $tTextIn; $tTextOut)
C_LONGINT:C283($iPosition)

$tTextIn:=$1
$iPosition:=Length:C16($tTextIn)

If (Substring:C12($tTextIn; $iPosition; 1)=Char:C90(Tab:K15:37))
	$tTextOut:=Substring:C12($tTextIn; 1; $iPosition-1)
Else 
	$tTextOut:=$tTextIn
End if 

$0:=$tTextOut

//End of routine