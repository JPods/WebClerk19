//%attributes = {}



// 4D_25Invoice - 2022-01-15
C_LONGINT:C283(gError)

gError:=Error

If (gError#0)
	ARRAY LONGINT:C221($codesArray; 0)
	ARRAY TEXT:C222($intCompArray; 0)
	ARRAY TEXT:C222($textArray; 0)
	GET LAST ERROR STACK:C1015($codesArray; $intCompArray; $textArray)
	$message:="Error#"+String:C10(gError)
	For ($i; 1; Size of array:C274($codesArray))
		$message:=Char:C90(Carriage return:K15:38)+"#"+String:C10($codesArray{$i})+" ("+$textArray{$i}+")"
	End for 
	$alert:=Util25_Get_LocalizedMessage("CheckNo"; $message)
	ALERT:C41($alert)
	
End if 