Class constructor($dataClassName : Text)
	This:C1470.dataClassName:=$dataClassName
	This:C1470.query:=New object:C1471("ents"; New object:C1471; "sel"; New object:C1471; "cur"; New object:C1471; "pos"; -1)
	
	This:C1470.getActions()
	This:C1470.getNames()
	This:C1470.getQueries()
	This:C1470.getScriptsolo()
	This:C1470.getScriptsilo()
	
	
	
Function getActions
	If (This:C1470.dataClassName=Null:C1517)
		$arrayName:="<>aActionsCustomers"
	Else 
		$arrayName:="<>aActions"+This:C1470.dataClassName+"s"
	End if 
	
	var $obSel : Object
	var $name : Text
	// clean up the choices of empties
	$obSel:=ds:C1482.PopupChoice.query("choice = :1 or choice = :2"; ""; " ")
	If ($obSel.length>0)
		$obSel.drop()
	End if 
	
	C_COLLECTION:C1488($cActions)
	$cActions:=ds:C1482.PopupChoice.query("arrayName = :1"; $arrayName).orderBy("choice").distinct("choice")
	If ($cActions.length=0)
		$cActions:=ds:C1482.PopupChoice.query("arrayName = :1"; "<>aActions").orderBy("choice").distinct("choice")
	End if 
	$cActions.insert(0; "Actions")
	ARRAY TEXT:C222(aActions; 0)
	COLLECTION TO ARRAY:C1562($cActions; aActions)
	aActions:=1
	This:C1470.actions:=$cActions
	
Function getNames
	var $c : Collection
	// change this setChEmploy
	// add to the collection the id, scripts, etc.....  Get rid of <>aNameID
	COPY ARRAY:C226(<>aNameID; aNameID)
	var $oNames; $o : Object
	var $cNames : Collection
	var $filter_c : Collection
	$filter_c:=Split string:C1554("email,dept,id,imagePath,nameID,phone1,role,securityLevel,comRate,colorBackground,colorForeGround,script"; ";")
	$oNames:=ds:C1482.Employee.query("clientServerUser = :1 and active = :2"; True:C214; True:C214).orderBy("nameID")
	//  $o:=$oNames.toObject($filter_c)
	$c:=$oNames.toCollection($filter_c)
	This:C1470.names:=New object:C1471("values"; New object:C1471; "details"; New object:C1471)
	$c.insert(0; "NameIDs")
	This:C1470.names.values:=$c.extract("nameID")
	This:C1470.names.values.insert(0; "NameIDs")
	This:C1470.names.details:=$c
	This:C1470.names.index:=0
	This:C1470.names.currentValue:="NameIDs"
	
	// HOWTO:  Popups Collections
	
	
Function runOpenScriptolo
	var $tmo : Object
	$tmo:=ds:C1482.TallyMaster.query(\
		"tableName = :1 and purpose = :2 and publish = 1"; \
		This:C1470.dataClassName; \
		"oloOpen").first()
	If ($tmo#Null:C1517)
		ExecuteScript($tmo.script)
	End if 
	
	
Function runEntityNew
	var $tmo : Object
	$tmo:=ds:C1482.TallyMaster.query(\
		"tableName = :1 and purpose = :2 and publish = 1"; \
		This:C1470.dataClassName; \
		"EntityNew").first()
	If ($tmo#Null:C1517)
		ExecuteScript($tmo.script)
	End if 
	
Function runEntityLoad
	var $tmo : Object
	$tmo:=ds:C1482.TallyMaster.query(\
		"tableName = :1 and purpose = :2 and publish = 1"; \
		This:C1470.dataClassName; \
		"EntityLoad").first()
	If ($tmo#Null:C1517)
		ExecuteScript($tmo.script)
	End if 
	
Function getScriptsolo
	var $tmo : Object
	var $filter_c : Collection
	$tmo:=ds:C1482.TallyMaster.query("purpose = :1 & tableName = :2 & publish > 0 & publish <= :3"; \
		"olo_list"; This:C1470.dataClassName; Storage:C1525.user.securityLevel)
	$filter_t:=Split string:C1554("name,script,id"; ";")
	This:C1470.scriptsolo:=$tmo.toCollection($filter_t)
	
	
Function getScriptsilo
	var $tmo : Object
	var $filter_c; $cToA : Collection
	$tmo:=ds:C1482.TallyMaster.query("purpose = :1 & tableName = :2 & publish > 0 & publish <= :3"; \
		"olo_list"; This:C1470.dataClassName; Storage:C1525.user.securityLevel)
	$filter_c:=Split string:C1554("name,script,id"; ";")
	This:C1470.scriptsolo:=$tmo.toCollection($filter_c)
	
	$filter_c:=Split string:C1554("id"; ";")
	$cToA:=$tmo.toCollection($filter_c)
	COLLECTION TO ARRAY:C1562($cToA; aEntryScripts)
	ARRAY TEXT:C222(aEntryScripts; 0)
	INSERT IN ARRAY:C227(aEntryScripts; 1; 1)
	aEntryScripts{1}:="Scripts"
	aEntryScripts:=1
	
Function getScriptsOpenilo
	var $tmo : Object
	var $filter_c : Collection
	$tmo:=ds:C1482.TallyMaster.query("purpose = :1 & tableName = :2 & publish > 0 & publish <= :3"; \
		"ilo_list"; This:C1470.dataClassName; Storage:C1525.user.securityLevel)
	$filter_t:=Split string:C1554("name,script,id"; ";")
	This:C1470.scriptsolo:=$tmo.toCollection($filter_t)
	
Function getQueries
	This:C1470.query.ents:=ds:C1482.TallyMaster.query(\
		"tableName = :1 and purpose = :2 and publish > 0 and publish <= :3"; \
		This:C1470.dataClassName; \
		"QuerySaved"; \
		Storage:C1525.user.securityLevel)
	
	
	
	