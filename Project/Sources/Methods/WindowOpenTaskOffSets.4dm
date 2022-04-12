//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-08-02T00:00:00, 05:27:51
// ----------------------------------------------------
// Method: WindowOpenTaskOffSets
// Description
// Modified: 08/02/13
// 
// 
//
// Parameters
// ----------------------------------------------------

// var $obWindows : Object
// $obWindows:=WindowCountToShow


// create means of redirecting the appropriate input layout everywhere this WindowOpenTaskOffSets is called about 47 places
// DB_ShowCurrentSelection ($ptUseTable;"";3;"";1)
// Process_AddRecord ($tableName)
// Prs_ShowSelection   
//  ### jwm ### 20131210_1107 addwidth 125 to TallyMasers
// QQQ???? finally have WindowCascade working properly. Look at this


// MustFixQQQZZZ: Bill James (2021-12-14T06:00:00Z)
// get rid of most places this is called 
// replace this with 



C_LONGINT:C283($horzOff; $vertOff; +$addWidth; $addHeight; $viWinRef)
C_TEXT:C284($vtFormName)
//TRACE
C_LONGINT:C283($cntTasks)
C_LONGINT:C283($1; $locationFlag; $2; $addWidth; $3; $addHeight)
C_LONGINT:C283($viLeftOffSet; $viTopOffSet)
C_LONGINT:C283($skipGeneralWindowSize; vHere)
$skipGeneralWindowSize:=0
$locationFlag:=0
$addWidth:=0
$addHeight:=0
$vtFormName:=""
If (Count parameters:C259>0)
	$locationFlag:=$1
	
	If (Count parameters:C259>1)
		$addWidth:=$2
		If (Count parameters:C259>2)
			$addHeight:=$3
			If (Count parameters:C259=5)  //  override to declare window width and height
				$skipGeneralWindowSize:=2
				If ($4=0)
					$addWidth:=1
				Else 
					$addWidth:=$4
				End if 
				If ($5=0)
					$addHeight:=1
				Else 
					$addHeight:=$5
				End if 
			End if 
		End if 
	End if 
End if 
$viLeftOffSet:=5
$viTopOffSet:=45
If (<>vWindowHeight<572)
	<>vWindowHeight:=572
End if 
If (<>vWindowWidth<762)
	<>vWindowWidth:=762
End if 

ARRAY TEXT:C222($aNames; 0)
COPY ARRAY:C226(<>aPrsName; $aNames)
$k:=Size of array:C274($aNames)
For ($i; $k; 1; -1)
	If (($aNames{$i}="ht@") | ($aNames{$i}="Log") | ($aNames{$i}="Main") | ($aNames{$i}="Processes"))
		DELETE FROM ARRAY:C228($aNames; $i; 1)
	End if 
End for 
//TRACE
$cntTasks:=Size of array:C274($aNames)
C_LONGINT:C283($curProcess; $fiAProNum)

$prsNum:=Current process:C322
C_LONGINT:C283($tasks; $prsNum; $state; $tics)
C_TEXT:C284($name; $tableName)
C_POINTER:C301(ptCurTable)
PROCESS PROPERTIES:C336($prsNum; $name; $state; $tics)

If (Is nil pointer:C315(ptCurTable))
	$tableName:="-"
Else 
	$tableName:=Table name:C256(ptCurTable)
End if 

Case of 
	: ($name="Sales Dept")
		$vertOff:=0
		$horzOff:=0
		$vtFormName:="DeptSales"
		ptCurTable:=->[Control:1]
	: ($name="ApplyPayments")
		// add something here to override size
		$vtFormName:="ApplyPayment"
		ptCurTable:=->[Control:1]
	: ($cntTasks>0)
		//$cntTasks:=$cntTasks-1
		$vertOff:=(20*$cntTasks)
		$horzOff:=(10*$cntTasks)
	Else 
		$vertOff:=0
		$horzOff:=0
End case 
C_LONGINT:C283($viWidth; $viHeight)

