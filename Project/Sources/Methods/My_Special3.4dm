//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-01-17T00:00:00, 09:30:29
// ----------------------------------------------------
// Method: My_Special3
// Description
// Modified: 01/17/14
// Structure: CEv13_131005
//
// Parameters
// ----------------------------------------------------

//  SC_OrderLines

ALL RECORDS:C47([Order:3])
vi2:=Records in selection:C76([Order:3])
For (vi1; 1; vi2)
	QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2)
	[Order:3]lineItems:35:=Records in selection:C76([OrderLine:49])
	SAVE RECORD:C53([Order:3])
	NEXT RECORD:C51([Order:3])
End for 
REDUCE SELECTION:C351([Order:3]; 0)

//  delete selection([Order])

// [index #1123] 

$INDEX_ID:="1123]"  // your index ID as a string
$TABLE_NAME:=""
$COLUMN_NAME:=""
Begin SQL
	SELECT TABLE_NAME, COLUMN_NAME
	FROM _USER_IND_COLUMNS
	WHERE INDEX_ID = :$INDEX_ID
	INTO :$TABLE_NAME, :$COLUMN_NAME;
End SQL


If (False:C215)
	READ WRITE:C146([OrderLine:49])
	vi2:=Records in selection:C76([OrderLine:49])
	FIRST RECORD:C50([OrderLine:49])
	For (vi1; 1; vi2)
		[OrderLine:49]itemNum:4:="OR_"+[OrderLine:49]itemNum:4
		SAVE RECORD:C53([OrderLine:49])
		NEXT RECORD:C51([OrderLine:49])
	End for 
	UNLOAD RECORD:C212([OrderLine:49])
	
	
	QUERY:C277([OrderLine:49]; [OrderLine:49]itemNum:4="OR_Com@")
	SELECTION TO ARRAY:C260([OrderLine:49]orderNum:1; ALONGINT1)
	vi2:=Size of array:C274(aLongint1)
	For (vi1; 1; vi2)
		QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=aLongint1{vi1})
		vi4:=Records in selection:C76([OrderLine:49])
		FIRST RECORD:C50([OrderLine:49])
		For (vi3; 1; vi4)
			If (([OrderLine:49]itemNum:4#"Com@") & ([OrderLine:49]itemNum:4#"OR_Com@"))
				[OrderLine:49]complete:48:=True:C214
				SAVE RECORD:C53([OrderLine:49])
			End if 
			NEXT RECORD:C51([OrderLine:49])
		End for 
	End for 
	
	
	For (vi1; 1; vi2)
		QUERY:C277([Order:3]; [Order:3]orderNum:2=aLongint1{vi1})
		
		vMod:=True:C214
		OrdLnFillRays
		vi4:=Size of array:C274(aoLineAction)
		For (vi3; 1; vi4)
			If (aOQtyBL{vi3}#0)
				aOLnCmplt{vi3}:="x"
				OrdLnExtend(vi3)
			End if 
		End for 
		acceptOrders
		NEXT RECORD:C51([Order:3])
	End for 
	
	
	
	
	
	
	
End if 