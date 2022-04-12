// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 11/06/14, 09:25:55
// ----------------------------------------------------
// Method: [Control].WorkOrdersTransfer
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
Case of 
	: ($formEvent=On Clicked:K2:4)
		
		
	: ($formEvent=On Plug in Area:K2:16)
		
	: ($formEvent=On Load:K2:1)
		//QUERY([ItemWarehouse];[ItemWarehouse]ItemNum=srItemNum)
		//REDUCE SELECTION([ItemWarehouse];0)
		
		OBJECT SET SHORTCUT:C1185(*; "Variable91"; "{")  // ### jwm ### 20180924_1329 override manual shortcut in form
		
		C_LONGINT:C283(eWorkOrders; vltaskID; vlGroupID)  // ### jwm ### 20140926_1717 added vlGroupID
		iLoInteger1:=90  // ### jwm ### 20140929_1649 changed from 4 to 90 day period
		
		WOTransfers_Sort(iLoText2)
		
		If (iLo80String3="")
			iLo80String3:=Current user:C182
		End if 
		[WorkOrder:66]actionByLast:65:=iLo80String3
		If (iLo80String4="")
			iLo80String4:=Current user:C182
		End if 
		iLoDate1:=Current date:C33
		
		//QUERY([WorkOrder];[WorkOrder]DTCompleted=0;*)
		QUERY:C277([WorkOrder:66]; [WorkOrder:66]dtCreated:44>=DateTime_Enter((Current date:C33-iLoInteger1); ?00:00:00?); *)
		QUERY:C277([WorkOrder:66];  & ; [WorkOrder:66]dtCreated:44<=DateTime_Enter((Current date:C33+iLoInteger1); ?23:59:59?); *)
		QUERY:C277([WorkOrder:66];  & ; [WorkOrder:66]woType:60="Transfer"; *)
		QUERY:C277([WorkOrder:66])
		
		iLo80String1:=""
		iLo80String2:=""
		iLo80String1:=DSSetSiteID
		
		//
		iLoText2:="View"
		OBJECT SET RGB COLORS:C628(iLoText2; 0x0000; 0x00FFFFFF)
		vHere:=2
		READ ONLY:C145([WorkOrder:66])
		
		OBJECT SET ENABLED:C1123(b13; False:C215)  //clone
		OBJECT SET ENABLED:C1123(b22; False:C215)  //close
		OBJECT SET ENABLED:C1123(b14; False:C215)  //receive
		OBJECT SET ENABLED:C1123(b20; False:C215)  //pickup
		OBJECT SET ENABLED:C1123(bQQPull; False:C215)  //QQPull
		OBJECT SET ENABLED:C1123(b24; True:C214)  //by site
		
		ptCurTable:=(->[Control:1])
		If (ptCurTable#(->[TallyMaster:60]))
			TallyMasterPopuuScriptsGeneral(ptCurTable; "WOTransfer"; ""; "aLooLoScripts")
		End if 
		
		
		
	: ($formEvent=On Load Record:K2:38)
		
		
	: ($formEvent=On Unload:K2:2)
		
		
		
		
	: ($formEvent=On Getting Focus:K2:7)
		
	: ($formEvent=On Losing Focus:K2:8)
		
	: ($formEvent=On Outside Call:K2:11)
		
		//  CHOPPED  AL_UpdateFields(eWorkOrders; 2)
		
	: ($formEvent=On Drop:K2:12)
		
	: ($formEvent=On Activate:K2:9)
		
		
		
End case 