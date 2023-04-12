//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-09-01T00:00:00, 19:21:23
// ----------------------------------------------------
// Method: WC_VariablesDeclare
// Description
// Modified: 09/01/17
// 
// 
//
// Parameters
// ----------------------------------------------------
// ### bj ### 20210822_1438
// Put into Storage then delete
// ports, sockets, and thread counts must be established 

C_BOOLEAN:C305(<>bWebEvent; <>vLookaHead)
<>vLookaHead:=False:C215
<>bWebEvent:=False:C215

ARRAY TEXT:C222(<>aWebSites; 0)
ARRAY TEXT:C222(<>aWebDefaultPages; 0)
ARRAY TEXT:C222(<>aWebRoot; 0)

C_LONGINT:C283(<>vMaxLifeBrowser)
If (<>vMaxLifeBrowser=0)
	<>vMaxLifeBrowser:=3600
End if 

If (<>tcCCNameRefNum="")
	<>tcCCNameRefNum:="RefNum"
End if 
If (<>tcCCNameAuthNum="")
	<>tcCCNameAuthNum:="approval"
End if 
If (<>tcCCNameDocID="")
	<>tcCCNameDocID:="ordernumber"
End if 
<>tcCCNameRefTotal:=""
If (<>tcCCNameRefTotal="")
	<>tcCCNameRefTotal:="fulltotal"
End if 
If (<>tcCCNameAVS="")
	<>tcCCNameAVS:="AVS"
End if 
If (<>tcCCNamePayType="")
	<>tcCCNamePayType:="payType"
End if 
If (<>tcCCNameAction="")
	<>tcCCNameAction:="payAction"
End if 


<>vbWCstop:=False:C215

C_LONGINT:C283($doNum)
$doNum:=Num:C11(<>vlWebRealPr>0)
<>WebRealFormat:="###,###,###,##0"+("."*$doNum)+("0"*<>vlWebRealPr*$doNum)
<>viWebShow:=<>viWebShow+(Num:C11(<>viWebShow=0)*20)
<>viMaxShow:=<>viMaxShow+(Num:C11(<>viMaxShow=0)*40)
<>vlServerAge:=100000
//
//
C_TEXT:C284(<>htmlExpire)
<>dtStartWebClerk:=DateTime_DTTo
WC_PageArrays("init")
<>forceEmpty:=""
C_LONGINT:C283(<>vTicDelay)
C_BOOLEAN:C305(<>multiSite)
<>multiSite:=False:C215
//Storage.wc.webFolder defined in jStart2
ARRAY TEXT:C222(<>aWebLog; 0)
C_LONGINT:C283(<>log; <>postDoc; <>dtStartWebClerk)
C_TEXT:C284(<>htmlExpire)
C_LONGINT:C283(<>vMaxLifeBrowser)

C_LONGINT:C283(<>vSecondsRecordPassing; <>vMilliSecondListen)
C_TIME:C306(<>myWebDoc)  //<>sumDoc)
ON ERR CALL:C155("jOECNoAction")
CLOSE DOCUMENT:C267(<>myWebDoc)
ON ERR CALL:C155("")

If (<>vSecondsRecordPassing=0)
	<>vSecondsRecordPassing:=60
End if 
If (<>vMilliSecondListen=0)
	<>vMilliSecondListen:=15000
End if 

<>vMaxLifeBrowser:=[WebClerk:78]lifespan:40
If (<>vMaxLifeBrowser=0)
	<>vMaxLifeBrowser:=86000
End if 

C_BOOLEAN:C305(<>bLogHeaders; <>bLogParameters)
<>bLogHeaders:=[WebClerk:78]logHeaders:45
<>bLogParameters:=[WebClerk:78]logParameters:46

C_BOOLEAN:C305(<>HTTPD_IsInitialised)




