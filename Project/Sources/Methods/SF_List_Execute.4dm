//%attributes = {}

// Modified by: Bill James (2022-03-26T05:00:00Z)
// Method: SF_List_Execute
// Description 
// Parameters
// ----------------------------------------------------
var $1 : Text
var $listboxSetup_o; $columnSetup_o : Object
var _LB_OutputDS_; listForm_o : Object

// unsure how to use Form
//_LB_OutputDS_:=New object("listbox"; Form)
_LB_OutputDS_:=New object:C1471("ents"; New object:C1471; "cur"; New object:C1471; "sel"; New object:C1471; "pos"; -1; "formName"; $1; "form"; New object:C1471; "meta"; New object:C1471)

allowAlerts_boo:=True:C214  //  setup for user and machine and function  // allow dialogs
tableName:=process_o.tableName
$tableNum_l:=ds:C1482[tableName].getInfo().tableNumber
$fieldNum_l:=ds:C1482[tableName].id.fieldNumber
ptCurTable:=Table:C252($tableNum_l)
ptCurID:=Field:C253($tableNum_l; $fieldNum_l)



var $recFC : Object
$recFC:=ds:C1482.FieldCharacteristic.query("tableName = :1 AND purpose = :2 AND role = :3 "; tableName; "formDefault"; "default").first()
If (process_o.entsOther=Null:C1517)
	process_o.entsOther:=New object:C1471("tableName"; New object:C1471)
End if 
If (process_o.entsOther.tableName=Null:C1517)
	process_o.entsOther:=New object:C1471("tableName"; New object:C1471)
End if 
process_o.entsOther.tableName:=New object:C1471("FieldCharacteristic"; $recFC)
If ($recFC=Null:C1517)
	ALERT:C41("Error: There is no FieldCharacteristic record tableName: "+tableName+", purpose: _LB_OutputDS_Default, role default")
	ConsoleMessage("Error: There is no FieldCharacteristic record tableName: "+tableName+", purpose: _LB_OutputDS_Default, role default")
	CANCEL:C270
Else 
	$listboxSetup_o:=$recFC.data.default["listboxSetup"]
	$listboxSetup_o.listBox:=$lb_Name
	If ($listboxSetup_o=Null:C1517)
		CANCEL:C270
	Else 
		_LB_OutputDS_.form:=$listboxSetup_o
		LBX_BoxFromStored($listboxSetup_o)
		
		var echo_o : Object
		echo_o:=New object:C1471
		Case of 
			: (process_o.script#Null:C1517)
				echo_o:=New object:C1471
				var $vtResponse : Text
				$vtResponse:=ExecuteScript(process_o.script)
				process_o.ents:=echo_o.ents
			: (process_o.tallyMaster#Null:C1517)
				var $oTM : Object
				$oTM:=ds:C1482.TallyMaster.query("name = :1 & purpose = :2 & publish > :3 & publish <= :4"; \
					process_o.tallyMaster.name; process_o.tallyMaster.purpose; \
					0; Storage:C1525.user.securityLevel)
				process_o.ents:=echo_o.ents
		End case 
		If (process_o.ents=Null:C1517)  // easier to pass objects than scripts
			process_o.ents:=ds:C1482[tableName].all()
		End if 
		If (process_o.cur=Null:C1517)
			process_o.cur:=process_o.ents.first()
		End if 
		If (process_o.sel=Null:C1517)
			process_o.sel:=process_o.ents
		Else 
			process_o.sel:=process_o.ents[0]
		End if 
		_LB_OutputDS_.ents:=process_o.ents
		_LB_OutputDS_.cur:=process_o.cur
		_LB_OutputDS_.sel:=process_o.sel
		
		_LB_OutputDS_.ents:=process_o.ents
		_LB_OutputDS_.cur:=process_o.cur
		_LB_OutputDS_.sel:=process_o.sel
		
		
		echo_o:=New object:C1471
		
		
		If (_LB_OutputDS_.ents=Null:C1517)
			entryEntity:=ds:C1482[process_o.tableName].new()
		Else 
			_LB_OutputDS_.cur:=_LB_OutputDS_.ents.first()
			// work the data in every detailed _LB_OutputDS_ as entryEntity Object
			// keep all associted entities in the process_o.ents object
			
			// save changes to entryEntity into the ents and database
			entryEntity:=_LB_OutputDS_.cur.toObject()
			
			process_o.entsOther[process_o.tableName]:=_LB_OutputDS_.ents.first()
			
		End if 
		
		SET WINDOW TITLE:C213(process_o.tableName+" displayed/selected: "+String:C10(_LB_OutputDS_.ents.length)+" / "+String:C10(_LB_OutputDS_.sel.length))
		
	End if 
End if 

