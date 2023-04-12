//%attributes = {"publishedWeb":true}
//// ----------------------------------------------------
//// User name (OS): williamjames
//// Date and time: 01/14/10, 14:53:42
//// ----------------------------------------------------
//// Method: 333Http_UserGet
//// Description
//// 
////
//// Parameters
//// ----------------------------------------------------

////
//C_POINTER($ptEmail)
//C_TEXT(eMailAddress)
//C_LONGINT($1; $forceChange)
//If (Count parameters=0)
//$forceChange:=0
//Else 
//$forceChange:=$1
//End if 
////TRACE
//C_TEXT(vUsePricePoint)
//vUsePricePoint:=""
//viEndUserSecurityLevel:=1
//vUseBase:=2  //always set to base
//tcCheckOutPath:="/Check_Out"  //*jitxUser="+String(vleventID)+"*"
//If ([EventLog]remoteUserRec>-1)
//vlUserRec:=[EventLog]remoteUserRec
//GOTO RECORD([RemoteUser]; vlUserRec)
//viEndUserSecurityLevel:=[RemoteUser]securityLevel
//eMailAddress:=[RemoteUser]email
//Case of 
//: (vWccTableNum=8)
//GOTO RECORD([Rep]; vWccPrimeRec)  //make available
////vUsePricePoint:=
//: (vWccTableNum=19)
//GOTO RECORD([Employee]; vWccPrimeRec)  //make available
////vUsePricePoint:=
//End case 
//Case of 
//: ([RemoteUser]tableNum<2)
//vUseBase:=2
//vUsePricePoint:=""

//: (([RemoteUser]tableNum=vWccTableNum) & ([EventLog]tableNum#2))  // operating as self
////KeyModifierCurrent 
////If (capKey=1)
////TRACE
////End if 
//: ((([EventLog]tableNum=2) & ([EventLog]customerRecNum>0)) | (([EventLog]customerRecNum>0) & ([EventLog]tableNum=2) & (vWccTableNum>0)))
//GOTO RECORD([Customer]; [EventLog]customerRecNum)
//// ### bj ### 20181230_1510
//// build addresses on pages
//// $addressAction:=WCapi_GetParameter ("AddressBuild";"")
//C_TEXT($clearCustomer)

//// Modified by: William James (2014-09-13T00:00:00 PoolPatio)
//If (eMailAddress="")
//eMailAddress:=[Customer]email  //convert at the bottom
//[RemoteUser]email:=[Customer]email
//SAVE RECORD([RemoteUser])
//End if 
//If ([Customer]terms="CC_SSLSecure")
//tcCheckOutPath:=tcSSLSecure+"/Check_Out"+"_"+<>tcSSLUser+"_"+<>tcDotted
//End if 
//DscntSetPrice([Customer]typeSale)
////vUseBase:=SetPricePoint ()
//vUsePricePoint:=[Customer]typeSale
//pvTypeSale:=[Customer]typeSale
//: (([RemoteUser]tableNum=111) & ([EventLog]customerRecNum>0))
//GOTO RECORD([Customer]; [EventLog]customerRecNum)
//QUERY([ManufacturerTerm]; [ManufacturerTerm]customerID=[Customer]customerID)

//: (([RemoteUser]tableNum=48) & ([EventLog]customerRecNum>0))
//GOTO RECORD([zzzLead]; [EventLog]customerRecNum)
//If ($forceChange=1)
//Temp2Customer
//[RemoteUser]tableNum:=2
//[RemoteUser]customerID:=[Customer]customerID
//[EventLog]tableNum:=2
//[EventLog]customerRecNum:=Record number([Customer])
//pvTypeSale:=[Customer]typeSale
//READ WRITE([RemoteUser])
//GOTO RECORD([RemoteUser]; [EventLog]remoteUserRec)  //unloaded in the Temp2Customer method
//If ([EventLog]idNum#0)
//SAVE RECORD([EventLog])
//End if 
//Else 
//If (eMailAddress="")
//eMailAddress:=[zzzLead]email
//[RemoteUser]email:=[zzzLead]email
//SAVE RECORD([RemoteUser])
//End if 
//If ([zzzLead]terms="CC_SSLSecure")
//tcCheckOutPath:=tcSSLSecure+"/Check_Out"+"_"+<>tcSSLUser+"_"+<>tcDotted  //+"*jitxUser="+String(vleventID)+"*"
//End if 
//DscntSetPrice([zzzLead]typeSale)
////vUseBase:=SetPricePoint ()
//vUsePricePoint:=[zzzLead]typeSale
//pvTypeSale:=[zzzLead]typeSale
////vUseBase:=SetPricePoint ([Lead]TypeSale)
//End if 
//vUsePricePoint:=[zzzLead]typeSale
//: (([RemoteUser]tableNum=38) & ([EventLog]customerRecNum>0))
//GOTO RECORD([Vendor]; [EventLog]customerRecNum)

//If (eMailAddress="")
//eMailAddress:=[Vendor]email
//[RemoteUser]email:=[Vendor]email
//SAVE RECORD([RemoteUser])
//End if 
//: ((([EventLog]tableNum=13) & ([EventLog]customerRecNum>0)) | (([EventLog]customerRecNum>0) & ([EventLog]tableNum=13) & (vWccTableNum>0)))
//GOTO RECORD([Contact]; [EventLog]customerRecNum)
//If (eMailAddress="")
//eMailAddress:=[Contact]email
//[RemoteUser]email:=[Contact]email
//SAVE RECORD([RemoteUser])
//End if 
//If ([Contact]customerID#"")
//QUERY([Customer]; [Customer]customerID=[Contact]customerID)
//Else 
//REDUCE SELECTION([Customer]; 0)
//End if 
//vUseBase:=SetPricePoint([Customer]typeSale)
//vUsePricePoint:=[Customer]typeSale
//pvTypeSale:=[Customer]typeSale
//Else 
//tcCheckOutPath:="/Register.html"  //*jitxUser=!xjit=0;"+String(vleventID)+"!*"
//End case 
//eMailAddress:=eMailAddress
//Else 
//UNLOAD RECORD([RemoteUser])
//End if 
//If ((vUseBase<2) | (vUseBase>5))
//vUseBase:=2
//End if 



//If (<>viDebugMode>410)
//C_TEXT($recText; $webLog)
//$recText:=", vWccTableNum: "+String(vWccTableNum)+", vWccPrimeRec: "+String(vWccPrimeRec)
//If ([RemoteUser]tableNum>0)
//$recText:=$recText+", UserRecordNum: "+String(Record number(Table([RemoteUser]tableNum)->))
//Else 
//$recText:=$recText+", UserRecordNum: Missing"
//End if 

//$theMessage:="////eventID="+String(vleventID)+", RemoteUserRec="+String(vlUserRec)+", EmployRepRemoteUser="+String(vWccRemoteUserRec)+", Security="+String(viEndUserSecurityLevel)+"/"+String(vWccSecurity)
//ConsoleLog($theMessage)
//WC_LogEvent("333Http_UserGet"; $theMessage)
//$webLog:=$webLog+"\t"+"////  333Http_UserGet, RemoteUserRecordNum: "+String(Record number([RemoteUser]))
//$webLog:=$webLog+", SecurityLevel: "+String([RemoteUser]securityLevel)+", vUsePricePoint: "+vUsePricePoint
//$webLog:=$webLog+", pvTypeSale: "+pvTypeSale+$recText+$theMessage+"\r"
//ConsoleLog($webLog)
//WC_LogEvent("333Http_UserGet"; $webLog)
//End if 
