//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1)
C_LONGINT:C283($1; $2; $3; $4; $5)

Case of 
	: ($1=0)
		ARRAY TEXT:C222(aRptPartNum; $1)
		ARRAY TEXT:C222(aRptPartDsc; $1)
		ARRAY LONGINT:C221(aBOMLevel; $1)  //Depth in BOM
		ARRAY REAL:C219(aQtyPlan; $1)  //Needed at this BOM Point        aQtyPlan
		ARRAY REAL:C219(aQtyAct; $1)  //Multiple at this BOM Point  aQtyAct
		ARRAY REAL:C219(aQtyReducedByOnHand; $1)  //DAN
		ARRAY REAL:C219(aQtyAdjOnHand; $1)  //DAN
		ARRAY LONGINT:C221(aBOMPlace; $1)  //keeps the place in line        aOpenOrders
		ARRAY TEXT:C222(aChecks; $1)  //                                    aChecks
		ARRAY REAL:C219(aCosts; $1)
		ARRAY REAL:C219(aCostsLast; $1)
		ARRAY TEXT:C222(aBomCmt; $1)
		ARRAY LONGINT:C221(aBomRecs; $1)
		
		
		ARRAY TEXT:C222(aBomBuildNote; $1)
		ARRAY TEXT:C222(aBomDescription; $1)
		ARRAY REAL:C219(aBOMCostsExpanded; $1)
		ARRAY REAL:C219(aBomPriceExpanded; $1)
		//
		ARRAY LONGINT:C221(aBomSelect; 0)
	: ($1>0)
		SELECTION TO ARRAY:C260([BOM:21]ChildItem:2; aRptPartNum; [BOM:21]Description:6; aRptPartDsc; [BOM:21]QtyInAssembly:3; aQtyPlan; [BOM:21]; aBomRecs; [BOM:21]Comment:5; aBomCmt)
		$k:=Size of array:C274(aRptPartNum)
		C_LONGINT:C283($rayType)
		$rayType:=Type:C295(aBOMLevel)
		$rayType:=Type:C295(aQtyAct)
		$rayType:=Type:C295(aQtyReducedByOnHand)
		$rayType:=Type:C295(aQtyAdjOnHand)
		$rayType:=Type:C295(aBOMPlace)
		$rayType:=Type:C295(aCosts)
		ARRAY LONGINT:C221(aBOMLevel; $k)  //Depth in BOM
		ARRAY REAL:C219(aQtyAct; $k)  //Multiple at this BOM Point  aQtyAct
		ARRAY REAL:C219(aQtyReducedByOnHand; $k)  //DAN
		ARRAY REAL:C219(aQtyAdjOnHand; $k)  //DAN
		ARRAY LONGINT:C221(aBOMPlace; $k)  //keeps the place in line        aOpenOrders
		ARRAY TEXT:C222(aChecks; $k)  //                                    aChecks
		ARRAY REAL:C219(aCosts; $k)
		ARRAY REAL:C219(aCostsLast; $k)
		
		
		ARRAY TEXT:C222(aBomBuildNote; $k)
		ARRAY TEXT:C222(aBomDescription; $k)
		ARRAY REAL:C219(aBOMCostsExpanded; $k)
		ARRAY REAL:C219(aBomPriceExpanded; $k)
		
		For ($i; 1; $k)
			aQtyAct{$i}:=aQtyPlan{$i}
			aBOMLevel{$i}:=1
			aBOMPlace{$i}:=$i
			aChecks{$i}:=""
			aCosts{$i}:=0
			aCostsLast{$i}:=0
			
			aBomBuildNote{$i}:=""
			aBomDescription{$i}:=""
			aBOMCostsExpanded{$i}:=0
			aBomPriceExpanded{$i}:=0
			
			aQtyReducedByOnHand{$i}:=aQtyPlan{$i}  //DAN
			aQtyAdjOnHand{$i}:=aQtyPlan{$i}  //DAN
		End for 
		UNLOAD RECORD:C212([BOM:21])
		//
		ARRAY LONGINT:C221(aBomSelect; 0)
	: ($1=-1)
		DELETE FROM ARRAY:C228(aRptPartNum; $2; $3)
		DELETE FROM ARRAY:C228(aRptPartDsc; $2; $3)
		DELETE FROM ARRAY:C228(aBOMLevel; $2; $3)  //Depth in BOM
		DELETE FROM ARRAY:C228(aQtyPlan; $2; $3)  //Needed at this BOM Point        aQtyPlan
		DELETE FROM ARRAY:C228(aQtyAct; $2; $3)  //Multiple at this BOM Point  aQtyAct
		DELETE FROM ARRAY:C228(aQtyReducedByOnHand; $2; $3)  //DAN
		DELETE FROM ARRAY:C228(aQtyAdjOnHand; $2; $3)  //DAN
		DELETE FROM ARRAY:C228(aBOMPlace; $2; $3)  //keeps the place in line        aOpenOrders
		DELETE FROM ARRAY:C228(aChecks; $2; $3)  //                                    aChecks
		DELETE FROM ARRAY:C228(aCosts; $2; $3)
		DELETE FROM ARRAY:C228(aCostsLast; $2; $3)
		DELETE FROM ARRAY:C228(aBomCmt; $2; $3)
		DELETE FROM ARRAY:C228(aBomRecs; $2; $3)
		
		DELETE FROM ARRAY:C228(aBomBuildNote; $2; $3)
		DELETE FROM ARRAY:C228(aBomDescription; $2; $3)
		DELETE FROM ARRAY:C228(aBOMCostsExpanded; $2; $3)
		DELETE FROM ARRAY:C228(aBomPriceExpanded; $2; $3)
		//
	: ($1=-3)
		$k:=Size of array:C274(aBomRecs)+1
		If (($2=0) | ($2>$k))
			$w:=$k
		Else 
			$w:=$2
		End if 
		INSERT IN ARRAY:C227(aRptPartNum; $w; 1)
		INSERT IN ARRAY:C227(aRptPartDsc; $w; 1)
		INSERT IN ARRAY:C227(aBOMLevel; $w; 1)  //Depth in BOM
		INSERT IN ARRAY:C227(aQtyPlan; $w; 1)  //Needed at this BOM Point        aQtyPlan
		INSERT IN ARRAY:C227(aQtyAct; $w; 1)  //Multiple at this BOM Point  aQtyAct
		INSERT IN ARRAY:C227(aQtyReducedByOnHand; $w; 1)  //DAN
		INSERT IN ARRAY:C227(aQtyAdjOnHand; $w; 1)  //DAN
		INSERT IN ARRAY:C227(aBOMPlace; $w; 1)  //keeps the place in line        aOpenOrders
		INSERT IN ARRAY:C227(aChecks; $w; 1)  //                                    aChecks
		INSERT IN ARRAY:C227(aCosts; $w; 1)
		INSERT IN ARRAY:C227(aCostsLast; 1)
		INSERT IN ARRAY:C227(aBomCmt; $w; 1)
		INSERT IN ARRAY:C227(aBomRecs; $w; 1)
		
		INSERT IN ARRAY:C227(aBomBuildNote; $w; 1)
		INSERT IN ARRAY:C227(aBomDescription; $w; 1)
		INSERT IN ARRAY:C227(aBOMCostsExpanded; $w; 1)
		INSERT IN ARRAY:C227(aBomPriceExpanded; $w; 1)
		//
		ARRAY LONGINT:C221(aBomSelect; 0)
		aRptPartNum{$w}:=[BOM:21]ChildItem:2
		aRptPartDsc{$w}:=[BOM:21]Description:6
		aBOMLevel{$w}:=1
		aQtyPlan{$w}:=[BOM:21]QtyInAssembly:3
		aQtyAct{$w}:=[BOM:21]QtyInAssembly:3*aQtyAct{$w}
		aQtyReducedByOnHand{$w}:=aQtyAct{$w}
		aQtyAdjOnHand{$w}:=aQtyAct{$w}
		aChecks{$w}:=""
		aCosts{$w}:=0
		aCostsLast{$w}:=0
		aBomCmt{$w}:=[BOM:21]Comment:5
		aBomRecs{$w}:=Record number:C243([BOM:21])
		UNLOAD RECORD:C212([BOM:21])
		
		For ($i; 1; $k)
			aBOMPlace{$i}:=$i
		End for 
	: ($1=-7)
		aRptPartNum{$2}:=[BOM:21]ChildItem:2
		aRptPartDsc{$2}:=[BOM:21]Description:6
		aBOMLevel{$2}:=1
		aQtyPlan{$2}:=[BOM:21]QtyInAssembly:3
		aQtyAct{$2}:=[BOM:21]QtyInAssembly:3*aQtyAct{$2}
		aQtyReducedByOnHand{$2}:=0
		aQtyAdjOnHand{$2}:=0
		aChecks{$2}:=""
		aBomCmt{$2}:=[BOM:21]Comment:5
		UNLOAD RECORD:C212([BOM:21])
		
		//INSERT ELEMENT(aBomBuildNote;$2;$3)
		//INSERT ELEMENT(aBomDescription;$2;$3)
		//INSERT ELEMENT(aBOMCostsExpanded;$2;$3)
		//INSERT ELEMENT(aBomPriceExpanded;$2;$3)
		
	: ($1=-9)
		
		INSERT IN ARRAY:C227(aRptPartNum; $2; $3)
		INSERT IN ARRAY:C227(aRptPartDsc; $2; $3)
		INSERT IN ARRAY:C227(aBOMLevel; $2; $3)  //Depth in BOM
		INSERT IN ARRAY:C227(aQtyPlan; $2; $3)  //Needed at this BOM Point        aQtyPlan
		INSERT IN ARRAY:C227(aQtyAct; $2; $3)  //Multiple at this BOM Point  aQtyAct
		INSERT IN ARRAY:C227(aQtyReducedByOnHand; $2; $3)  //DAN
		INSERT IN ARRAY:C227(aQtyAdjOnHand; $2; $3)  //DAN
		INSERT IN ARRAY:C227(aChecks; $2; $3)  //                                    aChecks
		INSERT IN ARRAY:C227(aCosts; $2; $3)
		INSERT IN ARRAY:C227(aCostsLast; 1)
		INSERT IN ARRAY:C227(aBomCmt; $2; $3)
		INSERT IN ARRAY:C227(aBomRecs; $2; $3)
		INSERT IN ARRAY:C227(aBOMPlace; $2; $3)  //keeps the place in line        aOpenOrders
		
		INSERT IN ARRAY:C227(aBomBuildNote; $2; $3)
		INSERT IN ARRAY:C227(aBomDescription; $2; $3)
		INSERT IN ARRAY:C227(aBOMCostsExpanded; $2; $3)
		INSERT IN ARRAY:C227(aBomPriceExpanded; $2; $3)
End case 