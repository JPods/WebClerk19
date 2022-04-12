C_OBJECT:C1216($line;$selected)
C_COLLECTION:C1488($menuLine;$comparison)
C_LONGINT:C283($index;$item)
C_TEXT:C284($type)
$evt:=Form event code:C388

Case of 
	: (($evt=On Clicked:K2:4) | ($evt=On Alternative Click:K2:36))
		If (Form:C1466.criteria_Cur#Null:C1517)
			$selected:=Form:C1466.criteria_Cur
			$comparison:=Form:C1466.queryMenus[Form:C1466.criteria_Cur.menuIndex]
			
			$popMenu:=Create menu:C408
			For each ($line;$comparison)
				APPEND MENU ITEM:C411($popMenu;$line.menu)
				SET MENU ITEM PARAMETER:C1004($popMenu;-1;$line.condition)
			End for each 
			$choice:=Dynamic pop up menu:C1006($popMenu)  //Displays the popup menu
			RELEASE MENU:C978($popMenu)  //Never forget to release every menus...
			If ($choice#"")
				$menuLine:=$comparison.indices("condition = :1";$choice)
				If ($menuLine.length>0)
					Form:C1466.criteria_Cur.operator:=$comparison[$menuLine[0]].menu+" "+Form:C1466.emojis.charMenu
					Form:C1466.criteria_Cur.condition:=$choice
				End if 
			End if 
		End if 
		
	: ($evt=On Data Change:K2:15)
		  //If (Form.criteria_Cur#Null)
		  //$index:=Form.criteria_Cur.index
		  //$type:=Form.criteria_Cur.type
		  //$item:=Form.criteria_Cur.item
		  //$valueObject:=QRY_SetCriteriaValueCell ($index;$item;$type)
		  //Form.criteria_Cur.condition:=$valueObject.condition
		  //Form.criteria_Cur.value:=$valueObject.value
		  //Form.criteria_Cur.valueType:=$valueObject.valueType
		  //Form.criteria_Cur.operator:=$valueObject.operator
		  //End if 
End case 