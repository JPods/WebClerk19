//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/30/20, 13:47:06
// ----------------------------------------------------
// Method: Date_FromObject
// Description
// 
C_DATE:C307($0)
C_TEXT:C284($2; $vtName)
C_LONGINT:C283(<>DateFormat)
C_OBJECT:C1216($1; $voDateGuess)
$voDateGuess:=$1
$vtName:=$2
If ($voDateGuess=Null:C1517)
	$0:=Current date:C33
Else 
	If ($voDateGuess[$vtName]=Null:C1517)
		$0:=Current date:C33
	Else 
		If (OB Get type:C1230($voDateGuess; $vtName)=Is date:K8:7)
			$0:=$voDateGuess.dateEnd
		Else 
			$0:=Date:C102($voDateGuess.dateEnd)
		End if 
	End if 
End if 