//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-09-03T00:00:00, 13:06:00
// ----------------------------------------------------
// Method: HTMLCleaner
// Description
// Modified: 09/03/17
// 
//
// Parameters
// ----------------------------------------------------



C_TEXT:C284($1; $2; $3)
C_LONGINT:C283($err; $i; $k; $len; $p)
C_BOOLEAN:C305($doThis; $doCnt)
C_TEXT:C284($myCreator; $oldCreator)
C_TEXT:C284($mySuffix; $tempFold)
ARRAY TEXT:C222(aText1; 0)
$doThis:=False:C215
$doCnt:=True:C214
$doSubFolders:="Subs"  //make this a choice at some time
Case of 
	: (Count parameters:C259=0)
		KeyModifierCurrent
		$tempFold:=""
		$tempFold:=Get_FolderName("Select folder for setting suffix.")
		If ($tempFold#"")
			$err:=HFS_CatToArray($tempFold; "aText1")
			$oldCreator:=Request:C163("Replace Suffix"; "")  //.html.txt  
			If (OK=1)
				$myCreator:=Request:C163("Add Suffix"; ".html")  //.html
				If (OK=1)
					$doThis:=True:C214
				End if 
			End if 
		End if 
	: (Count parameters:C259=1)
		$tempFold:=Storage:C1525.wc.webFolder
		$doThis:=True:C214
		$err:=HFS_CatToArray($tempFold; "aText1")
End case 
//TRACE
If ($doThis)
	$k:=Size of array:C274(aText9)
	//ThermoInitExit ("Check Variables "+String($k)+" pages";$k;True)
	$viProgressID:=Progress New
	
	For ($i; 1; $k)
		//Thermo_Update ($i)
		ProgressUpdate($viProgressID; $i; $k; "Check Variables: ")
		If (<>ThermoAbort)
			$i:=$k
		End if 
		$testEnd:=Substring:C12(aText9{$i}; Length:C16(aText9{$i})-5)
		If (($testEnd="@htm@") | ($testEnd="@inc@") | ($testEnd="@txt@"))
			If (HFS_Exists($tempFold+aText9{$i})=1)
				myDoc:=Open document:C264($tempFold+aText9{$i})
				If (OK=1)
					<>vEoF:=Get document size:C479(document)+1  // ### jwm ### 20160714_1147 is plus 1 needed ?
					RECEIVE PACKET:C104(myDoc; $pageIn; <>vEoF)
					If (OK=1)
						CLOSE DOCUMENT:C267(myDoc)
						$err:=HFS_Delete(document)
						
						
						C_LONGINT:C283($i; $k; $charCnt; $charInc; $charASCII)
						
						$charCnt:=Length:C16($pageIn)
						$pageOut:=""
						For ($charInc; 1; $charCnt)
							$charASCII:=Character code:C91($pageIn[[$charInc]])
							If (($charASCII=13) | (($charASCII>31) & ($charASCII<127)))
								$pageOut:=$pageOut+$pageIn[[$charInc]]
							Else 
								$pageOut:=$pageOut+"_e_"+String:C10(Character code:C91($pageIn[[$charInc]]))+"_"
							End if 
						End for 
						$testText:=""
						
						myDoc:=Create document:C266(document)
						SEND PACKET:C103(myDoc; $pageOut)
						CLOSE DOCUMENT:C267(myDoc)
						App_SetSuffix(".html.txt"; ".html")
						
					End if 
				End if 
			End if 
		End if 
	End for 
	//Thermo_Close 
	Progress QUIT($viProgressID)
End if 