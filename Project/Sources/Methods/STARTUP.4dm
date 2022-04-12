//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/03/09, 00:25:07
// ----------------------------------------------------
// Method: STARTUP
// Description
// 
//
// Parameters
// ----------------------------------------------------
Storage_Init
0000StorageByPass

SET DATABASE PARAMETER:C642(Diagnostic log recording:K37:69; 1)  //1 to enable or 0 to disable

//ConsoleLaunch   // ### jwm ### 20190228_2007 is this needed here ?
Compiler_Arrays
aaaDecConsts
StructureToArrays  // Needed to find unquie fields
STR_Permissions

// Modified by: Bill James (2018-06-14T00:00:00) removed 4Dwrite or commented out

// ### jwm ### 20191004_1707
// 4D Diagnostic Log
SET DATABASE PARAMETER:C642(Diagnostic log recording:K37:69; 1)  //1 to enable or 0 to disable


//ConsoleLaunch   // ### jwm ### 20190228_2007 is this needed here ?
Compiler_Arrays
aaaDecConsts
StructureToArrays  // Needed to find unquie fields
STR_Permissions


QUERY:C277([CounterPending:135]; [CounterPending:135]status:7=2)
DELETE SELECTION:C66([CounterPending:135])

// ### jwm ### 20190227_1731
//If (Application type#4D Server)
//ConsoleMessage ("Launch")
//End if


// MustFixQQQZZZ: Bill James (2021-12-07T06:00:00Z)
// These will are no longer needed and can be eliminated once non-table forms are shifted to Forms
QUERY:C277([Control:1]; [Control:1]idNum:7=0)
If (Records in selection:C76([Control:1])>0)
	ALL RECORDS:C47([Control:1])
	DELETE SELECTION:C66([Control:1])
	For ($i; 1; 100)
		CREATE RECORD:C68([Control:1])
		SAVE RECORD:C53([Control:1])
	End for 
	// ### bj ### 20180913_2345 already in the create record
	// UUIDResetValues (->[Control]id)
End if 
REDUCE SELECTION:C351([Control:1]; 0)

// ### jwm ### 20160412_1549 initialize Console to OFF
C_TEXT:C284(<>vConsoleMessage)
C_LONGINT:C283($found; <>consoleProcess; <>tcPrsMemory; <>consoleDirection)
If (<>tcPrsMemory=0)
	<>tcPrsMemory:=128000
End if 
<>consoleDirection:=2  // new at bottom

// launch Console window before Sales Splash Screen
// check DefaultSetups for ConsoleLaunch // ### jwm ### 20170509_1040
READ ONLY:C145([DefaultSetup:86])
QUERY:C277([DefaultSetup:86]; [DefaultSetup:86]variableName:7="ConsoleLaunch"; *)
QUERY:C277([DefaultSetup:86];  & [DefaultSetup:86]machine:13=Current machine:C483; *)
QUERY:C277([DefaultSetup:86];  & [DefaultSetup:86]nameID:1=Current user:C182; *)
QUERY:C277([DefaultSetup:86])

If (Application type:C494=4D Remote mode:K5:5)
	CHANGE CURRENT USER:C289
	Case of 
		: (OK=1)
			jpwNewUser
		: (Current user:C182="Designer")
			ALERT:C41("Starting in Designer Mode")
	End case 
End if 

ConsoleMessage("Current User: "+Current user:C182)

If (Records in selection:C76([DefaultSetup:86])>0)
	ConsoleLaunch
	ConsoleMessage("Startup: "+String:C10(Current time:C178))
End if 


UNLOAD RECORD:C212([DefaultSetup:86])
READ WRITE:C146([DefaultSetup:86])

C_BOOLEAN:C305($doCounters)
$doCounters:=False:C215
If (Records in table:C83([CounterPending:135])<50)  // new database
	
	//  P_OrdHeader Remove these from SuperReports
	
	C_LONGINT:C283($found; <>consoleProcess; <>tcPrsMemory)
	// ConsoleMessage ("ConsoleLaunch")
	
	// setup
	
	UUIDResetValues  // make sure UUIDs are complete
	
	// check for distinct values
	// DistinctValuesRecordCount
	//
	
	
	Fix_CounterRec2Name  // run this first to fix counter names
	//  UniqueRunForce already filled with values on opening
	// get the largest existing counter
	If (False:C215)  // transfer the existing counters, then let the walkover feature correct for defects
		
		Counters_MaxValue  // use this to make sure that sequence numbers are set
		// fix the name of the counter records
	End if 
	// ### bj ### 20190721_2248
	FixWorkOrdersDTtoHR
	
	Version14_DeletezzzRecords
	
	If (False:C215)  // do not force UniqueIDs
		CONFIRM:C162("Force UniqueIDs for version 14.")
		If (OK=1)
			UniqueForce14Convert
		End if 
	End if 
	C_LONGINT:C283($dummyBuild)  //  build CounterPendings to exceed 50
	
	
	
	//  jCounterRev14   // build the CounterPending records
	$doCounters:=True:C214
	
