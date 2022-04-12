//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: PoReceiptFillRay
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//


C_LONGINT:C283($1; $2; $3)
Case of 
	: ($1=0)
		ARRAY LONGINT:C221(aPoRcptJrnlID; $1)
		ARRAY DATE:C224(aPoRcptPackDate; $1)
		ARRAY TEXT:C222(aPoRcptPackID; $1)
		ARRAY LONGINT:C221(aPoRcptPONum; $1)
		ARRAY LONGINT:C221(aPoRcptID; $1)
		ARRAY REAL:C219(aPoRcptValue; $1)
		ARRAY TEXT:C222(aPoRcptVendorID; $1)
		ARRAY REAL:C219(aPoRcptInvAmount; $1)
		ARRAY DATE:C224(aPoRcptInvDate; $1)
		ARRAY REAL:C219(aPoRcptInvFrght; $1)
		ARRAY TEXT:C222(aPoRcptInvNum; $1)
		ARRAY REAL:C219(aPoRcptDuty; $1)
		ARRAY REAL:C219(aPoRcptNonProduct; $1)
		ARRAY REAL:C219(aPoRcptVAT; $1)
		//
		ARRAY LONGINT:C221(aPoRcptSelect; 0)
	: ($1>0)
		SELECTION TO ARRAY:C260([POReceipt:95]jrnlid:11; aPoRcptJrnlID; [POReceipt:95]packingListDate:13; aPoRcptPackDate; [POReceipt:95]packingListid:12; aPoRcptPackID; [POReceipt:95]idNumPO:2; aPoRcptPONum; [POReceipt:95]idNum:1; aPoRcptID; [POReceipt:95]stackValues:10; aPoRcptValue; [POReceipt:95]vendorID:3; aPoRcptVendorID; [POReceipt:95]vendorInvoiceAmount:7; aPoRcptInvAmount; [POReceipt:95]vendorInvoiceDate:5; aPoRcptInvDate; [POReceipt:95]vendorInvoiceFreight:6; aPoRcptInvFrght; [POReceipt:95]vendorInvoiceNum:4; aPoRcptInvNum; [POReceipt:95]duty:16; aPoRcptDuty; [POReceipt:95]nonProduct:15; aPoRcptNonProduct; [POReceipt:95]vAT:14; aPoRcptVAT)
		
	: ($1=-1)
		DELETE FROM ARRAY:C228(aPoRcptJrnlID; $2; $3)
		DELETE FROM ARRAY:C228(aPoRcptPackDate; $2; $3)
		DELETE FROM ARRAY:C228(aPoRcptPackID; $2; $3)
		DELETE FROM ARRAY:C228(aPoRcptPONum; $2; $3)
		DELETE FROM ARRAY:C228(aPoRcptID; $2; $3)
		DELETE FROM ARRAY:C228(aPoRcptValue; $2; $3)
		DELETE FROM ARRAY:C228(aPoRcptVendorID; $2; $3)
		DELETE FROM ARRAY:C228(aPoRcptInvAmount; $2; $3)
		DELETE FROM ARRAY:C228(aPoRcptInvDate; $2; $3)
		DELETE FROM ARRAY:C228(aPoRcptInvFrght; $2; $3)
		DELETE FROM ARRAY:C228(aPoRcptInvNum; $2; $3)
		DELETE FROM ARRAY:C228(aPoRcptDuty; $2; $3)
		DELETE FROM ARRAY:C228(aPoRcptNonProduct; $2; $3)
		DELETE FROM ARRAY:C228(aPoRcptVAT; $2; $3)
		
		
		ARRAY LONGINT:C221(aPoRcptSelect; 0)
	: ($1=-3)
		TRACE:C157
		INSERT IN ARRAY:C227(aPoRcptJrnlID; $2; $3)
		INSERT IN ARRAY:C227(aPoRcptPackDate; $2; $3)
		INSERT IN ARRAY:C227(aPoRcptPackID; $2; $3)
		INSERT IN ARRAY:C227(aPoRcptPONum; $2; $3)
		INSERT IN ARRAY:C227(aPoRcptID; $2; $3)
		INSERT IN ARRAY:C227(aPoRcptValue; $2; $3)
		INSERT IN ARRAY:C227(aPoRcptVendorID; $2; $3)
		INSERT IN ARRAY:C227(aPoRcptInvAmount; $2; $3)
		INSERT IN ARRAY:C227(aPoRcptInvDate; $2; $3)
		INSERT IN ARRAY:C227(aPoRcptInvFrght; $2; $3)
		INSERT IN ARRAY:C227(aPoRcptInvNum; $2; $3)
		INSERT IN ARRAY:C227(aPoRcptDuty; $2; $3)
		INSERT IN ARRAY:C227(aPoRcptNonProduct; $2; $3)
		INSERT IN ARRAY:C227(aPoRcptVAT; $2; $3)
		//
		ARRAY LONGINT:C221(aPoRcptSelect; 0)
		
	: ($1=-5)
		[POReceipt:95]jrnlid:11:=aPoRcptJrnlID{$2}
		[POReceipt:95]packingListDate:13:=aPoRcptPackDate{$2}
		[POReceipt:95]packingListid:12:=aPoRcptPackID{$2}
		[POReceipt:95]idNumPO:2:=aPoRcptPONum{$2}
		[POReceipt:95]idNum:1:=aPoRcptID{$2}
		[POReceipt:95]stackValues:10:=aPoRcptValue{$2}
		[POReceipt:95]vendorID:3:=aPoRcptVendorID{$2}
		[POReceipt:95]vendorInvoiceAmount:7:=aPoRcptInvAmount{$2}
		[POReceipt:95]vendorInvoiceDate:5:=aPoRcptInvDate{$2}
		[POReceipt:95]vendorInvoiceFreight:6:=aPoRcptInvFrght{$2}
		[POReceipt:95]vendorInvoiceNum:4:=aPoRcptInvNum{$2}
		[POReceipt:95]duty:16:=aPoRcptDuty{$2}
		[POReceipt:95]nonProduct:15:=aPoRcptNonProduct{$2}
		[POReceipt:95]vAT:14:=aPoRcptVAT{$2}
		
	: ($1=-7)
		aPoRcptJrnlID{$2}:=[POReceipt:95]jrnlid:11
		aPoRcptPackDate{$2}:=[POReceipt:95]packingListDate:13
		aPoRcptPackID{$2}:=[POReceipt:95]packingListid:12
		aPoRcptPONum{$2}:=[POReceipt:95]idNumPO:2
		aPoRcptID{$2}:=[POReceipt:95]idNum:1
		aPoRcptValue{$2}:=[POReceipt:95]stackValues:10
		aPoRcptVendorID{$2}:=[POReceipt:95]vendorID:3
		aPoRcptInvAmount{$2}:=[POReceipt:95]vendorInvoiceAmount:7
		aPoRcptInvDate{$2}:=[POReceipt:95]vendorInvoiceDate:5
		aPoRcptInvFrght{$2}:=[POReceipt:95]vendorInvoiceFreight:6
		aPoRcptInvNum{$2}:=[POReceipt:95]vendorInvoiceNum:4
		aPoRcptDuty{$2}:=[POReceipt:95]duty:16
		aPoRcptNonProduct{$2}:=[POReceipt:95]nonProduct:15
		aPoRcptVAT{$2}:=[POReceipt:95]vAT:14
		//
		ARRAY LONGINT:C221(aPoRcptSelect; 1)
		If (eReceipts>0)
			//  --  CHOPPED  AL_UpdateArrays(eReceipts; -2)
		End if 
End case 