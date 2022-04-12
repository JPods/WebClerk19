// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 04/25/07, 18:19:13
// ----------------------------------------------------
// Method: Object Method: Button5
// Description
// 
//
// Parameters
// ----------------------------------------------------
KeyModifierCurrent
$theText:=Get text from pasteboard:C524
If ($theText="")
	ALERT:C41("No comments selected to post")
Else 
	If (OptKey=1)
		If ([Service:6]proposalNum:27=0)
			ALERT:C41("No related Proposal")
		Else 
			CONFIRM:C162("Pre-pend selected comments to Proposal Public Comments?")
			If (OK=1)
				If ([Proposal:42]proposalNum:5#[Service:6]proposalNum:27)
					QUERY:C277([Proposal:42]; [Proposal:42]proposalNum:5=[Service:6]proposalNum:27)
				End if 
				If (Locked:C147([Proposal:42]))
					ALERT:C41("Proposal locked by another process.")
				Else 
					[Proposal:42]comment:36:=$theText+<>vCR+[Proposal:42]comment:36
					//acceptPropsl
					SAVE RECORD:C53([Proposal:42])
				End if 
			End if 
		End if 
	Else 
		If ([Service:6]orderNum:22=0)
			ALERT:C41("No related Order")
		Else 
			CONFIRM:C162("Pre-pend selected comments to Order Public Comments?")
			If (OK=1)
				If ([Order:3]orderNum:2#[Service:6]orderNum:22)
					QUERY:C277([Order:3]; [Order:3]orderNum:2=[Service:6]orderNum:22)
				End if 
				If (Locked:C147([Order:3]))
					ALERT:C41("Orders locked by another process.")
				Else 
					[Order:3]comment:33:=$theText+<>vCR+[Order:3]comment:33
					//acceptOrders
					SAVE RECORD:C53([Order:3])
				End if 
			End if 
		End if 
	End if 
End if 