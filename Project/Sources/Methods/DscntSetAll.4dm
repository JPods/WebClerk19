//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/10/11, 18:55:14
// ----------------------------------------------------
// Method: DscntSetAll
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_BOOLEAN:C305($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_DATE:C307($4)  //Discount Type; Validation Date
Case of 
	: ($3="")
		vUseBase:=2
	: ($1)  //(($1)&($2#""))
		DscntSetPrice($3; $4)
	Else 
		DscntSpecialClr($3)
End case 
vMod:=True:C214
If (Count parameters:C259=5)
	If ($5>0)
		jAlertMessage(9207)
	End if 
Else 
	//PLAY("ChangePrice")
	BEEP:C151
	// jAlertMessage (9207)
End if 