End if 



<>useTransactions:=False:C215  // ### jwm ### 20150911_1649 Test transactions


If (Storage:C1525.version.revDate<!2014-07-11!)
	Convert2TablePopups
End if 

// ### bj ### 20190131_1459
// these must be run after the program is fully running with all the externals in place
// If (False)
// If (Storage.version.revDate<!2019-01-15!)
// CONFIRM("Fix UserReports")
// If (OK=1)
// FixUserReportBlobsToXML 
// FixTableNamesUserReports 
// End if 
// End if 
// End if 

// must be after conversion
Storage:C1525.version.revDate:=$tempRevDate

//  NOTE: MATCH in (P) ServerStartup

ARRAY BOOLEAN:C223(<>ysURpLnLine; 0)
<>vbCarrierRelated:=True:C214  // ### jwm ### 20141006_1133

C_LONGINT:C283(<>viSkipFeature; <>vlHangMilli)
//<>viSkipFeature:=1
<>viSkipFeature:=0  //### jwm ### 20120418 enable NavServer for testing
<>vlHangMilli:=6000  //  (6 seconds )
C_LONGINT:C283(vHere; <>outLayoutTrigger)

<>doOrderLines:=True:C214

// ### jwm ### 20141030_0947 Window Position (center,bottom_right...)
C_TEXT:C284(<>WindowPosition)
C_BOOLEAN:C305(<>WindowToBack)

// Modified by: William James (2013-08-03T00:00:00)
C_LONGINT:C283(<>theProcessList; <>cronDelay; <>windowsize)
// If ((Screen width>1024) & ([Employee]ScreenSizeSmall=False))  // ### jwm ### 20170906_2052
<>windowsize:=1024
FORM SET INPUT:C55([Control:1]; "DeptSales")

<>cronDelay:=60
allowAlerts_boo:=True:C214


//### jwm ### 20120112_0856
//### jwm ### 20120120_1556 set timing idle to 20 seconds client server to 1 minute
//### jwm ### 20130530_1513 timeout values 20,-20,1,1
SET DATABASE PARAMETER:C642(Idle connections timeout:K37:51; 60)  // prevents firewall disconnecting idle new socket connections
//SET DATABASE PARAMETER(Idle connections timeout; -60)  // prevents firewall disconnecting idle existing socket connections
//SET DATABASE PARAMETER(4D Remote mode timeout; 60)  // ### jwm ### 20160226_1015 legacy network set timeout to 5 minutes
SET DATABASE PARAMETER:C642(4D Server timeout:K37:13; 60)  // ### jwm ### 20160226_1015 new network set timeout to 5 minutes)
SET DATABASE PARAMETER:C642(Direct2D status:K37:61; Direct2D disabled:K37:63)  // ### jwm ### 20160425_1305 test to eliminate Windows scaling issue.

C_TEXT:C284(srItemKeyWords)
C_LONGINT:C283(pvRecordNum; <>LoadCustomerRecord; <>viDelayProcessTics)
<>LoadCustomerRecord:=-1
//

C_DATE:C307(vDateCRCompleted)
C_TIME:C306(vTimeCRCompleted)
//
ARRAY TEXT:C222(<>AEMPPREF; Get last table number:C254)
C_BOOLEAN:C305(<>CalcHere; <>WriteHere)

