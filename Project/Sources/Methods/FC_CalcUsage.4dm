//%attributes = {"publishedWeb":true}
If (False:C215)
	//Date: 05/08/02
	//Who: Janani, Arkware
	//Description: added calc of qty on hand and tally
	VERSION_960
End if 
TRACE:C157
C_TEXT:C284($vFCItem)
C_LONGINT:C283($fia; $w; $k)
C_DATE:C307($ytdDate; $ytdDateLess1; $ytdDateLess2)

FC_FillRay(-8)
$k:=Size of array:C274(aFCItem)
//ThermoInitExit ("Processing Items.";$k;True)
$viProgressID:=Progress New

If ($k>0)
	For ($w; 1; $k)
		//Thermo_Update ($w)
		ProgressUpdate($viProgressID; $w; $k; "Processing Items")
		
		If (<>ThermoAbort)
			$w:=$k
		End if 
		$vFCItem:=aFCItem{$w}
		CREATE SET:C116([Item:4]; "Current")  // save selection
		QUERY:C277([Item:4]; [Item:4]itemNum:1=$vFCItem)
		aFCBaseQty{$w}:=[Item:4]qtyOnHand:14
		USE SET:C118("Current")
		$ytdDate:=Date_ThisYear(Current date:C33; 0)
		$ytdDateLess1:=Date_ThisYear($ytdDate-1; 0)
		$ytdDateLess2:=Date_ThisYear($ytdDateLess1-1; 0)
		aFCTallyYTD{$w}:=FC_SumYear($vFCItem; $ytdDate)
		aFCTallyLess1Year{$w}:=FC_SumYear($vFCItem; $ytdDateLess1)
		aFCTallyLess2Year{$w}:=FC_SumYear($vFCItem; $ytdDateLess2)
		
	End for 
End if 
//Thermo_Close 
Progress QUIT($viProgressID)
TRACE:C157

