//%attributes = {"publishedWeb":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): williamjames
	// Date and time: 06/27/07, 14:07:05
	// ----------------------------------------------------
	// Method: Http_OrdStatus
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
	//Date: 02/27/02
	//Who: Bill James, JIT
	//Description:
	VERSION_960
End if 
//TRACE
C_LONGINT:C283($1; $err; $orderNum; $trackNum; $ppNum; $k)
C_POINTER:C301($2)
C_BOOLEAN:C305($doError)
//February 11, 2002, Added publish level to service records

If (<>viOrdStatus=0)
	vResponse:=vResponse+"Order status not allowed"+"\r"
Else 
	vResponse:=vResponse+"You must be signed in to view open orders"+"\r"
	vResponse:=vResponse+"Must be a customer to check order status.  You are not currently signed in."+"\r"
End if 
$pageDo:=WC_DoPage("Error.html"; "")
//TRACE
If (<>viOrdStatus>0)
	//$userName:=WCapi_GetParameter("userName";"")
	//$password:=WCapi_GetParameter("password";"")
	//If (($userName#"")&($password#""))   
	If (Record number:C243([Customer:2])>-1)
		READ ONLY:C145([RemoteUser:57])
		READ ONLY:C145([Customer:2])
		$orderNum:=Num:C11(WCapi_GetParameter("orderNum"; ""))
		$ppNum:=Num:C11(WCapi_GetParameter("proposalNum"; ""))
		$woNum:=Num:C11(WCapi_GetParameter("WoNum"; ""))
		$trackNum:=Num:C11(WCapi_GetParameter("TrackNum"; ""))
		$CustomerPO:=WCapi_GetParameter("CustomerPO"; "")
		//
		$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
		$jitPageList:=WCapi_GetParameter("jitPageList"; "")
		$doError:=False:C215
		READ ONLY:C145([OrderLine:49])
		READ ONLY:C145([Order:3])
		READ ONLY:C145([Proposal:42])
		READ ONLY:C145([ProposalLine:43])
		READ ONLY:C145([TallySummary:77])
		Case of 
			: (($orderNum>0) | ($CustomerPO#""))
				If ($CustomerPO#"")
					QUERY:C277([Order:3]; [Order:3]customerPO:3=$CustomerPO; *)
					QUERY:C277([Order:3];  & [Order:3]customerID:1=[Customer:2]customerID:1)
					$orderNum:=[Order:3]idNum:2  //###jwm###20070627
				Else 
					QUERY:C277([Order:3]; [Order:3]idNum:2=$orderNum; *)
					QUERY:C277([Order:3];  & [Order:3]customerID:1=[Customer:2]customerID:1)
				End if 
				Case of 
					: (Records in selection:C76([Order:3])=1)
						//  CHOPPED QA_LoOnEntry(-1; Table(->[Order]); [Order]customerID; [Order]idNum; [Order]idNumTask)
						////  CHOPPED QA_LoOnEntry (-1;"";0;->[Order]taskID)
						QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=$orderNum)
						QUERY:C277([WorkOrder:66]; [WorkOrder:66]publish:30>0; *)
						QUERY:C277([WorkOrder:66];  & [WorkOrder:66]idNumTask:22=[Order:3]idNumTask:85; *)
						QUERY:C277([WorkOrder:66];  & [WorkOrder:66]customerID:28=[Customer:2]customerID:1)
						QUERY:C277([Service:6]; [Service:6]idNumOrder:22=$orderNum; *)
						//If (vWccSecurity<1)   // do not show all, signed in as customer with customer
						QUERY:C277([Service:6];  & [Service:6]publish:19>0; *)
						QUERY:C277([Service:6];  & [Service:6]publish:19<=viEndUserSecurityLevel; *)
						// End if 
						QUERY:C277([Service:6];  & [Service:6]idNum:26#0; *)
						QUERY:C277([Service:6];  & [Service:6]customerID:1=[Customer:2]customerID:1)
						//
						//QUERY([LoadTag];[LoadTag]documentID=[Order]OrderNum)
						QUERY:C277([LoadTag:88]; [LoadTag:88]idNumOrder:29=[Order:3]idNum:2)
						//
						QUERY:C277([Invoice:26]; [Invoice:26]idNumOrder:1=[Order:3]idNum:2)
						QUERY:C277([Payment:28]; [Payment:28]idNumOrder:2=[Order:3]idNum:2)
						//
						If (vWccSecurity>0)
							QUERY:C277([PO:39]; [PO:39]idNumOrder:18=[Order:3]idNum:2)
							QUERY:C277([POLine:40]; [POLine:40]idNumOrder:16=[Order:3]idNum:2)
						End if 
						pPayAmount:=Sum:C1([Payment:28]amount:1)
						pBalance:=[Order:3]total:27-pPayAmount
						//
						P_OrdHeadVars
						$pageDo:=WC_DoPage("OrdersOne.html"; $jitPageOne)
					: (Records in selection:C76([Order:3])>1)
						$pageDo:=WC_DoPage("OrdersList.html"; $jitPageList)
					Else 
						vResponse:="There is no unique matching Order record."
				End case 
			: ($ppNum>0)
				QUERY:C277([Proposal:42]; [Proposal:42]idNum:5=$ppNum; *)
				QUERY:C277([Proposal:42];  & [Proposal:42]customerID:1=[Customer:2]customerID:1)
				
				If (Records in selection:C76([Proposal:42])=1)
					////  CHOPPED QA_LoOnEntry (-1;"";0;->[Proposal]taskID)
					//  CHOPPED QA_LoOnEntry(-1; Table(->[Proposal]); [Proposal]customerID; [Proposal]idNum; [Proposal]idNumTask)
					QUERY:C277([ProposalLine:43]; [ProposalLine:43]idNumProposal:1=$ppNum)
					QUERY:C277([Service:6]; [Service:6]idNumProposal:27=$ppNum; *)
					//If (vWccSecurity<1)
					QUERY:C277([Service:6];  & [Service:6]publish:19>0; *)
					QUERY:C277([Service:6];  & [Service:6]publish:19<=viEndUserSecurityLevel; *)
					// End if 
					QUERY:C277([Service:6];  & [Service:6]idNum:26#0; *)
					QUERY:C277([Service:6];  & [Service:6]customerID:1=[Proposal:42]customerID:1)
					P_PpHeadVars
					$pageDo:=WC_DoPage("ProposalsOne.html"; $jitPageOne)
				Else 
					vResponse:="There is no unique matching Proposal record."
				End if 
			: ($woNum>0)
				QUERY:C277([WorkOrder:66]; [WorkOrder:66]publish:30>0; *)
				QUERY:C277([WorkOrder:66]; [WorkOrder:66]publish:30>0; *)
				QUERY:C277([WorkOrder:66];  & [WorkOrder:66]idNum:29=$woNum; *)
				QUERY:C277([WorkOrder:66];  & [WorkOrder:66]customerID:28=[Customer:2]customerID:1)
				If (Records in selection:C76([WorkOrder:66])=1)
					If ([WorkOrder:66]idNumTask:22>0)
						QUERY:C277([Order:3]; [Order:3]idNumTask:85=[WorkOrder:66]idNumTask:22)  //zzzTestThis
						P_OrdHeadVars
						$pageDo:=WC_DoPage("WorkOrdersOne.html"; $jitPageOne)
					End if 
				Else 
					vResponse:="There is no unique matching WorkOrders record."
				End if 
			: ($trackNum>0)
				TRACE:C157
				QUERY:C277([LoadTag:88]; [LoadTag:88]idNum:1=$trackNum; *)
				QUERY:C277([LoadTag:88];  & [LoadTag:88]customerID:23=[Customer:2]customerID:1)
				//
				If (Records in selection:C76([LoadTag:88])=1)
					vText1:=[LoadTag:88]trackingid:7
					$pageDo:=WC_DoPage("Track"+Substring:C12([LoadTag:88]carrierid:8; 1; 3)+".html"; $jitPageOne)
				Else 
					vResponse:="There is no unique matching LoadTags tracking record."
				End if 
			: (<>viOrdStatus=2)
				QUERY:C277([OrderLine:49]; [OrderLine:49]customerID:2=[Customer:2]customerID:1; *)
				QUERY:C277([OrderLine:49];  & [OrderLine:49]qtyBackLogged:8#0)
				ORDER BY:C49([OrderLine:49]; [OrderLine:49]idNumOrder:1)
				$pageDo:="OrderLinesList.html"
				REDUCE SELECTION:C351([OrderLine:49]; 0)
			Else 
				// TRACE
				QUERY:C277([Order:3]; [Order:3]dateInvoiceComp:6>=(Current date:C33-14); *)
				QUERY:C277([Order:3];  | [Order:3]complete:83<2; *)
				QUERY:C277([Order:3];  & [Order:3]customerID:1=[Customer:2]customerID:1)
				If (Records in selection:C76([Order:3])=0)
					QUERY:C277([Order:3]; [Order:3]customerID:1=[Customer:2]customerID:1)
					If (Records in selection:C76([Order:3])>0)
						ORDER BY:C49([Order:3]dateDocument:4; <)
						If (Records in selection:C76([Order:3])><>viMaxShow)
							REDUCE SELECTION:C351([OrderLine:49]; <>viMaxShow)
						End if 
					End if 
				End if 
				//
				// TRACE
				QUERY:C277([LoadTag:88]; [LoadTag:88]customerID:23=[Customer:2]customerID:1; *)
				QUERY:C277([LoadTag:88];  & [LoadTag:88]dtShipOn:10>DateTime_DTTo(Current date:C33-30))
				//
				QUERY:C277([Proposal:42]; [Proposal:42]complete:56=False:C215; *)
				QUERY:C277([Proposal:42];  & [Proposal:42]customerID:1=[Customer:2]customerID:1)
				//
				//Service is accessible only from within a record or via Service Server
				//QUERY([Service];[Service]Completed=False;*)
				//If (vWccSecurity<1)
				//QUERY([Service];&[Service]Publish>0;*)
				//QUERY([Service];&[Service]Publish<=vWccSecurity;*)
				//Else 
				//QUERY([Service];&[Service]Publish>0;*)
				//QUERY([Service];&[Service]Publish<=viEndUserSecurityLevel;*)
				//End if 
				//QUERY([Service];&[Service]customerID=[Customer]customerID)
				//
				
				$k:=Records in selection:C76([Order:3])+Records in selection:C76([Proposal:42])+Records in selection:C76([LoadTag:88])
				//            
				Case of 
					: ($k=0)
						vResponse:="No record matching search criteria"
					: ((Records in selection:C76([Order:3])=1) & ($k=1))
						////  CHOPPED QA_LoOnEntry (-1;"";0;->[Order]taskID)
						//  CHOPPED QA_LoOnEntry(-1; Table(->[Order]); [Order]customerID; [Order]idNum; [Order]idNumTask)
						QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=[Order:3]idNum:2)
						QUERY:C277([LoadTag:88]; [LoadTag:88]documentID:17=[Order:3]idNum:2)
						QUERY:C277([Service:6]; [Service:6]idNumOrder:22=[Order:3]idNum:2; *)
						// If (vWccSecurity<1)
						QUERY:C277([Service:6];  & [Service:6]publish:19>0; *)
						QUERY:C277([Service:6];  & [Service:6]publish:19<=viEndUserSecurityLevel)
						//End if 
						P_OrdHeadVars
						$pageDo:=WC_DoPage("OrdersOne.html"; $jitPageOne)
						// $pageDo:="OrderOne.html"
					: ((Records in selection:C76([Proposal:42])=1) & ($k=1))
						////  CHOPPED QA_LoOnEntry (-1;"";0;->[Proposal]taskID)
						//  CHOPPED QA_LoOnEntry(-1; Table(->[Proposal]); [Proposal]customerID; [Proposal]idNum; [Proposal]idNumTask)
						QUERY:C277([ProposalLine:43]; [ProposalLine:43]idNumProposal:1=[Proposal:42]idNum:5)
						P_PpHeadVars
						$pageDo:=WC_DoPage("ProposalsOne.html"; $jitPageOne)
						//$pageDo:="ProposalOne.html"
					: ((Records in selection:C76([TallySummary:77])=1) & ($k=1))
						vText1:=[TallySummary:77]trackID:13
						$pageDo:=Substring:C12([TallySummary:77]profile2:2; 1; 9)+".html"
					Else 
						If (Records in selection:C76([Order:3])>1)
							If (Records in selection:C76([Order:3])><>viMaxShow)
								REDUCE SELECTION:C351([Order:3]; <>viMaxShow)
								$num:=Records in selection:C76([Order:3])
							End if 
							ORDER BY:C49([Order:3]; [Order:3]idNum:2)
						End if 
						If (Records in selection:C76([Proposal:42])>1)
							If (Records in selection:C76([Proposal:42])><>viMaxShow)
								REDUCE SELECTION:C351([Proposal:42]; <>viMaxShow)
								$num:=Records in selection:C76([Proposal:42])
							End if 
							ORDER BY:C49([Proposal:42]; [Proposal:42]idNum:5)
						End if 
						If (Records in selection:C76([TallySummary:77])>1)
							If (Records in selection:C76([TallySummary:77])><>viMaxShow)
								REDUCE SELECTION:C351([TallySummary:77]; <>viMaxShow)
								$num:=Records in selection:C76([TallySummary:77])
							End if 
							ORDER BY:C49([TallySummary:77]; [TallySummary:77]longInt2:4)
						End if 
						$jitPageList:=WCapi_GetParameter("jitPageList"; "")
						$pageDo:=WC_DoPage("CustomersStatus.html"; $jitPageList)
				End case 
		End case 
		
		//        READ ONLY([OrdLine])
		READ WRITE:C146([Order:3])
		$doError:=False:C215
	End if 
End if 
$err:=WC_PageSendWithTags($1; $pageDo; 0)