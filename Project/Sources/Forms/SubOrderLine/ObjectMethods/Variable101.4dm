
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/29/20, 16:28:45
// ----------------------------------------------------
// Method: [Order].Input.Variable97
// Description
// 
//
// Parameters
// ----------------------------------------------------


If (Form event code:C388=On Load:K2:1)
	// fill the array on startup
Else 
	entry_o.contractDetailTag:=DE_PopUpArray(Self:C308)
	ContractDetailFill([Order:3]contractDetailTag:151; ->[Order:3]contractDetail:157)
End if 