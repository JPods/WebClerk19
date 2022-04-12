//%attributes = {"publishedWeb":true}
If (False:C215)
	//PM:  Txt_GetLastSpace 
	//Desc.:  return position of last space in passed text
	//NB:      
	//CB:      
	//New:    04/10/2000.nds   
End if 

C_TEXT:C284($1; $tText; $tClip)  //Text to test for last position of space
C_LONGINT:C283($lCounter; $lPosition; $0)  //Position number to pass back to calling routine
C_BOOLEAN:C305($oEndReached)

$tText:=$1
$tText:=Txt_TrimSpaces($tText)  //strip any leading or trailing spaces
$tClip:=$tText

Repeat 
	
	$lCounter:=Position:C15(" "; $tClip)
	
	If ($lCounter>0)
		$lPosition:=$lPosition+$lCounter
		$tClip:=Substring:C12($tClip; $lCounter+1)
	End if 
	
Until ($lCounter=0)

$0:=$lPosition
//End of routine
