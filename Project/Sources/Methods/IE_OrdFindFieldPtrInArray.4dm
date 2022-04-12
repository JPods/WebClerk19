//%attributes = {"publishedWeb":true}
//Method: PM:  IE_OrdFindFieldPtrInArray
//Noah Dykoski   May 13, 2000 / 4:16 AM
C_POINTER:C301($0)  //var pointer, the var contains the value of the field requested or blank / zero
C_POINTER:C301($1; $FieldPtr)
$FieldPtr:=$1
C_POINTER:C301($2; $FieldArrayPtr)
$FieldArrayPtr:=$2
C_POINTER:C301($3; $DataArrayPtr)
$DataArrayPtr:=$3

C_LONGINT:C283($Type)
$Type:=Type:C295($FieldPtr->)
C_LONGINT:C283($fia)
$fia:=Find in array:C230($FieldArrayPtr->; $FieldPtr)
If ($fia>0)
	Case of 
		: (($Type=Is alpha field:K8:1) | ($Type=Is text:K8:3) | ($Type=Is string var:K8:2))  //string
			C_TEXT:C284(vtTextTemp)
			vtTextTemp:=$DataArrayPtr->{$fia}
			$0:=->vtTextTemp
		: ($Type=Is integer:K8:5)  //Integer
			C_LONGINT:C283(viIntegerTemp)
			viIntegerTemp:=Num:C11($DataArrayPtr->{$fia})
			$0:=->viIntegerTemp
		: ($Type=Is longint:K8:6)  //LongInt
			C_LONGINT:C283(vlLongIntTemp)
			vlLongIntTemp:=Num:C11($DataArrayPtr->{$fia})
			$0:=->vlLongIntTemp
		: ($Type=Is real:K8:4)  //Real
			C_REAL:C285(vrRealTemp)
			vrRealTemp:=Num:C11($DataArrayPtr->{$fia})
			$0:=->vrRealTemp
		: ($Type=Is time:K8:8)  //time
			C_TIME:C306(vtTimeTemp)
			vtTimeTemp:=Time:C179($DataArrayPtr->{$fia})
			$0:=->vtTimeTemp
		: ($Type=Is date:K8:7)  //date
			C_DATE:C307(vdDateTemp)
			vdDateTemp:=Date:C102($DataArrayPtr->{$fia})
			$0:=->vdDateTemp
		: ($Type=Is boolean:K8:9)  //boolean
			C_BOOLEAN:C305(vbBooleanTemp)
			If (($DataArrayPtr->{$fia}="true") | ($DataArrayPtr->{$fia}="yes") | ($DataArrayPtr->{$fia}="1"))
				vbBooleanTemp:=True:C214
			Else 
				vbBooleanTemp:=False:C215
			End if 
			$0:=->vbBooleanTemp
	End case 
Else 
	Case of 
		: (($Type=0) | ($Type=2) | ($Type=24))  //string
			C_TEXT:C284(vtTextTemp)
			vtTextTemp:=""
			$0:=->vtTextTemp
		: (($Type=1) | ($Type=8) | ($Type=9))  //Integer
			C_LONGINT:C283(viIntegerTemp)
			viIntegerTemp:=0
			$0:=->viIntegerTemp
		: (($Type=1) | ($Type=8) | ($Type=9))  //LongInt
			C_LONGINT:C283(vlLongIntTemp)
			vlLongIntTemp:=0
			$0:=->vlLongIntTemp
		: (($Type=1) | ($Type=8) | ($Type=9))  //Real
			C_REAL:C285(vrRealTemp)
			vrRealTemp:=0
			$0:=->vrRealTemp
		: ($Type=11)  //time
			C_TIME:C306(vtTimeTemp)
			vtTimeTemp:=?00:00:00?
			$0:=->vtTimeTemp
		: ($Type=4)  //date
			C_DATE:C307(vdDateTemp)
			vdDateTemp:=!00-00-00!
			$0:=->vdDateTemp
		: ($Type=6)  //boolean
			C_BOOLEAN:C305(vbBooleanTemp)
			vbBooleanTemp:=False:C215
			$0:=->vbBooleanTemp
	End case 
End if 