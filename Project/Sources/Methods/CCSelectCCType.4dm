//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/25/09, 09:09:33
// ----------------------------------------------------
// Method: CCSelectCCType
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_BOOLEAN:C305($vFound; $0)
$vFound:=False:C215
C_LONGINT:C283($vLoop; $i; $k)
C_LONGINT:C283($vCnt)
C_LONGINT:C283($vPos)
$vCnt:=0
C_TEXT:C284($1)
C_POINTER:C301($2)

$k:=Size of array:C274(<>aPayTypes)
Case of 
	: ($1="")
	: ($1="3@")
		For ($i; 1; $k)
			If (<>aPayTypes{$i}[[1]]="A")
				If (<>aTndClass{$i}=<>ciTCCrdtCrd)
					$2->:=$i
					$i:=$k
					$vFound:=True:C214
				End if 
			Else 
				$vFound:=False:C215
			End if 
		End for 
	: ($1="4@")
		For ($i; 1; $k)
			If (<>aPayTypes{$i}[[1]]="V")
				If (<>aTndClass{$i}=<>ciTCCrdtCrd)
					$2->:=$i
					$i:=$k
					$vFound:=True:C214
				End if 
			Else 
				$vFound:=False:C215
			End if 
		End for 
	: ($1="5@")
		For ($i; 1; $k)
			If (<>aPayTypes{$i}[[1]]="M")
				If (<>aTndClass{$i}=<>ciTCCrdtCrd)
					$2->:=$i
					$i:=$k
					$vFound:=True:C214
				End if 
			Else 
				$vFound:=False:C215
			End if 
		End for 
	: ($1="6@")
		For ($i; 1; $k)
			If (<>aPayTypes{$i}[[1]]="D")
				If (<>aTndClass{$i}=<>ciTCCrdtCrd)
					$2->:=$i
					$i:=$k
					$vFound:=True:C214
				End if 
			Else 
				$vFound:=False:C215
			End if 
		End for 
End case 

If ($vFound=False:C215)  // if no match is found for the no point to "credit card"
	For ($vLoop; 1; Size of array:C274(<>aTndClass))
		If (<>aTndClass{$vLoop}=<>ciTCCrdtCrd)
			$vCnt:=$vCnt+1
			$vPos:=$vLoop
		End if 
	End for 
	If ($vCnt=1)  // if there is only one credit card entry found in the pop up then select it
		$2->:=$vPos
		$vFound:=True:C214
	End if 
End if 

$0:=$vFound