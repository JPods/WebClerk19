//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/13/18, 21:19:01
// ----------------------------------------------------
// Method: Txt_4D2Doc
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1; $docText; $field; $creator; $suff; $docName; $originalDocName)
C_LONGINT:C283($p; $file; $cntPara)
C_TEXT:C284($myText; $builtText)
C_BOOLEAN:C305($doLaunch; $3; $4; $doRecord; $5; $doClip)
C_TIME:C306($myDoc)
$doLaunch:=True:C214
$doRecord:=False:C215
$doClip:=False:C215
$cntPara:=Count parameters:C259
If ($cntPara>2)
	$doLaunch:=$3
	If ($cntPara>3)
		$doRecord:=$4
		If ($cntPara>4)
			$doClip:=$5
		End if 
	End if 
End if 
If ((vUseBase<2) | (vUseBase>5))  //for safety
	vUseBase:=2
End if 
$myText:=""
$docName:=""
$myPath:=""

If (Count parameters:C259=0)
	myDocName:=""
	$myOK:=EI_OpenDoc(->myDocName; ->myDoc; "Open File to Post Through"; ""; Storage:C1525.folder.jitExportsF)  //;jitQRsF
	
Else 
	myDocName:=$1
	myDoc:=Open document:C264(myDocName)
	$myOK:=OK
	If ((Count parameters:C259>1) & (OK=1))
		$docName:=$2
	End if 
End if 

If ($myOK=1)
	// ### bj ### 20181113_1943
	<>vEoF:=Get document size:C479(document)+1  // ### jwm ### 20160714_1147 is plus 1 needed ?
	RECEIVE PACKET:C104(myDoc; $docText; <>vEoF)
	CLOSE DOCUMENT:C267(myDoc)
	If (OK=1)
		C_TEXT:C284($myFolder)
		$originalDocName:=HFS_ShortName(myDocName)
		// set path to applied document
		$myPath:=pathUsingTable(ptCurTable; $originalDocName; True:C214)
		
		//P_FillVars(ptCurTable)  // fill out standard variable
		
		SET BLOB SIZE:C606(blobPageOut; 0)
		$docText:=TagsToText($docText)
		
		If (<>viDebugMode>410)  //added to accumulate shopping cart
			theText:=$docText
			ConsoleLog(theText)
		End if 
		$myDoc:=Create document:C266($myPath)
		SEND PACKET:C103($myDoc; $docText)
		CLOSE DOCUMENT:C267($myDoc)
		AE_LaunchDoc(document)
	End if 
End if 

