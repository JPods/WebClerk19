//%attributes = {}

// Modified by: Bill James (2022-07-15T05:00:00Z)
// Method: LBX_RightClickHeader
// Description 
// Parameters
// ----------------------------------------------------

#DECLARE($listboxName : Text; $columnNum : Integer; $select : Integer; $popup : Text)
Case of 
	: ($select=1)  //"Delete Column")  //
		LISTBOX DELETE COLUMN:C830(*; $listboxName; $columnNum)
		
	: ($select=2)  //($popup{$select}="Add Formula")  //
		$formula:=Request:C163("Formula (this.field)")
		If (OK=1)
			C_POINTER:C301($nullpointer)
			If ($formula="this.@")
				$title:=Substring:C12($formula; 6)
			Else 
				$title:=$formula
			End if 
			LISTBOX INSERT COLUMN FORMULA:C970(*; $listboxName; $columnNum+1; $title; $formula; Is text:K8:3; $title; $nullpointer)
			OBJECT SET TITLE:C194(*; $title; $title)
		End if 
	: ($select=3)  // "Save"
		$lbName:=$listboxName
		// setup storage
		If (LB_DataBrowser.FieldCharacteristic#Null:C1517)
			// save in Form
		Else 
			
			
			$object:=New object:C1471("table"; $tablename)
			$col:=New collection:C1472
			
			var $obColumn : Object
			
			// get the list of objects
			ARRAY TEXT:C222($aLBObjects_o; 0)
			LISTBOX GET OBJECTS:C1302(*; $listboxName; $aLBObjects_o)
			
			// get the list of columns, only the name is useful
			ARRAY TEXT:C222($aColNames_t; 0)
			ARRAY TEXT:C222($aHeaderNames_t; 0)
			ARRAY POINTER:C280($aColVars_p; 0)
			ARRAY POINTER:C280($aHeaderVars_p; 0)
			ARRAY BOOLEAN:C223($aColsVisible_b; 0)
			ARRAY POINTER:C280($arrStyles_p; 0)
			ARRAY TEXT:C222($aFooterNames_t; 0)
			ARRAY POINTER:C280($aFooterVars_p; 0)
			LISTBOX GET ARRAYS:C832(*; $listboxName; \
				$aColNames_t; $aHeaderNames_t; \
				$aColVars_p; $aHeaderVars_p; \
				$aColsVisible_b; $aStyles_p; \
				$aFooterNames_t; $aFooterVars_p)
			
			//LBX_BoxFromStored
			// LBX_HarvestTesting  This is good
			// LBX_valuesGetSet
			
			var $column_o : Object
			var $columns_c : Collection
			$columns_c:=New collection:C1472
			
			For ($i; 1; Size of array:C274($aColNames_t))
				$column_o:=New object:C1471
				$column_o.name:=$aColNames_t{$i}
				$column_o.header:=New object:C1471("name"; ""; "text"; "")
				$column_o.footer:=New object:C1471("name"; "")
				
				// data
				$column_o.formula:=LISTBOX Get column formula:C1202(*; $column_o.name)
				$column_o.dataSource:=$column_o.formula
				$column_o.fieldType:=ds:C1482[Form:C1466.dataClassName][$column_o.dataSource].fieldType
				
				$column_o.header.name:=$aHeaderNames_t{$i}
				$column_o.header.text:=Substring:C12($column_o.dataSource; 6)
				$column_o.footer.name:=$aFooterNames_t{$i}
				
				
				$column_o.enterable:=OBJECT Get enterable:C1067(*; $column_o.name)
				$column_o.width:=LISTBOX Get column width:C834(*; $column_o.name)
				$column_o.widthMin:=LISTBOX Get property:C917(*; $column_o.name; lk column min width:K53:50)
				$column_o.widthMax:=LISTBOX Get property:C917(*; $column_o.name; lk column max width:K53:51)
				$column_o.resizable:=LISTBOX Get property:C917(*; $column_o.name; lk column resizable:K53:40)
				$column_o.resizingMode:=LISTBOX Get property:C917(*; $column_o.name; lk resizing mode:K53:36)
				
				$column_o.format:=OBJECT Get format:C894(*; $column_o.name)
				$column_o.wordwrap:=LISTBOX Get property:C917(*; $column_o.name; lk allow wordwrap:K53:39)
				$column_o.bgColor:=LISTBOX Get property:C917(*; $column_o.name; lk background color expression:K53:47)
				$column_o.displayType:=LISTBOX Get property:C917(*; $column_o.name; lk display type:K53:46)
				$column_o.fontColor:=LISTBOX Get property:C917(*; $column_o.name; lk font color expression:K53:48)
				$column_o.fontStyle:=LISTBOX Get property:C917(*; $column_o.name; lk font style expression:K53:49)
				$column_o.truncate:=LISTBOX Get property:C917(*; $column_o.name; lk truncate:K53:37)
				
				$column_o.doubleClick:=LISTBOX Get property:C917(*; $column_o.name; lk double click on row:K53:43)
				$column_o.singleClickEdit:=LISTBOX Get property:C917(*; $column_o.name; lk single click edit:K53:70)
				$column_o.sortable:=LISTBOX Get property:C917(*; $column_o.name; lk sortable:K53:45)
				
				$columns_c.push($column_o)
			End for 
			Form:C1466.fc.data.views[Form:C1466.view].list.columns:=$columns_c
			Form:C1466.fc.data.views[Form:C1466.view].fields:=Form:C1466.listFields
			Form:C1466.fc.save()
			// keep for reference on how others store defaults
			//$created:=File("/PACKAGE/Databrowser/"+$tablename+".myPrefs").setText(JSON Stringify($object))
			
			// get the listbox properties
			var $listbox_o : Object
			$listbox_o:=New object:C1471
			$listbox_o.selMode:=LISTBOX Get property:C917(*; $lbName; lk selection mode:K53:35)
			//  Get -> integer
			//  LISTBOX SET PROPERTY(*; "LB1"; lk selection mode; lk none)
			//  Set:  lk none, l singel, lk multiple : 
			
			$listbox_o.singleClickEdit:=LISTBOX Get property:C917(*; $lbName; lk single click edit:K53:70)
			//  Get -> boolean
			//  LISTBOX SET PROPERTY(*; "LB22"; lk single click edit; lk no)
			//  Set:  lk no, lk yes  : 
			
			$listbox_o.doubleClick:=LISTBOX Get property:C917(*; $lbName; lk double click on row:K53:43)
			If ($listbox_o.doubleClick=lk do nothing:K53:52)
				$listbox_o.detailFormName:=""
			Else 
				$listbox_o.detailFormName:=LISTBOX Get property:C917(*; $lbName; lk detail form name:K53:44)
			End if 
			$listbox_o.detailFormName:=LISTBOX Get property:C917(*; $lbName; lk detail form name:K53:44)
			//  Get -> returns integer
			//  LISTBOX SET PROPERTY(*; $lbName; lk double click on row; lk do nothing)
			//  Set:  lk do nothing, lk edit record, lk display record
			//  MORE:
			//        LISTBOX SET PROPERTY(*; $lbName; lk detail form name; vFormName_t)
			
			
			$listbox_o.resizeMode:=LISTBOX Get property:C917(*; $lbName; lk resizing mode:K53:36)
			//  Get -> returns integer
			// LISTBOX SET PROPERTY(*; $lbName; lk resizing mode; lk manual)
			//  Set: lk manual, lk automatic
			
			// also applies to columns
			$listbox_o.truncate:=LISTBOX Get property:C917(*; $lbName; lk truncate:K53:37)
			//  Get  -> returns integer
			//  LISTBOX SET PROPERTY(*; $lbName; lk truncate; lk without ellipsis)
			//  Set: lk without ellipsis, lk with ellipsis
			
			
			$listbox_o.displayFooter:=LISTBOX Get property:C917(*; $lbName; lk display footer:K53:20)
			//  Get -> boolean
			//  LISTBOX Set property(*; $lbName; lk display footer; lk no)
			// Set:  lk no, lk yes  : 
			
			$listbox_o.displayHeader:=LISTBOX Get property:C917(*; $lbName; lk display header:K53:4)  //  boolean
			//  Get -> boolean
			//  LISTBOX Set property(*; $lbName; lk display header; lk no)
			// Set:  lk no, lk yes  : 
			
			//  $listbox_o.horScrollbarHeight:=LISTBOX Get property(*; $lbName; lk hor scrollbar height)  //  integer
			//  Get  -> returns integer
			//  LISTBOX Get property(*; $lbName; lk hor scrollbar height)
			
			$listbox_o.movableRows:=LISTBOX Get property:C917(*; $lbName; lk movable rows:K53:76)
			//  Get -> boolean
			//  LISTBOX Set property(*; $lbName; lk movable rows; lk yes)
			// Set:  lk no, lk yes  : 
			$fc_o.data[$lbName].listbox:=$listbox_o
			$fc_o.save()
			//  Form.obHarvest:=LBX_HarvestTesting("LB_Selection")
		End if 
		
	: ($select=4)  //  "Clear Saved")  // 
		File:C1566("/PACKAGE/Databrowser/"+$tablename+".myPrefs").delete()
		
	: ($select>5)
		$col:=Split string:C1554($popup; ";")
		$title:=$col[$select-1]
		C_POINTER:C301($nullpointer)
		ARRAY TEXT:C222($aFieldsUsed; 0)
		var $this_c : Collection
		$this_c:=New collection:C1472
		$this_c:=lb_o.columns.extract("dataSource")
		COLLECTION TO ARRAY:C1562($this_c; $aFieldsUsed)
		// extract collection from objects
		//$this_c:=lb_o.columns.distinct("dataSource")
		//var $eachColumn : Object
		//For each ($eachColumn; lb_o.columns)
		//APPEND TO ARRAY($aFieldsUsed; $eachColumn.dataSource)
		//End for each 
		If (Find in array:C230($aFieldsUsed; "This."+$title)>0)
			ConsoleLog($title+" is already listed.")
		Else 
			var $column_o : Object
			$column_o:=LBX_ColumnFromName(process_o.dataClassName; $title)
			LISTBOX INSERT COLUMN FORMULA:C970(*; $listboxName; $columnNum+1; \
				$column_o.name; $column_o.dataSource; $column_o.fieldType; \
				$column_o.header.name; $nullpointer; $column_o.footer.name; $nullpointer)
			OBJECT SET TITLE:C194(*; $column_o.header.name; $column_o.header.text)
			LISTBOX SET COLUMN WIDTH:C833(*; $column_o.name; $column_o.width)
			//LISTBOX INSERT COLUMN FORMULA(*; $listboxName; $columnNum+1; $title; "this."+$title; Is text; $title; $nullpointer)
			//OBJECT SET TITLE(*; $title; $title)
		End if 
End case 





