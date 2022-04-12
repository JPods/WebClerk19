//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 07/16/21, 16:14:06
// ----------------------------------------------------
// Method: PVars_AddressFullObj
// Description
C_OBJECT:C1216($1; $obRec)
C_TEXT:C284($0; $result)
$obRec:=$1
$result:=""
If ($obRec=Null:C1517)
	$result:="No Address"
Else 
	Case of 
		: (($obRec.country="USA") | ($obRec.country="US") | ($obRec.country=""))
			$result:=(($obRec.address1+Char:C90(Carriage return:K15:38))*(Num:C11($obRec.address1#"")))\
				+(($obRec.address2+Char:C90(Carriage return:K15:38))*(Num:C11($obRec.address2#"")))\
				+$obRec.city+", "+$obRec.state+"  "+$obRec.zip\
				+((Char:C90(Carriage return:K15:38)+$obRec.country)*(Num:C11($obRec.country#"")))
			
		: (($obRec.Country="France") | ($obRec.Country="FR"))
			$result:=(($obRec.address1+Char:C90(Carriage return:K15:38))*(Num:C11($obRec.address1#"")))\
				+(($obRec.address2+Char:C90(Carriage return:K15:38))*(Num:C11($obRec.address2#"")))\
				+Char:C90(Carriage return:K15:38)+$obRec.Zip_Code+"   "+$obRec.City\
				+Char:C90(Carriage return:K15:38)+$obRec.Country
			
		Else 
			$result:=(($obRec.address1+Char:C90(Carriage return:K15:38))*(Num:C11($obRec.address1#"")))\
				+(($obRec.address2+Char:C90(Carriage return:K15:38))*(Num:C11($obRec.address2#"")))\
				+$obRec.city+", "+$obRec.state+"  "+$obRec.zip\
				+((Char:C90(Carriage return:K15:38)+$obRec.country)*(Num:C11($obRec.country#"")))
	End case 
End if 
$0:=$result