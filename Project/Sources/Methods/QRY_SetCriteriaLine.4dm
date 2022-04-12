//%attributes = {}



// 4D_25Invoice - 2022-01-15
C_OBJECT:C1216($propertySelected;$1;$line;$valueObject)
C_COLLECTION:C1488($col_Operator)

$propertySelected:=$1
If (Count parameters:C259>1)
	$where:=$2
Else 
	$where:=-1
End if 

If ($propertySelected#Null:C1517)
	$col_Logicals:=New collection:C1472
	$col_Logicals.push(Get localized string:C991("operator_and"))\
		.push(Get localized string:C991("operator_or"))\
		.push(Get localized string:C991("operator_except"))
	$emptyLine:=New object:C1471("logicOperator";"";"operator";"";"propertyName";"";"path";"";"type";"";"value";"";"family";"";"condition";"";"menu";"")
	
	$n:=Form:C1466.criteria.length
	If ($n=0)
		$line:=OB Copy:C1225($emptyLine)
		Form:C1466.criteria.push($line)
	Else 
		$line:=New object:C1471("logicOperator";"and";"operator";"";"propertyName";"";"path";"";"type";"";"value";"";"family";"";"condition";"";"menu";"")
		If ($where=-1)
			Form:C1466.criteria.push($line)  //APPEND TO ARRAY(qry_ar_Logicals;New object("valueType";"text";"value";"And";"requiredList";$col_Logicals))
		Else 
			Form:C1466.criteria.insert($where;$line)
		End if 
	End if 
	Case of   //"long";"string";"number";"date";"duration";"bool";"long64";"float";"variant"
		: ($propertySelected.type="string")
			$index:=0
			$type:="text"
		: ($propertySelected.type="bool")
			$index:=2
			$type:="boolean"
		: ($propertySelected.type="date")
			$index:=3
			$type:="text"
		: ($propertySelected.type="duration")
			$index:=3
			$type:="text"
		: ($propertySelected.type="image")
			$index:=4
			$type:="text"
		: ($propertySelected.type="blob")
			$index:=5
			$type:="integer"
		: ($propertySelected.type="variant")
			$index:=7
			$type:="text"
		: ($propertySelected.type="property")
			$index:=6
			$type:="text"
		: ($propertySelected.type="1toN")
			$index:=6
			$type:="text"
		: ($propertySelected.type="Nto1")
			$index:=6
			$type:="text"
		: ($propertySelected.type="object")
			$index:=7
			$type:="text"
		: ($propertySelected.type="array")  //Added to the normal list of properties for obvious reasons...
			$index:=7
			$type:="text"
		Else 
			$index:=1  //"long";"number";"long64";"float"
			If (($propertySelected.type="long") | ($propertySelected.type="long64"))
				$type:="integer"
			Else 
				$type:="real"
			End if 
	End case 
	$item:=0
	$valueObject:=QRY_SetCriteriaValueCell ($index;$item;$type)
	$col_Operator:=Form:C1466.queryMenus[$index].extract("menu")
	$name:=$propertySelected.path
	$pos:=Position:C15(".";$name)
	If ($pos>0)
		$name:=Substring:C12($name;$pos+1)
	End if 
	If ($propertySelected.family=Null:C1517)
		$name:=$propertySelected.name
		If (Character code:C91($name[[1]])>8200)
			$name:=Substring:C12($name;3)
		End if 
	Else 
		If ($propertySelected.family#"")
			$name:=$propertySelected.family+"."+$name
		End if 
		If ($name="@[]")
			$name:=Substring:C12($name;1;Length:C16($name)-2)+" (Content)"
		Else 
			If ($name="@.length")
				$name:=Substring:C12($name;1;Length:C16($name)-Length:C16(".length"))+" (Count)"
			End if 
		End if 
	End if 
	$line.logicOperator:=Get localized string:C991("operator_and")+" "+Form:C1466.emojis.charMenu
	$line.logicOperatorChoice:="and"
	  //$line.menu:=$col_Operator
	$line.operator:=$col_Operator[0]+" "+Form:C1466.emojis.charMenu
	$line.condition:=$valueObject.condition
	$line.propertyName:=$name
	$line.family:=$propertySelected.family
	$line.path:=$propertySelected.path
	$line.originalType:=$propertySelected.type
	$line.value:=$valueObject.value
	$line.valueType:=$valueObject.valueType
	$line.menuIndex:=$index
	$line.type:=$type
	$line.index:=$propertySelected.index
	$line.item:=$item
	Form:C1466.criteria[0].logicOperator:=Form:C1466.pictGrey
	Form:C1466.criteria[0].logicOperatorChoice:=""
	Form:C1466.criteria:=Form:C1466.criteria
End if 
