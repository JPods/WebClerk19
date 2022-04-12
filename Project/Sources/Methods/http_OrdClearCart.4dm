//%attributes = {"publishedWeb":true}
//Method: http_OrdClearCart
//  C_LONGINT($1)
//  vText9:=""
//  $jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
//  //
//  //zttp_UserGet 
//  // ### bj ### 20181214_0720
//  // unless this is cloned, it should not be here.
//  // [EventLog]Message:=""
//  
//  [EventLog]qty:=0
//  [EventLog]value:=0
//  [EventLog]valueBonus:=0
//  //
//  If ([EventLog]idNum#0)
//  SAVE RECORD([EventLog])
//  End if 
//  //
//  QUERY([WebTempRec]; [WebTempRec]idEventLog=vleventID; *)
//  QUERY([WebTempRec];  & [WebTempRec]qtyOrdered#0; *)
//  QUERY([WebTempRec];  & [WebTempRec]posted=False)
//  C_LONGINT($i; $k)
//  $k:=Records in selection([WebTempRec])
//  FIRST RECORD([WebTempRec])
//  For ($i; 1; $k)
//  [WebTempRec]posted:=True
//  SAVE RECORD([WebTempRec])
//  NEXT RECORD([WebTempRec])
//  End for 
//  REDUCE SELECTION([WebTempRec]; 0)
//  //
//  $pageDo:=WC_DoPage("ShoppingCart.html"; $jitPageOne)
//  $err:=WC_PageSendWithTags($1; $pageDo; 0)
//  