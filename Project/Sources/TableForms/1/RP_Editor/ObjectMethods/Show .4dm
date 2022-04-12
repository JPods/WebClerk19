
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/05/19, 22:47:57
// ----------------------------------------------------
// Method: [Control].RP_Editor.Show 
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (<>aTableNames<1)
	ALERT:C41("Select the primary Table to display selection.")
Else 
	ProcessTableOpen(<>aTableNums{<>aTableNames}; vScript; "RecordPassing")
End if 