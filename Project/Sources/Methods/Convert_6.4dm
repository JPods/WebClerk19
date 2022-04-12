//%attributes = {"publishedWeb":true}
//Procedure: Convert_6
CONFIRM:C162("Assign new PO cost from Item Avg Cost?")
If (OK=1)
	ALL RECORDS:C47([Item:4])
	$k:=Records in selection:C76([Item:4])
	//ThermoInitExit ("Updating Item Records";$k;True)
	$viProgressID:=Progress New
	
	FIRST RECORD:C50([Item:4])
	For ($i; 1; $k)
		//Thermo_Update ($i)
		ProgressUpdate($viProgressID; $i; $k; "Updating Item Records")
		If (([Item:4]costLastInShip:47=0) & ([Item:4]costAverage:13#0))
			[Item:4]costLastInShip:47:=[Item:4]costAverage:13
			SAVE RECORD:C53([Item:4])
		End if 
		NEXT RECORD:C51([Item:4])
	End for 
	//Thermo_Close 
	Progress QUIT($viProgressID)
End if 
My_MoveShipping
CONFIRM:C162("Fill in Bill to Company in Order/Inv/Pp?")
If (OK=1)
	ALL RECORDS:C47([Order:3])
	ORDER BY:C49([Order:3]; [Order:3]customerid:1)
	$k:=Records in selection:C76([Order:3])
	//ThermoInitExit ("Updating Order Records";$k;True)
	$viProgressID:=Progress New
	
	FIRST RECORD:C50([Order:3])
	For ($i; 1; $k)
		//Thermo_Update ($i)
		ProgressUpdate($viProgressID; $i; $k; "Updating Order Records")
		If ([Order:3]customerid:1#[Customer:2]customerID:1)
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerid:1)
		End if 
		[Order:3]billToCompany:76:=[Customer:2]company:2
		SAVE RECORD:C53([Order:3])
		NEXT RECORD:C51([Order:3])
	End for 
	Progress QUIT($viProgressID)
	
	ALL RECORDS:C47([Invoice:26])
	ORDER BY:C49([Invoice:26]; [Invoice:26]customerid:3)
	$k:=Records in selection:C76([Invoice:26])
	//ThermoInitExit ("Updating Invoice Records";$k;True)
	$viProgressID:=Progress New
	
	FIRST RECORD:C50([Invoice:26])
	For ($i; 1; $k)
		//Thermo_Update ($i)
		ProgressUpdate($viProgressID; $i; $k; "Updating Invoice Records")
		If ([Invoice:26]customerid:3#[Customer:2]customerID:1)
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Invoice:26]customerid:3)
		End if 
		[Invoice:26]bill2Company:69:=[Customer:2]company:2
		SAVE RECORD:C53([Invoice:26])
		NEXT RECORD:C51([Invoice:26])
	End for 
	Progress QUIT($viProgressID)
	
	ALL RECORDS:C47([Proposal:42])
	ORDER BY:C49([Proposal:42]; [Proposal:42]customerid:1)
	$k:=Records in selection:C76([Proposal:42])
	//ThermoInitExit ("Updating Invoice Records";$k;True)
	$viProgressID:=Progress New
	
	FIRST RECORD:C50([Proposal:42])
	For ($i; 1; $k)
		//Thermo_Update ($i)
		ProgressUpdate($viProgressID; $i; $k; "Updating Invoice Records")
		
		If ([Proposal:42]customerid:1#[Customer:2]customerID:1)
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Proposal:42]customerid:1)
		End if 
		[Proposal:42]bill2Company:57:=[Customer:2]company:2
		SAVE RECORD:C53([Proposal:42])
		NEXT RECORD:C51([Proposal:42])
	End for 
	//Thermo_Close 
	Progress QUIT($viProgressID)
	
End if 
