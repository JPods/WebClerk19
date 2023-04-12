
// Modified by: Bill James (2021-12-18T06:00:00Z)
// Method: LBXDynamicDemo.PDDLDISP
// Description 
// Parameters
// ----------------------------------------------------


Case of 
	: (Form event code:C388=On Load:K2:1)
		// moved from Form on Load
		ARRAY TEXT:C222(PDDLDISP; 0)
		APPEND TO ARRAY:C911(PDDLDISP; "Selection")
		APPEND TO ARRAY:C911(PDDLDISP; "Array")
		APPEND TO ARRAY:C911(PDDLDISP; "Collection")
		APPEND TO ARRAY:C911(PDDLDISP; "Entity")
		PDDLDISP:=Find in array:C230(PDDLDISP; "Entity")
		//STR_FieldsListBox
	: (Form event code:C388=On Data Change:K2:15)
		C_TEXT:C284($demoSpanText)
		C_OBJECT:C1216($form)
		C_LONGINT:C283($nCol; $i)
		
		Case of 
			: (PDDLDISP{PDDLDISP}="Selection")
				ALL RECORDS:C47([Customer:2])
				$nCol:=3
				// $form:=LBX_DemoDynamic_02("Selection"; ->[Customer]; ->$nCol)  // Selection based
				//$form:=LBX_DemoReworked("Selection"; ->[Customer]; ->$nCol)  // Selection based
				
				jsonText:=JSON Stringify:C1217($form; *)
				jsonText:=Replace string:C233(jsonText; Char:C90(Tab:K15:37); "    ")
				form_o.typeSource:="Selection"
				demoText:=form_o.comment(form_o.typeSource)
				
				
			: (PDDLDISP{PDDLDISP}="Array")
				ARRAY TEXT:C222(arrNames; 0)
				ARRAY TEXT:C222(PDDL; 0)
				ARRAY TEXT:C222(PDDL1; 0)
				
				APPEND TO ARRAY:C911(arrNames; "PDDL")
				APPEND TO ARRAY:C911(arrNames; "PDDL1")
				
				For ($i; 1; 19)
					APPEND TO ARRAY:C911(PDDL; String:C10($i))
					APPEND TO ARRAY:C911(PDDL1; Char:C90($i+65))
				End for 
				
				$form:=LBX_DemoDynamic_02(2; ->arrNames)  // Array based
				form_o.setSubForm(form_o.name; $form)
				jsonText:=form_o.formText
				//$form:=LBX_DemoReworked("Array"; ->arrNames)
				
				
				
				form_o.typeSource:="Array"
				demoText:=form_o.comment(form_o.typeSource)
				
			: (PDDLDISP{PDDLDISP}="Collection")
				//ARRAY TEXT(colNames0; 0)
				//CLEAR VARIABLE(colNames0)
				//APPEND TO ARRAY(colNames0; "This.fname")
				//APPEND TO ARRAY(colNames0; "This.lname")
				//APPEND TO ARRAY(colNames0; "This.age")
				
				//C_COLLECTION(colLB1)
				
				//colLB1:=New collection(New object("fname"; "Bob"; "lname"; "James"; "age"; 39); New object("fname"; "Vinn"; "lname"; "Michaels"; "age"; 38))
				//// $form:=LBX_DemoDynamic_02(3; ->colLB1; ->colNames0)  // Collection
				//$form:=LBX_DemoReworked("Collection"; ->colLB1; ->colNames0)  // Collection
				//jsonText:=JSON Stringify($form; *)
				
				//SET TEXT TO PASTEBOARD(jsonText)
				
				//jsonText:=Replace string(jsonText; Char(Tab); "    ")
				
				//form_o.typeSource:="Collection"
				
				
				
			: (PDDLDISP{PDDLDISP}="Entity")
				//C_OBJECT(eSel1; $o)
				//ARRAY TEXT(colNames2; 0)
				//For each ($o; Form.LB_Fields.sel)
				//APPEND TO ARRAY(colNames2; "This."+$o.fieldName)
				//End for each 
				//eSel1:=ds[Form.LB_Tables.cur.tableName].all()
				//// $form:=LBX_DemoDynamic_02(4; ->eSel1; ->colNames2)  // Entity Collection #2
				//$form:=LBX_DemoReworked("Entity"; ->eSel1; ->colNames2)  // Entity Collection #2
				//jsonText:=JSON Stringify($form; *)
				//jsonText:=Replace string(jsonText; Char(Tab); "    ")
				
				//form_o.typeSource:="Entity"
				
			: (PDDLDISP{PDDLDISP}="MyTest11")
				var $obSetup; $field_o; $listboxSetup_o : Object
				var $fieldList_t; $tableName : Text
				$tableName:="Customer"
				$fieldList_t:="action,actionBy,actionDate,id"
				var $form : Object
				$obSetup:=New object:C1471("listboxName"; "LB_"+$tableName; "tableName"; $tableName)
				//  $form:=LBX_ColumnReturn($obSetup)
				$form:=LBX_DraftFieldLB($obSetup)
				form_o.typeSource:="Entity"
		End case 
		demoText:=form_o.comment(form_o.typeSource)
End case 