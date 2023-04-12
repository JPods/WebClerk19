C_OBJECT:C1216($event_o; obDisplay)
C_LONGINT:C283(viRow; $viRow)
$event_o:=FORM Event:C1606
Case of 
	: (Form event code:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event code:C388=On Load:K2:1)
		//Form.Draft:=New object("up"; Form)
		//Form.LB_Tables:=New object("ents"; New collection; "cur"; New object; "sel"; New collection; "pos"; -1)
		//Form.LB_Fields:=New object("ents"; New collection; "cur"; New object; "sel"; New collection; "pos"; -1)
		//OBJECT SET SUBFORM(*; "LBXTablesFields"; "LBXTablesFields")
		
		var formData : Object
		formData:=Form:C1466
		
		C_OBJECT:C1216(entSel)
		C_COLLECTION:C1488($filter_c)
		//$filter_c:=Split string("action;actionBy;action;actionDate;actionTime;company;address1;city;state;zip;phone;phoneCell;email;lastName;profile1;comment;id"; ";")
		//Form.cSel:=ds[tableName].all().toCollection()
		SET MENU BAR:C67(6)
		SET WINDOW TITLE:C213("Output Working")
		
		Form:C1466.SF_Selection:=New object:C1471("lastEvent"; New object:C1471)
		Form:C1466.form_o:=cs:C1710.cEditSubForm
		Form:C1466.form_o:=cs:C1710.cEditSubForm.new("SF_Selection"; "Customer")
		var $recFC : Object
		$recFC:=ds:C1482.FC.query("purpose = :1 and tableName = :2"; "formDefault"; "Customer").first()
		Case of 
			: (Form:C1466.fieldlist#Null:C1517)  // make a default value that can be passed
				Form:C1466.form_o.setLBFromCollection(Split string:C1554(fieldList; ";"))
			: ($recFC=Null:C1517)
				// do nothing
			: ($recFC.data.rework.columns#Null:C1517)
				Form:C1466.form_o.setLBFromColumns($recFC.data.rework.columns)
				
			: ($recFC.data.rework.fieldList#"")
				Form:C1466.form_o.setLBFromCollection(Split string:C1554($recFC.data.rework.fieldList; ";"))
			Else 
				
		End case 
		LBX_SelectionIfEmpty(Form:C1466.form_o.lbName; Form:C1466.form_o.dataClassName)
		
		
		
	: ($event_o.code=On Clicked:K2:4)
		
		Case of 
			: ($event_o.objectName="lbTableArray")
				If (False:C215)  // put into the list boxes
					C_TEXT:C284($tableName)
					If (($obEvt.row>0) & ($obEvt.row<=Size of array:C274(atTableNames)))
						tableName:=atTableNames{$obEvt.row}
						ARRAY TEXT:C222(atFieldNames; 0)
						STR_GetFieldNameList(tableName; ->atFieldNames)
					End if 
				End if 
				
			: ($event_o.objectName="OutputLB")
				$viRow:=$obEvt.row
				
				
				obDisplay:=New object:C1471
				obDisplay.Company:=Form:C1466.obRec.company
				obDisplay.ActionBy:=Form:C1466.obRec.actionBy
				obDisplay.action:=Form:C1466.obRec.action
				obDisplay.date:=Form:C1466.obRec.actionDate
				
				
			: ($event_o.objectName="LB_Draft")
				
				// HOWTO: entity to collection, entityToCollection entity to object
				
				//Form.LB_Draft.cur:=LB_Draft_cur.toObject()
				//Form.LB_Draft.sel:=New collection
				//Form.LB_Draft.sel:=LB_Draft_sel.toCollection()
				
		End case 
		
		
	: ($event_o.code=On Double Clicked:K2:5)
		
		If ($event_o.objectName="OutputLB")
			
			
			$viRow:=viRow
			$tableNum:=Table:C252(->[Customer:2])
			$script:="query([Customer];[Customer]id=\""+Form:C1466.obRec.id+"\")"
			ProcessTableOpen($tableNum; $script; "Customer: ")
			
		End if 
		
End case 


