//%attributes = {"publishedWeb":true}
C_LONGINT:C283($indexFile; $cntFile; $cntFld; $indexFld)
C_TEXT:C284($textResult)

C_LONGINT:C283($typeFld; $lenField; $numFld; $k)
C_BOOLEAN:C305($indexed)

C_LONGINT:C283($indexFile; $cntFile; $cntFld; $indexFld)
C_TEXT:C284($textResult)

C_LONGINT:C283($typeFld; $lenField; $numFld; $k)
C_BOOLEAN:C305($indexed)
ARRAY LONGINT:C221($aFileNums; 0)
TRACE:C157
$cntFile:=Get last table number:C254
For ($indexFile; 1; $cntFile)
	KeyModifierCurrent
	$textResult:=Request:C163(Table name:C256($indexFile)+" "+String:C10($indexFile)+" Cancel Clears Indexes"; "Cancel")
	If (OptKey=1)
		$indexFile:=$cntFile
	End if 
	If (OK=0)
		INSERT IN ARRAY:C227($aFileNums; 1; 1)
		$aFileNums{1}:=$indexFile
	End if 
End for 
$cntFile:=Size of array:C274($aFileNums)
For ($indexFile; 1; $cntFile)
	MESSAGE:C88(String:C10($indexFile)+" of "+String:C10($cntFile))
	READ WRITE:C146(Table:C252($aFileNums{$indexFile})->)
	ALL RECORDS:C47(Table:C252($aFileNums{$indexFile})->)
	DELETE SELECTION:C66(Table:C252($aFileNums{$indexFile})->)
End for 

REDRAW WINDOW:C456