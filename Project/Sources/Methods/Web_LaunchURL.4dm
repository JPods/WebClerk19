//%attributes = {"publishedWeb":true}
//Procedure: Web_LaunchURL
C_LONGINT:C283($error; $k; $i; $dots)
C_TEXT:C284($1; $vText1)
KeyModifierCurrent
If ($1#"")
	$vText1:=$1
	OPEN URL:C673($vText1)
	
	If (False:C215)
		$vText1:=""
		$k:=Length:C16($1)
		//TRACE
		For ($i; 1; $k)
			$vText1:=$vText1+$1[[$i]]
			Case of 
				: ($1[[$i]]=".")
					$dots:=$dots+1
				: ($1[[$i]]="/")
					$vText1:=$vText1+Substring:C12($1; $i+1)
					$i:=$k
			End case 
		End for 
		If ($dots=1)
			$vText1:="www."+$vText1
		End if 
		Case of 
			: ((CmdKey=0) & (OptKey=0) & ($1#"http://@"))
				$vText1:="http://"+$vText1
			: (CmdKey=1)
				If ($vText1="http://@")
					$vText1:="https"+Substring:C12($vText1; 5)
				Else 
					$vText1:="https://"+$vText1
				End if 
			: (OptKey=1)
				Case of 
					: ($vText1="http://@")
						$vText1:="ftp"+Substring:C12($vText1; 5)
					: ($vText1="https://@")
						$vText1:="ftp"+Substring:C12($vText1; 6)
					Else 
						$vText1:="ftp://"+$vText1
				End case 
		End case 
		
		OPEN URL:C673($vText1)
		//$error:=100
		If ($error#0)
			If (False:C215)
				If (Is macOS:C1572)
					OPEN URL:C673("open "+$vText1)
				Else 
					OPEN URL:C673("iexplore "+$vText1)
				End if 
			End if 
		End if 
	End if 
Else 
	BEEP:C151
	BEEP:C151
End if 