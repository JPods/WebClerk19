//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/28/20, 10:04:36
// ----------------------------------------------------
// Method: C_ChangeDateRange
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_BOOLEAN:C305($1)  //refresh


C_UpdateYears(C_DstartDate_V; ->C_Tyears_R; C_LcalendarSet_X)

//   CHOPPED CS_SetRange(C_LcalendarSet_X; C_DstartDate_V; C_DendDate_V)

If ($1)
	//  CHOPPED   Area_Refresh(C_LcalendarSet_X)
End if 

C_Tmonths_R:=Month of:C24(C_DstartDate_V)
C_Tyears_R:=Find in array:C230(C_Tyears_R; String:C10(Year of:C25(C_DstartDate_V)))

