// ----------------------------------------------------
// User name (OS): jimmedlen
// Date and time: 01/28/13, 15:42:16
// ----------------------------------------------------
// Method: [Control].WorkOrdersTransfer.Variable11
// Method: Object Method: bQQPull
// Description: QQPull Button
// File: Object Method: bQQPull.txt
// Parameters
// ----------------------------------------------------
// ### jwm ### 20141202_1313 added WOTransfers_Query

C_LONGINT:C283(bQQPull; $inc; $cnt)

//QQItemAdd (<>aPrsNum{Current process})

KeyModifierCurrent
If (OptKey=0)
	
	If (iLoDate1=!00-00-00!)
		ALERT:C41("Set Date")
		GOTO OBJECT:C206(iLoDate1)  //### jwm ### 20130128_1549
	Else 
		If (pQtyOrd<=0)
			ALERT:C41("Set Quantity")
			GOTO OBJECT:C206(pQtyOrd)  //### jwm ### 20130128_1549
		Else 
			If (vltaskID=0)
				vltaskID:=CounterNew(->[DialingInfo:81])
			End if 
			If (Size of array:C274(<>aItemLines)<1)
				ALERT:C41("No records selected")
			Else 
				<>bQQAddItems:=True:C214
				//[WorkOrder]WOType:="Transfer"
				Case of 
					: (iLoText2="View")
						ALERT:C41("Set to request or ship")
						
					: (iLoText2="Request")  //"RequestedTransfer"
						//### jwm ### 20130128_1622
						//CREATE EMPTY SET([WorkOrder];"current")
						//CREATE SET([WorkOrder];"current")  //create set with current selection
						$cnt:=Size of array:C274(<>aItemLines)
						READ ONLY:C145([Item:4])
						If (($cnt>0) & ($cnt<=Size of array:C274(<>aLsSrRec)))
							For ($inc; 1; $cnt)
								GOTO RECORD:C242([Item:4]; <>aLsSrRec{<>aItemLines{$inc}})
								// ### jwm ### 20140929_1512 added parameters 10 and 11
								WO_TransferCreate([Item:4]itemNum:1; pQtyOrd; vltaskID; iLoDate1; iLo80String1; iLo80String2; iLo80String3; "RequestedTransfer"; iLo80String4; iLo80String5; vlGroupID)
								//ADD TO SET([WorkOrder];"current")
							End for 
							//USE SET("current")
							//CLEAR SET("current")
							ORDER BY:C49([WorkOrder:66]dtCreated:44; <)  //### jwm ### 20130128_1625 sort most recent at top
						End if 
						
					: (iLoText2="Ship")  //"PendingTransfer"
						//### jwm ### 20130128_1622
						//CREATE EMPTY SET([WorkOrder];"current")
						//CREATE SET([WorkOrder];"current")  //create set with current selection
						$cnt:=Size of array:C274(<>aItemLines)
						READ ONLY:C145([Item:4])
						If (($cnt>0) & ($cnt<=Size of array:C274(<>aLsSrRec)))
							For ($inc; 1; $cnt)
								GOTO RECORD:C242([Item:4]; <>aLsSrRec{<>aItemLines{$inc}})
								// ### jwm ### 20140929_1512 added parameters 10 and 11
								WO_TransferCreate([Item:4]itemNum:1; pQtyOrd; vltaskID; iLoDate1; iLo80String1; iLo80String2; iLo80String3; "PendingTransfer"; iLo80String4; iLo80String5; vlGroupID)
								//ADD TO SET([WorkOrder];"current")
							End for 
							//USE SET("current")
							//CLEAR SET("current")
							//ORDER BY([WorkOrder]DTCreated;<)  //### jwm ### 20130128_1625 sort most recent at top (see WOTransfers_Sort)
						End if 
						
					: (iLoText2="Receive")  //"CompletedTransfer"
						ALERT:C41("Set to request or ship")
						
				End case 
				//<>vControlProcess:="WorkOrder Transfers"
				//OutSide_Do ("WorkOrder Transfers")
				// ### jwm ### 20141202_1313
				WOTransfers_Query
				WOTransfers_Sort(iLoText2)
				//  CHOPPED  AL_UpdateFields(eWorkOrders; 2)
			End if 
			TallyInventory
		End if 
	End if 
	
Else 
	QQ_Push(->aoItemNum; ->aRayLines)
End if 

