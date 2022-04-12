//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 10/26/18, 12:21:50
// ----------------------------------------------------
// Method: LoadTagsAreaList
// Description
// 
//
// Parameters
// ----------------------------------------------------


//  CHOPPED  $event:=AL_GetAreaLongProperty(eShipList; ALP_Area_AlpEvent)

Case of 
		
	: (ALProEvt=0)
		
	: (ALProEvt=1)
		ARRAY LONGINT:C221(aShipSel; 0)
		//  CHOPPED  $error:=AL_GetSelect(eShipList; aShipSel)
		doSearch:=2
		If (Size of array:C274(aShipSel)>0)
			PKArrayManage(-8; aShipSel{1})
		End if 
		// PKArrayManage (-8;... highlights  iLo40String1
		//HIGHLIGHT TEXT(iLo40String1;1;40)
	: (ALProEvt=2)
		ARRAY LONGINT:C221(aShipSel; 0)
		//  CHOPPED  $error:=AL_GetSelect(eShipList; aShipSel)
		doSearch:=2
		If (Size of array:C274(aShipSel)>0)
			//update form
			PKArrayManage(-8; aShipSel{1})
			
			// start debug
			//save contents of arrays to LoadTags records
			$k:=Size of array:C274(aPKUniqueID)
			For ($i; 1; $k)
				aPKdocumentID{$i}:=[Invoice:26]idNumOrder:1
				aPKInvoiceNum{$i}:=[Invoice:26]idNum:2
				PKArrayManage(-4; $i; 1)
			End for 
			//end debug
		End if 
		
		KeyModifierCurrent
		If (OptKey=0)
			jSetFromArray(->[LoadTag:88]; ->aPKUniqueID; ->aShipSel; ->[LoadTag:88]idNum:1)
		Else 
			QUERY:C277([LoadTag:88]; [LoadTag:88]idNum:1=aPKUniqueID{aShipSel{1}})
		End if 
		curTableNum:=Table:C252(->[LoadTag:88])
		ProcessTableOpen
		HIGHLIGHT TEXT:C210(iLo40String1; 1; 40)
		CANCEL:C270
	: (ALProEvt=-1)
	: (ALProEvt=-2)  //Edit menu Select All
		//ARRAY LONGINT(aShipSel;0)
		////  CHOPPED  $error:=AL_GetSelect (eShipList;aShipSel)
		AL_CmdAll(->aPKtrackID; ->aShipSel)
		
End case 
ALProEvt:=0