//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $i; $k; $w)
Case of 
	: ($1=0)
		ARRAY TEXT:C222(aSrAvail; 0)
		ARRAY BOOLEAN:C223(aSrOnFP; 0)
		ARRAY TEXT:C222(aSrNum; 0)
		ARRAY DATE:C224(aSrDateIn; 0)
		ARRAY DATE:C224(aSrExpire; 0)
		ARRAY LONGINT:C221(aSrLife; 0)
		ARRAY LONGINT:C221(aSrRecNum; 0)
		ARRAY LONGINT:C221(aSrRecID; 0)
		ARRAY LONGINT:C221(aSrSaleID; 0)
		ARRAY LONGINT:C221(aSrPoID; 0)
		//
		ARRAY LONGINT:C221(aSrRecSel; 0)
	: ($1>0)
		SELECTION TO ARRAY:C260([ItemSerial:47]; aSrRecNum; [ItemSerial:47]idUnique:18; aSrRecID; [ItemSerial:47]SalesLnRefID:11; aSrSaleID; [ItemSerial:47]PoLnRefID:7; aSrPoID; [ItemSerial:47]Status:8; aSrAvail; [ItemSerial:47]OnFloorPlan:16; aSrOnFP; [ItemSerial:47]SerialNum:4; aSrNum; [ItemSerial:47]DateReceived:12; aSrDateIn; [ItemSerial:47]FPExpireDate:15; aSrExpire)
		//
		TRACE:C157
		$k:=Size of array:C274(aSrRecID)
		ARRAY LONGINT:C221(aSrLife; $k)
		For ($i; 1; $k)
			$life:=aSrExpire{$i}-Current date:C33
			If ($life>0)
				aSrLife{$i}:=aSrExpire{$i}-Current date:C33
			Else 
				aSrLife{$i}:=0
			End if 
		End for 
		//
		ARRAY LONGINT:C221(aSrRecSel; 0)
	: ($1=-1)  //delele
		DELETE FROM ARRAY:C228(aSrAvail; $2; $3)
		DELETE FROM ARRAY:C228(aSrOnFP; $2; $3)
		DELETE FROM ARRAY:C228(aSrNum; $2; $3)
		DELETE FROM ARRAY:C228(aSrDateIn; $2; $3)
		DELETE FROM ARRAY:C228(aSrExpire; $2; $3)
		DELETE FROM ARRAY:C228(aSrLife; $2; $3)
		DELETE FROM ARRAY:C228(aSrRecNum; $2; $3)
		DELETE FROM ARRAY:C228(aSrSaleID; $2; $3)
		DELETE FROM ARRAY:C228(aSrPoID; $2; $3)
		DELETE FROM ARRAY:C228(aSrRecID; $2; $3)
		//
		ARRAY LONGINT:C221(aSrRecSel; 0)
	: ($1=-3)  //add new
		INSERT IN ARRAY:C227(aSrAvail; $2; $3)
		INSERT IN ARRAY:C227(aSrOnFP; $2; $3)
		INSERT IN ARRAY:C227(aSrNum; $2; $3)
		INSERT IN ARRAY:C227(aSrDateIn; $2; $3)
		INSERT IN ARRAY:C227(aSrExpire; $2; $3)
		INSERT IN ARRAY:C227(aSrLife; $2; $3)
		INSERT IN ARRAY:C227(aSrRecNum; $2; $3)
		INSERT IN ARRAY:C227(aSrSaleID; $2; $3)
		INSERT IN ARRAY:C227(aSrPoID; $2; $3)
		INSERT IN ARRAY:C227(aSrRecID; $2; $3)
		//
		ARRAY LONGINT:C221(aSrRecSel; 0)
		//$k:=$2+$3
		//$inc:=0
		//For ($i;$2;$k)
		//$inc:=$inc+1
		//aSrRecSel{$inc}:=$i
		//End for 
	: ($1=-5)  //selection to array
		
	: ($1=-7)  //sort    
		
End case 