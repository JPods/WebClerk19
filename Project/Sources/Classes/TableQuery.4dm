Class constructor
	C_OBJECT:C1216($1; $3)
	C_LONGINT:C283($2)
	
	This:C1470.dataClass:=$1
	This:C1470.entitiesInDataClass:=$2
	This:C1470.queryString:=""
	This:C1470.path:=""
	This:C1470.type:="IT_"
	This:C1470.inSelection:=False:C215
	This:C1470.indexOnly:=False:C215
	This:C1470.qryOperator:=1
	This:C1470.qryPropertyList:=This:C1470.propertyList(True:C214/*with objects*/; True:C214/*with related entity*/)
	$settings:=New object:C1471
	$settings.indexOnly:=False:C215
	This:C1470.settings:=$settings
	
Function show
	C_TEXT:C284($1; $2)
	C_POINTER:C301($ptr)
	This:C1470.containerName:=$1
	This:C1470.formName:=$2  //Name of the Form to use
	This:C1470.visibleName:=Get localized string:C991("Anywhere")
	This:C1470.path:="_ANYWHERE_"
	$ptr:=OBJECT Get pointer:C1124(Object named:K67:5; This:C1470.containerName)
	OBJECT SET SUBFORM:C1138($ptr->; This:C1470.formName; "")
	$ptr->:=This:C1470
	
Function makePopUp  //Not used
	C_TEXT:C284($1)
	C_POINTER:C301($ptr)
	$popupName:=$1
	$ptr:=OBJECT Get pointer:C1124(Object named:K67:5; $popupName)
	This:C1470.popupPtr:=$ptr
	ARRAY TEXT:C222($ptr->; 0)
	COLLECTION TO ARRAY:C1562(This:C1470.qryPropertyList; This:C1470.popupPtr->; "localName")
	INSERT IN ARRAY:C227(This:C1470.popupPtr->; 1; 2)
	This:C1470.popupPtr->{1}:=Get localized string:C991("Anywhere")
	This:C1470.popupPtr->{2}:="(-"
	This:C1470.popupPtr->:=1
	
Function makeOperatorPopUp
	C_TEXT:C284($1)
	$popupName:=$1
	This:C1470.popupOpPtr:=OBJECT Get pointer:C1124(Object named:K67:5; $popupName)
	This:C1470.operatorList:=New collection:C1472
	This:C1470.operatorList.push(New object:C1471("text"; "Contains"; "operator"; "[]"))
	This:C1470.operatorList.push(New object:C1471("text"; "Begins with"; "operator"; "["))
	This:C1470.operatorList.push(New object:C1471("text"; "Ends with"; "operator"; "]"))
	This:C1470.operatorList.push(New object:C1471("text"; "Is"; "operator"; "="))
	This:C1470.operatorList.push(New object:C1471("text"; "Is not"; "operator"; "!="))
	This:C1470.operatorList.push(New object:C1471("text"; "Is greater than"; "operator"; ">"))
	This:C1470.operatorList.push(New object:C1471("text"; "Is lesser than"; "operator"; "<"))
	This:C1470.operatorList.push(New object:C1471("text"; "Does not contain"; "operator"; "![]"))
	This:C1470.operatorList.push(New object:C1471("text"; "Does not begin with"; "operator"; "!["))
	This:C1470.operatorList.push(New object:C1471("text"; "Does not end with"; "operator"; "!]"))
	COLLECTION TO ARRAY:C1562(This:C1470.operatorList; This:C1470.popupOpPtr->; "text")
	This:C1470.popupOpPtr->:=1
	
