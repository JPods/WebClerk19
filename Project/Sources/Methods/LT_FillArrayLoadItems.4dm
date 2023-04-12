//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-02-13T00:00:00, 15:27:14
// ----------------------------------------------------
// Method: LT_FillArrayLoadItems
// Description
// Modified: 02/13/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($1; $2; $3; $incRay; $sizeRay; $diff; $p; $w; $k; $i)
C_LONGINT:C283($startElement; $numElements)
C_TEXT:C284($trackingID; $4; $status; $5)
$status:="PENDING"
$trackingID:="Not Assigned"
If (Count parameters:C259>1)
	$startElement:=$2
	If (Count parameters:C259>2)
		$numElements:=$3
		If (Count parameters:C259>3)
			$trackingID:=$4
			If (Count parameters:C259>4)
				$status:=$5
			End if 
		End if 
	End if 
End if 
//
//TRACE
Case of 
	: ($1=0)
		ARRAY LONGINT:C221(aLiLoadTagID; $1)
		ARRAY LONGINT:C221(aLiDocID; $1)
		ARRAY LONGINT:C221(aLiLineID; $1)
		ARRAY TEXT:C222(aLiItemNum; $1)
		ARRAY TEXT:C222(aLiItemNumAlt; $1)
		ARRAY TEXT:C222(aLiItemDescription; $1)
		ARRAY TEXT:C222(aLiHazardClass; $1)
		ARRAY REAL:C219(aLiQty; $1)
		ARRAY REAL:C219(aLiUnitWt; $1)
		ARRAY REAL:C219(aLiExtendedWt; $1)
		ARRAY REAL:C219(aLiValue; $1)
		ARRAY LONGINT:C221(aLiTagGroup; $1)
		ARRAY LONGINT:C221(aLiRecordNum; $1)
		ARRAY LONGINT:C221(aLiTableType; $1)
		ARRAY LONGINT:C221(aLiInvoiceNum; $1)
		ARRAY LONGINT:C221(aLiUniqueID; $1)
		//
		ARRAY LONGINT:C221(aLiLoadItemSelect; 0)
		//
		C_LONGINT:C283(eLoadList)
		If (eLoadList>0)
			//  --  CHOPPED  AL_UpdateArrays(eLoadList; -2)
		End if 
	: ($1>0)
		SELECTION TO ARRAY:C260([LoadItem:87]idNum:16; aLiUniqueID; [LoadItem:87]value:15; aLiValue; [LoadItem:87]itemNumAlt:12; aLiItemNumAlt; [LoadItem:87]weightExtended:11; aLiExtendedWt; [LoadItem:87]tableNum:1; aLiTableType; [LoadItem:87]; aLiRecordNum; [LoadItem:87]idNumOrder:2; aLiDocID; [LoadItem:87]lineid:5; aLiLineID; [LoadItem:87]itemNum:3; aLiItemNum; [LoadItem:87]itemDescription:4; aLiItemDescription; [LoadItem:87]hazardClass:10; aLiHazardClass; [LoadItem:87]quantity:7; aLiQty; [LoadItem:87]unitWeight:6; aLiUnitWt; [LoadItem:87]packGroupid:9; aLiTagGroup; [LoadItem:87]idNumLoadTag:8; aLiLoadTagID; [LoadItem:87]invoiceNum:14; aLiInvoiceNum)
		ARRAY LONGINT:C221(aLiLoadItemSelect; 1)
		aLiLoadItemSelect{1}:=1
	: ($1=-12)
		READ WRITE:C146([LoadItem:87])
		QUERY:C277([LoadItem:87]; [LoadItem:87]tableNum:1=Table:C252(->[Order:3]); *)
		QUERY:C277([LoadItem:87];  & [LoadItem:87]idNumOrder:2=[Order:3]idNum:2)
		SELECTION TO ARRAY:C260([LoadItem:87]idNum:16; aLiUniqueID; [LoadItem:87]value:15; aLiValue; [LoadItem:87]itemNumAlt:12; aLiItemNumAlt; [LoadItem:87]weightExtended:11; aLiExtendedWt; [LoadItem:87]tableNum:1; aLiTableType; [LoadItem:87]; aLiRecordNum; [LoadItem:87]idNumOrder:2; aLiDocID; [LoadItem:87]lineid:5; aLiLineID; [LoadItem:87]itemNum:3; aLiItemNum; [LoadItem:87]itemDescription:4; aLiItemDescription; [LoadItem:87]hazardClass:10; aLiHazardClass; [LoadItem:87]quantity:7; aLiQty; [LoadItem:87]unitWeight:6; aLiUnitWt; [LoadItem:87]packGroupid:9; aLiTagGroup; [LoadItem:87]idNumLoadTag:8; aLiLoadTagID; [LoadItem:87]invoiceNum:14; aLiInvoiceNum)
		C_LONGINT:C283($i; $k; $w)
		$k:=Size of array:C274(aOQtyOrder)
		ARRAY LONGINT:C221($aLineByLine; $k)
		ARRAY REAL:C219($aQtyByLine; $k)
		ARRAY REAL:C219($aQtyByOrdLine; $k)
		COPY ARRAY:C226(aOQtyOrder; $aQtyByOrdLine)
		//TRACE
		$k:=Size of array:C274(aLiRecordNum)
		$numElements:=1
		For ($i; $k; 1; -1)
			$doDelete:=False:C215
			$startElement:=$i
			$w:=Find in array:C230(aOLineNum; aLiLineID{$i})
			Case of 
				: ($w=-1)
					$doDelete:=True:C214
				: (aOQtyOrder{$w}<$aQtyByLine{$w})
					$doDelete:=True:C214
					TRACE:C157
				Else 
					$aQtyByLine{$w}:=$aQtyByLine{$w}+aLiQty{$i}
					$aQtyByOrdLine{$w}:=$aQtyByOrdLine{$w}-aLiQty{$i}
					If ($aQtyByOrdLine{$w}<0)
						TRACE:C157
						$doDelete:=True:C214
					End if 
			End case 
			If ($doDelete)
				
				
				GOTO RECORD:C242([LoadItem:87]; aLiRecordNum{$i})
				DELETE RECORD:C58([LoadItem:87])
				DELETE FROM ARRAY:C228(aLiRecordNum; $startElement; $numElements)
				DELETE FROM ARRAY:C228(aLiLoadTagID; $startElement; $numElements)
				DELETE FROM ARRAY:C228(aLiDocID; $startElement; $numElements)
				DELETE FROM ARRAY:C228(aLiLineID; $startElement; $numElements)
				DELETE FROM ARRAY:C228(aLiItemNum; $startElement; $numElements)
				DELETE FROM ARRAY:C228(aLiItemNumAlt; $startElement; $numElements)
				DELETE FROM ARRAY:C228(aLiItemDescription; $startElement; $numElements)
				DELETE FROM ARRAY:C228(aLiHazardClass; $startElement; $numElements)
				DELETE FROM ARRAY:C228(aLiQty; $startElement; $numElements)
				DELETE FROM ARRAY:C228(aLiUnitWt; $startElement; $numElements)
				DELETE FROM ARRAY:C228(aLiTagGroup; $startElement; $numElements)
				DELETE FROM ARRAY:C228(aLiTableType; $startElement; $numElements)
				DELETE FROM ARRAY:C228(aLiExtendedWt; $startElement; $numElements)
				DELETE FROM ARRAY:C228(aLiValue; $startElement; $numElements)
				DELETE FROM ARRAY:C228(aLiInvoiceNum; $startElement; $numElements)
				DELETE FROM ARRAY:C228(aLiUniqueID; $startElement; $numElements)
			End if 
		End for 
		$k:=Size of array:C274(aOLineNum)
		C_REAL:C285($qtyApply)
		//TRACE
		For ($i; 1; $k)
			QUERY:C277([Item:4]; [Item:4]itemNum:1=aOItemNum{$i})
			If (Not:C34(([Item:4]notTracked:56) & ([Item:4]weightAverage:8=0)))
				While ($aQtyByOrdLine{$i}>0)
					If ($aQtyByOrdLine{$i}>1)
						$qtyApply:=1
						$aQtyByOrdLine{$i}:=$aQtyByOrdLine{$i}-1
					Else 
						$qtyApply:=$aQtyByOrdLine{$i}
						$aQtyByOrdLine{$i}:=0
					End if 
					$startElement:=Size of array:C274(aLiRecordNum)+1
					INSERT IN ARRAY:C227(aLiRecordNum; $startElement; $numElements)
					aLiRecordNum{$startElement}:=-3
					INSERT IN ARRAY:C227(aLiLoadTagID; $startElement; $numElements)
					INSERT IN ARRAY:C227(aLiDocID; $startElement; $numElements)
					INSERT IN ARRAY:C227(aLiLineID; $startElement; $numElements)
					INSERT IN ARRAY:C227(aLiItemNum; $startElement; $numElements)
					INSERT IN ARRAY:C227(aLiItemNumAlt; $startElement; $numElements)
					INSERT IN ARRAY:C227(aLiItemDescription; $startElement; $numElements)
					INSERT IN ARRAY:C227(aLiHazardClass; $startElement; $numElements)
					INSERT IN ARRAY:C227(aLiQty; $startElement; $numElements)
					INSERT IN ARRAY:C227(aLiUnitWt; $startElement; $numElements)
					INSERT IN ARRAY:C227(aLiTagGroup; $startElement; $numElements)
					INSERT IN ARRAY:C227(aLiTableType; $startElement; $numElements)
					INSERT IN ARRAY:C227(aLiExtendedWt; $startElement; $numElements)
					INSERT IN ARRAY:C227(aLiValue; $startElement; $numElements)
					INSERT IN ARRAY:C227(aLiInvoiceNum; $startElement; $numElements)
					INSERT IN ARRAY:C227(aLiUniqueID; $startElement; $numElements)
					aLiLoadTagID{$startElement}:=0
					aLiDocID{$startElement}:=[Order:3]idNum:2
					aLiLineID{$startElement}:=aOUniqueID{$i}
					aLiItemNum{$startElement}:=aOItemNum{$i}
					aLiItemNumAlt{$startElement}:=aOAltItem{$i}
					aLiItemDescription{$startElement}:=aODescpt{$i}
					aLiHazardClass{$startElement}:=""
					aLiQty{$startElement}:=$qtyApply
					aLiUnitWt{$startElement}:=aOUnitWt{$i}
					aLiValue{$startElement}:=aODscntUP{$i}
					aLiExtendedWt{$startElement}:=Round:C94(aOUnitWt{$i}*$qtyApply; 1)
					aLiTagGroup{$startElement}:=-3
					aLiInvoiceNum{$startElement}:=-3
					aLiUniqueID{$startElement}:=-3
				End while 
			End if 
		End for 
		ARRAY LONGINT:C221(aLiLoadItemSelect; 1)
		aLiLoadItemSelect{1}:=1
		READ ONLY:C145([LoadItem:87])
		
	: ($1=-14)
		READ WRITE:C146([LoadItem:87])
		If (Is new record:C668([Invoice:26]))
			QUERY:C277([LoadItem:87]; [LoadItem:87]tableNum:1=Table:C252(->[Order:3]); *)
			QUERY:C277([LoadItem:87];  & [LoadItem:87]idNumOrder:2=[Invoice:26]idNumOrder:1)
		Else 
			QUERY:C277([LoadItem:87]; [LoadItem:87]invoiceNum:14=[Invoice:26]idNum:2)
		End if 
		SELECTION TO ARRAY:C260([LoadItem:87]idNum:16; aLiUniqueID; [LoadItem:87]value:15; aLiValue; [LoadItem:87]itemNumAlt:12; aLiItemNumAlt; [LoadItem:87]weightExtended:11; aLiExtendedWt; [LoadItem:87]tableNum:1; aLiTableType; [LoadItem:87]; aLiRecordNum; [LoadItem:87]idNumOrder:2; aLiDocID; [LoadItem:87]lineid:5; aLiLineID; [LoadItem:87]itemNum:3; aLiItemNum; [LoadItem:87]itemDescription:4; aLiItemDescription; [LoadItem:87]hazardClass:10; aLiHazardClass; [LoadItem:87]quantity:7; aLiQty; [LoadItem:87]unitWeight:6; aLiUnitWt; [LoadItem:87]packGroupid:9; aLiTagGroup; [LoadItem:87]idNumLoadTag:8; aLiLoadTagID; [LoadItem:87]invoiceNum:14; aLiInvoiceNum)
		C_LONGINT:C283($i; $k; $w)
		$k:=Size of array:C274(aOQtyOrder)
		ARRAY LONGINT:C221($aLineByLine; $k)
		ARRAY REAL:C219($aQtyByLine; $k)
		ARRAY REAL:C219($aQtyByOrdLine; $k)
		COPY ARRAY:C226(aOQtyOrder; $aQtyByOrdLine)
		// TRACE
		$k:=Size of array:C274(aLiRecordNum)
		$numElements:=1
		For ($i; $k; 1; -1)
			$doDelete:=False:C215
			$startElement:=$i
			$w:=Find in array:C230(aiLineNum; aLiLineID{$i})
			Case of 
				: ($w=-1)
					$doDelete:=True:C214
				: (aiQtyShip{$w}<$aQtyByLine{$w})
					$doDelete:=True:C214
					//TRACE
				Else 
					$aQtyByLine{$w}:=$aQtyByLine{$w}+aLiQty{$i}
					$aQtyByOrdLine{$w}:=$aQtyByOrdLine{$w}-aLiQty{$i}
					If ($aQtyByOrdLine{$w}<0)
						//TRACE
						$doDelete:=True:C214
					End if 
			End case 
			If ($doDelete)
				GOTO RECORD:C242([LoadItem:87]; aLiRecordNum{$i})
				DELETE RECORD:C58([LoadItem:87])
				DELETE FROM ARRAY:C228(aLiRecordNum; $startElement; $numElements)
				DELETE FROM ARRAY:C228(aLiLoadTagID; $startElement; $numElements)
				DELETE FROM ARRAY:C228(aLiDocID; $startElement; $numElements)
				DELETE FROM ARRAY:C228(aLiLineID; $startElement; $numElements)
				DELETE FROM ARRAY:C228(aLiItemNum; $startElement; $numElements)
				DELETE FROM ARRAY:C228(aLiItemDescription; $startElement; $numElements)
				DELETE FROM ARRAY:C228(aLiHazardClass; $startElement; $numElements)
				DELETE FROM ARRAY:C228(aLiQty; $startElement; $numElements)
				DELETE FROM ARRAY:C228(aLiUnitWt; $startElement; $numElements)
				DELETE FROM ARRAY:C228(aLiTagGroup; $startElement; $numElements)
				DELETE FROM ARRAY:C228(aLiTableType; $startElement; $numElements)
				DELETE FROM ARRAY:C228(aLiExtendedWt; $startElement; $numElements)
				DELETE FROM ARRAY:C228(aLiValue; $startElement; $numElements)
				DELETE FROM ARRAY:C228(aLiInvoiceNum; $startElement; $numElements)
				DELETE FROM ARRAY:C228(aLiUniqueID; $startElement; $numElements)
				
			End if 
		End for 
		$k:=Size of array:C274(aiLineNum)
		C_REAL:C285($qtyApply)
		For ($i; 1; $k)
			QUERY:C277([Item:4]; [Item:4]itemNum:1=aiItemNum{$i})
			If (Not:C34(([Item:4]notTracked:56) & ([Item:4]weightAverage:8=0)))
				While ($aQtyByOrdLine{$i}>0)
					If ($aQtyByOrdLine{$i}>1)
						$qtyApply:=1
						$aQtyByOrdLine{$i}:=$aQtyByOrdLine{$i}-1
					Else 
						$qtyApply:=$aQtyByOrdLine{$i}
						$aQtyByOrdLine{$i}:=0
					End if 
					$startElement:=Size of array:C274(aLiRecordNum)+1
					INSERT IN ARRAY:C227(aLiRecordNum; $startElement; $numElements)
					aLiRecordNum{$startElement}:=-3
					INSERT IN ARRAY:C227(aLiLoadTagID; $startElement; $numElements)
					INSERT IN ARRAY:C227(aLiDocID; $startElement; $numElements)
					INSERT IN ARRAY:C227(aLiLineID; $startElement; $numElements)
					INSERT IN ARRAY:C227(aLiItemNum; $startElement; $numElements)
					INSERT IN ARRAY:C227(aLiItemNumAlt; $startElement; $numElements)
					INSERT IN ARRAY:C227(aLiItemDescription; $startElement; $numElements)
					INSERT IN ARRAY:C227(aLiHazardClass; $startElement; $numElements)
					INSERT IN ARRAY:C227(aLiQty; $startElement; $numElements)
					INSERT IN ARRAY:C227(aLiUnitWt; $startElement; $numElements)
					INSERT IN ARRAY:C227(aLiTagGroup; $startElement; $numElements)
					INSERT IN ARRAY:C227(aLiTableType; $startElement; $numElements)
					INSERT IN ARRAY:C227(aLiExtendedWt; $startElement; $numElements)
					INSERT IN ARRAY:C227(aLiValue; $startElement; $numElements)
					INSERT IN ARRAY:C227(aLiInvoiceNum; $startElement; $numElements)
					INSERT IN ARRAY:C227(aLiUniqueID; $startElement; $numElements)
					//
					aLiLoadTagID{$startElement}:=0
					aLiUniqueID{$startElement}:=-3
					aLiDocID{$startElement}:=[Invoice:26]idNum:2
					aLiLineID{$startElement}:=aiUniqueID{$i}
					aLiItemNum{$startElement}:=aiItemNum{$i}
					aLiItemDescription{$startElement}:=aiDescpt{$i}
					aLiHazardClass{$startElement}:=""
					aLiQty{$startElement}:=$qtyApply
					aLiUnitWt{$startElement}:=aiUnitWt{$i}
					aLiExtendedWt{$startElement}:=Round:C94(aOUnitWt{$i}*$qtyApply; 1)
					aLiTagGroup{$startElement}:=-3
					aLiTableType{$startElement}:=3
					aLiValue{$startElement}:=aiUnitPriceDiscounted{$i}
					aLiInvoiceNum{$startElement}:=-3
				End while 
			End if 
		End for 
		ARRAY LONGINT:C221(aLiLoadItemSelect; 1)
		aLiLoadItemSelect{1}:=1
		READ ONLY:C145([LoadItem:87])
		
		
	: ($1=-1)  //delete an element
		//RACE
		If (aLiRecordNum{$startElement}>-1)
			GOTO RECORD:C242([LoadItem:87]; aLiRecordNum{$startElement})
			DELETE RECORD:C58([LoadItem:87])
		End if 
		DELETE FROM ARRAY:C228(aLiRecordNum; $startElement; $numElements)
		DELETE FROM ARRAY:C228(aLiLoadTagID; $startElement; $numElements)
		DELETE FROM ARRAY:C228(aLiDocID; $startElement; $numElements)
		DELETE FROM ARRAY:C228(aLiLineID; $startElement; $numElements)
		DELETE FROM ARRAY:C228(aLiItemNum; $startElement; $numElements)
		DELETE FROM ARRAY:C228(aLiItemNumAlt; $startElement; $numElements)
		DELETE FROM ARRAY:C228(aLiItemDescription; $startElement; $numElements)
		DELETE FROM ARRAY:C228(aLiHazardClass; $startElement; $numElements)
		DELETE FROM ARRAY:C228(aLiQty; $startElement; $numElements)
		DELETE FROM ARRAY:C228(aLiUnitWt; $startElement; $numElements)
		DELETE FROM ARRAY:C228(aLiTagGroup; $startElement; $numElements)
		DELETE FROM ARRAY:C228(aLiTableType; $startElement; $numElements)
		DELETE FROM ARRAY:C228(aLiExtendedWt; $startElement; $numElements)
		DELETE FROM ARRAY:C228(aLiValue; $startElement; $numElements)
		
		DELETE FROM ARRAY:C228(aLiInvoiceNum; $startElement; $numElements)
		DELETE FROM ARRAY:C228(aLiUniqueID; $startElement; $numElements)
		
		//
		ARRAY LONGINT:C221(aLiLoadItemSelect; 0)
	: ($1=-3)  //insert an element    
		INSERT IN ARRAY:C227(aLiRecordNum; $startElement; $numElements)
		aLiRecordNum{$startElement}:=-3
		INSERT IN ARRAY:C227(aLiLoadTagID; $startElement; $numElements)
		INSERT IN ARRAY:C227(aLiDocID; $startElement; $numElements)
		INSERT IN ARRAY:C227(aLiLineID; $startElement; $numElements)
		INSERT IN ARRAY:C227(aLiItemNum; $startElement; $numElements)
		INSERT IN ARRAY:C227(aLiItemNumAlt; $startElement; $numElements)
		INSERT IN ARRAY:C227(aLiItemDescription; $startElement; $numElements)
		INSERT IN ARRAY:C227(aLiHazardClass; $startElement; $numElements)
		INSERT IN ARRAY:C227(aLiQty; $startElement; $numElements)
		INSERT IN ARRAY:C227(aLiUnitWt; $startElement; $numElements)
		INSERT IN ARRAY:C227(aLiTagGroup; $startElement; $numElements)
		INSERT IN ARRAY:C227(aLiTableType; $startElement; $numElements)
		INSERT IN ARRAY:C227(aLiExtendedWt; $startElement; $numElements)
		INSERT IN ARRAY:C227(aLiValue; $startElement; $numElements)
		INSERT IN ARRAY:C227(aLiInvoiceNum; $startElement; $numElements)
		INSERT IN ARRAY:C227(aLiUniqueID; $startElement; $numElements)
		
		//
		ARRAY LONGINT:C221(aLiLoadItemSelect; 1)
		aLiLoadItemSelect{1}:=$startElement
	: ($1=-4)  //Fill a record
		
	: ($1=-5)  //array to selection
		//  If (Count parameters=4)
		READ WRITE:C146([LoadItem:87])
		
		//TRACE
		
		// must create the box first cannot use CounterNew to create an ID to be filled in later. Automatic UniqueID
		CREATE RECORD:C68([LoadTag:88])
		[LoadTag:88]customerID:23:=[Order:3]customerID:1
		[LoadTag:88]idNumOrder:29:=[Order:3]idNum:2
		[LoadTag:88]customerPO:37:=[Order:3]customerPO:3
		PKArrayManage(-3; 1; 1)  // create array elements
		$theWt:=0
		aPKUniqueID{1}:=[LoadTag:88]idNum:1
		
		$k:=Size of array:C274(aLiLineID)
		
		If (($k=0) & (allowAlerts_boo))
			ALERT:C41("ERROR: NO LINE ITEMS IN ARRAY\r\rCALL JIM MEDLEN")
		End if 
		
		For ($i; 1; $k)
			QUERY:C277([OrderLine:49]; [OrderLine:49]idNum:50=aLiLineID{$i})
			aPKValue{1}:=aPKValue{1}+Round:C94(aLiQty{$i}*aLiValue{$i}; 2)
			UNLOAD RECORD:C212([OrderLine:49])
			//TRACE
			
			If (iLoInteger1=0)  //scale driven by load items, jump to end for override
				//skip the summation and just straight to the total scale weight
				//aPKWeightExtended{1}:=aPKWeightExtended{1}+aLiExtendedWt{$I}
				//aPKWeightExtended{1}:=aPKWeightExtended{1}+vrWeightScale//###_jwm_###
			End if 
			aLiLoadTagID{$i}:=[LoadTag:88]idNum:1
			//      
			If (aLiLineID{$i}=-18)  //dInventory Dunnage
				READ WRITE:C146([DInventory:36])
				CREATE RECORD:C68([DInventory:36])
				[DInventory:36]itemNum:1:=aLiItemNum{$i}
				[DInventory:36]qtyOnHand:2:=-aLiQty{$i}
				[DInventory:36]idNumDoc:9:=srSO
				[DInventory:36]reason:13:="dun+"
				[DInventory:36]typeID:14:="dun+"
				[DInventory:36]dateCreated:39:=Current date:C33
				[DInventory:36]timeCreated:40:=Current time:C178
				[DInventory:36]dtCreated:15:=DateTime_DTTo
				[DInventory:36]changedBy:22:=Current user:C182
				[DInventory:36]tableName:30:=Table name:C256(->[Order:3])
				REDUCE SELECTION:C351([DInventory:36]; 0)
				READ ONLY:C145([DInventory:36])
			End if 
			//
		End for 
		If (iLoInteger1=1)  //single override
			//aPKWeightExtended{1}:=aPKWeightExtended{1}+aLiExtendedWt{$I}
			aPKWeightExtended{1}:=aPKWeightExtended{1}+vrWeightScale  //###_jwm_###
		End if 
		
		$k:=Size of array:C274(aLiValue)
		For ($i; 1; $k)
			CREATE RECORD:C68([LoadItem:87])
			aLiUniqueID{$i}:=[LoadItem:87]idNum:16
			// autocreated in structure
			[LoadItem:87]customerID:18:=[LoadTag:88]customerID:23
			[LoadItem:87]idNumOrder:2:=[LoadTag:88]idNumOrder:29
			[LoadItem:87]customerPO:17:=[LoadTag:88]customerPO:37
			[LoadItem:87]value:15:=aLiValue{$i}
			[LoadItem:87]itemNumAlt:12:=aLiItemNumAlt{$i}
			[LoadItem:87]weightExtended:11:=aLiExtendedWt{$i}
			[LoadItem:87]tableNum:1:=aLiTableType{$i}
			[LoadItem:87]idNumOrder:2:=aLiDocID{$i}
			[LoadItem:87]lineid:5:=aLiLineID{$i}
			[LoadItem:87]itemNum:3:=aLiItemNum{$i}
			[LoadItem:87]itemDescription:4:=aLiItemDescription{$i}
			[LoadItem:87]hazardClass:10:=aLiHazardClass{$i}
			[LoadItem:87]quantity:7:=aLiQty{$i}
			[LoadItem:87]unitWeight:6:=aLiUnitWt{$i}
			[LoadItem:87]packGroupid:9:=aLiTagGroup{$i}
			[LoadItem:87]idNumLoadTag:8:=aLiLoadTagID{$i}
			[LoadItem:87]invoiceNum:14:=aLiInvoiceNum{$i}
			SAVE RECORD:C53([LoadItem:87])
		End for 
		REDUCE SELECTION:C351([LoadItem:87]; 0)
		// qqqq????zzzz
		// Check if Apply To Selection was successful
		// ### jwm ### 20160317_1111 DEBUG why are we having LoadTags without LoadItems
		If ((Records in selection:C76([LoadItem:87])=0) & (allowAlerts_boo))
			ALERT:C41("ERROR: NO LOAD ITEMS WERE CREATED")
		End if 
		
		If ((Records in set:C195("LockedSet")#0) & (allowAlerts_boo))
			ALERT:C41("ERROR: LOAD ITEMS WERE LOCKED")
		End if 
		// ### jwm ### 20160317_1111 DEBUG why are we having LoadTags without LoadItems
		
		UNLOAD RECORD:C212([LoadItem:87])
		READ ONLY:C145([LoadItem:87])
		//
		If (iLoInteger9=0)
			If (iLoInteger1=0)
				aPKWeightExtended{1}:=vrWeightScale  //wt from scale
				aPKWeightProduct{1}:=vrWeightProduct  //Product Weight // ### jwm ### 20150126_1527
				aPKWeightTare{1}:=vrWeightTare  //Tare Weight  // ### jwm ### 20150126_1527
			End if 
		End if 
		
		aPKtrackID{1}:=$trackingID
		aPKDTReceiveExpected{1}:=DateTime_DTTo
		aPKStatus{1}:=$status
		aPKdocumentID{1}:=srSO
		
		aPKContainerType{1}:=1  //box
		aPKCarrierID{1}:=[Order:3]shipVia:13
		aPKCustomerVendorID{1}:=[Order:3]customerID:1
		aPKdocumentID{1}:=[Order:3]idNum:2
		aPKTransactionType{1}:=3
		
		PKArrayManage(-4; 1)  // complete the box
		If (eShipList>0)
			//  --  CHOPPED  AL_UpdateArrays(eShipList; -2)
			ARRAY LONGINT:C221(aShipSel; 1)
			aShipSel{1}:=1
			viVert:=1
			// -- AL_SetSelect(eShipList; aShipSel)
			// -- AL_SetScroll(eShipList; viVert; viHorz)
		End if 
		
		
		//TRACE
		If (iLoInteger9=0)  //set condition in b11 (Order Freight button to ignor)
			//added in packing window cannot be > 0 in Order layout
			badTechnique:=0  //so this can be found later
			$k:=Size of array:C274(aOQtyPack)
			For ($i; 1; $k)
				If (aOQtyPack{$i}#0)
					aoLineAction{$i}:=-2000  //  must be set to tell (P) OrdLineCalc
					aOQtyShip{$i}:=aOQtyShip{$i}+aOQtyPack{$i}
					aOQtyBL{$i}:=aOQtyOrder{$i}-aOQtyShip{$i}
					OrdLnExtend($i)
				Else 
					//  aoLineAction{$i}:=10  //  tell NO Change (P) OrdLineCalc
					aoLineAction{$i}:=-3000  // recalculate the line in case commissions or taxes changed
				End if 
			End for 
			
			booAccept:=True:C214
			vMod:=True:C214
			C_TEXT:C284(vPackingProcess)
			vPackingProcess:="PK"
			acceptOrders
			vPackingProcess:=""
		End if 
		
		LT_FillArrayLoadItems(0)  // empty the LoadItems arrays
		If (eLoadList>0)
			//  --  CHOPPED  AL_UpdateArrays(eLoadList; -2)
		End if 
		
		//Reset order lines to current counts
		If (eOrdList#0)
			PkOrderLoad(srSO; eOrdList)
		End if 
	: ($1=-55)  //array to selection
		//  If (Count parameters=4)
		READ WRITE:C146([LoadItem:87])
		TRACE:C157
		TRACE:C157
		//TRACE
		ALERT:C41("No load planning released")
		
		LT_FillArrayLoadItems(0)
		
	: ($1=-6)  //Update an array
		
	: ($1=-7)
		SORT ARRAY:C229(aLiTagGroup; aLiLoadTagID; aLiLineID; aLiDocID; aLiItemNum; aLiItemNumAlt; aLiItemDescription; aLiHazardClass; aLiQty; aLiUnitWt; aLiExtendedWt; aLiInvoiceNum; aLiUniqueID)
End case 


