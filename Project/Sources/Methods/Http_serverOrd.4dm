//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $c; $doThis; <>vbSaleLevel)
C_TEXT:C284(vResponse)
C_POINTER:C301($2)
$c:=$1
$suffix:=""
$doThis:=0
vResponse:=""
//TRACE
Case of 
		// : (Size of array(aParameterName)=0)  
		// the page is sending an echo
	: (voState.url="/order_ajaxone")
		WC_AjaxItemOrder($c; $2)
	: (voState.url="/Order_Clone@")  //clone cross of last three orders
		Http_CloneOrd($c; $2)
		//: (voState.url="/order_items3@")// //add items to order, 
		//Http_PostOrd3 ($c;$2;1;0)
		
	: (voState.url="/Update_items@")  // |($2->="Post /order_items/Update_items@"))
		Http_PostOrd2($c; $2; 1; 0)
		//
	: (voState.url="/order_items@")  // //add items to order, 
		Http_PostOrd2($c; $2; 1; 0)
		
	: (voState.url="/order_shipTo@")  ////add items to order, 
		//order_shipToSet?TableName=Contacts&RecordNum=_jit_13_-2jj&jitPageOne=CustomersConfirm.html
		$tableNameShipTo:=WCapi_GetParameter("TableNameShipTo"; "")
		$tableName:=WCapi_GetParameter("TableName"; "")
		$tableNum:=STR_GetTableNumber($tableNameShipTo)
		$recordStr:=WCapi_GetParameter("RecordNum"; "")
		$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
		Case of 
			: (voState.url="/order_shipToClear@")
				[EventLog:75]shipToRecordid:35:=0
				[EventLog:75]shipToTableNum:34:=0
				If ([EventLog:75]idNum:5#0)
					SAVE RECORD:C53([EventLog:75])
				End if 
				vResponse:="ShipTo Cleared"
			: (voState.url="/order_shipToSet@")
				If (($tableNum>0) & (Num:C11($recordStr)>0))
					vResponse:="ShipTo set as: "+$tableName+", Record Number:  "+$recordStr
					[EventLog:75]shipToRecordid:35:=Num:C11($recordStr)
					[EventLog:75]shipToTableNum:34:=$tableNum
					If ([EventLog:75]idNum:5#0)
						SAVE RECORD:C53([EventLog:75])
					End if 
					vResponse:="ShipTo Set"
				Else 
					vResponse:="Table or Record not defined correctly"
				End if 
		End case 
		If ($jitPageOne#"")
			Http_OrdFill($c; $2; False:C215)  //calculate order but do not save   // ### jwm ### 20150930_1502  
			$err:=WC_PageSendWithTags($c; WC_DoPage("CustomersOne.html"; $jitPageOne); 0)
		Else 
			Http_PostOrd2($c; $2; 1; 0)
		End if 
		If (False:C215)
			Case of 
				: (($tableName="Order") | ($tableName=""))
					//Http_PostOrd2 ($c;$2;1;0)
					http_CheckOut($c; $2)
				: ($tableName="Proposal")
					http_CheckProposal($c; $2)
				Else 
					$err:=WC_PageSendWithTags($c; WC_DoPage("CustomersOne.html"; $jitPageOne); 0)
			End case 
		End if 
	: (voState.url="/order_recalc@")  //add items to 
		Http_PostOrd2($c; $2; 0; 0)
		//
	: (voState.url="/check_Out@")  //  //GoCheck out
		//  http_PostOrd ($c;$2;0)   good idea someday.
		http_CheckOut($c; $2)
		//
	: (voState.url="/check_Proposal@")  //GoCheck out
		//  http_PostOrd ($c;$2;0)   good idea someday.
		http_CheckProposal($c; $2)
		//
	: (voState.url="/Order_Status@")  //pay the order
		Http_OrdStatus($c; $2)
	: (voState.url="/Order_EmailTextData@")  //pay the order
		$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
		$orderNum:=Num:C11(WCapi_GetParameter("OrderNum"))
		If (($orderNum>0) & (vWccPrimeRec>-1))
			EmailTextOrderData($orderNum)
		End if 
		$err:=WC_PageSendWithTags($1; $pageDo; 0)
		//
	: (voState.url="/Order_MultiLine@")  //pay the order
		Http_PostOrd2($c; $2; 0; 0)
		// Http_OrdMultiLine ($c;$2;0)
		//
	: (voState.url="/Order_Proposal@")  //pay the order
		Http_PPSearch($c; $2)
		//
	: (voState.url="/Order_Search@")  // //pay the order
		Http_OrdSearch($c; $2)
		//
	: (voState.url="/Order_ClearCart@")  //empty shopping cart
		http_OrdClearCart($c; $2)
		//
	: (voState.url="/Order_AutoPP@")  //automated orders
		//Http_AutoProposal($c; $2)
	: (voState.url="/Order_Ally@")  //automated orders
		Http_OrderAllyAssign($c; $2)
		
	: (voState.url="/Order_OpenDrawer@")  //automated orders
		CashDrawerOpen
		//
		//:(voState.url="/Order_AutoOrd@")
		////automated orders
		//Http_AutoOrder($c;$2)
		//
	: ((voState.url="/order_custom@") & (<>vbNoCustomWeb=1))  //add items to order, 
		http_Custom($c; $2; 0)
		//    
	: (voState.url="/order_Pp2Order@")  //add items to order, 
		http_Pp2Order($c; $2; 0)
	: (voState.url="/Order_PostCC@")  //clone cross of last three orders
		Http_PostCC($c; $2; 0)
		//
	Else 
		vResponse:="Improper Order request."
		$err:=WC_PageSendWithTags($c; WC_DoPage("Error.html"; ""); 0)
End case 
