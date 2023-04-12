//%attributes = {}

// Modified by: Bill James (2022-03-26T05:00:00Z)
// Method: SF_List_Execute
// Description 
// Parameters
// ----------------------------------------------------
var $1 : Text
var $listboxSetup_o; $columnSetup_o : Object
var LB_Selection; listForm_o : Object

// unsure how to use Form
//LB_Selection:=New object("listbox"; Form)
LB_Selection:=New object:C1471("ents"; New object:C1471; "cur"; New object:C1471; "sel"; New object:C1471; "pos"; -1; "formName"; $1; "form"; New object:C1471; "meta"; New object:C1471)

allowAlerts_boo:=True:C214  //  setup for user and machine and function  // allow dialogs
tableName:=process_o.dataClassName
$tableNum_l:=ds:C1482[tableName].getInfo().tableNumber
$fieldNum_l:=ds:C1482[tableName].id.fieldNumber
ptCurTable:=Table:C252($tableNum_l)
ptCurID:=Field:C253($tableNum_l; $fieldNum_l)



var $recFC : Object
//$recFC:=ds.FC.query("tableName = :1 AND purpose = :2 AND role = :3 "; tableName; "formDefault"; "default").first()
$recFC:=ds:C1482.FC.query("tableName = :1 AND purpose = :2"; tableName; "formDefault").first()

If (False:C215)
	SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($recFC.toObject()))
End if 
process_o.entsOther.tableName:=New object:C1471("FieldCharacteristic"; $recFC)
If ($recFC=Null:C1517)
	ALERT:C41("Error: There is no FieldCharacteristic record tableName: "+tableName+", purpose: LB_SelectionDefault, role default")
	ConsoleLog("Error: There is no FieldCharacteristic record tableName: "+tableName+", purpose: LB_SelectionDefault, role default")
	CANCEL:C270
Else 
	$listboxSetup_o:=$recFC.data.default["listboxSetup"]
	//$listboxSetup_o.listBox:=$lb_Name
	If (False:C215)
		SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($listboxSetup_o))
	End if 
	//If ($listboxSetup_o=Null)
	//CANCEL
	//Else 
	LB_Selection.form:=$listboxSetup_o
	If (False:C215)
		SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($listboxSetup_o))
	End if 
	
	
	LB_Selection("init")
	LBX_SetListbox(Form:C1466.listboxName)
	LBX_SetFieldPopup(ds:C1482[Form:C1466.dataClassName])
	
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
	
	echo_o:=New object:C1471
	
	OBJECT SET SCROLL POSITION:C906(*; "LB_Selection"; 1; 1)
	LISTBOX SELECT ROW:C912(*; "LB_Selection"; 1)
	SET WINDOW TITLE:C213(process_o.dataClassName+" displayed/selected: "+String:C10(LB_Selection.ents.length)+" / "+String:C10(LB_Selection.sel.length))
	
End if 
//End if 

