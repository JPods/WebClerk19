//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/22/10, 11:44:21
// ----------------------------------------------------
// Method: Sync_PostOut
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)
C_LONGINT:C283($2)
Case of 
	: (Count parameters:C259<2)
		
	: ($1=(->[Proposal:42]))
		If ($2=1)
			CONFIRM:C162("Post out Proposal.")
			If (OK=1)
				Records_Out(->[Proposal:42]; Storage:C1525.folder.jitExportsF+"042RecsSyncOrders.out"; 0)  //File; name of file; keep selection
				QUERY:C277([ProposalLine:43]; [ProposalLine:43]proposalNum:1=[Proposal:42]proposalNum:5)
				Records_Out(->[ProposalLine:43]; Storage:C1525.folder.jitExportsF+"043RecsSyncItem.out"; 0)  //File; name of file; keep selection
				//Records_Out (->[Item];Storage.folder.jitExportsF+"004RecsSyncItem.out";0)//File; name of file; keep selection
				Records_Out(->[Customer:2]; Storage:C1525.folder.jitExportsF+"002RecsSyncCust.out"; 0)  //File; name of file; keep selection
				QUERY:C277([QA:70]; [QA:70]idNumTask:12=[Proposal:42]idNumTask:70)
				Records_Out(->[QA:70]; Storage:C1525.folder.jitExportsF+"070RecsSyncQA.out"; 0)  //File; name of file; keep selection
			End if 
		Else 
			CONFIRM:C162("Pull In Proposal.")
			If (OK=1)
				CONFIRM:C162("[Proposal]")
				If (OK=1)
					Records_In(->[Proposal:42])  //File; name of file; keep selection
				End if 
				CONFIRM:C162("[ProposalLine]")
				If (OK=1)
					Records_In(->[ProposalLine:43])  //File; name of file; keep selection
				End if 
				CONFIRM:C162("[Customer]")
				If (OK=1)
					Records_In(->[Customer:2])  //File; name of file; keep selection
				End if 
				//CONFIRM("[Item]")
				//If (OK=1)
				//Records_In (->[Item])//File; name of file; keep selection
				//End if 
				CONFIRM:C162("[QACustomer]")
				If (OK=1)
					Records_In(->[QA:70])  //File; name of file; keep selection
				End if 
			End if 
		End if 
		
		
End case 