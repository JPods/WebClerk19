//%attributes = {}



// 4D_25Invoice - 2022-01-15
C_TEXT:C284($propertyName)
C_OBJECT:C1216($selection; $property; $fieldProperties)

If (Form event code:C388=On After Keystroke:K2:26)
	$text:=Get edited text:C655
Else 
	$text:=Form:C1466.queryString
End if 
$isNumeric:=($text=String:C10(Num:C11($text)))
$atBefore:="@"*Num:C11((Form:C1466.qryType=3) | (Form:C1466.qryType=4))
$atAfter:="@"*Num:C11((Form:C1466.qryType=2) | (Form:C1466.qryType=4))

$choice:=(Form:C1466.popupPtr)->
If (Form:C1466.inSelection)
	$selection:=Form:C1466.displayedSelection
Else 
	$selection:=Form:C1466.dataClass.all()
End if 
If ($choice<3)  //Search everywhere
	$qryString:=""
	For each ($property; Form:C1466.qryPropertyList)
		$fieldProperties:=QRY_Util_GetFieldProperties(Form:C1466.dataClassName; $property.name)
		$type:=$property.type
		$isTypeNumeric:=($type="long") | ($type="number") | ($type="long64") | ($type="float")
		$isTypeText:=($type="text") | ($type="string") | ($type="picture") | ($type="object") | ($type="collection")
		If ($fieldProperties.indexed | Not:C34(Form:C1466.indexOnly))
			If ($isTypeNumeric | $isTypeText)
				$toAdd:=""
				If ($qryString#"")
					$toAdd:=" OR "
				End if 
				If ($isTypeNumeric)
					If ($isNumeric)
						$qryString:=$qryString+$toAdd+$property.name+" = :1"
					End if 
				Else 
					$qryString:=$qryString+$toAdd+$property.name+" = :2"
				End if 
			End if 
		End if 
	End for each 
	Form:C1466.displayedSelection:=$selection.query($qryString; $text; $atBefore+$text+$atAfter)
Else 
	$propertyName:=Form:C1466.qryPropertyList[$choice-3].name
	$fieldProperties:=QRY_Util_GetFieldProperties(Form:C1466.dataClassName; $propertyName)
	$type:=$fieldProperties.typeS
	$isTypeNumeric:=($type="long") | ($type="number") | ($type="long64") | ($type="float")
	If ($isNumeric & $isTypeNumeric)
		Form:C1466.displayedSelection:=$selection.query($propertyName+" = :1"; $text)
	Else 
		Form:C1466.displayedSelection:=$selection.query($propertyName+" = :1"; $atBefore+$text+$atAfter)
	End if 
End if 

