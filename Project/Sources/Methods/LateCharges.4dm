//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/28/12, 09:12:17
// ----------------------------------------------------
// Method: LateCharges
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (UserInPassWordGroup("Archive"))
	If (False:C215)
		//07/30/02:janani
		// added "Late Charges: " to [Payment]Comment
	End if 
	C_LONGINT:C283($i; $k)
	C_REAL:C285($finCharge)
	C_TEXT:C284($strDate)
	C_TEXT:C284($curCustID)
	C_REAL:C285($invTotal)
	C_TEXT:C284($invForPay)
	C_DATE:C307($theDate)
	$theDate:=Current date:C33-30
	CONFIRM:C162("Are you sure you want to add Finance Charges for these "+String:C10(Records in selection:C76([Invoice:26]))+" Invoices?")
	If (OK=1)
		$finCharge:=Num:C11(Request:C163("Enter finance charge."; "1.5%"))
		If (OK=1)
			$finCharge:=$finCharge*0.01
			$strDate:=String:C10(Current date:C33)
			$k:=Records in selection:C76([Invoice:26])
			If (($finCharge#0) & ($k#0))
				//ThermoInitExit ("Finance charges";$k;True)
				$viProgressID:=Progress New
				
				ORDER BY:C49([Invoice:26]; [Invoice:26]customerID:3)
				FIRST RECORD:C50([Invoice:26])
				$i:=0
				Repeat 
					//Thermo_Update ($i)
					ProgressUpdate($viProgressID; $i; $k; "Finance charges")
					If (<>ThermoAbort)
						$i:=$k
					End if 
					$curCustID:=[Invoice:26]customerID:3
					$invTotal:=0
					$invForPay:=""
					Repeat 
						$i:=$i+1
						If (([Invoice:26]balanceDue:44>0) & ([Invoice:26]dateShipped:4<$theDate))
							$invForPay:=$invForPay+String:C10([Invoice:26]invoiceNum:2; "0000-0000")+"   "+String:C10([Invoice:26]balanceDue:44; "000,000,000.00")+"\r"
							$invTotal:=$invTotal+[Invoice:26]balanceDue:44
						End if 
						NEXT RECORD:C51([Invoice:26])
					Until (($curCustID#[Invoice:26]customerID:3) | ($i=$k))
					If ($invTotal>0)
						CREATE RECORD:C68([Payment:28])
						
						[Payment:28]amount:1:=Round:C94(-$invTotal*$finCharge; <>tcDecimalTt)
						[Payment:28]orderNum:2:=-1
						[Payment:28]invoiceNum:3:=-1
						[Payment:28]customerID:4:=$curCustID
						[Payment:28]typePayment:6:="Late"
						[Payment:28]dateReceived:10:=Current date:C33
						[Payment:28]timeReceived:52:=Current time:C178
						[Payment:28]checkNum:12:=""
						[Payment:28]comment:5:="Late Charges: "+$invForPay
						[Payment:28]nameOnAcct:11:=""
						[Payment:28]amountAvailable:19:=[Payment:28]amount:1
						SAVE RECORD:C53([Payment:28])
						Ledger_PaySave
					End if 
				Until ($i=$k)
				//Thermo_Close 
				Progress QUIT($viProgressID)
			End if 
		End if 
	End if 
	
	
	If (False:C215)
		CREATE RECORD:C68([Order:3])
		[Order:3]orderNum:2:=328795  //put in the number
		SAVE RECORD:C53([Order:3])
		
	End if 
	
	If (False:C215)
		vi2:=Records in selection:C76([Payment:28])
		ORDER BY:C49([Payment:28]; [Payment:28]customerID:4; [Payment:28]dateReceived:10)
		CREATE EMPTY SET:C140([Payment:28]; "Current")
		CREATE EMPTY SET:C140([Payment:28]; "Duplicate")
		FIRST RECORD:C50([Payment:28])
		vi8:=0
		vi9:=0
		vText1:=""
		For (vi1; 1; vi2)
			If (vText1#[Payment:28]customerID:4)
				vi8:=0
				vi9:=0
				vText1:=[Payment:28]customerID:4
				If ((vi8=Month of:C24([Payment:28]dateReceived:10)) & (vi9=Year of:C25([Payment:28]dateReceived:10)))
					ADD TO SET:C119([Payment:28]; "Duplicate")
				Else 
					ADD TO SET:C119([Payment:28]; "Current")
					vi8:=Month of:C24([Payment:28]dateReceived:10)
					vi9:=Year of:C25([Payment:28]dateReceived:10)
				End if 
			End if 
			NEXT RECORD:C51([Payment:28])
		End for 
		USE SET:C118("Current")
		CLEAR SET:C117("Current")
		DB_ShowCurrentSelection(->[Payment:28]; ""; 1; "Current"; 1)
		
		
		USE SET:C118("Duplicate")
		CLEAR SET:C117("Duplicate")
		DB_ShowCurrentSelection(->[Payment:28]; ""; 1; "Duplicate"; 1)
	End if 
	
End if 
