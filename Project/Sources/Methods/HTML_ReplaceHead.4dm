//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 04/16/07, 10:59:48
// ----------------------------------------------------
// Method: Method: HTML_ReplaceHead
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $theSelect; $theFieldStr; $pageOut; $docName; $theFileStr; $pendHold; $selectList; $holdSelect)
C_LONGINT:C283($pBeg; $p; $pEnd; $pLine; $pSize; $theFile; $theField; $pRef; $pEndRef; $rayLine)
C_TEXT:C284($strFile; $strField; $quoteChar)
$quoteChar:=Char:C90(34)
If (Is macOS:C1572)
	$lineBreak:=Char:C90(13)
Else 
	$lineBreak:=Char:C90(13)+Char:C90(10)
End if 
$clipText:=Get text from pasteboard:C524
C_LONGINT:C283($k; $i; $incRay; $cntRay)
$k:=0
ARRAY TEXT:C222(aText1; 0)
$tempFold:=""
$tempFold:=Get_FolderName("Select folder for changing head.")
If ($tempFold#"")
	TRACE:C157
	$err:=HFS_CatToArray($tempFold; "aText9")
	If ($err=0)
		$k:=Size of array:C274(aText9)
		//ThermoInitExit ("Changing Header "+String($k)+" pages";$k;True)
		$viProgressID:=Progress New
		
		For ($i; 1; $k)
			
			//Thermo_Update ($i)
			ProgressUpdate($viProgressID; $i; $k; "Changing Headers")
			If (<>ThermoAbort)
				$i:=$k
			End if 
			
			
			$testEnd:=Substring:C12(aText9{$i}; Length:C16(aText9{$i})-5)
			If ($testEnd="@htm@")
				If (HFS_Exists($tempFold+aText9{$i})=1)
					myDoc:=Open document:C264($tempFold+aText9{$i})
					If (OK=1)
						<>vEoF:=Get document size:C479(document)+1  // ### jwm ### 20160714_1147 is plus 1 needed ?
						RECEIVE PACKET:C104(myDoc; $pageIn; <>vEoF)
						If (OK=1)
							CLOSE DOCUMENT:C267(myDoc)
							
							$w:=Position:C15("<body"; $pageIn)
							If ($w>0)
								$pageIn:=Substring:C12($pageIn; $w+4)
								$w:=Position:C15(">"; $pageIn)
								If ($w>0)
									$pageIn:=Substring:C12($pageIn; $w+1)
									
									$pageIn:=$clipText+"\r"+"\r"+$pageIn
									$w:=HFS_Delete($tempFold+aText9{$i})
									sumDoc:=Create document:C266($tempFold+aText9{$i})
									SEND PACKET:C103(sumDoc; $pageIn)
									CLOSE DOCUMENT:C267(sumDoc)
								End if 
							End if 
						End if 
					End if 
					CLOSE DOCUMENT:C267(sumDoc)
					//Thermo_Close 
					Progress QUIT($viProgressID)
				End if 
			End if 
		End for 
	End if 
End if 