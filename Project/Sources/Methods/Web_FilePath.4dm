//%attributes = {"publishedWeb":true}
//Procedure: Web_FilePath("/images/NavH_BkGrd.gif")
C_TEXT:C284($0; $1)
C_TEXT:C284($2)

If ($1#"")
	If ($1[[1]]="/")
		$0:=Storage:C1525.wc.webFolder+$1
	Else 
		$0:=Storage:C1525.wc.webFolder+"/"+$1
	End if 
	If (Is macOS:C1572)
		$0:=Replace string:C233($0; "/"; ":")
	Else 
		$0:=Replace string:C233($0; "/"; "\\")
	End if 
	///images/NavH_BkGrd.gif
	If (Count parameters:C259=2)
		If ($2="Launch")
			vText1:=$0
			vText2:=""
			AE_LaunchDoc(vText1)
		End if 
	End if 
Else 
	$0:=""
End if 