Function quickSearch  //This function will be executed in the context of the _QuickQuery_ subform...
	C_OBJECT:C1216($1)  //... which has no access to the context of the main form
	$select:=$1
	$params:=New object:C1471
	
	$text:=This:C1470.queryString
	$targetChoice:=This:C1470.path
	$type:=This:C1470.type
	
	$ptr:=This:C1470.popupOpPtr
	$operator:=This:C1470.operatorList[($ptr->)-1].operator
	$isNumeric:=($text=String:C10(Num:C11($text)))
	$not:=($operator[[1]]="!")
	If ($not)
		$operator:=Substring:C12($operator; 2)
	End if 
	$atBefore:="@"*Num:C11(Position:C15("]"; $operator)>0)
	$atAfter:="@"*Num:C11(Position:C15("["; $operator)>0)
	If (Length:C16($atBefore+$atAfter)>0)
		$operator:="="
	End if 
	$params.qryString:=$text
	$params.isNumeric:=$isNumeric
	$params.operator:=$operator
	$params.not:=$not
	$params.targetChoice:=$targetChoice
	$params.atBefore:=$atBefore
	$params.atAfter:=$atAfter
	$params.inSelection:=This:C1470.inSelection
	CALL FORM:C1391(Current form window:C827; "CF_CallUpstairs"; "doSearch"; FORM Event:C1606; $params)  //So it will call the Search method in the context of the main form
	