Case of 
		//: (ptCurTable=(->[UserReports]))
		// TEST CHANGING THE NAME TO INPUT
		// ### jwm ### 20190221_2203Changed name of input form to "Input"
	: (False:C215)  // ### jwm ### 20190221_2200
		
		If ((Screen height:C188>800) & (Screen width:C187>1000))  //&(Current user="jitCorp"))
			//Open window(4;40;Screen width-100;Screen height-80;8;"UserReports";"jCancelButton")
			// ### jwm ### 20161116_1722 window was too large for 4D v14 on Windows
			$addWidth:=600
			$addHeight:=100
			Open window:C153(4+$horzOff; 50+$vertOff; 1024+$horzOff+$addWidth; 750+$vertOff+$addHeight; 8; ""; "jCancelButton")
			FORM SET INPUT:C55([UserReport:46]; "iUserReportDesign")
			$skipGeneralWindowSize:=1
		End if 
		
	: (ptCurTable=(->[TechNote:58]))
		Open window:C153(4; 40; 1332+40; 888+80; 8; "TechNotes"; "jCancelButton")
		$skipGeneralWindowSize:=1
	: (ptCurTable=(->[Control:1]))
		//  Expand this to set various layout sizes for the various Control layouts
		// if needed
		// ### jwm ### 20181210_1401 use open Form Window to save geometry
	: ($tableName="-")
		C_LONGINT:C283($windowsize; <>ignorInputLayout)
		
	Else 
		
		Case of 
			: (Records in selection:C76(ptcurTable->)=1)
				$vtFormName:="Input"  // ### jwm ### 20190625_1538 changed logic to open input when = 1
				
			: ($locationFlag=-3)  // -3 = new record
				$vtFormName:="Input"
				
			Else 
				$vtFormName:="Output"
		End case 
		
		
		
		C_LONGINT:C283($windowsize; <>ignorInputLayout)
End case 
Case of 
	: ($skipGeneralWindowSize=2)
		If (Is macOS:C1572)
			Open window:C153(4+$horzOff; 50+$vertOff; 1024+$horzOff+$addWidth; 758+$vertOff+$addHeight; 8; ""; "jCancelButton")
			// Open window(4+$horzOff;50+$vertOff;1000+$horzOff+$addWidth;700+$vertOff+$addHeight;8;"";"jCancelButton")
		Else 
			Open window:C153(4+$horzOff; 50+$vertOff; 1024+$horzOff+$addWidth; 750+$vertOff+$addHeight; 8; ""; "jCancelButton")
		End if 
	: ($skipGeneralWindowSize=1)
		
	: (True:C214)  // <>windowsize=1024)
		C_LONGINT:C283($heightRisk)
		If (Is macOS:C1572)
			$heightRisk:=758
		Else 
			$heightRisk:=750
		End if 
		// ### bj ### 20190128_1437
		// is accomplished in once the form in open 
		// OLO_HereAndMenu
		If ($vtFormName#"")
			
			
			$viWinRef:=Open form window:C675(ptCurTable->; $vtFormName; Plain form window:K39:10; *)  // ### jwm ### 20181210_1401 use open Form Window to save geometry
			WindowWithinScreen($viWinRef; $horzOff; $vertOff)
		Else 
			//Open window ( left ; top ; right ; bottom {; type {; title {; controlMenuBox}}} ) -> Function resul
			Open window:C153(4+$horzOff; 50+$vertOff; 1024+$horzOff+$addWidth; $heightRisk+$vertOff+$addHeight; 8; ""; "jCancelButton")
		End if 
	: ($name="Sales Dept")
		Open window:C153(4+$horzOff; 50+$vertOff; <>vWindowWidth+$horzOff+$addWidth; <>vWindowHeight+$vertOff+$addHeight; 8)
	: ($locationFlag=0)
		$viWidth:=<>vWindowWidth+$addWidth
		$viHeight:=<>vWindowHeight+$addHeight
		Open window:C153(4+$horzOff; 50+$vertOff; <>vWindowWidth+$horzOff+$addWidth; <>vWindowHeight+$vertOff+$addHeight; 8; ""; "jCancelButton")
	Else 
		Open window:C153(Screen width:C187-<>vWindowWidth-4-$horzOff; 40+$vertOff; Screen width:C187-$horzOff+$addWidth; <>vWindowHeight+$vertOff+$addHeight; 8; ""; "jCancelButton")
End case 

If (ptCurTable#(->[TallyMaster:60]))
	// ### jwm ### 20170821_2015 Enable this in FDI Copy QQQ
	Execute_TallyMaster("CenterWindow"; "Scripts")  // ### jwm ### 20160831_1100
End if 