//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-27T06:00:00Z)
// Method: PVars_Manufacturer
// Description 
// Parameters
// ----------------------------------------------------


var $1; $data_o : Object
$data_o:=$1
MfgName:=$data_o.company
MfgAddress:=PVar_AddressOnly($data_o)
MfgAttn:=$data_o.nameFirst+(" "*Num:C11($data_o.nameFirst#""))+$data_o.nameLast
MfgPhone:=Format_Phone($data_o.phone)
MfgPhoneCell:=Format_Phone($data_o.phoneCell)
MfgFAX:=Format_Phone($data_o.fax)

If (print_o=Null:C1517)
	print_o:=New object:C1471
End if 
print_o.mfgName:=MfgName
print_o.mfgAddress:=MfgAddress
print_o.mfgAttn:=MfgAttn
print_o.mfgPhone:=MfgPhone
print_o.mfgFAX:=MfgFAX
print_o.mfgPhoneCell:=MfgPhoneCell
