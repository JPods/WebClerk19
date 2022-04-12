//%attributes = {}



// 4D_25Invoice - 2022-01-15
C_TEXT:C284($propertyName)
C_OBJECT:C1216($selection)
C_BOOLEAN:C305($isIndexed)

If (Form event code:C388=On After Keystroke:K2:26)
	$text:=Get edited text:C655
Else 
	$text:=Form:C1466.queryString
End if 

If (Length:C16($text)=0)
	Form:C1466.displayedSelection:=Form:C1466.dataClass.all()
	
Else 
	$isNumeric:=($text=String:C10(Num:C11($text)))
	$choice:=Form:C1466.queryType
	If (Form:C1466.inSelection)
		$selection:=Form:C1466.displayedSelection
	Else 
		$selection:=Form:C1466.dataClass.all()
	End if 
	
	$atBefore:="@"*Num:C11((Form:C1466.qryType=3) | (Form:C1466.qryType=4))
	$atAfter:="@"*Num:C11((Form:C1466.qryType=2) | (Form:C1466.qryType=4))
	
	If ($choice="@YWHERE")  //Search everywhere or anywhere
		$qryString:=""
		For each ($propertyName; Form:C1466.dataClass)
			$fieldProperties:=QRY_Util_GetFieldProperties(Form:C1466.dataClassName; $propertyName)
			
			If (($choice="EVERYWHERE") | (Form:C1466.listColumns.indexOf($propertyName)>=0))
				$isIndexed:=Form:C1466.dsDescription[Form:C1466.dataClassName].fields[$propertyName].indexed
				If ($isIndexed | (Form:C1466.onlyIndexed))
					$type:=Form:C1466.dsDescription[Form:C1466.dataClassName].fields[$propertyName].typeS
					$isComplexType:=($type="blob") | ($type="image") | ($type="object") | ($type="bool") | Not:C34(Form:C1466.dsDescription[Form:C1466.dataClassName].fields[$propertyName].kind="storage")
					If (Not:C34($isComplexType))
						$isTypeNumeric:=($type="long") | ($type="number") | ($type="long64") | ($type="float")
						$toAdd:=""
						If ($qryString#"")
							$toAdd:=" OR "
						End if 
						If ($isTypeNumeric)
							If ($isNumeric)
								$qryString:=$qryString+$toAdd+$propertyName+" = :1"
							End if 
						Else 
							$qryString:=$qryString+$toAdd+$propertyName+" = :2"
						End if 
					End if 
				End if 
			End if 
		End for each 
		Form:C1466.displayedSelection:=$selection.query($qryString; $text; $atBefore+$text+$atAfter)
	Else 
		$propertyName:=Substring:C12(Form:C1466.queryType; Length:C16("QRY_")+1)
		If ($propertyName#"")
			If (Position:C15("."; $propertyName)>0)
				$type:="string"
			Else 
				$type:=Form:C1466.dsDescription[Form:C1466.dataClassName].fields[$propertyName].typeS
			End if 
			$isTypeNumeric:=($type="long") | ($type="number") | ($type="long64") | ($type="float")
			If ($isNumeric & $isTypeNumeric)
				Form:C1466.displayedSelection:=$selection.query($propertyName+" = :1"; $text)
			Else 
				Form:C1466.displayedSelection:=$selection.query($propertyName+" = :1"; $atBefore+$text+$atAfter)
			End if 
		End if 
	End if 
End if 
If (Form:C1466.displayedSelection=Null:C1517)
	
End if 