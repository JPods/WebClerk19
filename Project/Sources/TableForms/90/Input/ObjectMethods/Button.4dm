C_LONGINT:C283($i; $k)
ARRAY TEXT:C222(aObject; 0)
ARRAY POINTER:C280(aObjectPointer; 0)
ARRAY LONGINT:C221(aObjectPage; 0)
FORM GET OBJECTS:C898(aObject; aObjectPointer; aObjectPage)

If ([GenericChild1:90]templateName:57="")
	ALERT:C41("Enter the TemplateName")
Else 
	QUERY:C277([Template:130]; [Template:130]name:3=[GenericChild1:90]templateName:57; *)
	QUERY:C277([Template:130];  & [Template:130]tableNum:2=Table:C252(->[GenericChild1:90]))
	If (Records in selection:C76([Template:130])>0)
		DB_ShowCurrentSelection(->[Template:130]; ""; 1; "For "+[GenericChild1:90]name:3; 0)
	Else 
		CONFIRM:C162("Create TemplateName: "+[GenericChild1:90]templateName:57)
		If (OK=1)
			CREATE RECORD:C68([Template:130])
			
			[Template:130]name:3:=[GenericChild1:90]templateName:57
			[Template:130]tableNum:2:=Table:C252(->[GenericChild1:90])
			
			vText1:=""
			$k:=Size of array:C274(aObject)
			ARRAY TEXT:C222(aObjectTitle; $k)
			For ($i; 1; $k)
				aObjectTitle{$i}:=OBJECT Get title:C1068(*; aObject{$i})
				If (Position:C15(<>vCR; aObjectTitle{$i})>0)
					aObjectTitle{$i}:=Replace string:C233(aObjectTitle{$i}; <>vCR; "")
				End if 
				If (Position:C15(<>vLF; aObjectTitle{$i})>0)
					aObjectTitle{$i}:=Replace string:C233(aObjectTitle{$i}; <>vLF; "")
				End if 
				// remove any carriage returns
				If (aObject{$i}="text@")
					vText1:=vText1+aObject{$i}+<>vTab+String:C10(aObjectPage{$i})+<>vTab+aObjectTitle{$i}+<>vCR
					CREATE RECORD:C68([Templateline:132])
					[Templateline:132]templateid:2:=[Template:130]idNum:1
					[Templateline:132]dateCreated:6:=Current date:C33
					[Templateline:132]default:3:=aObjectTitle{$i}
					[Templateline:132]value:4:=aObjectTitle{$i}
					[Templateline:132]name:7:=[Template:130]name:3
					SAVE RECORD:C53([Templateline:132])
				End if 
			End for 
			[Template:130]packedList:5:=vText1
			SAVE RECORD:C53([Template:130])
			DB_ShowCurrentSelection(->[Template:130]; ""; 1; "For "+[GenericChild1:90]name:3; 0)
			If (False:C215)
				SET TEXT TO PASTEBOARD:C523(vText1)
			End if 
		End if 
	End if 
End if 

