//%attributes = {}

// Modified by: Bill James (2022-01-21T06:00:00Z)
// Method: Ent_Before
// Description 
// Parameters
// ----------------------------------------------------

var $1; $tableName : Text
var $rec : Object
$tableName:=$1
If (process_o=Null:C1517)
	// should never happend
	
	var process_o : Object
	process_o:=New object:C1471("ents"; New object:C1471; \
		"cur"; New object:C1471; \
		"sel"; New object:C1471; \
		"pos"; -1; \
		"tableName"; ""; \
		"tableForm"; ""; \
		"form"; ""; \
		"task"; "Ent_Before"; \
		"entsOther"; New object:C1471("tableName"; New object:C1471); \
		"cur"; New object:C1471)
	
End if 
If (process_o.cur=Null:C1517)  // if making a new record make sure to set curretRecord = null
	DB_NewEntityDefaults($tableName)
End if 
entryEntity:=process_o.cur.toObject()
MESSAGES OFF:C175
iLoQAText1:=""
allowAlerts_boo:=True:C214

iLoPagePopUpMenuBar(process_o.tableName)  // This should be reviewed for removal
If (process_o.page=Null:C1517)
	process_o.page:=FORM Get current page:C276
End if 
aPages:=process_o.page
SET TIMER:C645(20)


SET WINDOW TITLE:C213($tableName+" - "+aPages{1}+" - "+String:C10(1))

