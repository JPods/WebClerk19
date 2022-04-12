//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-11-30T00:00:00, 17:47:23
// ----------------------------------------------------
// Method: BootStrapConvert
// Description
// Modified: 11/30/17
// Structure: CE11zx_01
// 
//
// Parameters
// ----------------------------------------------------

If (False:C215)
	//Method: HTML_CheckSiteVars
	//Date: 07/01/02
	//Who: Bill
	//Description: Build to check all the web variables in a site at once.
	//check meta tags, security and jitReason
	//check variables
End if 

C_TEXT:C284($1; $theSelect; $theFieldStr; $pageOut; $docName; $theFileStr; $pendHold; $selectList; $holdSelect)
C_LONGINT:C283($pBeg; $p; $pEnd; $pLine; $pSize; $theFile; $theField; $pRef; $pEndRef; $rayLine)
C_TEXT:C284($strFile; $strField; $quoteChar)
$quoteChar:=Char:C90(34)
If (Is macOS:C1572)
	$lineBreak:=Char:C90(13)
Else 
	$lineBreak:=Char:C90(13)+Char:C90(10)
End if 

C_LONGINT:C283($k; $i; $incRay; $cntRay)
Tx_ListIn(Storage:C1525.folder.jitPrefPath+"P_WebVariables.txt")
$k:=0
ARRAY TEXT:C222(aText1; 0)
$tempFold:=""
$tempFold:=Get_FolderName("Select folder for checking web variables.")
If ($tempFold#"")
	TRACE:C157
	$err:=HFS_CatToArray($tempFold; "aText9")
	myDocName:="jitTagListing.txt"
	$myOK:=EI_CreateDoc(->myDocName; ->SumDoc; "Create Report Doc")
	If ($myOK=1)
		$k:=Size of array:C274(aText9)
		//ThermoInitExit ("Check Variables "+String($k)+" pages";$k;True)
		$viProgressID:=Progress New
		
		For ($i; 1; $k)
			
			//Thermo_Update ($i)
			ProgressUpdate($viProgressID; $i; $k; "Check Variables ")
			
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
							HTML_TagCheckPage($pageIn)
							$cntRay:=Size of array:C274(aTagName)
							SEND PACKET:C103(sumDoc; "\r"+"\r"+"//////////"+"\r"+$tempFold+aText9{$i}+"\r")
							For ($incRay; 1; $cntRay)
								SEND PACKET:C103(sumDoc; "\t"+aTagName{$incRay}+"\t"+aTagValue{$incRay}+"\r")
							End for 
						End if 
					End if 
				End if 
			End if 
		End for 
		CLOSE DOCUMENT:C267(sumDoc)
		//Thermo_Close 
		Progress QUIT($viProgressID)
		
	End if 
End if 

vi2:=Get last table number:C254
For (vi1; 1; vi2)
	ARRAY TEXT:C222(atFieldNames; 0)
	ARRAY LONGINT:C221(aiFieldNumbers; 0)
	
	GET FIELD TITLES:C804(Table:C252(vi1)->; atFieldNames; aiFieldNumbers)
	SORT ARRAY:C229(atFieldNames; aiFieldNumbers; >)
	SET FIELD TITLES:C602(Table:C252(vi1)->; atFieldNames; aiFieldNumbers; *)
	
End for 



