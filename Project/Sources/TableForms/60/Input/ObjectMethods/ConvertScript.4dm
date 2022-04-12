
CONFIRM:C162("Update Script"; " Update "; " Cancel")

If (OK=1)
	[TallyMaster:60]Script:9:=Tx_ConvertScripts([TallyMaster:60]Script:9)
End if 


CONFIRM:C162("Update Build"; " Update "; " Cancel")

If (OK=1)
	[TallyMaster:60]Build:6:=Tx_ConvertScripts([TallyMaster:60]Build:6)
End if 


CONFIRM:C162("Update After"; " Update "; " Cancel")

If (OK=1)
	[TallyMaster:60]After:7:=Tx_ConvertScripts([TallyMaster:60]After:7)
End if 


CONFIRM:C162("Update HeadAdder"; " Update "; " Cancel")

If (OK=1)
	[TallyMaster:60]Template:29:=Tx_ConvertScripts([TallyMaster:60]Template:29)
End if 

