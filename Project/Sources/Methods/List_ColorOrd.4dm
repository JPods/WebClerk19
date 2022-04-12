//%attributes = {"publishedWeb":true}
//Procedure: List_ColorOrd
C_LONGINT:C283($i; $k; $1)
$k:=Size of array:C274(aLsSrRec)
If ($k>0)
	//For ($i;1;$k)
	//If (aLsDocType{$i}="o@")
	//  // -- AL_SetRowColor ($1;$i;"Black";0;"Yellow";0)
	//End if 
	//End for 
	
	//  
	If (False:C215)
		TCMod_606_67_03_04_Trans
	End if 
	Case of 
		: (aLoCustOPi=4)  //{4}:="Pp_Lines"
			// -- AL_SetSort($1; -14)
		: (aLoCustOPi=6)  //{6}:="ordLines"
			// -- AL_SetSort($1; -14)
		: (aLoCustOPi=8)  //{8}:="Inv_Lines"
			// -- AL_SetSort($1; -14)
		Else 
			// -- AL_SetSort($1; -5)
	End case 
	//  --  CHOPPED  AL_UpdateArrays($1; -2)
End if 