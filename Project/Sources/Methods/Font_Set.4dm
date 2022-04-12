//%attributes = {"publishedWeb":true}
//Procedure: Font_Set
C_LONGINT:C283($0)
C_TEXT:C284($1; $theFont)
If (Count parameters:C259=1)
	//$0:=  //**WR O Font number ($1)
End if 
Case of 
	: ($0#0)
		//drop out    
	: (Is macOS:C1572)
		//$0:=  //**WR O Font number ("Geneva")
	Else 
		//$0:=  //**WR O Font number ("Arial")
End case 
If ($0=0)
	$0:=1
End if 