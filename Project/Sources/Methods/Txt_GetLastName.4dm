//%attributes = {"publishedWeb":true}
If (False:C215)
	//PM:     Txt_GetLastName 
	//Desc.:  Returns subjective last name from passed text
	//NB:      Assumes 4D List named "Suffixes" exists and tests against
	//           this list for common suffixes and appends to last name if found
	//           EX.: "John B. Taylor, Jr." will return "Taylor, Jr."
	//CB:      
	//New:    04/11/2000.nds   
End if 

C_TEXT:C284($1; $tPassedText)
C_TEXT:C284($tSuffix; $t)
C_TEXT:C284($0)
C_LONGINT:C283($iNum; $iSuffixFound)

$tPassedText:=Txt_StripPunctuation($1)

$iNum:=Txt_GetLastSpace($tPassedText)

If ($iNum>0)
	
	$tSuffix:=Substring:C12($tPassedText; $iNum+1)
	LIST TO ARRAY:C288("Suffixes"; $atSuffixes)
	$iSuffixFound:=Find in array:C230($atSuffixes; $tSuffix)
	
	If ($iSuffixFound>0)
		
		$tPassedText:=Substring:C12($tPassedText; 1; $iNum-1)  //clip off name to position of suffix
		$iNum:=Txt_GetLastSpace($tPassedText)  //find new position of the last space
		
		If ($iNum>0)
			$tPassedText:=Substring:C12($tPassedText; $iNum+1)+" "+$tSuffix
		End if 
		
	Else   //no suffix
		
		$tPassedText:=Substring:C12($tPassedText; $iNum+1)
		
	End if 
	
End if   //space found in passed text  


$0:=$tPassedText

//End of routine
