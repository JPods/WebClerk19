//%attributes = {}

// Modified by: Bill James (2022-01-22T06:00:00Z)
// Method: 19DevForm_TableToObj
// Description 
// Parameters
// ----------------------------------------------------

If (False:C215)  // remove when devloping
	If (Count parameters:C259=0)
		var $key_t; $path; $pathExtention : Text
		var $inc_i; $cnt_i : Integer
		
		$cnt_i:=Get last table number:C254
		$key_t:=Request:C163("Enter Key to convert TF form to objects.")
		If ((OK=1) & ($key_t="forkPhone"))
			$path:="Beldin:Users:williamjames:Documents:CommerceExpert:00WebClerk-PreORDA:Project:Sources:TableForms:"
			For ($inc_i; 2; $cnt_i)
				$pathExtention:=String:C10($inc_i)+":InputDS:form.4DForm"
				If (Test path name:C476($path+$pathExtention)=1)
					ConsoleMessage("Converting: "+Table name:C256($inc_i))
					19DevForm_TableToObj($path+$pathExtention)
				Else 
					ConsoleMessage("Failed, no path: "+Table name:C256($inc_i))
				End if 
			End for 
		End if 
		
	Else 
		var $1; $path_t : Text
		
		If (Count parameters:C259=1)
			$path_t:=$1
		Else 
			$path_t:="Beldin:Users:williamjames:Documents:CommerceExpert:00WebClerkApp:Project:Sources:TableForms:3:InputDS:form.4DForm"
		End if 
		If ($path_t#"")
			var $working_t; $reworked_t; $property_t; $fieldName_t; $tableName; $reNameProperty_t : Text
			var $asIS_o; $pageObjects_o; $field_o; $reworkedPage_o; $workingPage_o : Object
			var $pages_c; $pageArrange_c : Collection
			
			
			$working_t:=Document to text:C1236($path_t)
			SET TEXT TO PASTEBOARD:C523($working_t)
			$asis_o:=JSON Parse:C1218($working_t)
			$pages_c:=$asis_o.pages
			
			$pageCount_i:=$asis_o.pages.length
			
			var $pageCount_i : Integer
			$pageCount_i:=-1
			For each ($workingPage_o; $asis_o.pages)
				$pageCount_i:=$pageCount_i+1
				If ($workingPage_o#Null:C1517)
					$pageObjects_o:=$asis_o.pages[$pageCount_i].objects
					If ($pageObjects_o#Null:C1517)
						$pageArrange_c:=$asis_o.pages[$pageCount_i].entryOrder
						
						// reset each page
						$reworkedPageObjects_o:=New object:C1471
						$arrange_t:=""
						If ($pageArrange_c#Null:C1517)
							$arrange_t:=$pageArrange_c.join(",")
						End if 
						
						var $cnt_i : Integer
						$cnt_i:=-1
						For each ($property_t; $pageObjects_o)
							$cnt_i:=$cnt_i+1
							If ($property_t#"Field@")
								$reworkedPageObjects_o[$property_t]:=$pageObjects_o[$property_t]
							Else 
								// items beginning the zzz may be deleted at any time. This is set just for audit of the conversion
								$pageObjects_o[$property_t].zzzdataSource:=$pageObjects_o[$property_t].dataSource
								
								$fieldName_t:=$pageObjects_o[$property_t].dataSource
								$tableName:=Substring:C12($fieldName_t; 2; Position:C15(":"; $fieldName_t)-2)
								$fieldName_t:=Substring:C12($fieldName_t; Position:C15("]"; $fieldName_t)+1; Length:C16($fieldName_t))
								$fieldName_t:=Substring:C12($fieldName_t; 1; Position:C15(":"; $fieldName_t)-1)
								$reNameProperty_t:="_PROP_"+$tableName+"_"+$fieldName_t+"_"
								
								// change dataSource and rename property
								$pageObjects_o[$property_t].dataSource:="entryEntity."+$fieldName_t
								// replace in entryOrder
								$arrange_t:=Replace string:C233($arrange_t; $property_t; $reNameProperty_t)
								// put the changes into a new page object
								$reworkedPageObjects_o[$reNameProperty_t]:=$pageObjects_o[$property_t]
							End if 
						End for each 
						// replace the page objects
						If ($reworkedPageObjects_o#Null:C1517)
							$asis_o.pages[$pageCount_i].objects:=$reworkedPageObjects_o
						End if 
						If ($arrange_t#"")
							$reworkedPageEntry_c:=Split string:C1554($arrange_t; ",")
							$asis_o.pages[$pageCount_i].entryOrder:=$reworkedPageEntry_c
						End if 
						
					End if 
				End if 
			End for each 
			$reworked_t:=JSON Stringify:C1217($asis_o)
			SET TEXT TO PASTEBOARD:C523($reworked_t)
			TEXT TO DOCUMENT:C1237($path_t; $reworked_t)
			
		End if 
	End if 
End if 

If (False:C215)
	var $TM_ent : Object
	var $method_t : Text
	$TM_ent:=ds:C1482.TallyMaster.query("name =  InputDSMethod").first()
	If ($TM_ent#Null:C1517)
		$TM_ent.$method_t:=$TM_ent.build
	End if 
	If ($method_t="")
		$method_t:="// TallyMaster not defined name = InputDSMethod"
	End if 
	$method_t:=" // "+String:C10(Current date:C33; ISO date GMT:K1:10)+" -- Current User: "+Current user:C182+"\r"+$method_t
	$pathToMethod:="Beldin:Users:williamjames:Documents:CommerceExpert:00WebClerkProject:Project:Sources:TableForms:3:InputDS:method.4dm"
	TEXT TO DOCUMENT:C1237($pathToMethod; $method_t)
End if 