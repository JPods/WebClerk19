//%attributes = {"publishedWeb":true}
//Dan; Arkware (10/25/01)
If (False:C215)
	//VERSION_9924 
	//03/10/03.prf
	//added new code from Dan Bentson
	
	//03/26/03.dmb
	//took out first letter match.  Added event log error if type found is not a credi
End if 

C_TEXT:C284($0)
C_LONGINT:C283($1; $typeIn; $fia)
$typeIn:=$1
C_TEXT:C284($retString)

$fia:=0

$retString:=""

Case of 
	: ($typeIn=<>ciCCIUnknwn)
		$fia:=Find in array:C230(<>aPayTypes; "unknown")
		If ($fia>0)
			$retString:=<>aPayTypes{$fia}
		End if 
	: ($typeIn=<>ciCCIVisa)
		$fia:=Find in array:C230(<>aPayTypes; "visa")
		If ($fia>0)
			$retString:=<>aPayTypes{$fia}
		End if 
	: ($typeIn=<>ciCCIMstrCd)
		$fia:=Find in array:C230(<>aPayTypes; "mastercard")
		If ($fia>0)
			$retString:=<>aPayTypes{$fia}
		Else 
			$fia:=Find in array:C230(<>aPayTypes; "mc")
			If ($fia>0)
				$retString:=<>aPayTypes{$fia}
			Else 
				$fia:=Find in array:C230(<>aPayTypes; "master card")
				If ($fia>0)
					$retString:=<>aPayTypes{$fia}
				End if 
			End if 
		End if 
	: ($typeIn=<>ciCCIAmEx)
		$fia:=Find in array:C230(<>aPayTypes; "amex")
		If ($fia>0)
			$retString:=<>aPayTypes{$fia}
		Else 
			$fia:=Find in array:C230(<>aPayTypes; "americanexpress")
			If ($fia>0)
				$retString:=<>aPayTypes{$fia}
			Else 
				$fia:=Find in array:C230(<>aPayTypes; "american express")
				If ($fia>0)
					$retString:=<>aPayTypes{$fia}
				End if 
			End if 
		End if 
	: ($typeIn=<>ciCCICartBl)
		$fia:=Find in array:C230(<>aPayTypes; "carte blache")
		If ($fia>0)
			$retString:=<>aPayTypes{$fia}
		End if 
	: ($typeIn=<>ciCCIDiners)
		$fia:=Find in array:C230(<>aPayTypes; "diners")
		If ($fia>0)
			$retString:=<>aPayTypes{$fia}
		End if 
	: ($typeIn=<>ciCCIDiscov)
		$fia:=Find in array:C230(<>aPayTypes; "discover")
		If ($fia>0)
			$retString:=<>aPayTypes{$fia}
		Else 
			$fia:=Find in array:C230(<>aPayTypes; "disc")
			If ($fia>0)
				$retString:=<>aPayTypes{$fia}
			End if 
		End if 
	: ($typeIn=<>ciCCIJCB)
		$fia:=Find in array:C230(<>aPayTypes; "jcb")
		If ($fia>0)
			$retString:=<>aPayTypes{$fia}
		End if 
	: ($typeIn=<>ciCCIOther)
		$fia:=Find in array:C230(<>aPayTypes; "enroute")
		If ($fia>0)
			$retString:=<>aPayTypes{$fia}
		End if 
End case 



//find any match with the same fi
// for example dis compared to discover would match.
//C_TEXT($firstChar;$firstCharFind)
//C_TEXT($possibleMatch)
//C_Longint($cur;$soa;$matchCount)
If ($fia>0)
	If (<>aTndClass{$fia}#<>ciTCCrdtCrd)
		$retString:=""
	End if 
End if 

If ($retString="")
	
	//$matchCount:=0
	//$firstChar:=Substring(<>aCCIssuer{$typeIn+1};0;1)
	//$soa:=Size of array(<>aPayTypes)
	//For ($cur;1;$soa)
	//// find first char in <>aPayTypes{$cur}
	//$firstCharFind:=Substring(<>aPayTypes{$cur};0;1)
	//If ($firstCharFind=$firstChar)
	//$possibleMatch:=<>aPayTypes{$cur}
	//$matchCount:=$matchCount+1
	//$fia:=$cur
	//End if 
	//End for 
	
	
	// if no match found or more than 1 match found then just use first element with 3
	//If ($matchCount=1)
	//$retString:=$possibleMatch
	//Else 
	$fia:=Find in array:C230(<>aTndClass; <>ciTCCrdtCrd)
	If ($fia>=0)
		$retString:=<>aPayTypes{$fia}
	Else 
		$retString:=<>aPayTypes{1}  //nothing found - use first entry (cash)
	End if 
	//End if 
End if 

If (<>aTndClass{$fia}#<>ciTCCrdtCrd)
	ELog_NewRecord(1; "InproperType"; "Credit card match for "+$retString+" is not of type credit card.")
End if 


$0:=$retString
