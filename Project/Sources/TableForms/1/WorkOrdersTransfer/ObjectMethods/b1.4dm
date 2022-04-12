Case of 
	: (iLoText2="View")
		iLoText2:="Request"
		OBJECT SET RGB COLORS:C628(iLoText2; 0x00FFFF00; 0x00FF)
		If (UserInPassWordGroup("Inventory"))
			READ WRITE:C146([WorkOrder:66])
		End if 
		OBJECT SET ENABLED:C1123(bClone; True:C214)  //clone
		OBJECT SET ENABLED:C1123(b22; True:C214)  //close
		OBJECT SET ENABLED:C1123(b14; False:C215)  //receive
		OBJECT SET ENABLED:C1123(bQQPull; True:C214)  //QQPull
		OBJECT SET ENABLED:C1123(b20; True:C214)  //ship
		OBJECT SET ENABLED:C1123(b24; True:C214)  //bySite
		OBJECT SET ENABLED:C1123(b21; True:C214)  //New taskID
		
		If ((b64=1) & (vltaskID>0))
			QUERY:C277([WorkOrder:66];  & ; [WorkOrder:66]idNumTask:22=vltaskID; *)
		Else 
			QUERY:C277([WorkOrder:66]; [WorkOrder:66]action:33="RequestedTransfer"; *)
		End if 
		
		
	: (iLoText2="Request")
		iLoText2:="Ship"
		OBJECT SET RGB COLORS:C628(iLoText2; 0x0000; 0xFF00)
		
		OBJECT SET ENABLED:C1123(bClone; True:C214)  //clone
		OBJECT SET ENABLED:C1123(b22; False:C215)  //close
		OBJECT SET ENABLED:C1123(b14; False:C215)  //receive
		OBJECT SET ENABLED:C1123(bQQPull; True:C214)  //QQPull
		OBJECT SET ENABLED:C1123(b20; True:C214)  //ship  //### jwm ### 20130128_1631 set to Enable
		OBJECT SET ENABLED:C1123(b24; True:C214)  //bySite
		OBJECT SET ENABLED:C1123(b21; True:C214)  //New taskID
		
		If ((b64=1) & (vltaskID>0))
			QUERY:C277([WorkOrder:66];  & ; [WorkOrder:66]idNumTask:22=vltaskID; *)
		Else 
			QUERY:C277([WorkOrder:66]; [WorkOrder:66]woType:60="Transfer"; *)
			QUERY:C277([WorkOrder:66];  & [WorkOrder:66]action:33="PendingTransfer"; *)
			QUERY:C277([WorkOrder:66];  & ; [WorkOrder:66]dtComplete:6=0; *)
		End if 
		
	: (iLoText2="Ship")
		iLoText2:="Receive"
		OBJECT SET ENABLED:C1123(bClone; False:C215)  //clone
		OBJECT SET ENABLED:C1123(b22; False:C215)  //close
		OBJECT SET ENABLED:C1123(b14; True:C214)  //receive
		OBJECT SET ENABLED:C1123(bQQPull; False:C215)  //QQPull
		OBJECT SET ENABLED:C1123(b20; False:C215)  //ship  
		OBJECT SET ENABLED:C1123(b24; True:C214)  //bySite
		OBJECT SET ENABLED:C1123(b21; False:C215)  //New taskID
		
		If ((b64=1) & (vltaskID>0))
			QUERY:C277([WorkOrder:66];  & ; [WorkOrder:66]idNumTask:22=vltaskID; *)
		Else 
			QUERY:C277([WorkOrder:66]; [WorkOrder:66]action:33="CompletedTransfer"; *)
			QUERY:C277([WorkOrder:66];  | [WorkOrder:66]action:33="PendingTransfer"; *)
			QUERY:C277([WorkOrder:66];  & [WorkOrder:66]woType:60="Transfer"; *)
			
		End if 
		
		
		OBJECT SET RGB COLORS:C628(iLoText2; 0x0000; 0x00FF0000)
		
		
		
	Else   //: (iLoText2="Receive")
		iLoText2:="View"
		OBJECT SET RGB COLORS:C628(iLoText2; 0x0000; 0x00FFFFFF)
		READ ONLY:C145([WorkOrder:66])
		//
		OBJECT SET ENABLED:C1123(bClone; False:C215)  //clone
		OBJECT SET ENABLED:C1123(b22; False:C215)  //close   //### jwm ### 20130128_1635 set to Disable
		OBJECT SET ENABLED:C1123(b14; False:C215)  //receive
		OBJECT SET ENABLED:C1123(bQQPull; False:C215)  //QQPull
		
		OBJECT SET ENABLED:C1123(b21; False:C215)  //New taskID
		OBJECT SET ENABLED:C1123(b20; False:C215)  //ship
		OBJECT SET ENABLED:C1123(b24; True:C214)  //bySite
		//
		KeyModifierCurrent
		If ((b64=1) & (vltaskID>0))
			QUERY:C277([WorkOrder:66];  & ; [WorkOrder:66]idNumTask:22=vltaskID; *)
		Else 
			QUERY:C277([WorkOrder:66]; [WorkOrder:66]woType:60="Transfer"; *)
			//QUERY([WorkOrder];&[WorkOrder]DTCompleted=0;*)
		End if 
		
		
End case 
QUERY:C277([WorkOrder:66];  & ; [WorkOrder:66]dtCreated:44>=DateTime_Enter((iLoDate1-iLoInteger1); ?00:00:00?); *)
QUERY:C277([WorkOrder:66];  & ; [WorkOrder:66]dtCreated:44<=DateTime_Enter((iLoDate1+iLoInteger1); ?23:59:59?); *)
QUERY:C277([WorkOrder:66])

WOTransfers_Sort(iLoText2)
//  CHOPPED  AL_UpdateFields(eWorkOrders; 2)

