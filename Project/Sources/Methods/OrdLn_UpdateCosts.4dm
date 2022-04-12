//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-01-17T00:00:00, 11:37:48
// ----------------------------------------------------
// Method: OrdLn_UpdateCosts
// Description
// Modified: 01/17/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($1; $doThis)
If (Count parameters:C259=0)
	CONFIRM:C162("Update order lines to current costs.")
	$doThis:=OK
Else 
	$doThis:=$1
End if 
If ($doThis=1)
	vi2:=Records in selection:C76([Order:3])
	FIRST RECORD:C50([Order:3])
	READ WRITE:C146([OrderLine:49])
	For (vi1; 1; vi2)
		MESSAGE:C88(String:C10(vi1))
		QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2)
		vi4:=Records in selection:C76([OrderLine:49])
		FIRST RECORD:C50([OrderLine:49])
		For (vi3; 1; vi4)
			QUERY:C277([Item:4]; [Item:4]itemNum:1=[OrderLine:49]itemNum:4)
			QUERY:C277([OrderLine:49]; [OrderLine:49]lineNum:3=[OrderLine:49]lineNum:3; *)
			QUERY:C277([OrderLine:49];  & [OrderLine:49]orderNum:1=[Order:3]orderNum:2)
			// QUERY([POLine];[POLine]RefOrderNum=[Order]OrderNum)
			QUERY:C277([QQQPOLine:40]; [QQQPOLine:40]itemNum:2=[OrderLine:49]itemNum:4; *)
			QUERY:C277([QQQPOLine:40];  & [QQQPOLine:40]qtyBackLogged:5>0)
			vi7:=Records in selection:C76([QQQPOLine:40])
			Case of 
				: (([Item:4]qtyOnHand:14=0) & (vi7>0))
					
					FIRST RECORD:C50([QQQPOLine:40])
					vR1:=Round:C94(DiscountApply([QQQPOLine:40]unitCost:7; [QQQPOLine:40]discount:8; 15); <>tcDecimalUC)
					CONFIRM:C162(String:C10([Order:3]orderNum:2)+": "+[OrderLine:49]itemNum:4+"= "+String:C10(vR1)+": "+String:C10(Round:C94([OrderLine:49]unitPrice:9; 2))+"is "+String:C10(Round:C94([OrderLine:49]unitCost:12; 2)))
					If (OK=1)
						[Item:4]costAverage:13:=vR1
						SAVE RECORD:C53([Item:4])
						[OrderLine:49]unitCost:12:=[Item:4]costAverage:13
						[OrderLine:49]extendedCost:13:=Round:C94([OrderLine:49]unitCost:12*[OrderLine:49]qtyOrdered:6; 2)
						[OrderLine:49]unitCost:12:=[OrderLine:49]unitCost:12
						[OrderLine:49]extendedCost:13:=[OrderLine:49]extendedCost:13
					End if 
				: (vi7>0)
					FIRST RECORD:C50([QQQPOLine:40])
					vR1:=Round:C94(DiscountApply([QQQPOLine:40]unitCost:7; [QQQPOLine:40]discount:8; 15); <>tcDecimalUC)
					CONFIRM:C162(String:C10([Order:3]orderNum:2)+": "+[OrderLine:49]itemNum:4+"= "+String:C10(vR1)+": "+String:C10(Round:C94([OrderLine:49]unitPrice:9; 2))+"is "+String:C10(Round:C94([OrderLine:49]unitCost:12; 2)))
					If (OK=1)
						[OrderLine:49]unitCost:12:=Round:C94(DiscountApply([QQQPOLine:40]unitCost:7; [QQQPOLine:40]discount:8; 15); <>tcDecimalUC)
						[OrderLine:49]extendedCost:13:=Round:C94([OrderLine:49]unitCost:12*[OrderLine:49]qtyOrdered:6; 2)
						[OrderLine:49]unitCost:12:=[OrderLine:49]unitCost:12
						[OrderLine:49]extendedCost:13:=[OrderLine:49]extendedCost:13
					End if 
				: ([Item:4]costAverage:13=0)
					vR1:=0.8*[OrderLine:49]unitPrice:9
					vR1:=Round:C94(vR1; 2)
					CONFIRM:C162(String:C10([Order:3]orderNum:2)+": "+[OrderLine:49]itemNum:4+"= "+String:C10(vR1)+": "+String:C10(Round:C94([OrderLine:49]unitPrice:9; 2))+"is "+String:C10(Round:C94([OrderLine:49]unitCost:12; 2)))
					If (OK=1)
						[OrderLine:49]unitCost:12:=0.8*[OrderLine:49]unitPrice:9
						[OrderLine:49]extendedCost:13:=Round:C94([OrderLine:49]unitCost:12*[OrderLine:49]qtyOrdered:6; 2)
						[OrderLine:49]unitCost:12:=[OrderLine:49]unitCost:12
						[OrderLine:49]extendedCost:13:=[OrderLine:49]extendedCost:13
					End if 
				Else 
					vR1:=Round:C94([Item:4]costAverage:13; 2)
					CONFIRM:C162(String:C10([Order:3]orderNum:2)+": "+[OrderLine:49]itemNum:4+"= "+String:C10(vR1)+": "+String:C10(Round:C94([OrderLine:49]unitPrice:9; 2))+"is "+String:C10(Round:C94([OrderLine:49]unitCost:12; 2)))
					If (OK=1)
						[OrderLine:49]unitCost:12:=[Item:4]costAverage:13
						[OrderLine:49]extendedCost:13:=Round:C94([OrderLine:49]unitCost:12*[OrderLine:49]qtyOrdered:6; 2)
						[OrderLine:49]unitCost:12:=[OrderLine:49]unitCost:12
						[OrderLine:49]extendedCost:13:=[OrderLine:49]extendedCost:13
					End if 
			End case 
			SAVE RECORD:C53([OrderLine:49])
			NEXT RECORD:C51([OrderLine:49])
		End for 
		OrdLnFillRays
		vMod:=calcOrder(vMod)
		SAVE RECORD:C53([Order:3])
		NEXT RECORD:C51([Order:3])
	End for 
End if 

REDRAW WINDOW:C456

