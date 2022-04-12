//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-08-25T00:00:00, 00:39:23
// ----------------------------------------------------
// Method: TallyMastersExecuteSearch
// Description
// Modified: 08/25/17
// 
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20170928_1147 updated name of Query Editor

C_POINTER:C301($ptSelf; $1)
$ptSelf:=$1
C_TEXT:C284($theRecName)
$theRecName:=$ptSelf->{$ptSelf->}

Case of 
	: ($ptSelf->=1)
		// do nothing
	: ($theRecName="Edit TallyMasters")
		// ### bj ### 20200330_1808  open the queries
		If (UserInPassWordGroup("AdminControl"))
			C_TEXT:C284($vtScript)
			$vtScript:="QUERY([TallyMaster];[TallyMaster]Purpose=\"search\";*) "+"\r"
			$vtScript:=$vtScript+"QUERY([TallyMaster]; & ;[TallyMaster]TableNum="+String:C10(Table:C252(ptCurTable))+")"
			ProcessTableOpen(Table:C252(->[TallyMaster:60]); $vtScript; "Table: "+Table name:C256(ptCurTable))
			REDUCE SELECTION:C351([TallyMaster:60]; 0)
		End if 
	: ($theRecName="Query Editor")  // ### jwm ### 20170928_1147
		jSrchEditor
	Else 
		READ ONLY:C145([TallyMaster:60])
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]name:8=$theRecName; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]purpose:3="search"; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]tableNum:1=Table:C252(ptCurTable))
		Case of 
			: (Records in selection:C76([TallyMaster:60])>1)
				FIRST RECORD:C50([TallyMaster:60])
				ExecuteText(0; [TallyMaster:60]script:9; "ExecuteTM Name: "+[TallyMaster:60]name:8+"; Purpose: "+[TallyMaster:60]purpose:3)
				
			: (Records in selection:C76([TallyMaster:60])=0)
				
			Else 
				ExecuteText(0; [TallyMaster:60]script:9; "ExecuteTM Name: "+[TallyMaster:60]name:8+"; Purpose: "+[TallyMaster:60]purpose:3)
		End case 
		REDUCE SELECTION:C351([TallyMaster:60]; 0)
		READ WRITE:C146([TallyMaster:60])
		MenuTitle  // ### jwm ### 20171211_1255 update window title
End case 
$ptSelf->:=1
