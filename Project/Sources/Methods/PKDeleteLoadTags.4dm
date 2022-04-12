//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 04/16/07, 11:19:03
// ----------------------------------------------------
// Method: PKDeleteLoadTags
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)
If (Count parameters:C259=1)
	READ WRITE:C146([LoadItem:87])
	READ WRITE:C146([LoadTag:88])
	Case of 
		: ($1=(->[Invoice:26]))
			QUERY:C277([LoadTag:88]; [LoadTag:88]invoiceNum:19=[Invoice:26]invoiceNum:2)
			C_LONGINT:C283(vi1; vi2)
			vi2:=Records in selection:C76([LoadTag:88])
			FIRST RECORD:C50([LoadTag:88])
			For (vi1; 1; vi2)
				[LoadTag:88]invoiceNum:19:=-212
				[LoadTag:88]Status:6:="Pending"
				QUERY:C277([LoadItem:87]; [LoadItem:87]LoadTagID:8=[LoadTag:88]idUnique:1)
				vi4:=Records in selection:C76([LoadItem:87])
				For (vi3; 1; vi4)
					[LoadItem:87]invoiceNum:14:=-212
					SAVE RECORD:C53([LoadItem:87])
					NEXT RECORD:C51([LoadItem:87])
				End for 
				SAVE RECORD:C53([LoadTag:88])
				NEXT RECORD:C51([LoadTag:88])
			End for 
			QUERY:C277([LoadTag:88]; [LoadTag:88]invoiceNum:19=-212)
			DELETE SELECTION:C66([LoadTag:88])
			QUERY:C277([LoadItem:87]; [LoadItem:87]invoiceNum:14=-212)
			DELETE SELECTION:C66([LoadItem:87])
		: ($1=(->[Order:3]))
			QUERY:C277([LoadTag:88]; [LoadTag:88]orderNum:29=[Order:3]orderNum:2)
			C_LONGINT:C283(vi1; vi2)
			vi2:=Records in selection:C76([LoadTag:88])
			FIRST RECORD:C50([LoadTag:88])
			For (vi1; 1; vi2)
				[LoadTag:88]orderNum:29:=-212
				[LoadTag:88]Status:6:="Pending"
				QUERY:C277([LoadItem:87]; [LoadItem:87]LoadTagID:8=[LoadTag:88]idUnique:1)
				vi4:=Records in selection:C76([LoadItem:87])
				For (vi3; 1; vi4)
					[LoadItem:87]orderNum:2:=-212
					SAVE RECORD:C53([LoadItem:87])
					NEXT RECORD:C51([LoadItem:87])
				End for 
				SAVE RECORD:C53([LoadTag:88])
				NEXT RECORD:C51([LoadTag:88])
			End for 
			QUERY:C277([LoadTag:88]; [LoadTag:88]orderNum:29=-212)
			DELETE SELECTION:C66([LoadTag:88])
			QUERY:C277([LoadItem:87]; [LoadItem:87]orderNum:2=-212)
			DELETE SELECTION:C66([LoadItem:87])
	End case 
End if 