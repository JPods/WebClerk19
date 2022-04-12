//%attributes = {}



// 4D_25Invoice - 2022-01-15
C_OBJECT:C1216($subfield; $property)
C_COLLECTION:C1488($listOriginal; $subfields)
C_TEXT:C284($class; $subfieldName)

$listOriginal:=$1
$plistChoice:=$2

$propertyList:=New collection:C1472
$spacer:=Char:C90(NBSP ASCII CODE:K15:43)*8
For each ($property; $listOriginal)
	Case of 
		: ($property.type=Null:C1517)
			
		: ($property.type="1toN")
			If ($plistChoice>2)
				$line:=New object:C1471
				$line.name:=Form:C1466.emojis.charOpenS+" "+$property.name
				$line.path:=$property.path
				$line.family:=$property.family
				$line.subFields:=$property.subFields
				$line.type:=$property.type
				$line.index:=$property.index
				$propertyList.push($line)
				If (Not:C34($property.close))
					$line.name:=Form:C1466.emojis.charCloseS+" "+$property.name
					$subfields:=$property.subFields
					For each ($subfield; $subfields)
						$line:=New object:C1471
						$line.name:=$spacer+$subfield.name
						$line.path:=$subfield.path
						$line.family:=$subfield.family
						$line.type:=$subfield.type
						$line.index:=$subfield.index
						$propertyList.push($line)
					End for each 
				End if 
			Else 
				
			End if 
			
		: ($property.type="Nto1")
			If ($plistChoice>2)
				$line:=New object:C1471
				$line.name:=Form:C1466.emojis.charOpenS+" "+$property.name
				$line.path:=$property.path
				$line.family:=$property.family
				$line.type:=$property.type
				$line.index:=$property.index
				$propertyList.push($line)
				If (Not:C34($property.close))
					$line.name:=Form:C1466.emojis.charCloseS+" "+$property.name
					$subfields:=$property.subFields
					For each ($subfield; $subfields)
						$line:=New object:C1471
						$line.name:=$spacer+$subfield.name
						$line.path:=$subfield.path
						$line.family:=$subfield.family
						$line.type:=$subfield.type
						$line.index:=$subfield.index
						$propertyList.push($line)
					End for each 
				End if 
			Else 
				
			End if 
			
		: ($property.type="object")
			If ($plistChoice>1)
				$line:=New object:C1471
				$line.name:=Form:C1466.emojis.charOpenS+" "+$property.name
				$line.path:=$property.path
				$line.family:=$property.family
				$line.subFields:=$property.subFields
				$line.type:=$property.type
				$line.index:=$property.index
				$propertyList.push($line)
				If (Not:C34($property.close))
					$line.name:=Form:C1466.emojis.charCloseS+" "+$property.name
					$subfields:=$property.subFields
					For each ($subfield; $subfields)
						$line:=New object:C1471
						$line.name:=$spacer+$subfield.name
						$line.path:=$subfield.path
						$line.family:=$subfield.family
						$line.type:=$subfield.type
						$line.index:=$subfield.index
						$propertyList.push($line)
					End for each 
				End if 
			Else 
				$propertyList.push($property)
			End if 
			
		Else 
			$propertyList.push($property)
	End case 
	
End for each 

If ($plistChoice>3)
	$index:=1000
	For each ($class; Form:C1466.dataStore)
		If ($class#Form:C1466.dataClassName)
			If (Form:C1466.dsDescription[$class]#Null:C1517)  //Form.dataClassName
				$index:=$index+1
				$line:=New object:C1471
				$line.name:=Form:C1466.emojis.charOpenS+" ["+$class+"]"
				$line.path:=$class
				$line.family:=$class
				$line.type:="table"
				$line.index:=$index
				$propertyList.push($line)
				If (Form:C1466.qryTablesClose[$class]=Null:C1517)
					Form:C1466.qryTablesClose[$class]:=True:C214
				End if 
				If (Not:C34(Form:C1466.qryTablesClose[$class]))
					$line.name:=Form:C1466.emojis.charCloseS+" ["+$class+"]"
					$subfields:=Form:C1466.dsDescription[$class].fields
					For each ($subfieldName; $subfields)
						If (Form:C1466.dsDescription[$class].fields[$subfieldName].kind="storage")
							$index:=$index+1
							$line:=New object:C1471
							$line.name:=$spacer+$subfieldName
							$line.path:=$class+"."+$subfieldName
							$line.family:=$class
							$line.type:=$subfields[$subfieldName].typeS
							$line.index:=$index
							$propertyList.push($line)
						End if 
					End for each 
				End if 
			End if 
		End if 
	End for each 
End if 
$0:=$propertyList

