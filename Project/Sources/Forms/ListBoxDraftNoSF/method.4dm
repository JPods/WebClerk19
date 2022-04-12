C_OBJECT:C1216($event_o; obDisplay)
C_LONGINT:C283(viRow; $viRow)
$event_o:=FORM Event:C1606
Case of 
	: (Form event code:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event code:C388=On Load:K2:1)
		
		var tableName : Text
		If (tableName="")  // setup the fields, default is Customer
			tableName:="Customer"
		End if 
		aTableNames:=Find in array:C230(aTableNames; tableName)
		// STR_TablesListBox
		STR_FieldsListBox
		C_OBJECT:C1216(entSel)
		C_COLLECTION:C1488($filter_c)
		//$filter_c:=Split string("action,actionBy,action,actionDate,actionTime,company,address1,city,state,zip,phone,phoneCell,email,lastName,profile1,comment,id"; ",")
		//Form.cSel:=ds[tableName].all().toCollection()
		SET MENU BAR:C67(6)
		SET WINDOW TITLE:C213("Output Working")
		
		
		
		
		
	: ($event_o.code=On Clicked:K2:4)
		
		If ($event_o.objectName="lbTableArray")
			If (False:C215)  // put into the list boxes
				C_TEXT:C284($tableName)
				If (($obEvt.row>0) & ($obEvt.row<=Size of array:C274(atTableNames)))
					tableName:=atTableNames{$obEvt.row}
					ARRAY TEXT:C222(atFieldNames; 0)
					STR_GetFieldNameList(tableName; ->atFieldNames)
				End if 
			End if 
		End if 
		If ($event_o.objectName="OutputLB")
			$viRow:=$obEvt.row
			
			
			obDisplay:=New object:C1471
			obDisplay.Company:=Form:C1466.obRec.company
			obDisplay.ActionBy:=Form:C1466.obRec.actionBy
			obDisplay.action:=Form:C1466.obRec.action
			obDisplay.date:=Form:C1466.obRec.actionDate
		End if 
		
	: ($event_o.code=On Double Clicked:K2:5)
		
		If ($event_o.objectName="OutputLB")
			
			
			$viRow:=viRow
			$tableNum:=Table:C252(->[Customer:2])
			$script:="query([Customer];[Customer]id=\""+Form:C1466.obRec.id+"\")"
			ProcessTableOpen($tableNum; $script; "Customer: ")
			
		End if 
		
End case 


