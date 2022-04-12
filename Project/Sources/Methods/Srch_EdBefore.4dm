//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-04-28T00:00:00, 23:00:18
// ----------------------------------------------------
// Method: Srch_EdBefore
// Description
// Modified: 04/28/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($1)
myOK:=0
If (curTableNum=0)
	curTableNum:=Table:C252(ptCurTable)
End if 
ARRAY TEXT:C222(aTmp20Str3; 6)
aTmp20Str3{1}:="New Selection"
aTmp20Str3{2}:="Search Selection"
aTmp20Str3{3}:="Union"
aTmp20Str3{4}:="Intersection"
aTmp20Str3{5}:="Difference"
aTmp20Str3{6}:="Reverse"
//
aTmp20Str3:=1

ARRAY TEXT:C222(aTmp20Str2; 2)
aTmp20Str2{1}:="or"
aTmp20Str2{2}:="and"
//
aTmp20Str2:=1
ARRAY TEXT:C222(aTmp20Str4; 0)
APPEND TO ARRAY:C911(aTmp20Str4; "begins with")  //  =
APPEND TO ARRAY:C911(aTmp20Str4; "ends with")  //  =
APPEND TO ARRAY:C911(aTmp20Str4; "equals")  //  =
APPEND TO ARRAY:C911(aTmp20Str4; "not equals")  //  #
APPEND TO ARRAY:C911(aTmp20Str4; "greater than")  //  >
APPEND TO ARRAY:C911(aTmp20Str4; "greater or equal")  //  >=
APPEND TO ARRAY:C911(aTmp20Str4; "less than")  //  <
APPEND TO ARRAY:C911(aTmp20Str4; "less than or equal")  //  <=
APPEND TO ARRAY:C911(aTmp20Str4; "contains")  // @  and @
APPEND TO ARRAY:C911(aTmp20Str4; "not contains")  //  #
APPEND TO ARRAY:C911(aTmp20Str4; "keyword")  //  %

aTmp20Str4:=1
vText1:=""
<>aTableNames:=Find in array:C230(<>aTableNums; curTableNum)
//
If (curTableNum=0)
	curTableNum:=Table:C252(ptCurTable)
End if 
StructureFields(curTableNum)

C_LONGINT:C283(eSrchFlds; eSrchRecs)
If (eSrchFlds>0)
	Fld_ALDefine(eSrchFlds)
End if 
//
ARRAY TEXT:C222(aQueryBooleans; 0)
ARRAY TEXT:C222(aTmp40Str1; 0)
ARRAY TEXT:C222(aQueryOperators; 0)
ARRAY TEXT:C222(aQueryValues; 0)
ARRAY TEXT:C222(aTmpText2; 0)

If ($1>0)
	//
	
	
	// -- $error:=AL_SetArraysNam($1; 1; 4; "aQueryBooleans"; "aQueryFieldNames"; "aQueryOperators"; "aQueryValues")  //;"aTmpText2")
	// -- AL_SetHeaders($1; 1; 4; "Combine"; "Field"; "Compare"; "Value")  //;"space")
	
	// -- AL_SetWidths($1; 1; 4; 52; 140; 85; 180)  //;30)
	//
	// -- AL_SetCallbacks($1; "Srch_Enter"; "")  //
	//
	// -- AL_SetRowOpts($1; 0; 0; 1; 0; 1)
	//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
	// -- AL_SetColOpts($1; 1; 0; 1; 0; 0)
	//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
	//   // -- AL_SetEnterable ($1;4;3;aQueryBooleans)
	//name; column; mode; array
	
	//// -- AL_SetEntryOpts ($1;2;1;1;1)
	// ### jwm ### 20150807_1221
	// -- AL_SetEntryOpts($1; 3; 0; 1; 1)  //Entry Mode Single and double-click selection, return NOT allowed
	
	//Name; EntryMode; AllowReturn; DisplaySeconds;MoveWithArrow;MapEnterKey
	// // -- AL_SetSortOpts ($1;0;0;0;"";0)
	//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
	//// -- AL_SetCallbacks ($1;"";"")
	//Name; GP at entry; Function true or false if keep changes
	// -- AL_SetSort($1; 1)
	
	// ### bj ### 20181111_1300
	// -- AL_SetEnterable($1; 1; 2; aTmp20Str2)
	// -- AL_SetEnterable($1; 2; 0)
	// -- AL_SetEnterable($1; 3; 2; aTmp20Str4)
	//// -- AL_SetColumnLongProperty ($1;1;ALP_Column_Enterable;0)  // set column 1 to be non-enterable
	//// -- AL_SetColumnLongProperty ($1;2;ALP_Column_Enterable;0)  // set column 1 to be non-enterable
	//// -- AL_SetColumnLongProperty ($1;3;ALP_Column_Enterable;0) // set column 1 to be non-enterable
	// -- AL_SetEnterable($1; 4; 1)
	//// -- AL_SetColumnLongProperty ($1;4;ALP_Column_Enterable;1)
	
	
	// -- AL_SetHdrStyle($1; 0; "Geneva"; 9; 2)
	// -- AL_SetStyle($1; 0; "Geneva"; 12; 0)
	// -- AL_SetDividers($1; "Gray"; "Gray"; 0; ""; ""; 0)
	// -- AL_SetMiscOpts($1; 0; 1; ""; 0)
	//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
	//
End if 
//
If (eSrchRecs>0)
	If (ptCurTable=(->[TallyMaster:60]))
		CREATE SET:C116([TallyMaster:60]; "Current")
	End if 
	// ### bj ### 20191004_1702  Jim added authority level 
	QUERY:C277([TallyMaster:60]; [TallyMaster:60]tableNum:1=curTableNum; *)
	QUERY:C277([TallyMaster:60];  & [TallyMaster:60]purpose:3="search"; *)
	QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25<=Storage:C1525.user.securityLevel; *)
	QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25>=0)  // ### jwm ### 20190826_1557) Authority level added to Searches
	SELECTION TO ARRAY:C260([TallyMaster:60]name:8; aTmp20Str1; [TallyMaster:60]; aTmpLong1)
	//  --  CHOPPED  AL_UpdateArrays(eSrchRecs; -2)
	UNLOAD RECORD:C212([TallyMaster:60])
	If (ptCurTable=(->[TallyMaster:60]))
		USE SET:C118("Current")
		CLEAR SET:C117("Current")
	End if 
	//
	ARRAY LONGINT:C221(aFieldLns; 0)
	//
	Select_ALDefine(eSrchRecs)
End if 