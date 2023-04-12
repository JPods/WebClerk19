If (Shift down:C543)
	SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217(LB_DataBrowser))
Else 
	SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217(LB_DataBrowser.fc.data.views[LB_DataBrowser.view].columnsb_o))
End if 