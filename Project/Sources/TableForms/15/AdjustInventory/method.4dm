
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/05/19, 17:51:07
// ----------------------------------------------------
// Method: [Default].AdjustInventory
// Description
// 
//
// Parameters
// ----------------------------------------------------


// ### jwm ### 20150721_1518 Check Authority to adjust inventory
C_BOOLEAN:C305($adjByBOM; $adjByItems)
$adjByBOM:=UserInPassWordGroup("AdjustByBOM")
$adjByItems:=UserInPassWordGroup("AdjustByItem")

Case of 
	: (($adjByBOM=False:C215) | ($adjByItems=False:C215))
		// ### bj ### 20191005_1731 TESTTHIS
		ALERT:C41("Must be in both AdjustByBOM "+String:C10($adjByBOM)+" and AdjustByItem "+String:C10($adjByItems)+" password groups.")
		CANCEL:C270
	: (Before:C29)
		SET MENU BAR:C67(6)
		srItem:=""
		srItemDscrp:=""
		vi1:=0
		vr1:=0
		vr2:=0
		vr3:=0
		vr4:=0
		v1:=""
		v2:=""
		vsiteID:=DSSetSiteID
		//
		booMod:=False:C215
		OBJECT SET ENABLED:C1123(b1; False:C215)  // ### jwm ### 20150724_1409
		OBJECT SET ENABLED:C1123(b5; False:C215)
		OBJECT SET ENABLED:C1123(b6; False:C215)
		
		ARRAY TEXT:C222(aLsReason; 0)
		ARRAY TEXT:C222(aItemChild; 0)
		List_RaySize(0)
		//  Item_ListBe4 
		ARRAY LONGINT:C221(aItemLines; 0)
		//
		vsiteID:=DSGetMachineSiteID
		
		C_LONGINT:C283($error)
		srItem:=""
		srItemDscrp:=""
		srItemType:=""
		srItemsProfile1:=""
		srItemsProfile2:=""
		srItemsProfile3:=""
		srItemsProfile4:=""
		ARRAY LONGINT:C221(aItemLines; 0)
		// -- $error:=AL_SetArraysNam(eItemList; 1; 11; "aLsDocType"; "aLsItemNum"; "aLsItemDesc"; "aLsReason"; "aLsQtyOH"; "aLsQtySO"; "aLsQtyPO"; "aLsItemChild"; "aLsLeadTime"; "aLsCost"; "aLsSrRec")
		// -- AL_SetHeaders(eItemList; 1; 11; "T"; "Item Number"; "Description"; "Reason"; "Qty O/H"; "Adjust"; "Adj'd O/H"; "C"; "Lead"; "Cost"; "RecNum")
		// -- AL_SetWidths(eItemList; 1; 11; 3; 130; 207; 60; 70; 70; 70; 12; 51; 5; 80)  //;3;3;3;3)
		//
		// -- AL_SetRowOpts(eItemList; 1; 0; 0; 0; 1)
		//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
		// -- AL_SetColOpts(eItemList; 1; 0; 1; 3; <>viPixel)
		//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
		// -- AL_SetEntryOpts(eItemList; 1; 0; 0)
		//Name; EntryMode; AllowReturn; DisplaySeconds
		// -- AL_SetSortOpts(eItemList; 0; 1; 1; ""; 1)
		//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
		//// -- AL_SetCallbacks (eItemList;"";"")
		//Name; GP at entry; Function true or false if keep changes
		// -- AL_SetSort(eItemList; 2)
		//
		// -- AL_SetFormat(eItemList; 5; "###,###.####"; 3; 2)
		// -- AL_SetFormat(eItemList; 6; "###,###.####"; 3; 2)
		// -- AL_SetFormat(eItemList; 7; "###,###.####"; 3; 2)
		// -- AL_SetFormat(eItemList; 8; "###,###.####"; 3; 2)
		//    // -- AL_SetFormat (eItemList;8;<>tcFormatUC;3;2)
		// -- AL_SetFormat(eItemList; 9; <>tcFormatUC; 3; 2)
		//
		// -- AL_SetHdrStyle(eItemList; 0; "Geneva"; 9; 2)
		// -- AL_SetStyle(eItemList; 0; "Geneva"; 12; 0)
		// -- AL_SetDividers(eItemList; "Gray"; "Gray"; 0; ""; ""; 0)
		aLsSrRec:=Num:C11(Size of array:C274(aLsSrRec)>0)
	Else 
		
		If (doSearch>0)
			//ALERT(String(aLsSrRec)+": "+String(doSearch))
			C_BOOLEAN:C305($myOK; $save)
			Case of 
				: (doSearch=10)
					//change item          
				: (doSearch>0)
					doSearch:=ItemSr(doSearch)
					If (doSearch>0)
						
						// Modified by: Bill James (2016-03-04T00:00:00 Saving Unintended Changes
						// dangerous as it can have unintended changes
						If (False:C215)  // (vMod) 
							TRACE:C157
							//$save:=jConfirmSave (True;True)
							//If ($save)
							// ### jwm ### 20150721_1518 Check Authority to adjust inventory
							If ($adjByItems)
								CONFIRM:C162("Save Inventory Adjustments"; " Cancel "; " Save ")
								If (OK#1)  // default = Cancel
									InvtAdjDiaSave
								End if 
							End if 
						End if 
						
						ARRAY TEXT:C222(aLsReason; 0)
						viRecordsInSelection:=Records in selection:C76([Item:4])
						List_FillOpts(viRecordsInSelection; 0)
						ARRAY TEXT:C222(aLsReason; viRecordsInSelection)
						ARRAY LONGINT:C221(aItemLines; 0)
						//aLsSrRec:=Num(Size of array(aLsSrRec)>0)
					End if 
			End case 
			
			//  CHOPPED  AL_GetScroll(eItemList; viVert; viHorz)
			//  --  CHOPPED  AL_UpdateArrays(eItemList; -2)
			// -- AL_SetSelect(eItemList; aItemLines)
			// -- AL_SetScroll(eItemList; viVert; viHorz)
			
			doSearch:=0
		End if 
		Case of 
			: (Size of array:C274(aItemLines)=0)
				OBJECT SET ENABLED:C1123(b1; False:C215)  // ### jwm ### 20150724_1322
				OBJECT SET ENABLED:C1123(b5; False:C215)
				OBJECT SET ENABLED:C1123(b6; False:C215)
			: (aLsQtySO{aItemLines{1}}#0)
				If ($adjByItems)
					OBJECT SET ENABLED:C1123(b1; True:C214)  // ### jwm ### 20150724_1322
				End if 
				If ($adjByBOM)  // ### jwm ### 20150724_1412
					OBJECT SET ENABLED:C1123(b5; True:C214)
					OBJECT SET ENABLED:C1123(b6; True:C214)
				End if 
			Else 
				OBJECT SET ENABLED:C1123(b1; False:C215)  // ### jwm ### 20150724_1323
				OBJECT SET ENABLED:C1123(b5; False:C215)
				OBJECT SET ENABLED:C1123(b6; False:C215)
		End case 
		
End case 
