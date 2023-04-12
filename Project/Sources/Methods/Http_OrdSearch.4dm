//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $err; $orderNum; $k)
C_POINTER:C301($2)
$suffix:=""
$doThis:=0
vResponse:=""
//zttp_UserGet 
C_TEXT:C284($doPage)
$suffix:=""
vResponse:="No matching record (s)."
$doPage:=WC_DoPage("Error.html"; "")
Case of 
	: (voState.url="/Order_SearchCloneAllowed@")  //clone cross of last three orders
		QUERY:C277([Order:3]; [Order:3]salesNameID:10="CloneAllowed")
		Case of 
			: (Records in selection:C76([Order:3])=1)
				$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
				$doPage:=WC_DoPage("OrdersCloneList.html"; $jitPageOne)
			: (Records in selection:C76([Order:3])>1)
				ORDER BY:C49([Order:3]; [Order:3]status:59; [Order:3]idNum:2)
				$jitPageList:=WCapi_GetParameter("jitPageList"; "")
				$doPage:=WC_DoPage("OrdersCloneList.html"; $jitPageList)
		End case 
	: (Record number:C243([Customer:2])>-1)
		$orderNum:=Num:C11(WCapi_GetParameter("orderNum"; ""))
		$CustPO:=WCapi_GetParameter("CustomerPO"; "")
		$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
		$jitPageList:=WCapi_GetParameter("jitPageList"; "")
		Case of 
			: ($CustPO#"")
				QUERY:C277([Order:3]; [Order:3]idNum:2=$orderNum; *)
				QUERY:C277([Order:3];  & [Order:3]customerID:1=[Customer:2]customerID:1)
			: ($orderNum>0)
				QUERY:C277([Order:3]; [Order:3]customerPO:3=$CustPO; *)
				QUERY:C277([Order:3];  & [Order:3]customerID:1=[Customer:2]customerID:1)
		End case 
		Case of 
			: (Records in selection:C76([Order:3])>1)
				$doPage:=WC_DoPage("OrdersList.html"; $jitPageList)
			: (Records in selection:C76([Order:3])=1)
				$doPage:=WC_DoPage("OrdersOne.html"; $jitPageOne)
				//$doPage:=Storage.wc.webFolder+"Error.html"
				QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=[Order:3]idNum:2)
				QUERY:C277([WorkOrder:66]; [WorkOrder:66]publish:30>0; *)
				QUERY:C277([WorkOrder:66];  & [WorkOrder:66]idNumTask:22=[Order:3]idNumTask:85; *)
				QUERY:C277([WorkOrder:66];  & [WorkOrder:66]customerID:28=[Customer:2]customerID:1)
				QUERY:C277([Service:6]; [Service:6]idNumOrder:22=[Order:3]idNum:2; *)
				QUERY:C277([Service:6];  & [Service:6]publish:19>0)
				QUERY:C277([Service:6];  & [Service:6]publish:19<=viEndUserSecurityLevel)
				QUERY:C277([Service:6];  & [Service:6]idNum:26#0)
				QUERY:C277([Service:6];  & [Service:6]customerID:1=[Customer:2]customerID:1)
			Else 
				vResponse:="No valid Order by you for "+String:C10($orderNum)
				QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=[Order:3]idNum:2)
				$doPage:=WC_DoPage("OrdersOne.html"; $jitPageOne)
		End case 
	Else 
		vResponse:=vResponse+"Must be a customer to check order status, remote user relates to :"+Table name:C256([EventLog:75]tableNum:9)+"\r"
End case 
$err:=WC_PageSendWithTags($1; $doPage; 0)
Http_ReduceSelection
vItemRelated:=""
