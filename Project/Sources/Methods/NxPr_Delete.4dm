//%attributes = {"publishedWeb":true}
//Procedure: Register_OpenWi
//C_Longint($tempBase)
//C_BOOLEAN($endLoop)
//C_TEXT($tempSale)
C_TEXT:C284($theResponse)
Process_InitLocal
ptCurTable:=(->[Control:1])
$p:=Position:C15("jitcorp.com"; Storage:C1525.default.domain)
If ($p=0)
	$theResponse:=Request:C163("Enter jitPassword")
	$p:=Num:C11((OK=1) & ($theResponse="daslake"))
End if 
If ($p>0)
	<>prcControl:=0
	Open window:C153(Screen width:C187-312; 40; Screen width:C187-4; 380; 4; "ExitTest")
	ControlRecCheck
	DISABLE MENU ITEM:C150(1; 4)
	READ ONLY:C145([Customer:2])
	FORM SET INPUT:C55([Control:1]; "ExitTest")
	ProcessTableOpen(->[Control:1])
	//Else 
	//ControlRecCheck 
End if 