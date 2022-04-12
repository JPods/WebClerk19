//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/22/06, 03:08:14
// ----------------------------------------------------
// Method: Ord_FillArray
// Description
// 
//
// Parameters
// ----------------------------------------------------

//Procedure: Ord_FillArray
C_LONGINT:C283($1; $i; $2; $w)
Case of 
	: ($1=0)
		ARRAY DATE:C224(aNeedDates; $1)
		ARRAY LONGINT:C221(aNeedTimes; $1)
		ARRAY LONGINT:C221(aOpenOrders; $1)
		ARRAY LONGINT:C221(ataskID; $1)
		ARRAY TEXT:C222(aOrdStatus; $1)
		ARRAY REAL:C219(aOrdAmt; $1)
		ARRAY TEXT:C222(aOrdNames; $1)
		ARRAY TEXT:C222(aOrdCompany; $1)
		ARRAY TEXT:C222(aOrdAddress1; $1)
		ARRAY TEXT:C222(aOrdLevel; $1)
		ARRAY TEXT:C222(aOrdShipVia; $1)
		ARRAY TEXT:C222(aCustCtrl; $1)
		ARRAY TEXT:C222(aCustPO; $1)
		ARRAY DATE:C224(aComDates; $1)
		ARRAY LONGINT:C221(aOrdRecs; $1)
		
	: ($1>0)
		SELECTION TO ARRAY:C260([Order:3]company:15; aOrdCompany; [Order:3]address1:16; aOrdAddress1; [Order:3]dateNeeded:5; aNeedDates; [Order:3]actionTime:37; aNeedTimes; [Order:3]orderNum:2; aOpenOrders; [Order:3]status:59; aOrdStatus; [Order:3]amount:24; aOrdAmt; [Order:3]actionBy:55; aOrdNames; [Order:3]typeSale:22; aOrdLevel; [Order:3]shipVia:13; aOrdShipVia; [Order:3]company:15; aCustCtrl; [Order:3]customerPO:3; aCustPO; [Order:3]dateInvoiceComp:6; aComDates; [Order:3]; aOrdRecs; [Order:3]taskid:85; ataskID)
	: ($1=-1)
		$w:=$2
		DELETE FROM ARRAY:C228(aNeedDates; $w)
		DELETE FROM ARRAY:C228(aNeedTimes; $w)
		DELETE FROM ARRAY:C228(aOpenOrders; $w)
		DELETE FROM ARRAY:C228(ataskID; $w)
		DELETE FROM ARRAY:C228(aOrdStatus; $w)
		DELETE FROM ARRAY:C228(aOrdAmt; $w)
		DELETE FROM ARRAY:C228(aOrdNames; $w)
		DELETE FROM ARRAY:C228(aOrdCompany; $w)
		DELETE FROM ARRAY:C228(aOrdAddress1; $w)
		DELETE FROM ARRAY:C228(aOrdLevel; $w)
		DELETE FROM ARRAY:C228(aOrdShipVia; $w)
		DELETE FROM ARRAY:C228(aCustCtrl; $w)
		DELETE FROM ARRAY:C228(aCustPO; $w)
		DELETE FROM ARRAY:C228(aComDates; $w)
		DELETE FROM ARRAY:C228(aOrdRecs; $w)
	: ($1=-3)
		FIRST RECORD:C50([Order:3])
		For ($i; 1; $2)
			$w:=Size of array:C274(aOrdRecs)+1
			INSERT IN ARRAY:C227(aNeedDates; $w)
			INSERT IN ARRAY:C227(aNeedTimes; $w)
			INSERT IN ARRAY:C227(aOpenOrders; $w)
			INSERT IN ARRAY:C227(ataskID; $w)
			INSERT IN ARRAY:C227(aOrdStatus; $w)
			INSERT IN ARRAY:C227(aOrdAmt; $w)
			INSERT IN ARRAY:C227(aOrdNames; $w)
			INSERT IN ARRAY:C227(aOrdCompany; $w)
			INSERT IN ARRAY:C227(aOrdAddress1; $w)
			INSERT IN ARRAY:C227(aOrdLevel; $w)
			INSERT IN ARRAY:C227(aOrdShipVia; $w)
			INSERT IN ARRAY:C227(aCustCtrl; $w)
			INSERT IN ARRAY:C227(aCustPO; $w)
			INSERT IN ARRAY:C227(aComDates; $w)
			INSERT IN ARRAY:C227(aOrdRecs; $w)
			aNeedDates{$w}:=[Order:3]dateNeeded:5
			aNeedTimes{$w}:=[Order:3]actionTime:37*1
			aOpenOrders{$w}:=[Order:3]orderNum:2
			ataskID{$w}:=[Order:3]taskid:85
			aOrdStatus{$w}:=[Order:3]status:59
			aOrdAmt{$w}:=[Order:3]amount:24
			aOrdNames{$w}:=[Order:3]actionBy:55
			aOrdCompany{$w}:=[Order:3]company:15
			aOrdAddress1{$w}:=[Order:3]address1:16
			aOrdLevel{$w}:=[Order:3]typeSale:22
			aOrdShipVia{$w}:=[Order:3]shipVia:13
			aCustCtrl{$w}:=[Order:3]company:15
			aCustPO{$w}:=[Order:3]customerPO:3
			aComDates{$w}:=[Order:3]dateInvoiceComp:6
			aOrdRecs{$w}:=Record number:C243([Order:3])
			NEXT RECORD:C51([Order:3])
		End for 
		UNLOAD RECORD:C212([Order:3])
	: ($1=-12)  //Omit Subset
		If (Size of array:C274(aRayLines)>0)
			
			Ray_OmitSubSet(->aRayLines; ->aOrdRecs; ->aNeedDates; ->aNeedTimes; ->aOpenOrders; ->aOrdStatus; ->aOrdAmt; ->aOrdNames; ->aOrdLevel; ->aOrdShipVia; ->aCustCtrl; ->aCustPO; ->aComDates; ->aOrdAddress1; ->aOrdCompany; ->ataskID)
			doSearch:=6
		Else 
			BEEP:C151
			BEEP:C151
		End if 
	: ($1=-11)  //Show Subset
		
		$cntLines:=Size of array:C274(aRayLines)
		
		If ($cntLines>0)
			
			Ray_ShowSubSet(->aRayLines; ->aOrdRecs; ->aNeedDates; ->aNeedTimes; ->aOpenOrders; ->aOrdStatus; ->aOrdAmt; ->aOrdNames; ->aOrdLevel; ->aOrdShipVia; ->aCustCtrl; ->aCustPO; ->aComDates; ->aOrdAddress1; ->aOrdCompany; ->ataskID)
			doSearch:=6
		Else 
			BEEP:C151
			BEEP:C151
		End if 
End case 
//UNLOAD RECORD([Order])    // can't do this for add invoice loop under Inv Menu