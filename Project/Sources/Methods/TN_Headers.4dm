//%attributes = {"publishedWeb":true}
//Procedure: TN_Headers
C_LONGINT:C283($1; $2)
If (Count parameters:C259=0)
	C_TEXT:C284($strRsr)
	C_LONGINT:C283($rsr; $err)
	C_PICTURE:C286($tempPict)
	$strRsr:=Request:C163("Enter Resource to Edit"; "22119")
	$doOpen:=-1
	If (OK=1)
		$rsr:=Num:C11($strRsr)
		If (($rsr>22118) & ($rsr<22300))
			$doOpen:=1
		End if 
	End if 
Else 
	$doOpen:=$1
	$rsr:=$2
End if 
If ($doOpen>-1)
	If ($doOpen=1)
		GET PICTURE RESOURCE:C502($rsr; $tempPict)  //22118 is the jitManual header
		//$err:=  //**WR Insert picture area (Body;$tempPict;0)
	Else 
		//$tempPict:=  //**WR O Save to picture (Body)
		
	End if 
End if 