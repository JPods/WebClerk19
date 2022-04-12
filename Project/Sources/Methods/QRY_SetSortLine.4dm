//%attributes = {}



// 4D_25Invoice - 2022-01-15
C_OBJECT:C1216($propertySelected;$1;$object;$valueObject;$object)
C_COLLECTION:C1488($col_Operator)
C_TEXT:C284($type)

$propertySelected:=$1
If (Count parameters:C259>1)
	$where:=$2
Else 
	$where:=-1
End if 

If ($propertySelected#Null:C1517)
	$object:=OB Copy:C1225($propertySelected)
	$n:=Form:C1466.criteriaList.length
	If ($n=0)
		Form:C1466.criteriaList.push($object)
	Else 
		If ($where=-1)
			Form:C1466.criteriaList.push($object)
		Else 
			Form:C1466.criteriaList.insert($where;$object)
		End if 
	End if 
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
	$object.name:=$name
	$object.propertyName:=$name
	$object.family:=$propertySelected.family
	$object.path:=$propertySelected.path
	$object.originalType:=$propertySelected.type
	$object.valueType:=$valueObject.valueType
	$object.type:=$type
	$object.criteriaDesc:=False:C215
	$object.criteriaPict:=Choose:C955(Num:C11($object.criteriaDesc);Form:C1466.pictAsc;Form:C1466.pictDesc)
	
End if 
