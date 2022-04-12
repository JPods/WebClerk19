//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-06-26T00:00:00, 16:51:43
// ----------------------------------------------------
// Method: Key_BlockSource
// Description
// Modified: 06/26/13
// 
// Only used with Dow Jones for remote Copy right type issues
// Keep may be needed to list blacklist
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1)
C_POINTER:C301($2)
//
TRACE:C157
C_TEXT:C284($thePath)
C_LONGINT:C283($p; $i; $k)
ARRAY TEXT:C222(aBlockSource; 0)
Case of 
	: (Count parameters:C259=2)
		$thePath:=Storage:C1525.folder.jitPrefPath+$1
		$k:=Size of array:C274($2->)
		ARRAY TEXT:C222(aBlockSource; $k)
		For ($i; 1; $k)
			aBlockSource{$i}:=$2->{$i}
		End for 
	: (Count parameters:C259=1)
		$thePath:=Storage:C1525.folder.jitPrefPath+$1
	Else   //(Count parameters=1)
		$thePath:=Storage:C1525.folder.jitPrefPath+"SuppressSource.txt"
End case 
//
If (HFS_Exists($thePath)=1)
	C_TEXT:C284($badword)
	myDoc:=Open document:C264($thePath)
	If (OK=1)
		C_TEXT:C284($endLine)
		$endLine:="\r"
		Repeat 
			RECEIVE PACKET:C104(myDoc; $badword; $endLine)
			If (OK=1)
				$badword:=TxtStripLineFeed($badword)
				$p:=Position:C15(Char:C90(64); $badword)
				If ($p>0)
					$badword:=Substring:C12($badword; $p+1; Length:C16($badword)-$p-1)
				End if 
				$p:=Find in array:C230(aBlockSource; $badword)
				If ($p=-1)
					INSERT IN ARRAY:C227(aBlockSource; 1; 1)
					aBlockSource{1}:=$badword
				End if 
			End if 
		Until (OK=0)
		CLOSE DOCUMENT:C267(myDoc)
	End if 
End if 