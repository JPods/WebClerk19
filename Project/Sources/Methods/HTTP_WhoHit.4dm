//%attributes = {"publishedWeb":true}
////Procedure: HTTP_WhoHit (process; who)
//C_TEXT(vtHtWho)
//C_TEXT(vtHtDotted)
//$err:=ITK_TCPStrmInfo ($1;$remoteHost)
//vtHtDotted:=ITK_Addr2Name ($remoteHost;2)
//vtHtWho:=ITK_Addr2Name ($remoteHost)
//SEARCH([EventLog];[EventLog]MessageID=$remoteHost)
//If (Records in selection([EventLog])=0)
//SEARCH([EventLog];[EventLog]MessageID=$remoteHost)
//If (Records in selection([EventLog])=0)
//$remoteHost:=WCapi_GetParameter($1;"WhoIs";"")
//End if 
//CREATE RECORD([EventLog])
// 
//[EventLog]DTEvent:=DateTime_DTTo 
//[EventLog]Group:="NetOrd"
//[EventLog]MessageID:=$remoteHost
//Else 
//Case of 
//: ([EventLog]FileNum=2)
//GOTO RECORD([Customer];[EventLog]CustomerRecNum)
//: ([EventLog]FileNum=48)
//GOTO RECORD([Lead];[EventLog]CustomerRecNum)
//: ([EventLog]FileNum=File([Vendor]))
//GOTO RECORD([Vendor];[EventLog]CustomerRecNum)
//: ([EventLog]FileNum=File([Contact]))
//GOTO RECORD([Contact];[EventLog]CustomerRecNum)
//SEARCH([Customer];[Customer]customerID=[Contact]customerID)
//End case 
//If (([EventLog]DTEvent-DateTime_DTTo >14400)|($3=1))//update from
// within the order layout
//[EventLog]Message:=""//else we want to add to the order, so leave it
// alone
//[EventLog]Qty:=0
//[EventLog]Value:=0
//End if 
//[EventLog]DTEvent:=DateTime_DTTo 
//viSaleID:=Record number([EventLog])
//End if 