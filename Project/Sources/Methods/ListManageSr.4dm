//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 11/12/10, 10:23:56
// ----------------------------------------------------
// Method: ListManageSr
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($1)

doSearch:=ItemSr(doSearch)

// ### jwm ### 20150526_1303
C_TEXT:C284($typeSaleSel)
$typeSaleSel:=""

Case of 
	: (ptCurTable=(->[Order:3]))
		$salesTypeSel:=[Order:3]typeSale:22
	: (ptCurTable=(->[Invoice:26]))
		$salesTypeSel:=[Invoice:26]typeSale:49
	: (ptCurTable=(->[Proposal:42]))
		$salesTypeSel:=[Proposal:42]typeSale:20
End case 

If (doSearch>0)
	//If (Size of array(aLsDocType)>0)
	//  If (aLsDocType{1}="h")//values if displaying items  
	//End if 
	//End if 
	viRecordsInSelection:=Records in selection:C76([Item:4])
	// ### jwm ### 20150526_1306 added $salesTypeSel parameter 3
	List_FillOpts(viRecordsInSelection; vUseBase; $salesTypeSel)
	doSearch:=0
End if 
If (False:C215)
	// -- AL_SetHeaders($1; 1; 13; "T"; "Item Number"; "Description"; "On Hand"; "On S/O"; "On P/O"; "Lead"; "Price"; "Discount"; "Discount Price"; "Cost"; "Margin"; ""; ""; "")
	
	// -- AL_SetWidths($1; 1; 13; 12; 115; 90; 50; 45; 5; 5; 5; 31; 61; 51; 51; 3; 3; 3)
	
	// -- AL_SetRowColor($1; 0; "Black"; 0; "white"; 0)
End if 
//  CHOPPED  AL_GetScroll($1; viVert; viHorz)
//  --  CHOPPED  AL_UpdateArrays($1; -2)
// -- AL_SetScroll($1; viVert; viHorz)
//OrdSetColor($1)  //pass in the areaList
QQSetColor($1; ->aLsItemNum)  //###_jwm_### 20101112