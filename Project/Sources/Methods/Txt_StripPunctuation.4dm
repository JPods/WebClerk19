//%attributes = {"publishedWeb":true}
If (False:C215)
	//PM:  Txt_StripPunctuation 
	//Desc.:  
	//NB:      
	//CB:      
	//New:    04/11/2000.nds   
End if 

C_TEXT:C284($1; $tText)
C_TEXT:C284($0)
C_LONGINT:C283($i)

$tText:=$1

If ($tText#"")
	
	LIST TO ARRAY:C288("Punctuation"; $atPunctuation)
	
	For ($i; 1; Size of array:C274($atPunctuation))
		$tText:=Replace string:C233($tText; $atPunctuation{$i}; "")  //delete punctuation 
	End for 
	
End if 

$0:=$tText

//End of routine  

