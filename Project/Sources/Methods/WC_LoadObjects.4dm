//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/04/11, 14:25:25
// ----------------------------------------------------
// Method: WC_LoadObjects
// Description
// 
//
// Parameters
// ----------------------------------------------------

READ ONLY:C145([WebClerk:78])


//TRACE
C_TEXT:C284($myObjectFolder; $myText)
C_LONGINT:C283($error; $i; $k; $w)

ARRAY TEXT:C222(<>aWebObjectName; 0)
ARRAY TEXT:C222(<>aWebObjectValue; 0)

// ### bj ### 20210822_1434  QQQZZZ Harvest then delete
If (False:C215)
	
	$myObjectFolder:=<>WebFolder+"jitObjects"+Folder separator:K24:12
	vResponse:="No jitObjects found"
	QUERY:C277([WebClerkDevice:150]; [WebClerkDevice:150]active:7=True:C214; *)
	QUERY:C277([WebClerkDevice:150];  & [WebClerkDevice:150]purpose:2="Object")
	
	SELECTION TO ARRAY:C260([WebClerkDevice:150]name:4; <>aWebObjectName; [WebClerkDevice:150]value:5; <>aWebObjectValue)
	REDUCE SELECTION:C351([WebClerkDevice:150]; 0)
	
	
	//TRACE
	C_TEXT:C284($myObjectFolder; $myText)
	C_LONGINT:C283($error; $i; $k; $w; $fia)
	$myObjectFolder:=<>WebFolder+"jitObjects"+Folder separator:K24:12
	vResponse:="No jitObjects found"
	If (HFS_Exists($myObjectFolder)=1)
		ARRAY TEXT:C222(aText1; 0)
		vResponse:="jitObjects reloaded"
		$error:=HFS_CatToArray($myObjectFolder; "aText1"; Absolute path:K24:14+Ignore invisible:K24:16+Recursive parsing:K24:13)
		$k:=Size of array:C274(aText1)
		For ($i; 1; $k)
			Case of 
				: (Length:C16(aText1{$i})=0)  // Modified by: williamjames (111216 checked for <= length protection)
				: ((": "=aText1{$i}[[Length:C16(aText1{$i})]]) | ("<<"=aText1{$i}[[Length:C16(aText1{$i})]]))
					//drop out
				: (aText1{$i}[[1]]=".")
					//drop out
				Else 
					// myDoc:=Open document($myObjectFolder+aText1{$i})
					myDoc:=Open document:C264(aText1{$i}; Read mode:K24:5)  // ### jwm ### 20150917_1122 absolute path
					If (OK=1)
						<>vEoF:=Get document size:C479(document)+1  // ### jwm ### 20160714_1147 is plus 1 needed ?
						RECEIVE PACKET:C104(myDoc; $myText; <>vEoF)
						If (OK=1)
							C_LONGINT:C283($lenmyText)
							$lenmyText:=Length:C16($myText)
							If (Character code:C91($myText[[$lenmyText]])=13)
								$myText:=Substring:C12($myText; 1; $lenmyText-1)
							End if 
							If (Find in array:C230(<>aWebObjectName; aText1{$i})<1)
								APPEND TO ARRAY:C911(<>aWebObjectValue; $myText)
								APPEND TO ARRAY:C911(<>aWebObjectName; aText1{$i})
								If (<>viDebugMode>410)
									ConsoleMessage("ObjectName:\t"+aText1{$i})
									ConsoleMessage("ObjectVAlue:\t"+$myText)
								End if 
							End if 
						End if 
						CLOSE DOCUMENT:C267(myDoc)  // ### jwm ### 20160714_1145 moved outside of if statement always close document after opening
					End if 
			End case 
		End for 
		ARRAY TEXT:C222(aText1; 0)
	End if 
End if 