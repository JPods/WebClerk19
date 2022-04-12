//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1)
C_POINTER:C301($2)
//
vResponse:="No records available."
$doPage:=WC_DoPage("Error.html"; "")
$tableName:="WorkOrder"
$allRecords:=WCapi_GetParameter("AllRecords"; "")
C_LONGINT:C283($pageControl)
Case of 
	: (voState.url="/WCC_WorkOrderMyLoad@")  //Complex Transactions        
		QUERY:C277([WorkOrder:66]; [WorkOrder:66]dtComplete:6=0; *)
		If ((vWccSecurity>4999) & (($allRecords="T@") | (($allRecords="y@"))))
			QUERY:C277([WorkOrder:66])
		Else 
			QUERY:C277([WorkOrder:66];  & [WorkOrder:66]actionBy:8=[Employee:19]nameID:1)
		End if 
		//$pageControl:=1
		//: (voState.url="/WCC_OrderPeriod@")//Complex Transactions   
		//$dateBegin:=Date(WCapi_GetParameter("dateBegin";""))
		//$dateEnd:=Date(WCapi_GetParameter("dateEnd";""))
		//QUERY([Order];[Order]DateOrdered>=$dateBegin;*)
		//QUERY([Order];&[Order]DateOrdered<=$dateEnd)
		//$pageControl:=1
		//: (voState.url="/WCC_OrderPeriod@")//Complex Transactions   
		//$orderNum:=Num(WCapi_GetParameter("orderNum";""))
		//QUERY([Order];[Order]OrderNum=$orderNum)
		//$pageControl:=2
		//: (voState.url="/WCC_OrderNum@")
		////Complex Transactions   
		//$orderNum:=Num(WCapi_GetParameter("orderNum";""))
		//QUERY([Order];[Order]OrderNum=$orderNum)
		//If (Records in selection([Order])=1)
		////QUERY([Customer];[Customer]customerID=[Order]customerID)
		//QUERY([OrdLine];[OrdLine]OrderNum=[Order]OrderNum)
		//ptCurTable:=(->[Order])
		//RelatedRelease 
		//$pageControl:=2
		//End if 
		//: (voState.url="/Wcc_OrderZipRange@")//Complex Transactions       
		//$zipBegin:=WCapi_GetParameter("zipBegin";"")
		//$zipEnd:=WCapi_GetParameter("zipEnd";"")
		//QUERY([Order];[Order]Zip>=$zipBegin;*)
		//QUERY([Order];&[Order]Zip<=$zipEnd)
		//$pageControl:=1
End case 
C_LONGINT:C283($k)
$k:=Records in selection:C76([WorkOrder:66])
Case of 
	: ($k>1)
		$jitPageList:=WCapi_GetParameter("jitPageList"; "")
		$doPage:=WC_DoPage("Wcc"+$tableName+"List.html"; $jitPageList)
	: ($k=1)
		$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
		$doPage:=WC_DoPage("Wcc"+$tableName+"One.html"; $jitPageOne)
End case 
$err:=WC_PageSendWithTags($1; $doPage; 0)
//