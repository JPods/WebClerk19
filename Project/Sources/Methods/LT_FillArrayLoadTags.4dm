//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/25/07, 07:30:52
// ----------------------------------------------------
// Method: LT_FillArrayLoadTags
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1; $2; $3; $incRay; $sizeRay; $diff; $p; $w; $k; $i)
C_LONGINT:C283($startElement; $numElements)
If (Count parameters:C259>1)
	$startElement:=$2
	If (Count parameters:C259>2)
		$numElements:=$3
	End if 
End if 
//
Case of 
	: (vbForceShip)  //skip if forced from packing window
	: ($1=0)
		ARRAY LONGINT:C221(aLtLoadTagID; $1)
		ARRAY LONGINT:C221(aLtOrderNum; $1)
		ARRAY LONGINT:C221(aLtPoNum; $1)
		ARRAY LONGINT:C221(aLtinvoiceNum; $1)
		ARRAY TEXT:C222(aLtTagStatus; $1)
		ARRAY TEXT:C222(aLttrackID; $1)
		ARRAY REAL:C219(aLtWeightExt; $1)
		ARRAY REAL:C219(aLtTagWidth; $1)
		ARRAY REAL:C219(aLtTagHeight; $1)
		ARRAY REAL:C219(aLtTagDepth; $1)
		ARRAY TEXT:C222(aLtCarrier; $1)
		ARRAY DATE:C224(aLtStage; $1)
		ARRAY DATE:C224(aLtShipOn; $1)
		ARRAY DATE:C224(aLtCustoms; $1)
		ARRAY DATE:C224(aLtExpected; $1)
		ARRAY TEXT:C222(aLtInsureID; $1)
		ARRAY TEXT:C222(aLtHazard; $1)
		ARRAY LONGINT:C221(aLtTagRecordID; $1)
		//    
		ARRAY LONGINT:C221(aLtTagSelect; 0)
		//
	: ($1>0)
		LT_FillArrayFromTable($1)
		
	: ($1=-12)
		READ WRITE:C146([LoadTag:88])
		QUERY:C277([LoadTag:88]; [LoadTag:88]documentID:17=[Invoice:26]idNum:2)
		$k:=Records in selection:C76([LoadTag:88])
		LT_FillArrayFromTable($k)
		
		If (False:C215)
			C_LONGINT:C283($i; $k; $w)
			$k:=Size of array:C274(aOQtyOrder)
			ARRAY LONGINT:C221($aLineByLine; $k)
			ARRAY REAL:C219($aQtyByLine; $k)
			ARRAY REAL:C219($aQtyByOrdLine; $k)
			COPY ARRAY:C226(aOQtyOrder; $aQtyByOrdLine)
			TRACE:C157
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
					Else 
						$aQtyByLine{$w}:=$aQtyByLine{$w}+aLiQty{$i}
						$aQtyByOrdLine{$w}:=$aQtyByOrdLine{$w}-aLiQty{$i}
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
				End if 
			End for 
			$k:=Size of array:C274(aOLineNum)
			C_REAL:C285($qtyApply)
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
						INSERT IN ARRAY:C227(aLiItemDescription; $startElement; $numElements)
						INSERT IN ARRAY:C227(aLiHazardClass; $startElement; $numElements)
						INSERT IN ARRAY:C227(aLiQty; $startElement; $numElements)
						INSERT IN ARRAY:C227(aLiUnitWt; $startElement; $numElements)
						INSERT IN ARRAY:C227(aLiTagGroup; $startElement; $numElements)
						aLiLoadTagID{$startElement}:=0
						aLiDocID{$startElement}:=[Order:3]idNum:2
						aLiLineID{$startElement}:=aOLineNum{$i}
						aLiItemNum{$startElement}:=aOItemNum{$i}
						aLiItemDescription{$startElement}:=aODescpt{$i}
						aLiHazardClass{$startElement}:=""
						aLiQty{$startElement}:=$qtyApply
						aLiUnitWt{$startElement}:=aOUnitWt{$i}
						aLiTagGroup{$startElement}:=-3
					End while 
				End if 
			End for 
			ARRAY LONGINT:C221(aLiLoadItemSelect; 1)
			aLiLoadItemSelect{1}:=1
			READ ONLY:C145([LoadItem:87])
			
		End if 
	: ($1=-1)  //delete an element
		DELETE FROM ARRAY:C228(aLtLoadTagID; $startElement; $numElements)
		DELETE FROM ARRAY:C228(aLtOrderNum; $startElement; $numElements)
		DELETE FROM ARRAY:C228(aLtPoNum; $startElement; $numElements)
		DELETE FROM ARRAY:C228(aLtinvoiceNum; $startElement; $numElements)
		DELETE FROM ARRAY:C228(aLtTagStatus; $startElement; $numElements)
		DELETE FROM ARRAY:C228(aLttrackID; $startElement; $numElements)
		DELETE FROM ARRAY:C228(aLtWeightExt; $startElement; $numElements)
		DELETE FROM ARRAY:C228(aLtTagWidth; $startElement; $numElements)
		DELETE FROM ARRAY:C228(aLtTagHeight; $startElement; $numElements)
		DELETE FROM ARRAY:C228(aLtTagDepth; $startElement; $numElements)
		DELETE FROM ARRAY:C228(aLtCarrier; $startElement; $numElements)
		DELETE FROM ARRAY:C228(aLtStage; $startElement; $numElements)
		DELETE FROM ARRAY:C228(aLtShipOn; $startElement; $numElements)
		DELETE FROM ARRAY:C228(aLtCustoms; $startElement; $numElements)
		DELETE FROM ARRAY:C228(aLtExpected; $startElement; $numElements)
		DELETE FROM ARRAY:C228(aLtInsureID; $startElement; $numElements)
		DELETE FROM ARRAY:C228(aLtHazard; $startElement; $numElements)
		DELETE FROM ARRAY:C228(aLtTagRecordID; $startElement; $numElements)
		
		
		//
		ARRAY LONGINT:C221(aLiLoadItemSelect; 0)
	: ($1=-3)  //insert an element    
		INSERT IN ARRAY:C227(aLtTagRecordID; $startElement; $numElements)
		aLtTagRecordID{$startElement}:=-3
		INSERT IN ARRAY:C227(aLtLoadTagID; $startElement; $numElements)
		INSERT IN ARRAY:C227(aLtOrderNum; $startElement; $numElements)
		INSERT IN ARRAY:C227(aLtPoNum; $startElement; $numElements)
		INSERT IN ARRAY:C227(aLtinvoiceNum; $startElement; $numElements)
		INSERT IN ARRAY:C227(aLtTagStatus; $startElement; $numElements)
		INSERT IN ARRAY:C227(aLttrackID; $startElement; $numElements)
		INSERT IN ARRAY:C227(aLtWeightExt; $startElement; $numElements)
		INSERT IN ARRAY:C227(aLtTagWidth; $startElement; $numElements)
		INSERT IN ARRAY:C227(aLtTagHeight; $startElement; $numElements)
		INSERT IN ARRAY:C227(aLtTagDepth; $startElement; $numElements)
		INSERT IN ARRAY:C227(aLtCarrier; $startElement; $numElements)
		INSERT IN ARRAY:C227(aLtStage; $startElement; $numElements)
		INSERT IN ARRAY:C227(aLtShipOn; $startElement; $numElements)
		INSERT IN ARRAY:C227(aLtCustoms; $startElement; $numElements)
		INSERT IN ARRAY:C227(aLtExpected; $startElement; $numElements)
		INSERT IN ARRAY:C227(aLtInsureID; $startElement; $numElements)
		INSERT IN ARRAY:C227(aLtHazard; $startElement; $numElements)
		//
		ARRAY LONGINT:C221(aLiLoadItemSelect; $startElement)
	: ($1=-4)  //Fill a record
		
	: ($1=-5)  //array to selection
		TRACE:C157
		// Modified by: Bill James (2016-08-12T00:00:00) Selection to Array
		// ### bj ### 20181212_2137
		// not called but needs to be removed as an option
		READ WRITE:C146([LoadItem:87])
		QUERY:C277([LoadItem:87]; [LoadItem:87]tableNum:1=Table:C252(->[Order:3]); *)
		QUERY:C277([LoadItem:87];  & [LoadItem:87]idNumOrder:2=[Order:3]idNum:2)
		C_LONGINT:C283($diffRecCnt)
		$diffRecCnt:=Records in selection:C76([LoadItem:87])-Size of array:C274(aLiRecordNum)
		If ($diffRecCnt>0)
			REDUCE SELECTION:C351([LoadItem:87]; $diffRecCnt)
			DELETE SELECTION:C66([LoadItem:87])
			QUERY:C277([LoadItem:87]; [LoadItem:87]tableNum:1=Table:C252(->[Order:3]); *)
			QUERY:C277([LoadItem:87];  & [LoadItem:87]idNumOrder:2=[Order:3]idNum:2)
		End if 
		$k:=Size of array:C274(aLiDocID)
		// ARRAY LONGINT($aTableType;$k)
		For ($i; 1; $k)
			CREATE RECORD:C68([LoadItem:87])
			// $aTableType{$i}:=3
			//[LoadItem]TableNum:=3
			//[LoadItem]OrderNum:=aLiDocID{$incRay}
			//[LoadItem]LineID:=aLiLineID{$incRay}
			//[LoadItem]ItemNum:=aLiItemNum{$incRay}
			//[LoadItem]ItemDescription:=aLiItemDescription{$incRay}
			//[LoadItem]HazardClass:=aLiHazardClass{$incRay}
			//[LoadItem]Quantity:=aLiQty{$incRay}
			//[LoadItem]UnitWeight:=aLiUnitWt{$incRay}
			//[LoadItem]PackGroupID:=aLiTagGroup{$incRay}
		End for 
		ARRAY TO SELECTION:C261($aTableType; [LoadItem:87]tableNum:1; aLiDocID; [LoadItem:87]idNumOrder:2; aLiLineID; [LoadItem:87]lineid:5; aLiItemNum; [LoadItem:87]itemNum:3; aLiItemDescription; [LoadItem:87]itemDescription:4; aLiHazardClass; [LoadItem:87]hazardClass:10; aLiQty; [LoadItem:87]quantity:7; aLiUnitWt; [LoadItem:87]unitWeight:6; aLiTagGroup; [LoadItem:87]packGroupid:9)
		
		
		UNLOAD RECORD:C212([LoadItem:87])
		READ ONLY:C145([LoadItem:87])
		//
	: ($1=-15)  //build in invoices
		
		ALERT:C41("This feature is superseded.")
		
		ConsoleLog("TEST: vModLoadTags")
		
		//TRACE
		If (vModLoadTags)
			READ WRITE:C146([LoadItem:87])
			QUERY:C277([LoadItem:87]; [LoadTag:88]idNumInvoice:19=[Invoice:26]idNum:2)  //;*)
			//QUERY([LoadItem];&[LoadTag]LoadTagID=-3)
			C_LONGINT:C283($diffRecCnt)
			DELETE SELECTION:C66([LoadItem:87])
			
			
			// End if 
			
			READ ONLY:C145([LoadItem:87])
		End if 
		vModLoadTags:=False:C215
	: ($1=-6)  //Update an array
		
	: ($1=-7)
		
End case 