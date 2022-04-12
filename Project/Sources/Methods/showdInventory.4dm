//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 01/14/14, 08:12:56
// ----------------------------------------------------
// Method: showdInventory
// Description
// 
//
// Parameters
// ----------------------------------------------------
//  ### jwm ### 20140114_0936 updated to include Work Order Transfers

//QUERY([dInventory];[dInventory]DTItemCard=0)
C_LONGINT:C283($time)
$time:=Milliseconds:C459
CREATE EMPTY SET:C140([DInventory:36]; "Pending")
QUERY:C277([DInventory:36]; [DInventory:36]dtItemCard:16=0)
CREATE SET:C116([DInventory:36]; "QOH")
QUERY:C277([DInventory:36]; [DInventory:36]dtSiteID:34=0; *)
If (Size of array:C274(<>asiteIDs)>1)
	QUERY:C277([DInventory:36])
	//  ### jwm ### 20140616_1346 
	// if using siteIDs all siteIDs must be filled for all dInventory
Else 
	QUERY:C277([DInventory:36];  & ; [DInventory:36]siteID:20#"")
	//  ### jwm ### 20140616_1528 ignore empty Site ID
End if 
CREATE SET:C116([DInventory:36]; "QWO")
UNION:C120("QOH"; "QWO"; "Pending")
USE SET:C118("Pending")
CLEAR SET:C117("QOH")
CLEAR SET:C117("QWO")
CLEAR SET:C117("Pending")
$time:=Milliseconds:C459-$time
jMessageWindow("Elapsed time = "+String:C10($time)+" milliseconds")
ProcessTableOpen(->[DInventory:36])



