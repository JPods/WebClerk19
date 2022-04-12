C_OBJECT:C1216($selected)

$evt:=Form event code:C388

Case of 
	: (($evt=On Clicked:K2:4) | ($evt=On Alternative Click:K2:36))
		If (Form:C1466.criteria_Cur#Null:C1517)
			If (Form:C1466.criteria_Pos>1)
				$menu:=New object:C1471("and";Get localized string:C991("operator_and");\
					"or";Get localized string:C991("operator_or");\
					"except";Get localized string:C991("operator_except"))
				$selected:=Form:C1466.criteria_Cur
				$popMenu:=Create menu:C408
				APPEND MENU ITEM:C411($popMenu;$menu.and)
				SET MENU ITEM PARAMETER:C1004($popMenu;-1;"and")
				APPEND MENU ITEM:C411($popMenu;$menu.or)
				SET MENU ITEM PARAMETER:C1004($popMenu;-1;"or")
				APPEND MENU ITEM:C411($popMenu;$menu.except)
				SET MENU ITEM PARAMETER:C1004($popMenu;-1;"except")
				$choice:=Dynamic pop up menu:C1006($popMenu)  //Displays the popup menu
				RELEASE MENU:C978($popMenu)  //Never forget to release every menus...
				If ($choice#"")
					Form:C1466.criteria_Cur.logicOperator:=$menu[$choice]+" "+Form:C1466.emojis.charMenu
					Form:C1466.criteria_Cur.logicOperatorChoice:=$choice
				End if 
			End if 
		End if 
		
End case 