//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 05/10/19, 00:16:15
// ----------------------------------------------------
// Method: ALpLoadSets
// Description
// 
//
// Parameters
// ----------------------------------------------------

///  HARVEST QQQ

C_LONGINT:C283($k)
$k:=0
ARRAY LONGINT:C221(aTmpLong1; 0)
ARRAY LONGINT:C221(aTmpLong2; 0)
ARRAY TEXT:C222(aText3; 0)
ARRAY TEXT:C222(aText4; 0)
ARRAY TEXT:C222(aText5; 0)

C_TEXT:C284($tableName)
C_LONGINT:C283($tableNum)

C_LONGINT:C283($w; $i; $k; $p; $max)

$max:=Get last table number:C254
$error:=HFS_CatToArray(Storage:C1525.folder.jitPrefPath; "aText4")
$k:=Size of array:C274(aText4)

ARRAY LONGINT:C221(aTmpLong1; $k)
ARRAY LONGINT:C221(aTmpLong2; $k)
ARRAY TEXT:C222(aText3; $k)
ARRAY TEXT:C222(aText4; $k)
ARRAY TEXT:C222(aText5; $k)

//For (Counter_Variable;Start_Expression;End_Expression{;Increment_Expression})
//statement(s)
//End for

For ($i; $k; 1; -1)
	$p:=0
	$error:=1
	$vbDelete:=False:C215
	If (aText4{$i}="S_@")
		$tableNum:=Num:C11(Substring:C12(aText4{$i}; 3; 3))  //aTmpLong1{$i}
		$tableName:=Table name:C256($tableNum)  ///aText3{$i}
		If (($tableNum>0) & ($tableNum<=$max))
			$p:=Position:C15(".4ST"; aText4{$i})
			If ($p>0)
				aTmpLong1{$i}:=$tableNum
				aText3{$i}:=$tableName
				aText5{$i}:=Substring:C12(aText4{$i}; 6; Length:C16(aText4{$i})-9)
				aTmpLong2{$i}:=-2
				// aText5{$i}:=Substring(aText4{$i};6;Length(aText4{$i})-9)
				$error:=0
			Else 
				$vbDelete:=True:C214
			End if 
		Else 
			$vbDelete:=True:C214
		End if 
	Else 
		$vbDelete:=True:C214
	End if 
	
	If ($vbDelete=True:C214)
		// keep arrays synchronized 
		DELETE FROM ARRAY:C228(aTmpLong1; $i; 1)
		DELETE FROM ARRAY:C228(aText3; $i; 1)
		DELETE FROM ARRAY:C228(aText4; $i; 1)
		DELETE FROM ARRAY:C228(aText5; $i; 1)
		DELETE FROM ARRAY:C228(aTmpLong2; $i; 1)
	End if 
	
End for 

QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="Sets"; *)
// QUERY([TallyMaster]; & [TallyMaster]TableNum=$tableNum;*)
QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25>0)
$k:=Records in selection:C76([TallyMaster:60])
FIRST RECORD:C50([TallyMaster:60])
For ($i; 1; $k)
	APPEND TO ARRAY:C911(aTmpLong1; [TallyMaster:60]tableNum:1)
	APPEND TO ARRAY:C911(aText3; Table name:C256([TallyMaster:60]tableNum:1))
	APPEND TO ARRAY:C911(aText4; [TallyMaster:60]id:38)
	APPEND TO ARRAY:C911(aText5; [TallyMaster:60]name:8)
	APPEND TO ARRAY:C911(aTmpLong2; OB Get:C1224([TallyMaster:60]obGeneral:41; "Records"; Is longint:K8:6))
	NEXT RECORD:C51([TallyMaster:60])
End for 
REDUCE SELECTION:C351([TallyMaster:60]; 0)


// -- $error:=AL_SetArraysNam(eFileList; 1; 5; "aTmpLong2"; "aText3"; "aText5"; "aText4"; "aTmpLong1")
// -- AL_SetHeaders(eFileList; 1; 5; "Count"; "Table"; "SetName"; "SetID"; "TableNum")
// -- AL_SetWidths(eFileList; 1; 5; 100; 100; 200; 280; 40)  //;30)
//(areaRef:L; columnNumber:I; numWidths:I; width1:I; …; widthN:I)
// -- AL_SetHdrStyle(eFileList; 0; "Geneva"; 9; 2)
// -- AL_SetStyle(eFileList; 0; "Geneva"; 12; 0)
// -- AL_SetRowOpts(eFileList; 0; 0; 0; 0; 1)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
// -- AL_SetColOpts(eFileList; 1; 1; 0; 0; 0)
//(areaRef:L;allowColumnResize:I;automaticResize:I;allowColumnLock:I;hideLastColumns:I;displayPixelWidth:I; dragColumn:I; acceptDrag:I)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
// -- AL_SetEntryOpts(eFileList; 1; 0; 0)
//Name; EntryMode; AllowReturn; DisplaySeconds       
// -- AL_SetSortOpts(eFileList; 0; 1; 0; ""; 1)
//(areaRef:L;automaticSort:I;userSort:I;allowSortEditor:I;sortEditorPrompt:S;showSortOrder:I; showSortDirIndicator:I)
//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
// -- AL_SetMiscOpts(eFileList; 0; 1; ""; 0)
//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
// -- AL_SetSort(eFileList; 2; 3)
//(areaRef:L; column1:I; …; columnN:I)


//  CHOPPED  AlpUpdateArea(eFileList; -2)