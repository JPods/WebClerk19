//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-12-12T00:00:00, 11:23:41
// ----------------------------------------------------
// Method: InvoiceLinesCalc
// Description
// Modified: 12/12/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------



READ WRITE:C146([InvoiceLine:54])
READ WRITE:C146([OrderLine:49])

C_LONGINT:C283($i; $w; $k; $ordLine; vLineSeq)
C_REAL:C285($discntPrice; $dOnHand; $dOnOrd)

If (Size of array:C274(aiLinesDelete)>0)  // manage deleted lines then manage remaining array elements
	$k:=Size of array:C274(aiLinesDelete)
	For ($i; 1; $k)
		QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]idNum:47=aiLinesDelete{$i})
		invoicelinedelete
	End for 
End if 
//TRACE
If ([Invoice:26]orderNum:1>9)  // bad way to affirm by setting to -1
	If ([Order:3]orderNum:2#[Invoice:26]orderNum:1)
		QUERY:C277([Order:3]; [Order:3]orderNum:2=[Invoice:26]orderNum:1)
	End if 
	OrdLnFillRays
	vLineSeq:=MaxValueInArray(->aoSeq)
End if 
$k:=Size of array:C274(aiUniqueID)
If ($k>0)
	For ($i; 1; $k)
		$discntPrice:=DiscountApply([InvoiceLine:54]unitPrice:9; [InvoiceLine:54]discount:10; <>tcDecimalUP)
		
		If (False:C215)  // inside IvcLnLoadRec  ([Invoice]OrderNum>9)  // bad way to affirm by setting to -1
			QUERY:C277([OrderLine:49]; [OrderLine:49]idNum:50=[InvoiceLine:54]orderLineNum:48)
		End if 
		$dOnOrd:=0
		aiSeq{$i}:=$i  // make sure the current sequence is saved in the line record
		Case of 
			: (aiLineAction{$i}=-3)  // create a line  
				CREATE RECORD:C68([InvoiceLine:54])
				IvcLnLoadRec($i; [Invoice:26]orderNum:1; True:C214)
			: (aiLineAction{$i}=-3000)  // changes to a line  
				QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]idNum:47=aiUniqueID{$i})
				IvcLnLoadRec($i; [Invoice:26]orderNum:1; True:C214)
				
			Else 
				// ????? what is this for ?????
				[InvoiceLine:54]printNot:52:=aiPrintThis{$i}
		End case 
	End for 
	
	If ([Order:3]orderNum:2>1)
		OrdLnFillRays
		OrdLn_RaySize(3; 0; 0)
	End if 
End if 

// ### jwm ### 20160318_1822 we need to be consistant with locking and unlocking Line Records
READ ONLY:C145([InvoiceLine:54])
READ ONLY:C145([OrderLine:49])