ARRAY TEXT:C222(aTmpText1; 0)
HIDE TOOL BAR:C434
C_TEXT:C284(fExUnExPrice)
C_BOOLEAN:C305(<>allowZip; Is macOS:C1572; $doFirst)
C_REAL:C285(vrLo1; vrLo2; vrLo3; vrLo4; vrLo5; vrLo6; vrLo7)
C_LONGINT:C283($plat; $sys; $mach)
C_LONGINT:C283(<>viDelayPrss)
SET DEFAULT CENTURY:C392(19; 90)
<>viDelayPrss:=45
compiler  //
// Modified by: Bill James (2016-11-02T00:00:00)
ARRAY TEXT:C222(<>aExtensionValue; 0)  // need to keep from initializing in every new process
ARRAY TEXT:C222(<>aContentType; 0)
$doFirst:=True:C214
If (False:C215)  // (Records in table([Control])>0)
	DEFAULT TABLE:C46([Control:1])
	myOK:=1
	FORM SET INPUT:C55([Control:1]; "StartUp")
	ALL RECORDS:C47([Control:1])
	FIRST RECORD:C50([Control:1])
	Pict_InputLo(->[Control:1]; 1; 8)  //get PICT resc 21001
	SET WINDOW TITLE:C213("Automating Sales for Time-Profit-Control")
	DISPLAY RECORD:C105
	$doFirst:=False:C215
End if 
//
READ ONLY:C145([Default:15])
C_OBJECT:C1216(systemInfo)
// ### bj ### 20191004_1102
// excellent machine info, read from object, good example of the use of an object
systemInfo:=Get system info:C1571

vi1:=Num:C11(Is compiled mode:C492)


C_TEXT:C284(vRecDelim)
C_TEXT:C284(vFldDelim)
vFldDelim:=Char:C90(9)
vRecDelim:=Char:C90(13)
C_BOOLEAN:C305(<>doSearchCounter; Is macOS:C1572)
<>doSearchCounter:=True:C214

