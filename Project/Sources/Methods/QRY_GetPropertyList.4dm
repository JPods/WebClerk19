//%attributes = {}



// 4D_25Invoice - 2022-01-15
C_PICTURE:C286($pict)
C_OBJECT:C1216($currentSelection; $zeProperty; $dataClass; $zeRelatedDataclass; $zeRelatedProperty; $object; $criteria; $dsDescription; $relatedDataclass)
C_TEXT:C284($property; $relatedProperty)
C_COLLECTION:C1488($zePaths; $typeList)

$what2do:=$1
$formData:=$2
$currentSelection:=$3

//We make the list of the Entity Types accepted by Query or Order by, in a Collection (much simpler than an array)
$colOK2Use:=New collection:C1472("long"; "string"; "number"; "date"; "duration"; "bool"; "long64"; "float"; "variant")
// Other types, like image, blob, or objects, cannot be use directly for sorting

//We get the things that we will need (here the pictures of up and down arrows) but it can be Strings or any other data
$formData.pictures:=New object:C1471
Case of 
	: ($what2do="SORT")
		$colOK2Use.push("image").push("blob").push("object").push("array").push("1toN").push("Nto1").push("table")  //  To add properties which can be used for searching...
		$path:=Get 4D folder:C485(Current resources folder:K5:16)+"Images"+Folder separator:K24:12+"4DIcons"+Folder separator:K24:12
		READ PICTURE FILE:C678($path+"ArrowUp.png"; $pict)
		$formData.pictAsc:=$pict
		READ PICTURE FILE:C678($path+"ArrowDown.png"; $pict)
		$formData.pictDesc:=$pict
		READ PICTURE FILE:C678($path+"ArrowOpen.png"; $pict)
		$formData.pictOpen:=$pict
		READ PICTURE FILE:C678($path+"ArrowClose.png"; $pict)
		$formData.pictClose:=$pict
		READ PICTURE FILE:C678($path+"Grey.png"; $pict)
		$formData.pictGrey:=$pict
		
	: ($what2do="QRY")
		$colOK2Use.push("image").push("blob").push("object").push("array").push("1toN").push("Nto1").push("table")  //  To add properties which can be used for searching...
		$path:=Get 4D folder:C485(Current resources folder:K5:16)+"Images"+Folder separator:K24:12+"4DIcons"+Folder separator:K24:12
		READ PICTURE FILE:C678($path+"Grey.png"; $pict)
		$formData.pictGrey:=$pict
		READ PICTURE FILE:C678($path+"ArrowOpen.png"; $pict)
		$formData.pictOpen:=$pict
		READ PICTURE FILE:C678($path+"ArrowClose.png"; $pict)
		$formData.pictClose:=$pict
		
End case 
$formData.emojis:=QRY_GetEmojis
//We can use Pictures, but we can also use Emojis in order to emulate Popup Menus or special Open-Close functions in standard ListBoxes

