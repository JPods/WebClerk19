//%attributes = {"publishedWeb":true}
//Procedure: PpLine_Update
READ WRITE:C146([ProposalLine:43])
$k:=Records in selection:C76([ProposalLine:43])
ORDER BY:C49([ProposalLine:43]; [ProposalLine:43]itemNum:2)
FIRST RECORD:C50([ProposalLine:43])
READ ONLY:C145([Item:4])
//ThermoInitExit ("Expanding Item Information";$k;True)
$viProgressID:=Progress New
For ($i; 1; $k)
	//Thermo_Update ($i)
	ProgressUpdate($viProgressID; $i; $k; "Expanding Item Information")
	If (<>ThermoAbort)
		$i:=$k
	End if 
	If ([Item:4]itemNum:1#[ProposalLine:43]itemNum:2)
		QUERY:C277([Item:4]; [Item:4]itemNum:1=[ProposalLine:43]itemNum:2)
	End if 
	[ProposalLine:43]itemType:45:=[Item:4]type:26
	[ProposalLine:43]itemProfile1:46:=[Item:4]profile1:35
	[ProposalLine:43]itemProfile2:47:=[Item:4]profile2:36
	//[ProposalLine]obHistory:=[Item]profile3
	//[ProposalLine]obItem:=[Item]profile4
	[ProposalLine:43]vendorID:44:=[Item:4]vendorID:45
	SAVE RECORD:C53([ProposalLine:43])
	NEXT RECORD:C51([ProposalLine:43])
End for 
READ WRITE:C146([Item:4])
READ ONLY:C145([ProposalLine:43])
//Thermo_Close 
Progress QUIT($viProgressID)
UNLOAD RECORD:C212([Item:4])