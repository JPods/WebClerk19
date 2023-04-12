
// Modified by: Bill James (2022-04-02T05:00:00Z)
// Method: oLoButtonBar.aActions
// Description 
// Parameters
// ----------------------------------------------------
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		process_o.entitySave()
		// load in the form on load
		If (process_o.cur.action#Null:C1517)
			//Form.ents:=ds[process_o.dataClassName].query("action = :1"; Self->{Self->})
		Else 
			//ALERT("No Action field")
		End if 
End case 