//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 03/13/18, 11:12:26
// ----------------------------------------------------
// Method: MyTest17
// Description
// 
//
// Parameters
// ----------------------------------------------------


vi2:=Records in selection:C76([Item:4])
FIRST RECORD:C50([Item:4])
For (vi1; 1; vi2)
	vText1:=[Item:4]itemNum:1
	// [Item]ItemNum:=[Item]VendorItemNum
	[Item:4]priceC:4:=[Item:4]costLastInShip:47
	SAVE RECORD:C53([Item:4])
	NEXT RECORD:C51([Item:4])
End for 

READ WRITE:C146([ProposalLine:43])
vi2:=Records in selection:C76([ProposalLine:43])
FIRST RECORD:C50([ProposalLine:43])
For (vi1; 1; vi2)
	QUERY:C277([Item:4]; [Item:4]itemNum:1=[ProposalLine:43]itemNum:2)
	If (Records in selection:C76([Item:4])=1)
		// [Item]ItemNum:=[Item]VendorItemNum
		[ProposalLine:43]unitCost:7:=[Item:4]costLastInShip:47
	Else 
		[ProposalLine:43]itemProfile4:49:="No Item"
	End if 
	SAVE RECORD:C53([ProposalLine:43])
	NEXT RECORD:C51([ProposalLine:43])
End for 



If (False:C215)  // fix part numbers
	vi2:=Records in selection:C76([ProposalLine:43])
	FIRST RECORD:C50([ProposalLine:43])
	TRACE:C157
	For (vi1; 1; vi2)
		Case of 
			: ([ProposalLine:43]itemNum:2="@-AdvChm@")
				[ProposalLine:43]itemNum:2:=Replace string:C233([ProposalLine:43]itemNum:2; "-AdvChm"; "")
			: ([ProposalLine:43]itemNum:2="@-Local@")
				[ProposalLine:43]itemNum:2:=Replace string:C233([ProposalLine:43]itemNum:2; "-Local"; "")
			: ([ProposalLine:43]itemNum:2="@-Copperfld@")
				[ProposalLine:43]itemNum:2:=Replace string:C233([ProposalLine:43]itemNum:2; "-Copperfld"; "-CCS")
		End case 
		QUERY:C277([Item:4]; [Item:4]itemNum:1=[ProposalLine:43]itemNum:2)
		Case of 
			: (Records in selection:C76([Item:4])=1)
				[ProposalLine:43]itemProfile4:49:="Items = 1"
			: (Records in selection:C76([Item:4])>1)
				[ProposalLine:43]itemProfile4:49:="Items = "+String:C10(Records in selection:C76([Item:4]))
			Else 
				vi8:=Position:C15("-"; [ProposalLine:43]itemNum:2)
				If (vi8>0)
					vText8:=Substring:C12([ProposalLine:43]itemNum:2; vi8-1)
					QUERY:C277([Item:4]; [Item:4]itemNum:1=vText8)
					Case of 
						: (Records in selection:C76([Item:4])=1)
							[ProposalLine:43]itemProfile4:49:="Items = 1 with -"
						: (Records in selection:C76([Item:4])>1)
							[ProposalLine:43]itemProfile4:49:="Items = "+String:C10(Records in selection:C76([Item:4]))+" with -"
						Else 
							QUERY:C277([Item:4]; [Item:4]itemNum:1=vText8+"@")
							If (Records in selection:C76([Item:4])>0)
								[ProposalLine:43]itemProfile4:49:="Items = with CCS"
							Else 
								[ProposalLine:43]itemProfile4:49:="Items = 0 with -"
							End if 
							
							
					End case 
				Else 
					[ProposalLine:43]itemProfile4:49:="Items = 0 no -"
				End if 
		End case 
		SAVE RECORD:C53([ProposalLine:43])
		NEXT RECORD:C51([ProposalLine:43])
	End for 
	
End if 


If (False:C215)
	
	
	QUERY:C277([TallyResult:73]; [TallyResult:73]Purpose:2="ErrorEmail"; *)
	QUERY:C277([TallyResult:73];  & ; [TallyResult:73]Profile1:17="open")
	If (Records in selection:C76([TallyResult:73])>0)
		ProcessTableOpen(Table:C252(->[TallyResult:73]))
	Else 
		ConsoleMessage("No duplicate Email issues.")
	End if 
	
	C_POINTER:C301($1; $vpFieldParent; $vpFieldChild; $vpTable)
	$vpFieldChild:=$1
	$vpFieldParent:=$2
	
	$vpTableChild:=Table:C252(Table:C252($vpFieldChild))
	QUERY:C277($vpTableChild->; $vpFieldChild->=$vpFieldParent->)
	//$0:=Records in selection($vpTableChild->)
	$0:=Selection to JSON:C1234([OrderLine:49]; [OrderLine:49]itemNum:4; [OrderLine:49]qtyOrdered:6)
End if 