Function doQuickSearch  //The actual Search method will run in the context of the main form.
	C_OBJECT:C1216($1; $2)
	$event:=$1
	$params:=$2
	$text:=$params.qryString
	$isNumeric:=$params.isNumeric
	$operator:=$params.operator
	$not:=$params.not
	$targetChoice:=$params.targetChoice
	$atBefore:=$params.atBefore
	$atAfter:=$params.atAfter
	$inSelection:=$params.inSelection
	
	If ($not)
		//$operator:="!"+$operator
	End if 
	$flDoIt:=True:C214
	$selection:=Form:C1466.displayedSelection
	If ($text="")
		If ($event.objectName#Null:C1517)
			If ($event.objectName="@_POPUP_@")
				$flDoIt:=False:C215
			End if 
		Else 
			$result:=Form:C1466.dataClass.all()
		End if 
	Else 
		If ($inSelection)
			$selection:=$selection
		Else 
			$selection:=Form:C1466.dataClass.all()
		End if 
		If ($targetChoice="_ANYWHERE_")  //Search everywhere
			$qryString:=""
			For each ($property; Form:C1466.queryTable.qryPropertyList)
				$toAdd:=""
				If ($qryString#"")
					$toAdd:=" OR "
				End if 
				$fieldName:=Split string:C1554($property.name; "."; sk ignore empty strings:K86:1+sk diacritical:K86:3)[0]
				$fieldProperties:=This:C1470.dataClass[$fieldName]
				Case of 
					: ($fieldProperties.kind="storage")
						$type:=$fieldProperties.fieldType
						$isTypeNumeric:=($type=Is integer:K8:5) | ($type=Is longint:K8:6) | ($type=Is real:K8:4) | ($type=Is integer 64 bits:K8:25) | ($property.name="@_Num")
						$isTypeText:=($type=Is text:K8:3) | ($type=Is alpha field:K8:1) | ($type=Is object:K8:27) | ($type=Is collection:K8:32)  //| ($type="picture") 
						If ($fieldProperties.indexed | Not:C34(Form:C1466.queryTable.indexOnly))
							If ($isTypeNumeric | $isTypeText)
								If (($isTypeNumeric) & ($isNumeric))
									$qryString:=$qryString+$toAdd+$property.name+" "+$operator+" :1"
								Else 
									$qryString:=$qryString+$toAdd+$property.name+" "+$operator+" :2"
								End if 
							End if 
						End if 
						
					: ($fieldProperties.kind="relatedEntity")
						$qryString:=$qryString+$toAdd+$property.name+" "+$operator+" :2"
						
					: ($fieldProperties.kind="calculated")
						//$qryString:=$qryString+$toAdd+$property.name+" "+$operator+" :1"
						
					Else 
						
				End case 
			End for each 
			$result:=$selection.query($qryString; $text; $atBefore+$text+$atAfter)
			//{name:employees,kind:relatedEntities,relatedDataClass:Employee,
			//fieldType:42,type:EmployeeSelection,inverseName:employer}
			//42=Is collection
			//$fieldProperties:=QRY_Util_GetFieldProperties (Form.dataClassName;$property.name)
			
		Else   //Search on one attribute
			//$property:=Form.queryTable.qryPropertyList[$targetChoice-3]
			$propertyName:=$targetChoice  //$property.name
			$fieldName:=Split string:C1554($propertyName; "."; sk ignore empty strings:K86:1+sk diacritical:K86:3)[0]
			$fieldProperties:=Form:C1466.dataClass[$fieldName]
			Case of 
				: ($fieldProperties.kind="storage")
					$type:=$fieldProperties.fieldType
					$isTypeNumeric:=($type=Is integer:K8:5) | ($type=Is longint:K8:6) | ($type=Is real:K8:4) | ($type=Is integer 64 bits:K8:25) | ($propertyName="@_Num")
					If ($isNumeric & $isTypeNumeric)
						$result:=$selection.query($propertyName+" "+$operator+" :1"; $text)
					Else 
						$result:=$selection.query($propertyName+" "+$operator+" :1"; $atBefore+$text+$atAfter)
					End if 
					
				: ($fieldProperties.kind="calculated")
					$result:=$selection.query($propertyName+" "+$operator+" :1"; $atBefore+$text+$atAfter)
					
				: ($fieldProperties.kind="relatedEntity")
					$result:=$selection.query($propertyName+" "+$operator+" :1"; $atBefore+$text+$atAfter)
				Else 
			End case 
		End if 
	End if 
	
	If ($flDoIt)
		If ($not)
			Form:C1466.displayedSelection:=Form:C1466.dataClass.all().minus($result)
		Else 
			Form:C1466.displayedSelection:=$result
		End if 
		Util_UpdateOnContext
	End if 
	
	
Function propertyList
	C_OBJECT:C1216($currentSelection; $zeProperty; $dataClass; $zeRelatedDataclass; $zeRelatedProperty; $object)
	C_TEXT:C284($property; $relatedProperty)
	C_COLLECTION:C1488($zePaths)
	C_BOOLEAN:C305($1; $2)
	
	$withObjects:=$1  //We want to query on Object attributes
	$withRelated:=$2  //We want to query on Related Entity
	$dataClass:=This:C1470.dataClass
	
	//We make the list of the Entity Types accepted by Query in a Collection (much simpler than an array)
	$colOK2Use:=New collection:C1472("long"; "string"; "number"; "date"; "duration"; "bool"; "long64"; "float"; "variant")
	// Other types, like image, blob, or objects, cannot be use directly for searching
	$qryPropertyList:=New collection:C1472
	For each ($property; $dataClass)  //For each property in the DataClass ($property is the property name)
		If ($property#"_@")  //Until we have the getInfo() on Fields, I use the prefix the Field Name with "_" in order to know if it's supposed to be invisible...
			$zeProperty:=$dataClass[$property]  //Access the property from it's name
			Case of 
				: ($zeProperty.kind="storage")
					$x:=Type:C295($zeProperty)
					Case of 
						: (($zeProperty.type="object") & $withObjects)  //If it's an object field, we will get the different contents
							//Until the member function .distinctPaths will be available, please use:
							$zePaths:=wrap_distinctPaths($dataClass.all(); $zeProperty.name)  //Equivalent to DISTINCT ATTRIBUTE PATHS
							//As soon as available, replace the line above by the following one:
							//$zePaths:=$currentSelection.distinctPaths($zeProperty.name)
							
							For each ($path; $zePaths)
								Case of 
									: ($path="@[]")  //Object itself
										$object:=$qryPropertyList.pop()  //Returns the last object while removing it
										$object.type:="object"
										$qryPropertyList.push(New object:C1471("name"; $zeProperty.name+"."+$path; "type"; "array"; "localName"; Util_Get_LocalizedMessage($zeProperty.name)+"."+$path))
										
									: ($path="@.length")  //This the number of elements of an array
										//$qryPropertyList.push(New object("name";$zeProperty.name+"."+$path;"type";"long"))
										//Here you can define other exclusions if needed
										
									Else 
										$qryPropertyList.push(New object:C1471("name"; $zeProperty.name+"."+$path; "type"; "variant"; "localName"; Util_Get_LocalizedMessage($zeProperty.name)+"."+$path))
										//We use Variant for the type, for we can't know the type of an object's property
								End case 
							End for each 
							
						: ($colOK2Use.indexOf($zeProperty.type)>-1)  //We can use it for searching
							$qryPropertyList.push(New object:C1471("name"; $zeProperty.name; "type"; $zeProperty.type; "localName"; Util_Get_LocalizedMessage($zeProperty.name)))
							
						Else 
							
					End case 
					
				: ($zeProperty.kind="calculated")
					If ($zeProperty.name="@_Num")
						$zeProperty.type:="number"
					End if 
					$qryPropertyList.push(New object:C1471("name"; $zeProperty.name; "type"; $zeProperty.type; "localName"; $zeProperty.name))  //Util_Get_LocalizedMessage ($zeProperty.name)))
					
				: (($zeProperty.kind="relatedEntity") & $withRelated)  //We are going to get the related One table's fields
					$zeRelatedDataclass:=ds:C1482[$zeProperty.relatedDataClass]
					For each ($relatedProperty; $zeRelatedDataclass)
						$zeRelatedProperty:=$zeRelatedDataclass[$relatedProperty]
						If ($zeRelatedProperty.kind="storage")
							If ($colOK2Use.indexOf($zeProperty.type)>-1)
								$qryPropertyList.push(New object:C1471("name"; $zeProperty.name+"."+$zeRelatedProperty.name; "type"; $zeRelatedProperty.type; "localName"; Util_Get_LocalizedMessage($zeProperty.name)+"."+Util_Get_LocalizedMessage($zeRelatedProperty.name)))
							End if 
						End if 
					End for each 
					
				: ($zeProperty.kind="relatedEntities")  //do nothing in simple queries
					
				Else 
					
			End case 
		End if 
	End for each 
	$0:=$qryPropertyList
	
Function propertyList2Menu
	C_OBJECT:C1216($currentSelection; $zeProperty; $dataClass; $zeRelatedDataclass; $zeRelatedProperty; $object; $qryPropertyObject)
	C_TEXT:C284($property; $relatedProperty)
	C_COLLECTION:C1488($zePaths)
	C_BOOLEAN:C305($1; $2)
	$withObjects:=$1  //We want to query on Object attributes
	$withRelated:=$2  //We want to query on Related Entity
	$dataClass:=This:C1470.dataClass
	
	//We make the list of the Entity Types accepted by Query in a Collection (much simpler than an array)
	$colOK2Use:=New collection:C1472("long"; "string"; "number"; "date"; "duration"; "bool"; "long64"; "float"; "variant")
	// Other types, like image, blob, or objects, cannot be use directly for searching
	$qryPropertyMenu:=Create menu:C408
	APPEND MENU ITEM:C411($qryPropertyMenu; Get localized string:C991("Anywhere"))
	SET MENU ITEM PARAMETER:C1004($qryPropertyMenu; -1; "_ANYWHERE_")
	APPEND MENU ITEM:C411($qryPropertyMenu; "(-")
	
	For each ($property; $dataClass)  //For each property in the DataClass ($property is the property name)
		If ($property#"_@")  //Until we have the getInfo() on Fields, I use the prefix the Field Name with "_" in order to know if it's supposed to be invisible...
			$zeProperty:=$dataClass[$property]  //Access the property from it's name
			Case of 
				: (($zeProperty.type="number") | ($zeProperty.type="long") | ($zeProperty.type="long64") | ($zeProperty.type="float") | ($zeProperty.name="@_Num"))
					$key:="IN_"
				: ($zeProperty.type="bool")
					$key:="IB_"
				: ($zeProperty.type="date")
					$key:="ID_"
				Else 
					$key:="IT_"
			End case 
			Case of 
				: ($zeProperty.kind="storage")
					$x:=Type:C295($zeProperty)
					Case of 
						: (($zeProperty.type="object") & $withObjects)  //If it's an object field, we will get the different contents
							$qryPropertyMenu:=This:C1470.propertyObject2Menu($zeProperty; $qryPropertyMenu; $dataClass; "")
							
						: ($colOK2Use.indexOf($zeProperty.type)>-1)  //We can use it for searching
							//$qryPropertyList.push(New object("name";$zeProperty.name;"type";$zeProperty.type;"localName";Util_Get_LocalizedMessage ($zeProperty.name)))
							APPEND MENU ITEM:C411($qryPropertyMenu; $zeProperty.name)
							SET MENU ITEM PARAMETER:C1004($qryPropertyMenu; -1; This:C1470.makeReference($key; $zeProperty.name; Null:C1517; ""))
							
						Else 
							
					End case 
					
				: ($zeProperty.kind="calculated")
					If ($zeProperty.name="@_Num")
						$zeProperty.type:="number"
					End if 
					//$qryPropertyList.push(New object("name";$zeProperty.name;"type";$zeProperty.type;"localName";$zeProperty.name))  //Util_Get_LocalizedMessage ($zeProperty.name)))
					APPEND MENU ITEM:C411($qryPropertyMenu; $zeProperty.name)
					SET MENU ITEM PARAMETER:C1004($qryPropertyMenu; -1; This:C1470.makeReference($key; $zeProperty.name; Null:C1517; ""))
					
				: (($zeProperty.kind="relatedEntity") & $withRelated)  //We are going to get the related One table's fields
					$zeRelatedDataclass:=ds:C1482[$zeProperty.relatedDataClass]
					$objPropertyList:=New collection:C1472
					For each ($relatedProperty; $zeRelatedDataclass)
						$zeRelatedProperty:=$zeRelatedDataclass[$relatedProperty]
						Case of 
							: (($zeRelatedProperty.type="object") & $withObjects)  //If it's an object field, we will get the different contents
								$subMenu:=Create menu:C408
								$subMenu:=This:C1470.propertyObject2Menu($zeRelatedProperty; $subMenu; $zeRelatedDataclass; $zeProperty.name)
								$objPropertyList.push(New object:C1471("name"; $zeRelatedProperty.name; "type"; $zeRelatedProperty.type; "localName"; $zeRelatedProperty.name; "subMenu"; $subMenu))
								//RELEASE MENU($subMenu)
								
							: ($colOK2Use.indexOf($zeRelatedProperty.type)>-1)  //We can use it for searching
								//$objPropertyList.push(New object("name";$zeProperty.name+"."+$zeRelatedProperty.name;"type";$zeRelatedProperty.type;"localName";Util_Get_LocalizedMessage ($zeProperty.name)+"."+Util_Get_LocalizedMessage ($zeRelatedProperty.name)))
								$objPropertyList.push(New object:C1471("name"; $zeRelatedProperty.name; "type"; $zeRelatedProperty.type; "localName"; $zeRelatedProperty.name))
						End case 
					End for each 
					$subMenu:=Create menu:C408
					For each ($item; $objPropertyList)
						If ($item.subMenu=Null:C1517)
							APPEND MENU ITEM:C411($subMenu; $item.localName)
							SET MENU ITEM PARAMETER:C1004($subMenu; -1; This:C1470.makeReference($key; $zeProperty.name; $item; ""))  // $key+$zeProperty.name+"."+$item.name+)
						Else 
							APPEND MENU ITEM:C411($subMenu; $item.localName; $item.subMenu)
						End if 
					End for each 
					APPEND MENU ITEM:C411($qryPropertyMenu; $zeProperty.name; $subMenu)
					
				: ($zeProperty.kind="relatedEntities")  //do nothing in simple queries
					
				Else 
					
			End case 
		End if 
	End for each 
	$choice:=Dynamic pop up menu:C1006($qryPropertyMenu)  //Displays the popup menu
	RELEASE MENU:C978($qryPropertyMenu)
	//If ($choice#"")
	//ALERT($choice+" = "+This.dataClass.get(Num(Substring($choice;4))).Name)
	//End if 
	$0:=$choice
	
Function propertyObject2Menu
	C_OBJECT:C1216($1; $3; $object)
	C_TEXT:C284($4; $2)
	$zeProperty:=$1
	$qryPropertyMenu:=$2
	$dataClass:=$3
	$prefix:=$4
	//Until the member function .distinctPaths will be available, please use:
	$zePaths:=wrap_distinctPaths($dataClass.all(); $zeProperty.name)  //Equivalent to DISTINCT ATTRIBUTE PATHS
	//As soon as available, replace the line above by the following one:
	//$zePaths:=$currentSelection.distinctPaths($zeProperty.name)
	$objPropertyList:=New collection:C1472
	For each ($path; $zePaths)
		Case of 
			: ($path="@[]")
				$object:=$objPropertyList.pop()  //Returns the last object while removing it
				$object.type:="object"
				$objPropertyList.push(New object:C1471("name"; $path; "type"; "array"; "localName"; $path))
				
			: ($path="@.length")  //This the number of elements of an array or collection
				$objPropertyList.push(New object:C1471("name"; $path; "type"; "array"; "localName"; $path))
				
			Else 
				$objPropertyList.push(New object:C1471("name"; $path; "type"; "variant"; "localName"; $path))
				//$qryPropertyList.push(New object("name";$zeProperty.name+"."+$path;"type";"variant";"localName";Util_Get_LocalizedMessage ($zeProperty.name)+"."+$path))
				//We use Variant for the type, for we can't know the type of an object's property
		End case 
	End for each 
	$subMenu:=Create menu:C408
	For each ($item; $objPropertyList)
		APPEND MENU ITEM:C411($subMenu; $item.localName)
		If ($prefix="")
			SET MENU ITEM PARAMETER:C1004($subMenu; -1; This:C1470.makeReference("IT_"; $zeProperty.name; $item; ""))  //"IT_"+$zeProperty.name+"."+$item.name)
		Else 
			SET MENU ITEM PARAMETER:C1004($subMenu; -1; This:C1470.makeReference("IT_"; $zeProperty.name; $item; $prefix))  //"IT_"+$prefix+"."+$zeProperty.name+"."+$item.name)
		End if 
	End for each 
	If ($prefix="")
		APPEND MENU ITEM:C411($qryPropertyMenu; $zeProperty.name; $subMenu)
		RELEASE MENU:C978($subMenu)
		$0:=$qryPropertyMenu
	Else 
		$0:=$subMenu
	End if 
	
Function makeReference
	C_OBJECT:C1216($3)
	C_TEXT:C284($1; $2; $4)
	$key:=$1
	$propertyName:=$2
	$item:=$3
	$prefix:=$4
	$separator:="*{}*"
	$result:=$key
	$visibleName:=Util_Get_LocalizedMessage($propertyName)
	If ($prefix#"")
		$result:=$result+$prefix+"."
		$visibleName:=Util_Get_LocalizedMessage($prefix)+"."+$visibleName
	End if 
	$result:=$result+$propertyName
	If ($item#Null:C1517)
		$result:=$result+"."+$item.name
		$visibleName:=$visibleName+"."+$item.localName
	End if 
	$result:=$result+$separator+$visibleName
	$0:=$result
	
Function getInfoFmChoice
	C_TEXT:C284($1)
	C_OBJECT:C1216($0)
	$choice:=$1
	$separator:="*{}*"
	$result:=New object:C1471
	Case of 
		: ($choice="_ANYWHERE_")
			$result.display:="Anywhere"
			$result.key:="IT_"
			$result.path:=$choice
		Else 
			$result.key:=Substring:C12($choice; 1; 3)  //"IN_" or "IT_"
			$choice:=Substring:C12($choice; 4)
			$pos:=Position:C15($separator; $choice)
			If ($pos<1)
				$result.display:=$choice
				$result.path:=$choice
			Else 
				$result.display:=Substring:C12($choice; $pos+Length:C16($separator))
				$result.path:=Substring:C12($choice; 1; $pos-1)
			End if 
	End case 
	$0:=$result
	
	
	
	
	