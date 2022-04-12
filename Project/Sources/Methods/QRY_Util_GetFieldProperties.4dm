//%attributes = {}



// 4D_25Invoice - 2022-01-15
//This Method is a Wrapper, which is used in order to wait for a future ORDA capability to deliver directlty these informations

var $fFound; $fLength; $fNum; $fType; $tFound; $tNum : Integer
var $fIndexed; $fInvisible; $fUnique : Boolean
var $1; $2; $dataClassName; $fieldName : Text

$dataClassName:=$1
$fieldName:=$2

$result:=New object:C1471

If (True:C214)  //new way using ORDA
	$property:=ds:C1482[$dataclassname][$fieldname]
	If ($property#Null:C1517)
		$types:=New collection:C1472("string"; "number"; "string"; "image"; "date"; ""; "bool"; ""; "number"; "number"; ""; "date"; "variant")  //From 0 to 12, numbers are contiguous
		$types[Is string var:K8:2]:="string"
		$types[Is integer 64 bits:K8:25]:="number"
		$types[Is BLOB:K8:12]:="blob"
		$types[Is object:K8:27]:="object"
		$types[Is collection:K8:32]:="42"
		$types[Is null:K8:31]:=""
		//Storage attributes can be "number", "date", "object", "bool", "image", "blob", or "string"
		
		$result.typeL:=$property.fieldType
		$result.length:=0  //We don't need it now
		$result.indexed:=$property.indexed
		$result.unique:=$property.unique
		$result.invisible:=($fieldname="_@")  //My own convention: field beginning with _ is invisible
		$result.typeS:=$types[$property.fieldType]
		$result.type:=$property.type
	End if 
	
Else   //Classic way. Compare the size of the code...
	If ($dataClassName#"")
		If ($fieldName#"")
			$pos:=Position:C15("."; $fieldName)
			If ($pos>0)
				$fieldName:=Substring:C12($fieldName; 1; $pos-1)
			End if 
			$tFound:=0
			For ($tNum; 1; Get last table number:C254)
				If (Is table number valid:C999($tNum))
					If (Table name:C256($tNum)=$dataClassName)
						$tFound:=$tNum
						$tNum:=Get last table number:C254
					End if 
				End if 
			End for 
			If ($tFound>0)
				$fFound:=0
				For ($fNum; 1; Get last field number:C255($tFound))
					If (Is field number valid:C1000($tFound; $fNum))
						If (Field name:C257($tFound; $fNum)=$fieldName)
							$fFound:=$fNum
							$fNum:=Get last field number:C255($tFound)
						End if 
					End if 
				End for 
			End if 
			If ($fFound>0)
				GET FIELD PROPERTIES:C258($tFound; $fFound; $fType; $fLength; $fIndexed; $fUnique; $fInvisible)
				$result.typeL:=$fType
				$result.length:=$fLength
				$result.indexed:=$fIndexed
				$result.unique:=$fUnique
				$result.invisible:=$fInvisible
				Case of 
					: (($fType=Is real:K8:4) | ($fType=_o_Is float:K8:26))
						$result.typeS:="number"
					: (($fType=Is longint:K8:6) | ($fType=Is integer:K8:5) | ($fType=Is integer 64 bits:K8:25))
						$result.typeS:="long"
					: (($fType=Is text:K8:3) | ($fType=Is alpha field:K8:1) | ($fType=Is string var:K8:2))
						$result.typeS:="string"
					: ($fType=Is date:K8:7)
						$result.typeS:="date"
					: ($fType=Is time:K8:8)
						$result.typeS:="duration"
					: ($fType=Is picture:K8:10)
						$result.typeS:="image"
					: ($fType=Is boolean:K8:9)
						$result.typeS:="bool"
					: ($fType=Is BLOB:K8:12)
						$result.typeS:="BLOb"
					: ($fType=Is object:K8:27)
						$result.typeS:="object"
					: ($fType=Is collection:K8:32)
						$result.typeS:="collection"
						
					Else 
						//Is null or not handled
						$result.typeS:="null"
				End case 
			End if 
		End if 
	End if 
End if 

$0:=$result