// move CommerceExpert Folder if needed
If (Application type:C494#4D Server:K5:6)
	// FolderMove
End if 

If (Application type:C494#4D Server:K5:6)
	
	If (Test path name:C476(Storage:C1525.folder.jitF+"jitIndex.txt")<0)
		StructureWrite("NoDialog")
		//myDoc:=create document(Storage.folder.jitF+"jitIndex.txt")
		//If (OK=1)
		//CLOSE DOCUMENT(myDoc)
		//End if 
	End if 
	// <>vlOnCD:=Get_FileLocked (Storage.folder.jitF+"jitIndex.txt")  //check if locked
End if 
//
//
//.compiler //why do we need this second one?????

Licenses

C_TEXT:C284(<>forwin)
C_BOOLEAN:C305(<>CalcHere; <>WriteHere)
//<>WriteHere:=Res_CheckPlugIn ("4D Write")
// ### bj ### 20180911_2005
// gmgmgm do we want to eliminate thise
// <>WriteHere:=Is license available(4D Write license)
//ConsoleMessage ("TEST: <>WriteHere = "+String(Num(<>WriteHere)))
//End if 
//$result:=SW_Register ("bRx-05958-3177";"bAe-23939-9076")

//
//C_TEXT($set1;$set2)
//$set1:="1"
//$set2:="2"
//$result:=NL_Register ($set1;$set2)
//
//ThermoHookOn
//ThermoPrintOn
thermoIcon:=15000
C_LONGINT:C283(SRWindow)  //required to zoom window
C_DATE:C307(SRDate)
//C_LONGINT(SRpage;SRRecord;SRTime)
C_LONGINT:C283(<>UserRunPrcs)
C_BOOLEAN:C305(<>learnMode)
<>UserRunPrcs:=Current process:C322
C_LONGINT:C283($k; $i)
$k:=Records in table:C83([Control:1])
//Case of 
//: ($k=0)
//CREATE RECORD([Control])
//C_DATE(<>tc_ActDate)
//<>tc_ActDate:=Current date
//ControlFill 
//SAVE RECORD([Control])
//UNLOAD RECORD([Control])
//jCenterWindow (318;218;1)
//DIALOG([Control];"diaSignOn")
//CLOSE WINDOW
////: ($k>1000)
////ALL RECORDS
////SUB_SELECTION TO ARRAY(aTmpLong1;
//End case 
//jsetChArrays //must be before new Co records

ARRAY TEXT:C222(<>aPrsName; 0)
ARRAY LONGINT:C221(<>aPrsNum; 0)
ARRAY LONGINT:C221(<>aPrsDTActiv; 0)


If (Records in table:C83([Default:15])=0)
	
	// MustFixQQQZZZ: Bill James (2022-01-13T06:00:00Z)
	//Shift to ORDA json load
	jNewCoSetups  // Initilizing popups 2/26/02
	jNewCoBuildRecs
End if 
Prs_RayRebuild
Prs_InitVarPrcs
Process_InitLocal

// ### bj ### 20210217_0152  
// only the last table. why here????
// ### jwm ### 20171205_1658
// Alphabetically sort Field Names for 4D dialogs
vi2:=Get last table number:C254
For (vi1; 1; vi2)
	If (Is table number valid:C999(vi1))
		ARRAY TEXT:C222(atFieldNames; 0)
		ARRAY LONGINT:C221(aiFieldNumbers; 0)
		GET FIELD TITLES:C804(Table:C252(vi1)->; atFieldNames; aiFieldNumbers)
		SORT ARRAY:C229(atFieldNames; aiFieldNumbers; >)
		SET FIELD TITLES:C602(Table:C252(vi1)->; atFieldNames; aiFieldNumbers; *)
	End if 
End for 

C_LONGINT:C283(<>viPayBatch)
GOTO RECORD:C242([Counter:41]; Table:C252(->[Term:37]))
<>viPayBatch:=[Counter:41]counter:1-1
UNLOAD RECORD:C212([Counter:41])
Essentials

jStartup
ExecuteArrayBuild

C_BOOLEAN:C305(<>vbDefaultQA)
QUERY:C277([QAQuestion:71]; [QAQuestion:71]defaultT:6=True:C214)
<>vbDefaultQA:=(Records in selection:C76([QAQuestion:71])>0)
REDUCE SELECTION:C351([QAQuestion:71]; 0)
vText:=""
pvPage:="xyz"
ScreenSize:="9"
vHere:=0
vItemScale:=0.5

MESSAGES OFF:C175


// RijuQQQ Example
C_OBJECT:C1216($obEmployeeRec)
$obEmployeeRec:=New object:C1471
$obEmployeeRec:=ds:C1482.Employee.query("nameID = :1 "; "Admin")
If ($obRec=Null:C1517)
	$obRec:=ds:C1482.Employee.new()
	$result_o:=$obRec.save()
	$obRec.nameID:="Admin"
	$obRec.emailServerOut:="insertServer"
	$obRec.emailPortOut:=25
	$obRec.emailUserName:="insertValidUserName"
	$obRec.emailPassword:="insertValidPassword"
	$obRec.email:="insertValidEmailAddress"
	$result_o:=$obRec.save()
	$obRemoteUser:=ds:C1482.RemoteUser.query("tableNum = :1 AND customerID = :2"; $obRec.nameID; ds:C1482.Employee.getInfo().tableNumber)
	If ($obRemoteUser=Null:C1517)
		C_OBJECT:C1216($obEmployeeRec)
		// RijuQQQ Replace
		// when we have time we need to replace the 
		QUERY:C277([Employee:19]; [Employee:19]id:72=$obRec.id)
		RemoteUser_Create(Table:C252(ds:C1482.Employee.getInfo().tableNumber); $obRec.nameID; $obRec.zip+(Num:C11($obRec.zip="")*"admin"); 5000)
	End if 
End if 

UNLOAD RECORD:C212([Employee:19])
UNLOAD RECORD:C212([RemoteUser:57])
//
ptCurTable:=(->[Control:1])
jsetDefaultFile(->[Customer:2])
//

C_BOOLEAN:C305($doMySales)
Default_Employee

Dept_Sales

SET WINDOW TITLE:C213(Storage:C1525.default.menuTitle)

MESSAGES ON:C181
//
ReduceSelectAll
If (Not:C34(Storage:C1525.default.disableProcessWindow))
	Process_Running
End if 
BarcodeInitArray

SetAllowedMethods  //###_jwm_Set Quick Report Allowed Methods

If (False:C215)
	//ARRAY POINTER(<>aptSyncTables; 0)
	// build up Sync again
	var $oSel : Object
	$oSel:=ds:C1482.TallyMaster.query("purpose = :1 & name = :2"; "Admin"; "SyncTables")
	// APPEND TO ARRAY(<>aptSyncTables; Table($tableNum))
End if 

EssentialVariableSet

Execute_TallyMaster("Startup"; "Admin")
// ### bj ### 20181120_2130
// lots of path problems using Parallel 4D confuses the OS 
// think there can be many benefits is a script to configure specific machines on startup
Execute_TallyMaster(Current machine:C483; "Current Machine")

// ### jwm ### 20190218_1110 Do Not Run On Server
If (Application type:C494#4D Server:K5:6)
	CronJobStartup
End if 

C_LONGINT:C283(<>mySignal; $found)
<>mySignal:=1

If ($doCounters)  // database conversion to v14
	$found:=0
	Repeat 
		$found:=Prs_CheckRunnin("Counters_@")
	Until ($found<1)
	
	
End if 


