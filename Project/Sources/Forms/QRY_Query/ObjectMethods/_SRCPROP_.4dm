C_LONGINT:C283($l;$t;$r;$b;$mouseButton;$index)
C_REAL:C285($mouseX;$mouseY)
C_COLLECTION:C1488($result)

$evt:=Form event code:C388

Case of 
	: ($evt=On Clicked:K2:4)
		If (Form:C1466.propertySelected#Null:C1517)
			OBJECT GET COORDINATES:C663(*;"Column0";$l;$t;$r;$b)
			GET MOUSE:C468($mouseX;$mouseY;$mouseButton)
			If (($mouseX>$l) & ($mouseX<($l+30)))
				If (Form:C1466.propertySelected.subFields#Null:C1517)
					$result:=Form:C1466.propertyListOriginal.indices("index = :1";Form:C1466.propertySelected.index)
					If ($result.length>0)
						$index:=$result[0]
						Form:C1466.propertyListOriginal[$index].close:=Not:C34(Form:C1466.propertyListOriginal[$index].close)
						Form:C1466.propertyList:=QRY_RedrawList (Form:C1466.propertyListOriginal;Form:C1466.plistChoice)
					End if 
				Else 
					If (Form:C1466.propertySelected.type="table")
						Form:C1466.qryTablesClose[Form:C1466.propertySelected.path]:=Not:C34(Form:C1466.qryTablesClose[Form:C1466.propertySelected.path])
						Form:C1466.propertyList:=QRY_RedrawList (Form:C1466.propertyListOriginal;Form:C1466.plistChoice)
					End if 
				End if 
			End if 
		End if 
		
	: ($evt=On Double Clicked:K2:5)
		If (Form:C1466.propertySelected#Null:C1517)
			QRY_SetCriteriaLine (Form:C1466.propertySelected)
		End if 
		
	: ($evt=On Begin Drag Over:K2:44)
		Form:C1466.clipObject:=New object:C1471("source";"SRC";"object";Form:C1466.propertySelected)
		
		
End case 