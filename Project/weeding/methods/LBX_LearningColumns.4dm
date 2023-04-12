//%attributes = {}

// Modified by: Bill James (2022-07-20T05:00:00Z)
// Method: LBX_LearningColumns
// Description 
// Parameters
// ----------------------------------------------------
// https://developer.4d.com/docs/en/FormObjects/listboxOverview.html

// much better documentation
//  https://livedoc.4d.com/4D-Language-Reference-19-R6/List-Box/LISTBOX-SET-PROPERTY.301-5911042.en.html

var $sel; $ent : Object

//$sel:=ds.FC.query("purpose = :1 and role = :2"; "formDefault"; "Customer")
$sel:=ds:C1482.FC.query("purpose = :1"; "formDefault")
If (Macintosh option down:C545)
	SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($sel.first().data.default))
End if 
var $rawText; $workedText; $fieldList : Text
var $working_c : Collection
var $tableName; $fieldName : Text

For each ($ent; $sel)
	$col_o:=$ent.data.default.listboxSetup.columns
	//SET TEXT TO PASTEBOARD(JSON Stringify($col_o))
	$working_c:=New collection:C1472
	var $each_o; $col_o; $reworked_o : Object
	If ($col_o#Null:C1517)
		For each ($counter; $col_o)
			$tableName:=$col_o[$counter].column.className
			$fieldName:=$col_o[$counter].column.valueName
			$each_o:=New object:C1471(\
				"header"; New object:C1471("name"; $col_o[$counter].header.name; \
				"text"; $fieldName); \
				"footer"; New object:C1471("name"; $col_o[$counter].footer.name))
			For each ($property; $col_o[$counter].column)
				Case of   // clean up bad properties
					: ($property="formula")  // bad property
						$each_o.dataSource:=$col_o[$counter].column[$property]
					: ($property="dataSource")
						$each_o.dataSource:=$col_o[$counter].column.dataSource
					: ($property="header")
						$each_o.header:=$col_o[$counter].column.header
					: ($property="footer")
						$each_o.footer:=$col_o[$counter].column.footer
					: ($property="textAlign")
						$each_o.textAlign:=$col_o[$counter].column.textAlign
					: ($property="align")
						$each_o.align:=$col_o[$counter].column.textAlign
					: ($property="width")
						$each_o[$property]:=$col_o[$counter].column[$property]
					: ($property="widthMin")
						// drop for now
					: ($property="widthMax")
						// drop for now
					: ($property="wordWrap")  // text
						$each_o.wordWrap:="none"
					: ($property="truncateMode")
						$each_o.truncateMode:="none"
					: ($property="bgColor")
						//$each_o[$property]:=$col_o[$counter].column[$property]
					: ($property="fontColor")
						//$each_o[$property]:=$col_o[$counter].column[$property]
					: ($property="resizeable")
						//$each_o[$property]:=$col_o[$counter].column[$property]
					: ($property="showBackground")  //  boolean
						// drop
					: ($property="valueName")
						//$each_o[$property]:=$col_o[$counter].column[$property]
					: ($property="className")
						//$each_o[$property]:=$col_o[$counter].column[$property]
					Else 
						//$each_o[$property]:=$col_o[$counter].column[$property]
				End case 
			End for each 
			If ($each_o.name=Null:C1517)
				$each_o.name:="LB_Selection_"+$fieldName+"_"
			End if 
			If ($each_o.truncateMode=Null:C1517)
				$each_o.truncateMode:="none"
			End if 
			If ($each_o.wordWrap=Null:C1517)
				$each_o.wordWrap:="none"
			End if 
			If ($each_o.enterable=Null:C1517)
				$each_o.enterable:=False:C215
			End if 
			If ($each_o.fieldType=Null:C1517)
				$each_o.fieldType:=ds:C1482[$tableName][$fieldName].fieldType
			End if 
			$working_c.push($each_o)
		End for each 
		$fieldList:=Substring:C12($fieldList; 1; Length:C16($fieldList)-3)
		$ent.data.rework:=New object:C1471("columns"; $working_c; "fieldList"; $fieldList)
		$ent.save()
		If (Macintosh option down:C545)
			SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($ent.data.rework))
		End if 
	End if 
End for each 

//SET TEXT TO PASTEBOARD(JSON Stringify($working_c))

