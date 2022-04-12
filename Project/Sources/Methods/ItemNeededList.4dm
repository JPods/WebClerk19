//%attributes = {"publishedWeb":true}
C_LONGINT:C283($k; $i; $w)
jsetDefaultFile(->[Item:4])
ALL RECORDS:C47([Item:4])
$k:=Records in selection:C76([Item:4])
CREATE EMPTY SET:C140([Item:4]; "CurItems")
FIRST RECORD:C50([Item:4])
//ThermoInitExit ("Processing Item Records";$w;True)
$viProgressID:=Progress New

For ($i; 1; $k)
	//Thermo_Update ($i)
	ProgressUpdate($viProgressID; $i; $k; "Processing Item Records")
	If (<>ThermoAbort)
		$i:=$k
	End if 
	If ([Item:4]qtyOnHand:14+[Item:4]qtyOnPo:20-[Item:4]qtyOnSalesOrder:16<[Item:4]qtyMinStock:18)
		ADD TO SET:C119([Item:4]; "CurItems")
	End if 
	NEXT RECORD:C51([Item:4])
End for 
//Thermo_Close 
Progress QUIT($viProgressID)
USE SET:C118("CurItems")
CLEAR SET:C117("CurItems")
ProcessTableOpen(->[Item:4])