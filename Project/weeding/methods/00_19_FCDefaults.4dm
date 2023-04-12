//%attributes = {}
var $fc_LB_Selection_s; $fc_LB_Selection_o; $fc_rework; $fc_default_s; $fc_default_r : Object
var $table_o; $one; $fc_delete : Object
var $vtProperty : Text

$fc_delete:=ds:C1482.FC.query("role = rework17")
$fc_delete.drop()
$fc_delete:=Null:C1517

For each ($vtProperty; ds:C1482)
	If ($vtProperty#"zz@")
		$table_o:=ds:C1482[$vtProperty]
		$fc_LB_Selection_s:=ds:C1482.FC.query("purpose = :1 and tableName = :2"; "DataBrowser"; $vtProperty)
		//$fc_LB_Selection_s.drop()
		//If ($fc_LB_Selection_s.length>0)
		//$fc_LB_Selection_o:=$fc_LB_Selection_s.first()
		//var $lbSelection : Object
		//$lbSelection:=$fc_LB_Selection_o.data.LB_Selection
		//End if 
		
		$fc_default_s:=ds:C1482.FC.query("tableName = :1 AND purpose = :2"; $vtProperty; "formDefault")
		var $c : Collection
		var $outPut : Object
		If ($fc_default_s.length>0)
			$fc_default_r:=$fc_default_s.first()
			// numbered
			$fc_default_r.data.default:=Null:C1517  // has customer fields
			
			//$c:=$fc_default_r.data.backup.listboxSetup.columns
			$fieldList:=$fc_default_r.data.backup.listboxSetup.fieldList
			$outPut:=$fc_default_r.data
		End if 
		
		var $id : Text
		var $fc_rework; $fctest : Object
		//var $fc_rework : cs.FCEntity
		// drop "default is it corrupted with multiple tables
		
		//$fc_rework.newRec()
		
		var $o : Object
		//
		// Fix_QQQ by: Bill James (2023-01-01T06:00:00Z)
		// this method should be deleted or changed
		$fc_rework:=STR_FCNew($o)
		
		
		
		$fc_rework.role:="rework18"
		$fc_rework.obSync:=New object:C1471("deleteLater"; \
			New object:C1471("backup"; $fc_default_r.data.backup; \
			"rework"; $fc_default_r.data.rework))
		
		
		// make 10 columns
		var $c; $columns_c; $fieldNames_c : Collection
		$fieldNames_c:=Split string:C1554($fieldList; ";")
		
		var $property : Text
		$columns_c:=New collection:C1472
		var $cnt : Integer
		$cnt:=0
		For each ($property; ds:C1482[$vtProperty])
			$oneColumn:=LBX_ColumnFromName($vtProperty; $property)
			If ($oneColumn#Null:C1517)
				$columns_c.push($oneColumn)
			End if 
		End for each 
		$fc_rework.data.views.default.list.fields:=$fieldList
		$fc_rework.data.views.default.list.lbName:="LB_Selection"
		$fc_rework.data.views.default.list.columns:=$columns_c
		$fc_rework.data.views.default.list.sfName:=""
		$fc_rework.data.views.default.list.subform:=Null:C1517
		
		$fc_rework.data.views.default.entry.fields:=$fieldList
		$fc_rework.data.views.default.entry.sfName:="SF_cur"
		$fc_rework.data.views.default.entry.subform:=Null:C1517
		
		$result:=$fc_rework.save()
		$fctest:=ds:C1482.FC.get($id)
		
		$fc_rework.obGeneral.keyTags:=KeyTagsFromAlphaFields($fc_rework)
		
		$result:=$fc_rework.save()
		$fctest:=ds:C1482.FC.get($id)
		
		
		
	End if 
End for each 