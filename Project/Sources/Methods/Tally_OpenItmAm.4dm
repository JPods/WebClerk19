//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-10-05T00:00:00, 11:31:49
// ----------------------------------------------------
// Method: Tally_OpenItmAm
// Description
// Modified: 10/05/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20150204_1430 was missing Next Record 
// ### jwm ### 20150323_1718 reset every Item Record reset Items to zero when needed.
// ### jwm ### 20160118_1426 moved outside if statement

C_LONGINT:C283($w; $i; $k; $cntItem)
C_BOOLEAN:C305(ThermoAbort)

// why are we creating a service record and not an Eventlog ???
CREATE RECORD:C68([TallyResult:73])
[TallyResult:73]name:1:="Tally_OpenItmAm"
[TallyResult:73]name:1:="TallyAction"
[TallyResult:73]salesNameID:31:=Current user:C182
[TallyResult:73]dtReport:12:=DateTime_DTTo(Current date:C33; Current time:C178)
[TallyResult:73]profile1:17:="Update Open Item Qty"

C_LONGINT:C283($i; $k)

ALL RECORDS:C47([Item:4])
$k:=Records in selection:C76([Item:4])
FIRST RECORD:C50([Item:4])
//ThermoInitExit ("Tally Qty OnSalesOrder/OnPO";$k;True)  // ### jwm ### 20150204_1424 changed to true "New Thermo"
$viProgressID:=Progress New
For ($i; 1; $k)
	//Thermo_Update ($i)
	ProgressUpdate($viProgressID; $i; $k; "Tally Qty OnSalesOrder/OnPO")
	If (ThermoAbort)
		$i:=$k
	End if 
	If (Locked:C147([Item:4]))
		[TallyResult:73]textBlk1:5:="Locked:__"+[Item:4]itemNum:1+"__"+String:C10([Item:4]qtyOnSalesOrder:16)+"__"+String:C10([Item:4]qtyOnPo:20)+"\r"
	Else 
		QUERY:C277([OrderLine:49]; [OrderLine:49]itemNum:4=[Item:4]itemNum:1; *)
		//QUERY([OrderLine]; & ;[OrderLine]QtyBackLogged>0)  // ### jwm ### 20150323_1718
		QUERY:C277([OrderLine:49])
		[Item:4]qtyOnSalesOrder:16:=Sum:C1([OrderLine:49]qtyBackLogged:8)
		QUERY:C277([POLine:40]; [POLine:40]itemNum:2=[Item:4]itemNum:1; *)
		//QUERY([POLine]; & ;[POLine]QtyBackLogged>0) // ### jwm ### 20150323_1718
		QUERY:C277([POLine:40])
		[Item:4]qtyOnPo:20:=Sum:C1([POLine:40]qtyBackLogged:5)
		[Item:4]qtyAvailable:73:=[Item:4]qtyOnHand:14-[Item:4]qtyOnSalesOrder:16-[Item:4]qtyAllocated:72  //### jwm ### 20130226_1809
		[Item:4]qtyAvailable:73:=[Item:4]qtyAvailable:73*Num:C11([Item:4]qtyAvailable:73>0)  //### jwm ### 20130226_1809
		SAVE RECORD:C53([Item:4])
	End if 
	NEXT RECORD:C51([Item:4])  // ### jwm ### 20150204_1430 was missing Next Record // ### jwm ### 20160118_1426 moved outside if statement
End for 
If ([TallyResult:73]textBlk1:5#"")
	SAVE RECORD:C53([TallyResult:73])
	DB_ShowCurrentSelection(->[TallyResult:73]; ""; 0; "Locked Items in Tally of Qty OnOrder/OnPO"; 0)
End if 
UNLOAD RECORD:C212([Item:4])
UNLOAD RECORD:C212([TallyResult:73])
//If ($doMessage)
//Thermo_Close 
Progress QUIT($viProgressID)
//End if 