//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-29T06:00:00Z)
// Method: PVars_AddressFull
// Description 
// Parameters
// ----------------------------------------------------
var $o : Object
var $1 : Variant
var $0 : Text
var $tableName : Text
If (Count parameters:C259>0)
	Case of 
		: ((Value type:C1509($1)=Is longint:K8:6) | (Value type:C1509($1)=Is real:K8:4) | (Value type:C1509($1)=Is integer:K8:5))
			$tableName:=Table name:C256($1)
		: ((Value type:C1509($1)=Is text:K8:3) | (Value type:C1509($1)=Is string var:K8:2))
			$tableName:=$1
		: (Value type:C1509($1)=Is object:K8:27)
			$tableName:=$1
		: (Value type:C1509($1)=12)
			$tableName:=$1
		: (Value type:C1509($1)=Is pointer:K8:14)
			$tableName:=Table name:C256($1)
		Else 
			//
	End case 
	JustAddress:=""
	If ($tableName#"")
		If ($tableName=process_o.tableName)
			$o:=process_o.cur
		Else 
			$o:=process_o.ents[$tableName].first()
		End if 
	End if 
Else 
	$o:=process_o.cur
End if 
If ($o.address1#Null:C1517)
	JustAddress:=jConcat($o.address1; "\r")+jConcat($o.address2; "\r")+jConcat($o.city; ", ")+jConcat($o.state; " ")+jConcat($o.zip; " ")+$o.country
	$o.obGeneral.justAddress:=JustAddress
End if 
If ($o.nameFirst#Null:C1517)
	$name:=jConcat($o.nameFirst+(" "*Num:C11($o.nameFirst#""))+$o.nameLast)
	$o.obGeneral.attention:=$name
End if 

JustAddress:=Txt_ClearExtraReturns(JustAddress)
$0:=JustAddress