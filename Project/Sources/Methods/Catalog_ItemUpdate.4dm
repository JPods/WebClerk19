//%attributes = {}

// Modified by: Bill James (2022-11-13T06:00:00Z)
// Method: Catalog_ItemUpdate
// Description 
// Parameters
// ----------------------------------------------------
#DECLARE($incoming_o : Object; $setup_o : Object)->$result : Object


If ($incoming_o=Null:C1517)
	//why
Else 
	var $rec_o; $sel_o; $mapItem_o : Object
	If ($setup_o.dataClassName#Null:C1517)
		Repeat 
			If (Length:C16($incoming_o[$setup_o.map.key.foreign])<8)
				$incoming_o[$setup_o.map.key.foreign]:="0"+$incoming_o[$setup_o.map.key.foreign]
			End if 
		Until (Length:C16($incoming_o[$setup_o.map.key.foreign])>=8)
		
		$sel_o:=ds:C1482[$setup_o.dataClassName].query($setup_o.map.key.home+" = :1"; $incoming_o[$setup_o.map.key.foreign]+$setup_o.vendorSuffix)
		$doSave:=True:C214
		Case of 
			: ($sel_o.length>1)
				ConsoleLog("Multiples: "+String:C10($sel_o.length)+": "+$setup_o.map.key.foreign)
				$doSave:=False:C215
				vi1:=vi1+1
			: ($sel_o.length=1)
				$rec_o:=$sel_o.first()
				vi2:=vi2+1
			Else 
				vi3:=vi3+1
				$rec_o:=ds:C1482.Item.new()
				$rec_o.itemNum:=$incoming_o[$setup_o.map.key.foreign]+$setup_o.vendorSuffix
				$rec_o.indicator6:=1
				$rec_o.dateLastCost:=Current date:C33
				$rec_o.obGeneral:=Init_obGeneral
				$rec_o.vendorID:="Copperfield"
				$rec_o.dateLastCost:=Current date:C33
				$rec_o.dateReleased:=Current date:C33
				$rec_o.dateCreated:=Current date:C33
				$rec_o.vendorItemNum:=$incoming_o[$setup_o.map.key.foreign]
				$rec_o.save()
		End case 
		
		If ($doSave)
			
			
			$rec_o.obGeneral.history.push(New object:C1471("raw"+$setup_o.dateTimeISO; $incoming_o))
			var $property_t : Text
			var $changes_c : Collection
			$changes_c:=New collection:C1472
			For each ($property_t; $setup_o.map)
				If ($property_t="priceMSR")
					If ($incoming_o[$setup_o.map[$property_t].foreign]#"")
						
					End if 
				End if 
				$changes_c.push(New object:C1471($property_t; New collection:C1472(\
					$rec_o[$setup_o.map[$property_t].home]; \
					$incoming_o[$setup_o.map[$property_t].foreign])))
				If ($property_t#"key")
					$typeFld:=Value type:C1509($rec_o[$setup_o.map[$property_t].home])
					Case of 
						: ($property_t="docPath@")
							// HOWTO:Undefined  https://developer.4d.com/docs/Concepts/null-undefined/#undefined
							var $incomeProperty : Text
							$incomeProperty:=$setup_o.map[$property_t].foreign
							If (Not:C34(Undefined:C82($incoming_o[$incomeProperty])))
								If ($incoming_o[$incomeProperty]#"")
									$rec_o.obGeneral.docPaths[$property_t]:=$incoming_o[$setup_o.map[$property_t].foreign]
								End if 
							End if 
						: ($property_t="script_@")
							// handle all at the end
						: (($typeFld=Is alpha field:K8:1) | ($typeFld=Is text:K8:3))
							$rec_o[$setup_o.map[$property_t].home]:=$incoming_o[$setup_o.map[$property_t].foreign]
							
						: (($typeFld=Is real:K8:4) | ($typeFld=_o_Is float:K8:26))
							$rec_o[$setup_o.map[$property_t].home]:=Round:C94(Num:C11($incoming_o[$setup_o.map[$property_t].foreign]); 2)
							
						: (($typeFld=Is longint:K8:6) | ($typeFld=Is integer 64 bits:K8:25))
							If ($obField.fieldName="DT@")
								$rec_o[$setup_o.map[$property_t].home]:=Num:C11($incoming_o[$setup_o.map[$property_t].foreign])
							Else 
								$rec_o[$setup_o.map[$property_t].home]:=String:C10($incoming_o[$setup_o.map[$property_t].foreign])
							End if 
							
						: ($typeFld=Is date:K8:7)
							$rec_o[$setup_o.map[$property_t].home]:=Date:C102($incoming_o[$setup_o.map[$property_t].foreign])  //; Internal date short)
							// add goFigure
							
						: ($typeFld=Is time:K8:8)
							$rec_o[$setup_o.map[$property_t].home]:=Time:C179($incoming_o[$setup_o.map[$property_t].foreign])  // ; HH MM AM PM)
							
						: ($typeFld=Is boolean:K8:9)
							If (($incoming="t@") || ($incoming="1@") || ($incoming_o[$setup_o.map[$property_t].foreign]="y@"))
								$rec_o[$setup_o.map[$property_t].home]:=True:C214
							Else 
								$rec_o[$setup_o.map[$property_t].home]:=False:C215
							End if 
							
						: ($typeFld=Is object:K8:27)
							$rec_o[$setup_o.map[$property_t].home]:=JSON Parse:C1218($incoming_o[$setup_o.map[$property_t].foreign])
						: ($typeFld=Is picture:K8:10)
							//$rec_o[$setup_o.map[$property_t].home]:="Error: is picture"
						: ($typeFld=Is BLOB:K8:12)
							//$rec_o[$setup_o.map[$property_t].home]:="Error: is blob"
						Else 
							//$rec_o[$setup_o.map[$property_t].home]:="Error: undefined"
					End case 
					// Catalog_setValue($rec_o; $setup_o.map[$property_t].home]; $incoming_o[$setup_o.map[$property_t].foreign])
				End if 
			End for each 
			//ExecuteScript_Object()
			$rec_o.costAverage:=$rec_o.costMSC
			$rec_o.costLastInShip:=$rec_o.costMSC
			
			Case of 
				: ($rec_o.status="Active@")
					$rec_o.retired:=False:C215
					If ($rec_o.dateRetired#!00-00-00!)
						$rec_o.dateRetired:=!00-00-00!
						$rec_o.dateReleased:=Current date:C33
					End if 
				: ($rec_o.status="Inactive@")
					If ($rec_o.retired=False:C215)
						$rec_o.retired:=True:C214
						$rec_o.dateRetired:=Current date:C33
					End if 
				: ($rec_o.status="Special@")
					If ($rec_o.retired=True:C214)
						$rec_o.dateReleased:=Current date:C33
					End if 
					If ($rec_o.alertMessage="")
						$rec_o.alertMessage:="Special Order"
					Else 
						If (Position:C15("Special Order"; $rec_o.alertMessage)<1)
							$rec_o.alertMessage:="Special Order: "+$rec_o.alertMessage
						End if 
					End if 
			End case 
			
			//$rec_o.salesGlAccount:="sale_"+$rec_o.vendorSuffix
			//$rec_o.costGLAccount:="cost_"+$rec_o.vendorSuffix
			//$rec_o.inventoryGlAccount:="inventory_"+$rec_o.vendorSuffix
			$rec_o.salesGlAccount:="47990"
			$rec_o.costGLAccount:="50100"
			$rec_o.inventoryGlAccount:="12200"
			$rec_o.indicator7:=20230213
			
			Catalog_History($rec_o; $changes_c)
			var $tags_t : Text
			$tags_t:=KeyTagsFromAlphaFields($rec_o)
			$rec_o.menu:=JSON Stringify:C1217($rec_o.obGeneral)
			$rec_o.save()
		End if 
	End if 
End if 

