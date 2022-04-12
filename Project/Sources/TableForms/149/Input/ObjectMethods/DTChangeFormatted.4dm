C_TEXT:C284(vtDTChangeFormatted)
If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Clicked:K2:4))
	vtDTChangeFormatted:=jDateTimeRBoth([ChangeLog:149]DTChange:6)
End if 