QRY_GetPropertyTypePictures($formData; $colOK2Use; $what2do)
$dataClass:=$formData.dataClass
$propertyList:=New collection:C1472
$dataClass:=$formData.dataClass
$index:=0
For each ($property; $dataClass)  //For each property in the DataClass ($property is the property name)
	If ($property#"_@")  //We have decided that fields whose name starts with a '_' should not be visible
		$index:=$index+1
		$zeProperty:=$dataClass[$property]  //Access the property from it's name
		Case of 
			: ($zeProperty.kind="storage")
				Case of 
					: ($zeProperty.type="object")  //If it's an object field, we will get the different contents
						//Until the member function .distinctPaths will be available, please use:
						$zePaths:=wrap_distinctPaths($currentSelection; $zeProperty.name)  //Equivalent to DISTINCT ATTRIBUTE PATHS
						//As soon as available, replace the line above by the following one:
						//$zePaths:=$currentSelection.distinctPaths($zeProperty.name)
						$collection:=New collection:C1472
						For each ($path; $zePaths)
							$path2use:=$property+"."+$path
							$fl_Array:=False:C215
							If ($path#"@[]")
								$fl_Array:=($zePaths.indexOf($path+"[]")>-1)
							End if 
							
							Case of 
								: ($fl_Array)
									$collection.push(New object:C1471("name"; $path+"<span style='color:#0096FF'> (Content)</span>"; \
										"path"; $path2use+"[]"; \
										"family"; $property; \
										"type"; "array"; \
										"index"; $index))
									$collection.push(New object:C1471("name"; $path+"<span style='color:#FF2600'> (Count)</span>"; \
										"path"; $path2use+".length"; \
										"family"; $property; \
										"type"; "long"; \
										"index"; $index))
									$x:=$zePaths.indexOf($path+"[]")
									If ($x>-1)
										$zePaths.remove($x; 1)
									End if 
									$x:=$zePaths.indexOf($path+".length")
									If ($x>-1)
										$zePaths.remove($x; 1)
									End if 
									
								: (($path="@[]") & ($what2do="SORT"))  //This is a collection
									$object:=$formData.propertyList.pop()  //In case of Sorting, only length is relevant
									If ($path="@.length")  //This the number of elements of an array
										$collection.push(New object:C1471("name"; $path; \
											"path"; $path2use; \
											"family"; $property; \
											"type"; "long"; \
											"index"; $index))
									End if 
									
								: ($path="@[]")
									$collection.push(New object:C1471("name"; Substring:C12($path; 1; Length:C16($path)-2); \
										"path"; $path2use; \
										"family"; $property; \
										"type"; "array"; \
										"index"; $index))
									
								: ($path="@.length")  //This is the number of elements of a collection
									$collection.push(New object:C1471("name"; $path; \
										"path"; $path2use; \
										"family"; $property; \
										"type"; "long"; \
										"index"; $index))
									//Here you can define other exclusions if needed
									
								Else 
									$collection.push(New object:C1471("name"; $path; \
										"path"; $path2use; \
										"family"; $property; \
										"type"; "variant"; \
										"index"; $index))  //We use Variant for the type, for we can't know the type of an object's property
							End case 
							$index:=$index+1
						End for each 
						$propertyList.push(New object:C1471("name"; $property; \
							"path"; ""; \
							"subFields"; $collection; \
							"type"; "object"; \
							"close"; True:C214; \
							"index"; $index))
						
					: ($colOK2Use.indexOf($zeProperty.type)>-1)  //We can use it for sorting or searching
						$propertyList.push(New object:C1471("name"; $property; \
							"path"; $property; \
							"type"; QRY_Util_GetFieldProperties(Form:C1466.dataClassName; $property).typeS; \
							"family"; ""; \
							"index"; $index))
						
					Else 
						
				End case 
				
			: (($zeProperty.kind="relatedEntities") & ($what2do="SORT"))  //This is 1->N relation, it can't be used for sorting
				
				
			: ($zeProperty.kind="relatedEntities")  //We are going to get the related Many table's fields
				$relatedDataclass:=$formData.dataStore[$zeProperty.relatedDataClass]
				$collection:=New collection:C1472
				For each ($relatedProperty; $relatedDataclass)
					If ($relatedProperty#"_@")
						$path2use:=$property+"."+$relatedProperty
						$zeRelatedProperty:=$relatedDataclass[$relatedProperty]
						If ($zeRelatedProperty.kind="storage")
							$collection.push(New object:C1471("name"; $relatedProperty; \
								"path"; $path2use; \
								"family"; $property; \
								"type"; QRY_Util_GetFieldProperties($zeProperty.relatedDataClass; $relatedProperty).type; \
								"index"; $index))
						End if 
						$index:=$index+1
					End if 
				End for each 
				$propertyList.push(New object:C1471("name"; $property; \
					"path"; ""; \
					"subFields"; $collection; \
					"type"; "1toN"; \
					"close"; True:C214; \
					"index"; $index))
				
			: ($zeProperty.kind="relatedEntity")  //We are going to get the related One table's fields
				$relatedDataclass:=$formData.dataStore[$zeProperty.relatedDataClass]
				$collection:=New collection:C1472
				For each ($relatedProperty; $relatedDataclass)
					If ($relatedProperty#"_@")
						$path2use:=$property+"."+$relatedProperty
						$zeRelatedProperty:=$relatedDataclass[$relatedProperty]
						If ($zeRelatedProperty.kind="storage")
							$collection.push(New object:C1471("name"; $relatedProperty; \
								"path"; $path2use; \
								"family"; $property; \
								"type"; QRY_Util_GetFieldProperties(Form:C1466.dataClassName; $relatedProperty).type; \
								"index"; $index))
						End if 
						$index:=$index+1
					End if 
				End for each 
				$propertyList.push(New object:C1471("name"; $property; \
					"path"; ""; \
					"subFields"; $collection; \
					"type"; "Nto1"; \
					"close"; True:C214; \
					"index"; $index))
				
			: ($zeProperty.kind="calculated")
				$propertyList.push(New object:C1471("name"; $property; \
					"path"; $property; \
					"type"; "number"; \
					"family"; ""; \
					"index"; $index))
				
			: ($zeProperty.kind="alias")
				$propertyList.push(New object:C1471("name"; $property; \
					"path"; $property; \
					"type"; "number"; \
					"family"; ""; \
					"index"; $index))
				
			Else 
				
		End case 
	End if 
End for each 

$0:=$propertyList