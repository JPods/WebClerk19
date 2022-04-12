//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/26/20, 13:06:51
// ----------------------------------------------------
// Method: WC_InitServerProcess
// Description
// 
//
// Parameters
// ----------------------------------------------------

// switch these all to an object

C_LONGINT:C283($serverSocket; $sslServerSocket)
ARRAY LONGINT:C221(aWebRelatedTableNum; 0)
C_LONGINT:C283(vdeBugElement; vRelateLevel)
MESSAGES OFF:C175
C_TEXT:C284(vText11; $temp; $url; $fic; $modified; $lastmod; $testText)
C_TEXT:C284($MIMEtype)
C_LONGINT:C283($s; $wCookie; $foundEnd; vlUserRec; $i; $p; $pForm)
C_LONGINT:C283($err; $c; $srtt; $localIP)
C_LONGINT:C283($localPort; $remotePort)
C_BOOLEAN:C305(<>vbWCstop; vbDropOut; <>doBlob)
//<>WebRealFormat
C_TEXT:C284(tcEmailAddr; tcEmailSrvr; tcDomain; cdTime)
C_TEXT:C284(ccNumber; ccExpires; ccName; ccZip)
C_TEXT:C284(tcSSLSecure; tcJustAddress; tcFullAddress; webLog)
C_TEXT:C284(tcCompany; tcEmailAddr; tcEmailSrvr; tcDomain; tcSecure; tcDotted; tcSSLSecure; tcSSLUser)
C_BLOB:C604(vUpLoadBlob)
C_DATE:C307(vTmpDateBeg; vTmpDateEnd; tcEmailAddress)


var $entDefault : Object
$entDefault:=ds:C1482.Default.query("primeDefault = 1").first()
tcCompany:=Storage:C1525.default.company
tcJustAddress:=jConcat(Storage:C1525.default.address1; "\r")+jConcat(Storage:C1525.default.address2; "\r")+jConcat(Storage:C1525.default.city; ", ")+jConcat(Storage:C1525.default.state; " ")+jConcat(Storage:C1525.default.zip; " ")+jConcat(jCountry(Storage:C1525.default.country; [Customer:2]country:9))
tcFullAddress:=Storage:C1525.default.address
tcEmailAddr:=Storage:C1525.default.email
tcEmailSrvr:=Storage:C1525.default.emailServer

tcDomain:=Storage:C1525.default.domain
tcSecure:=<>tcSecure
tcDotted:=<>tcDotted
tcSSLUser:=<>tcSSLUser
tcSSLSecure:=<>tcSecure
C_TEXT:C284(tcCheckOutPath)
tcCheckOutPath:=""
tcPayPath:=""
//
$track:=False:C215
ccWebNum:=<>ccWebNum
ccWebDate:=<>ccWebDate
ccWebName:=<>ccWebName
vlBeenHere:=0  //changed in item 250 Accepted message qp 9766 bytes 2320
vBeenHere:=0
//
viEndUserSecurityLevel:=1

C_LONGINT:C283(viWebOrder; maxClickList)

maxClickList:=9*<>viWebShow
viWebOrder:=1
//
//SEARCH([TallyResult];[TallyResult]Name="TestLabel1";*)
//SEARCH([TallyResult];&[TallyResult]Purpose="webClerk1")
//myDocName:=[TallyResult]TextBlk1
//UNLOAD RECORD([TallyResult])
//
ARRAY TEXT:C222(aTCP; 6)
C_LONGINT:C283(viRemoteIP; viTooOld)
//vText11 is the request
//vText12 is the value of pages to be converted.
Process_InitLocal
allowAlerts_boo:=False:C215  //block all 
$c:=0



