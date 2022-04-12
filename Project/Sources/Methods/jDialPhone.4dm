//%attributes = {"publishedWeb":true}
//Procedure: jDialPhone
C_POINTER:C301($1)
C_TEXT:C284($dialStr)
$dialStr:=$1->
C_POINTER:C301($2)
C_TEXT:C284($Prefix)
If (Count parameters:C259>=2)
	$Prefix:=$2->
Else 
	$Prefix:=""
End if 
C_POINTER:C301($3)
C_TEXT:C284($Suffix)
If (Count parameters:C259>=3)
	$Suffix:=$3->
Else 
	$Suffix:=""
End if 

If (Is macOS:C1572)
	$dialStr:=Di  // -- AL_SetNumber($dialStr; $Prefix; $Suffix)
	Case of 
		: ($dialStr="")
			BEEP:C151
			//: (DK_DeskAvail =1)
			//DK_DeskDial ($dialStr)
			//Else 
			//DK_SpeakerDIAL ($dialStr)
	End case 
Else 
	BEEP:C151
	BEEP:C151
End if 