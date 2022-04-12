//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-08-24T00:00:00, 21:56:59
// ----------------------------------------------------
// Method: TallyMasterExecuteSort
// Description
// Modified: 08/24/17
// 
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20170928_1148 updated name of Sort Editor
// ### jwm ### 20170928_1153 updated action to Sort Editor

C_POINTER:C301($ptSelf; $1)
$ptSelf:=$1

Case of 
	: ($ptSelf->=1)
		//do nothing
	: ($ptSelf->{$ptSelf->}="Sort Editor")  // ### jwm ### 20170928_1148
		jSORT  // ### jwm ### 20170928_1153 
	Else 
		READ ONLY:C145([TallyMaster:60])
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]Name:8=$ptSelf->{$ptSelf->}; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]Purpose:3="sort"; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]tableNum:1=Table:C252(ptCurTable))
		Case of 
			: (Records in selection:C76([TallyMaster:60])>1)
				FIRST RECORD:C50([TallyMaster:60])
				ExecuteText(0; [TallyMaster:60]Script:9; "ExecuteTM Name: "+[TallyMaster:60]Name:8+"; Purpose: "+[TallyMaster:60]Purpose:3)
				
			: (Records in selection:C76([TallyMaster:60])=0)
				
			Else 
				ExecuteText(0; [TallyMaster:60]Script:9; "ExecuteTM Name: "+[TallyMaster:60]Name:8+"; Purpose: "+[TallyMaster:60]Purpose:3)
		End case 
		REDUCE SELECTION:C351([TallyMaster:60]; 0)
		READ WRITE:C146([TallyMaster:60])
		MenuTitle  // ### jwm ### 20171211_1255 update window title
		$ptSelf->:=1  // ### jwm ### 20171211_1307 reset drop down menu
End case 