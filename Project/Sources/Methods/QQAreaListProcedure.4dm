//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 05/30/06, 13:20:19
// ----------------------------------------------------
// Method: QQAreaListProcedure
// Description
// 
//
// Parameters
// ----------------------------------------------------
//  ### jwm ### 20140122_1349 get Buckets

C_LONGINT:C283($error)

Case of 
	: (ALProEvt=0)  //AL Null Event
	: (ALProEvt=1)  //AL Single Click
		If (Modified record:C314([Item:4]))
			SAVE RECORD:C53([Item:4])
		End if 
		If (Modified record:C314([ItemSpec:31]))
			SAVE RECORD:C53([ItemSpec:31])
		End if 
		ARRAY LONGINT:C221(aItemLines; 0)
		//  CHOPPED  $error:=AL_GetSelect(eQuickQuote; aItemLines)
		If ((aLsDocType{aItemLines{1}}="") | (aLsDocType{aItemLines{1}}="s") | (aLsDocType{aItemLines{1}}="b") | (aLsDocType{aItemLines{1}}="r"))  //### jwm ### 20120614_1626
			QUERY:C277([Item:4]; [Item:4]itemNum:1=aLsItemNum{aItemLines{1}})
			Item_GetSpec
			READ ONLY:C145([ItemSiteBucket:136])
			QUERY:C277([ItemSiteBucket:136]; [ItemSiteBucket:136]itemNum:2=aLsItemNum{aItemLines{1}}; *)  //  ### jwm ### 20140122_1349 get Buckets
			QUERY:C277([ItemSiteBucket:136];  & ; [ItemSiteBucket:136]qtyOnHand:5#0)  // ### jwm ### 20180924_1310 omit zero qty on hand
			If ([Item:4]alertMessage:52#"")  //### jwm ### 20120515 alert message if not empty
				ConsoleLog([Item:4]alertMessage:52)
			End if 
		Else 
			BEEP:C151
		End if 
		COPY ARRAY:C226(aItemLines; <>aItemLines)
		COPY ARRAY:C226(aLsSrRec; <>aLsSrRec)
	: (ALProEvt=2)  //AL Double Click
		If (False:C215)
			If (Modified record:C314([Item:4]))
				SAVE RECORD:C53([Item:4])
			End if 
			If (Modified record:C314([ItemSpec:31]))
				SAVE RECORD:C53([ItemSpec:31])
			End if 
		End if 
		ARRAY LONGINT:C221(aItemLines; 0)
		//  CHOPPED  $error:=AL_GetSelect(eQuickQuote; aItemLines)
		COPY ARRAY:C226(aItemLines; <>aItemLines)
		COPY ARRAY:C226(aLsSrRec; <>aLsSrRec)
		$w:=Find in array:C230(<>aPrsName; iLoaText1{iLoaText1})
		//TRACE
		Case of 
			: ((iLoaText1{iLoaText1}="Process@") | (iLoaText1{iLoaText1}="Quick@"))
				//no action
			: ((iLoaText1>1) & ($w>0))
				QQItemAdd(<>aPrsNum{$w}; True:C214)
			Else 
				GOTO RECORD:C242([Item:4]; aLsSrRec{aItemLines{1}})
				ProcessTableOpen(Table:C252(->[Item:4])*-1)
		End case 
		//: ($w>0)
		
		//End case 
	: ((ALProEvt=-1) | (ALProEvt=-5) | (ALProEvt=-6))  //AL Sort Button Event
		QQSetColor(eQuickQuote; ->aLsItemNum)  //###_jwm_### 20101112
	: (ALProEvt=-2)  //AL Select All Event
		AL_CmdAll(->aLsItemNum; ->aItemLines)
		COPY ARRAY:C226(aItemLines; <>aItemLines)
		COPY ARRAY:C226(aLsSrRec; <>aLsSrRec)
End case 
ALProEvt:=0