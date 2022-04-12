//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/28/20, 10:15:05
// ----------------------------------------------------
// Method: Compiler_C_P
// Description
// 
//
// Parameters
// ----------------------------------------------------

//AreaList
C_LONGINT:C283(C_LareaList_X)


//CalendarSet
C_LONGINT:C283(C_LcalendarSet_X)
ARRAY TEXT:C222(C_Tmonths_R; 0)
ARRAY TEXT:C222(C_Tyears_R; 0)

C_DATE:C307(C_DstartDate_V; C_DendDate_V)

ARRAY TEXT:C222(C_EmployeeNameID_R; 0)
ARRAY DATE:C224(C_DrecDates_R; 0)
ARRAY TEXT:C222(C_TrecDesc_R; 0)
ARRAY TIME:C1223(C_HrecTimes_R; 0)
ARRAY LONGINT:C221(C_aLOrderRecord; 0)

ARRAY TEXT:C222(C_TrecFonts_R; 0)
ARRAY INTEGER:C220(C_LrecSizes_R; 0)
ARRAY INTEGER:C220(C_LrecFaces_R; 0)
ARRAY INTEGER:C220(C_LrecColors_R; 0)

ARRAY TEXT:C222(D_TviewMode_R; 0)
C_LONGINT:C283($i; $LbkpViewMode)
C_TEXT:C284($TvisibleDays)

$LbkpViewMode:=D_TviewMode_R

FONT LIST:C460(S_Tfont_R)
LIST TO ARRAY:C288("days"; D_Tday_R)
LIST TO ARRAY:C288("TimeZone"; D_TimeZones_R)
LIST TO ARRAY:C288("styleHorAlign"; S_ThorAlign_R)
LIST TO ARRAY:C288("styleVertAlign"; S_TvertAlign_R)
LIST TO ARRAY:C288("viewMode"; D_TviewMode_R)
LIST TO ARRAY:C288("TimeZone"; D_TimeZones_R)
LIST TO ARRAY:C288("TimeRounding"; D_TtimeRounding_R)
LIST TO ARRAY:C288("YearView"; D_TyearView_R)
LIST TO ARRAY:C288("DisplayTime"; D_TeventTime_R)
LIST TO ARRAY:C288("DrawMode"; D_TdrawMode_R)
LIST TO ARRAY:C288("HeadersFormats"; D_TdayHeaderFormat_R)
LIST TO ARRAY:C288("HeadersFormats"; D_TweekHeaderFormat_R)
LIST TO ARRAY:C288("MontHeaderFormat"; D_TmontHeaderFormat_R)
LIST TO ARRAY:C288("MontHeaderAlignment"; D_TdayHeaderAlignment_R)
LIST TO ARRAY:C288("MontHeaderAlignment"; D_TweekHeaderAlignment_R)
LIST TO ARRAY:C288("CompatibilityMode"; D_TcompatibilityMode_R)

COPY ARRAY:C226(D_Tday_R; D_TfirstDay_R)
INSERT IN ARRAY:C227(D_TfirstDay_R; 1; 1)
D_TfirstDay_R{1}:="System setting"

// D_Tday_R:=Num(Pref0get("D_Tday_R";"1";Current user))
// D_TfirstDay_R:=Num(Pref0get("D_TfirstDay_R";"2";Current user))
// D_TyearView_R:=Num(Pref0get("D_TyearView_R";"3";Current user))
// D_TdrawMode_R:=Num(Pref0get("D_TdrawMode_R";"1";Current user))
// D_TimeZones_R:=Num(Pref0get("D_TimeZones_R";"2";Current user))
// D_TdayHeaderFormat_R:=Num(Pref0get("D_TdayHeaderFormat_R";"1";Current user))
// D_TweekHeaderFormat_R:=Num(Pref0get("D_TweekHeaderFormat_R";"1";Current user))
// D_TmontHeaderFormat_R:=Num(Pref0get("D_TmontHeaderFormat_R";"1";Current user))
// D_TdayHeaderAlignment_R:=Num(Pref0get("D_TdayHeaderAlignment_R";"1";Current user))
// D_TweekHeaderAlignment_R:=Num(Pref0get("D_TweekHeaderAlignment_R";"1";Current user))
// 
// $TvisibleDays:=Pref0get("VisibleDays";"1111111";Current user)
$TvisibleDays:="1111111"
D_Lsunday_N:=Num:C11(Substring:C12($TvisibleDays; 1; 1))
D_Lmonday_N:=Num:C11(Substring:C12($TvisibleDays; 2; 1))
D_Ltuesday_N:=Num:C11(Substring:C12($TvisibleDays; 3; 1))
D_Lwednesday_N:=Num:C11(Substring:C12($TvisibleDays; 4; 1))
D_Lthurday_N:=Num:C11(Substring:C12($TvisibleDays; 5; 1))
D_Lfriday_N:=Num:C11(Substring:C12($TvisibleDays; 6; 1))
D_Lsaturday_N:=Num:C11(Substring:C12($TvisibleDays; 7; 1))

// D_LactivateDD_N:=Num(Pref0get("D_LactivateDD_N";"1";Current user))
// D_LdisplayMonthName_N:=Num(Pref0get("D_LdisplayMonthName_N";"1";Current user))
// D_LdisplayWeekNumber_N:=Num(Pref0get("D_LdisplayWeekNumber_N";"1";Current user))
// D_LscrollMonthViewWeeks_N:=Num(Pref0get("D_LscrollMonthViewWeeks_N";"1";Current user))
// D_LshowInfoText_N:=Num(Pref0get("D_LshowInfoText_N";"0";Current user))
// 
// D_LstartHour_V:=Num(Pref0get("D_LstartHour_V";"0";Current user))
// D_LstartWorkHour_V:=Num(Pref0get("D_LstartWorkHour_V";"8";Current user))
// D_LendWorkHour_V:=Num(Pref0get("D_LendWorkHour_V";"18";Current user))
// D_LendHour_V:=Num(Pref0get("D_LendHour_V";"24";Current user))
// D_LhoursInDayView_V:=Num(Pref0get("D_LhoursInDayView_V";"10";Current user))
// 
// D_LbannerResize_N:=Num(Pref0get("D_LbannerResize_N";"1";Current user))
// D_LeventResize_N:=Num(Pref0get("D_LeventResize_N";"1";Current user))
// D_LeventDelete_N:=Num(Pref0get("D_LeventDelete_N";"1";Current user))
// D_TtimeRounding_R:=Num(Pref0get("D_TtimeRounding_R";"1";Current user))
// D_TeventTime_R:=Num(Pref0get("D_TeventTime_R";"1";Current user))
// 
// D_LmouseWheelScroll_N:=Num(Pref0get("D_LmouseWheelScroll_N";"0";Current user))
// 
// D_Lcustom_N:=Num(Pref0get("D_Lcustom_N";"0";Current user))
// D_LcalendarApp_N:=Num(Pref0get("D_LcalendarApp_N";"1";Current user))
// 
// S_TlistStyles_R:=Num(Pref0get("S_TlistStyles_R";"1";Current user))

//D_TcompatibilityMode_V:=D_TcompatibilityMode_R{CS_GetAreaLongProperty (C_LcalendarSet_X;CS_Area_Compatibility)+1}  //for info

