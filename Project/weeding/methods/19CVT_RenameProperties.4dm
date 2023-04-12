//%attributes = {}

// Modified by: Bill James (2022-05-08T05:00:00Z)
// Method: 19CVT_RenameProperties
// Description 
// Parameters
// ----------------------------------------------------


// Modified by: Bill James (2022-05-06T05:00:00Z)
// CONVERT
//19DevForm_TableToObj
// workt_this
//$pathRSC:="/Users/williamjames/Documents/CommerceExpert/00WebClerk19/Resources/CE13ztjEN.xlf"
//$rscText:=Document to text($pathRSC)
#DECLARE($path_t : Text; $tableName_t : Text)
var $pathRSC; $rscText; $formPath : Text
var $rscjSon : Object

var $file_o : 4D:C1709.File
Case of 
	: (Count parameters:C259=0)
		
		$file_o:=FileSelect
		If ($file_o#Null:C1517)
			$working_t:=Document to text:C1236($file_o.platformPath)
		End if 
	: ($path_t="pasteboard")
		$working_t:=Get text from pasteboard:C524
	Else 
		$file_o:=File:C1566($path_t; fk platform path:K87:2)
		$working_t:=$file_o.getText()
End case 

If ($tableName_t="")
	$tableName_t:=Request:C163("TableName"; "Customer")
End if 

// MustFixQQQZZZ: Bill James (2022-05-08T05:00:00Z)
// replace with dataClassName



//If ($path#"")
var $working_t; $reworked_t; $propertyOld_t; $fieldName_t; $tableName_t; $reNameProperty_t : Text
var $asIS_o; $pageOld_o; $reworkedPageObjects_o; $pageObjects_o; $feature_o : Object
$reworkedPageObjects_o:=New object:C1471
// convert document to json
$asis_o:=JSON Parse:C1218($working_t)

var $pageCount_i; $noDupCounter : Integer


$asis_o.events:=New collection:C1472("onLoad"; "onValidate"; "onClick"; \
"onOutsideCall"; "onDoubleClick"; "onMenuSelect"; \
"onDataChange"; "onCloseBox"; "onUnload"; \
"onTimer"; "onLoadRecord"; "onPageChange")
// there is always page zero and page 1
var $noDupCounter; $pageCnt : Integer  // force object properties to always be unique by adding a incremented value
var $pagesNew_c : Collection
var $pageObjectNew_o : Object
$pagesNew_c:=New collection:C1472  // new collection to the for the page
$pageCnt:=-1
ConsoleLog("Form: "+$formPath)
For each ($pageOld_o; $asis_o.pages)  // loop through the pages
	If ($pageOld_o=Null:C1517)
		$pageOld_o:=New object:C1471("objects"; New object:C1471)
	End if 
	$pageCnt:=$pageCnt+1
	ConsoleLog("Page: "+String:C10($pageCnt))
	// variables, fields, text, etc....
	$reworkedPageObjects_o:=New object:C1471  // new object for each page
	
	For each ($propertyOld_t; $pageOld_o.objects)  // loop through the page properties
		$noDupCounter:=$noDupCounter+1  // create a unique value
		
		$reNameProperty_t:="_"+$propertyOld_t+"_"  // prep a change of property name
		
		$doNew:=True:C214
		Case of 
			: ($pageOld_o.objects[$propertyOld_t]=Null:C1517)
				ConsoleLog($tableName_t+": Object null: "+$propertyOld_t)
				
			: ($pageOld_o.objects[$propertyOld_t].type="listbox")
				If ($propertyOld_t="var@")
					$reNameProperty_t:="_lb_rename_"+String:C10($noDupCounter)
				Else 
					$reNameProperty_t:=$propertyOld_t
				End if 
				ConsoleLog($tableName_t+": listbox: "+$propertyOld_t)
				
			: ($propertyOld_t="Rectangle@")
				// change stroke, fill, and sizes as needed
				$reNameProperty_t:=$reNameProperty_t+String:C10($noDupCounter)
				
			: ($propertyOld_t="TimePicker@")
				$reNameProperty_t:=$reNameProperty_t+$pageOld_o.objects[$propertyOld_t].dataSource+"_"+String:C10($noDupCounter)
				
			: ($propertyOld_t="PopupDate@")
				$reNameProperty_t:=$reNameProperty_t+$pageOld_o.objects[$propertyOld_t].dataSource+"_"+String:C10($noDupCounter)
				
			: ($propertyOld_t="Text@")
				If ($pageOld_o.objects[$propertyOld_t].text=Null:C1517)
					$reNameProperty_t:="_Text_null_"+String:C10($noDupCounter)
				Else 
					$temp_t:=Replace string:C233($pageOld_o.objects[$propertyOld_t].text; " "; "")
					$temp_t:=Replace string:C233($temp_t; "/"; "_")
					$temp_t:=Replace string:C233($temp_t; ":"; "_")
					$temp_t:=Replace string:C233($temp_t; ","; "")
					$reNameProperty_t:="_Text_"+$temp_t+"_"+String:C10($noDupCounter)
				End if 
			: ($propertyOld_t="Field@")
				// save for archive
				If ($pageOld_o.objects[$propertyOld_t].dataSource="entry@")
					$fieldName_t:=Replace string:C233($pageOld_o.objects[$propertyOld_t].dataSource; "entry_o."; "")
					$reNameProperty_t:="_PROP_"+$tableName_t+"_"+$fieldName_t+"_"+String:C10($noDupCounter)
				Else 
					$pageOld_o.objects[$propertyOld_t].zzzdataSource:=$pageOld_o.objects[$propertyOld_t].dataSource
					// parse the field name out
					$fieldName_t:=$pageOld_o.objects[$propertyOld_t].dataSource
					$tableName_t:=Substring:C12($fieldName_t; 2; Position:C15(":"; $fieldName_t)-2)
					$fieldName_t:=Substring:C12($fieldName_t; Position:C15("]"; $fieldName_t)+1; Length:C16($fieldName_t))
					$fieldName_t:=Substring:C12($fieldName_t; 1; Position:C15(":"; $fieldName_t)-1)
					// name it property
					$reNameProperty_t:="_PROP_"+$tableName_t+"_"+$fieldName_t+"_"+String:C10($noDupCounter)
					$pageOld_o.objects[$propertyOld_t].dataSource:="entry_o."+$fieldName_t
				End if 
				
			: (Position:C15($tableName_t; $pageOld_o.objects[$propertyOld_t].dataSource)>0)
				$pageOld_o.objects[$propertyOld_t].zzzdataSource:=$pageOld_o.objects[$propertyOld_t].dataSource
				// parse the field name out
				$fieldName_t:=$pageOld_o.objects[$propertyOld_t].dataSource
				$tableName_t:=Substring:C12($fieldName_t; 2; Position:C15(":"; $fieldName_t)-2)
				$fieldName_t:=Substring:C12($fieldName_t; Position:C15("]"; $fieldName_t)+1; Length:C16($fieldName_t))
				$fieldName_t:=Substring:C12($fieldName_t; 1; Position:C15(":"; $fieldName_t)-1)
				// name it property
				$reNameProperty_t:="_PROP_"+$tableName_t+"_"+$fieldName_t+"_"+String:C10($noDupCounter)
				$pageOld_o.objects[$propertyOld_t].dataSource:="entry_o."+$fieldName_t
				
				
			: ($propertyOld_t="_PROP_@")
				$reNameProperty_t:=$propertyOld_t
				// Modified by: Bill James (2022-05-05T05:00:00Z)
				ConsoleLog("Already processed: "+$reNameProperty_t)
				
			: ($propertyOld_t="_@")  // already processed
				$reNameProperty_t:=$propertyOld_t
				ConsoleLog("Already processed: "+$reNameProperty_t)
				
			: ($propertyOld_t="Variable@")
				$fieldName_t:=$pageObjects_o[$propertyOld_t].dataSource
				$reNameProperty_t:="_VAR_"+$pageOld_o.objects[$propertyOld_t].dataSource+"_"+String:C10($noDupCounter)
				// leave the dataSource as is for now
				// consider making an object with all the default values for variables
				
			: (($propertyOld_t="listbox@") | ($propertyOld_t="@LB_@"))
				$reNameProperty_t:=$propertyOld_t
				ConsoleLog("Check this ListBox: "+$propertyOld_t)
				
			: ($propertyOld_t="@SF_@")
				$reNameProperty_t:=$propertyOld_t
				ConsoleLog("Check this Subform: "+$propertyOld_t)
			Else 
				$reNameProperty_t:=$propertyOld_t
				ConsoleLog("Object UNK: "+$propertyOld_t)
				// keep other page objects
				If ($pageOld_o.objects[$propertyOld_t].dataSource=Null:C1517)
					ConsoleLog("Without dataSource: "+$propertyOld_t)
				Else 
					ConsoleLog("dataSource: "+$propertyOld_t)
					//If ($pageOld_o.objects[$propertyOld_t].dataSource=$propertyOld_t)
					//$reNameProperty_t:="_VAR_"+$propertyOld_t+"_"+String($noDupCounter)
					//Else 
					//$reNameProperty_t:="_CHK_"+$propertyOld_t+"_"+String($noDupCounter)
					//End if 
				End if 
		End case 
		$reworkedPageObjects_o[$reNameProperty_t]:=$pageOld_o.objects[$propertyOld_t]
	End for each 
	If ($pageOld_o.objects#Null:C1517)
		$pageOld_o.objects:=$reworkedPageObjects_o
	End if 
End for each 
$reworked_t:=JSON Stringify:C1217($asis_o)
var $exists; $writeable : Boolean
$exists:=$file_o.exists
$writeable:=$file_o.isWritable
//  TEXT TO DOCUMENT($file_o.platformPath; $reworked_t)
$file_o.setText($reworked_t)

SET TEXT TO PASTEBOARD:C523($reworked_t)
//End if 