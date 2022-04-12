//%attributes = {"publishedWeb":true}
//Procedure: http_Custom
//  C_LONGINT($1; $err; $orderNum; $recordID; $p; $k)
//  C_POINTER($2)
//  //
//  C_LONGINT(<>vbNoCustomWeb)
//  C_TEXT($thePage; $suffix; $theFile; webScript)
//  C_TEXT(voState.url; jitCustomBody; webScript; jitPageList; jitPageOne; jitRequired)
//  $suffix:=""
//  $thePage:=WC_DoPage("Error"+$suffix+".html"; "")
//  vResponse:="Custom script called."
//  Case of 
//  : (<>vbNoCustomWeb=0)
//  vResponse:="WebClerk preferences \"Allow Customer Scripts \" set to FALSE."
//  Else 
//  jitCustomBody:=""
//  jitRequired:=""
//  jitPageList:=""
//  WC_VariablesRead
//  //
//  jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
//  // jitPageList:=WCapi_GetParameter("jitPageList";"")
//  
//  
//  
//  webScript:=WCapi_GetParameter("webScript"; "")
//  If (webScript="")
//  webScript:=WCapi_GetParameter("jitCustomScript"; "")
//  If (webScript="")
//  webScript:=WCapi_GetParameter("ReportName"; "")
//  If (webScript="")
//  webScript:=WCapi_GetParameter("Name"; "")
//  End if 
//  End if 
//  End if 
//  
//  jitRequired:=WCapi_GetParameter("jitRequired"; "")
//  
//  //If (Record number([RemoteUser])>-1)
//  $p:=Position("/"; vText11)
//  jitCustomBody:=Substring(vText11; $p)  //clip the Method
//  
//  C_LONGINT($recordID; $vlSecurity)
//  If (vWccSecurity>viEndUserSecurityLevel)
//  $vlSecurity:=vWccSecurity
//  Else 
//  $vlSecurity:=viEndUserSecurityLevel
//  End if 
//  
//  vResponse:="Script Purpose: WebScript; Name: "+webScript+"; Allowed Security: "+String($vlSecurity)+"."
//  If (webScript="AddWorkOrder")
//  jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
//  http_SaveWO($1; $2)
//  Else 
//  READ WRITE([OrderLine])
//  READ WRITE([InvoiceLine])
//  READ ONLY([TallyMaster])
//  QUERY([TallyMaster]; [TallyMaster]name=webScript; *)
//  QUERY([TallyMaster];  & [TallyMaster]purpose="WebScript"; *)
//  QUERY([TallyMaster];  & [TallyMaster]publish>0; *)
//  QUERY([TallyMaster];  & [TallyMaster]publish<=$vlSecurity)
//  
//  
//  Case of 
//  : (False)
//  ALL RECORDS([Customer])
//  REDUCE SELECTION([Customer]; 10)
//  : ([TallyMaster]name="")
//  vResponse:=vResponse+"  [TallyMaster]Name is empty."
//  : (voState.url="/jit_Custom_testThis@")
//  //If (Not(Compiled application))
//  
//  If (variable1#"")  //modify invoices
//  QUERY([Invoice]; [Invoice]invoiceNum=Num(variable1))
//  If ((Records in selection([Invoice])=1) & (Not(Locked([Invoice]))))
//  QUERY([Customer]; [Customer]customerID=[Invoice]customerID)
//  If ([Invoice]orderNum>1)
//  QUERY([Order]; [Order]orderNum=[Invoice]orderNum)
//  Else 
//  UNLOAD RECORD([Order])
//  End if 
//  vR2:=Num(variable2)
//  
//  vR1:=vR2-[Invoice]amount
//  CREATE RECORD([DCash])
//  
//  [DCash]changeAmount:=vR1
//  [DCash]customerIDApply:=[Customer]customerID
//  [DCash]customerIDReceive:=[Customer]customerID
//  [DCash]docApply:=[Invoice]invoiceNum
//  [DCash]docReceive:=[Invoice]invoiceNum
//  // zzzqqq jDateTimeStamp(->[DCash]comment; "Web based change = "+String(vR1))
//  [DCash]dateEvent:=Current date
//  [DCash]nameID:=[RemoteUser]userName
//  [DCash]tableApply:=28
//  [DCash]tableReceive:=28
//  [DCash]takenBy:=[RemoteUser]userName
//  [DCash]terms:="Web"
//  SAVE RECORD([DCash])
//  
//  WC_Parse(Table(->[Invoice]); ->vText11; False)
//  [Invoice]amountForceValue:=vR2
//  ptTableLast:=(->[Invoice])
//  vHere:=2
//  uBoolean1:=NxPvInvAccess
//  NxPvInvoices
//  CalcOverRidePrice(->[Invoice])
//  vMod:=True
//  acceptInvoice(True)
//  Ledger_InvSave
//  vHere:=0
//  Else 
//  Response:="No Payment Record"
//  End if 
//  End if 
//  
//  If (False)  //modify payments
//  If (variable1#"")
//  QUERY([Payment]; [Payment]idNum=Num(variable1))
//  If ((Records in selection([Payment])=1) & (Not(Locked([Payment]))))
//  QUERY([Customer]; [Customer]customerID=[Payment]customerID)
//  vR2:=Num(variable2)
//  vR1:=vR2-[Payment]amountAvailable
//  CREATE RECORD([DCash])
//  
//  [DCash]changeAmount:=vR1
//  [DCash]customerIDApply:=[Customer]customerID
//  [DCash]customerIDReceive:=[Customer]customerID
//  [DCash]docApply:=[Payment]idNum
//  [DCash]docReceive:=[Payment]idNum
//  // zzzqqq jDateTimeStamp(->[DCash]comment; "Web based change = "+variable2)
//  [DCash]dateEvent:=Current date
//  [DCash]nameID:=[RemoteUser]userName
//  [DCash]tableApply:=28
//  [DCash]tableReceive:=28
//  [DCash]takenBy:=[RemoteUser]userName
//  [DCash]terms:="Web"
//  SAVE RECORD([DCash])
//  WC_Parse(Table(->[Payment]); ->vText11; False)
//  [Payment]amountAvailable:=vR2
//  SAVE RECORD([Payment])
//  Ledger_PaySave
//  Else 
//  Response:="No Payment Record"
//  End if 
//  End if 
//  End if 
//  If (False)
//  If (variable1#"")
//  QUERY([Order]; [Order]orderNum=Num(variable1))
//  If ((Records in selection([Order])=1) & ([RemoteUser]customerID=[Order]mfrID))
//  //
//  READ ONLY([ManufacturerTerm])
//  QUERY([ManufacturerTerm]; [ManufacturerTerm]customerID=[Order]mfrID)
//  //
//  v4:="Com"+[Order]mfrID
//  srOrd:=[Order]orderNum
//  vAmount:=Num(Variable4)
//  v2:=[Order]typeSale
//  vR6:=Num(Variable4)
//  vR5:=Round(vR6*(Num(Variable7)*0.01); 2)
//  vR7:=[Order]amount
//  v6:=Variable10  //Mfr Order
//  v7:=Variable11  //Mfr Invoice
//  vDate6:=Date(Variable6)  //date shipped
//  vR2:=Num(Variable7)  //default commission %  15
//  vR4:=Num(Variable8)  //commission Split    40
//  vR1:=Round(vAmount*vR2*0.01; 2)
//  vR3:=Round(vR1*vR4*0.01; 2)
//  
//  If ([Order]flow=0)
//  QUERY([OrderLine]; [OrderLine]orderNum=[Order]orderNum)
//  vi2:=Records in selection([OrderLine])
//  FIRST RECORD([OrderLine])
//  uInteger1:=0
//  
//  uReal1:=OrdersFlowToCommission(4)  //Item record must already be the selection
//  //[Order]Flow:=4
//  //CMANewCommOrderLine (-1;$backlog;$backlog;Current date;"CommWindow";"exact";$inTest;vR2;vR4)
//  //CMAComOrderOneLine (4;$inTest+1;0)
//  
//  CMANewCommOrderLine(-1; uReal1; uReal1; Current date; "CommWindow"; "exact"; uInteger1; vR2; vR4)
//  CMAComOrderOneLine(4)
//  
//  //[Order]Flow:=4
//  [Order]amount:=[OrderLine]extendedPrice
//  [Order]repCommission:=Round([Order]amount*[OrderLine]commRateRep*0.01; 2)  //[OrderLine]CommRep
//  [Order]salesCommission:=Round([Order]amount*[OrderLine]commRateSales*0.01; 2)  //[OrderLine]CommSales
//  [Order]total:=[OrderLine]extendedPrice
//  [Order]amountBackLog:=[OrderLine]backOrdAmount
//  
//  SAVE RECORD([Order])
//  End if 
//  CMAComInvoiceOneLine(1)
//  READ WRITE([ManufacturerTerm])
//  End if 
//  //End if 
//  End if 
//  End if 
//  
//  : (([TallyMaster]publish<=0) & (Records in selection([TallyMaster])=1))
//  vResponse:=vResponse+"  Script not published."
//  : (([TallyMaster]publish>$vlSecurity) & (Records in selection([TallyMaster])=1))
//  vResponse:=vResponse+"  Script access exceeds your authority."
//  : (Records in selection([TallyMaster])=0)
//  vResponse:=vResponse+"  No custom Script Record Match."
//  : (Records in selection([TallyMaster])>1)
//  vResponse:=vResponse+"  Multiple custom scripts with the same name."
//  : (Records in selection([TallyMaster])=1)
//  ExecuteText(0; [TallyMaster]script)
//  REDUCE SELECTION([TallyMaster]; 0)
//  
//  
//  // bad testing point
//  If (Records in selection([Customer])=0)  // remove this after testing
//  ALL RECORDS([Customer])
//  REDUCE SELECTION([Customer]; 10)
//  End if 
//  
//  : (webScript="createWorkOrder")
//  If (False)
//  vText1:=voState.url
//  v1:=WCapi_GetParameter("ItemClass"; "")
//  CREATE RECORD([WorkOrder])
//  [WorkOrder]woNum:=CounterNew(->[WorkOrder])
//  [WorkOrder]itemNum:=v1
//  [WorkOrder]description:=jitCustomBody
//  //WC_Parse (Table(->[WorkOrder]);->voState.url)
//  //WC_Parse (Table(->[WorkOrder]);->jitCustomBody)
//  [WorkOrder]dtReleased:=DateTime_Enter
//  [WorkOrder]dtCreated:=[WorkOrder]dtReleased
//  [WorkOrder]action:="WebInProcess"
//  [WorkOrder]customerID:=[Customer]customerID
//  [WorkOrder]company:=[Customer]company
//  //[WorkOrder]groupid:=vlEventRec
//  //[WorkOrder]idNumTask:=-vlEventRec
//  [WorkOrder]salesOrderLine:=-3
//  [WorkOrder]description:=Replace string(jitCustomBody; "\n"; "")
//  QUERY([TallyResult]; [TallyResult]name="scriptWeb"; *)
//  QUERY([TallyResult];  & [TallyResult]purpose="OmegaScript")
//  SAVE RECORD([WorkOrder])
//  jitPageOne:="Stamp OK"+Storage.char.crlf  //hard coded into the applet
//  $bytesSend:=TCP Send($socket; jitPageOne)
//  $thePage:=""
//  End if 
//  Else 
//  vResponse:=vResponse+"  No matching criteria."
//  End case 
//  
//  READ ONLY([OrderLine])
//  READ ONLY([InvoiceLine])
//  End if 
//  Case of 
//  : (jitPageOne="Send Message")
//  EventLogsMessage("Custom Attempt"+voState.url)
//  If ([EventLog]idNum#0)
//  SAVE RECORD([EventLog])
//  End if 
//  : (jitPageList#"")
//  $thePage:=WC_DoPage(jitPageList; "")  //already sent in http_saveWO
//  : (jitPageOne="")
//  $thePage:=WC_DoPage("WorkOrdersOne.html"; "")  //already sent in http_saveWO
//  Else 
//  $thePage:=WC_DoPage(jitPageOne; "")
//  End case 
//  
//  
//  End case 
//  If ($thePage#"")
//  $err:=WC_PageSendWithTags($1; $thePage; 0)
//  End if 
//  
//  
//  jitCustomBody:=""
//  jitRequired:=""
//  jitPageList:=""
//  webScript:=""
//  jitPageOne:=""
//  
//  
//  If (False)  //fix TallyMasters
//  vi2:=Records in selection([TallyMaster])
//  FIRST RECORD([TallyMaster])
//  For (vi1; 1; vi2)
//  [TallyMaster]after:=Replace string([TallyMaster]after; "jitPageVariable"; "jitVariable")
//  [TallyMaster]build:=Replace string([TallyMaster]build; "jitPageVariable"; "jitVariable")
//  [TallyMaster]template:=Replace string([TallyMaster]template; "jitPageVariable"; "jitVariable")
//  [TallyMaster]path:=Replace string([TallyMaster]path; "jitPageVariable"; "jitVariable")
//  [TallyMaster]script:=Replace string([TallyMaster]script; "jitPageVariable"; "jitVariable")
//  SAVE RECORD([TallyMaster])
//  NEXT RECORD([TallyMaster])
//  End for 
//  End if 
//  
//  
//  
//  