//%attributes = {}

// Modified by: Bill James (2022-01-26T06:00:00Z)
// Method: Ledger_CustomersSelect
// Description 
// Parameters
// ----------------------------------------------------
// Add to predefined TallyMasters
var ent : Object
C_LONGINT:C283($i; $k)
$k:=Form:C1466.sel.length
CONFIRM:C162("Reledger Current Selection of Customer Records "+String:C10($k))
If (OK=1)
	
	$viProgressID:=Progress New
	For each (ent; Form:C1466.sel)
		$i:=$i+1
		ProgressUpdate($viProgressID; $i; $k; "Rebuild Ledgers")
		If (<>ThermoAbort)
			$i:=$k
		End if 
		Ledger_ThisCustomer(ent.customerID)  // no confirm
		Ledger_TallyBal(ent)
		
	End for each 
	//Thermo_Close 
	Progress QUIT($viProgressID)
End if 