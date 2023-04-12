//%attributes = {"publishedWeb":true}
//PProcedure: App_SetSuffix(old;new;specific document)
If (False:C215)
	//Method: App_SetSuffix
	//Date: 07/01/02
	//Who: Bill
	//Description: Add a correct suffix/creator
	//Make sure the '.' is added
	
	//zzz the procedures that call this should be cleaned up with 
	
	C_TIME:C306($myDoc)
	C_TEXT:C284($path)
	$myDoc:=CreateDocumentXPlatform($path)
End if 


C_TEXT:C284($1; $2; $3)
C_LONGINT:C283($err; $i; $k; $len; $p)
C_BOOLEAN:C305($doThis; $doCnt)
C_TEXT:C284($myCreator; $oldCreator)
C_TEXT:C284($mySuffix; $tempFold)
ARRAY TEXT:C222(aText1; 0)
$doThis:=False:C215
$doCnt:=True:C214
//TRACE
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
	: (Count parameters:C259=4)
		$oldCreator:=$1
		$myCreator:=$2
		$err:=HFS_CatToArray($4; "aText1")
		$doSubFolders:="Sub"
		$doThis:=True:C214
		$tempFold:=$4
	: (Count parameters:C259=3)
		$tempFold:=Storage:C1525.wc.webFolder
		$doThis:=True:C214
		$oldCreator:=$1
		$myCreator:=$2
		$doCnt:=False:C215
		ARRAY TEXT:C222(aText1; 1)
		aText1{1}:=$3
	: (Count parameters:C259=1)
		$tempFold:=HFS_ShortName(document)
		$theLen:=TXT_PositionLast($tempFold; ".")  //
		//
		If (($theLen>0) & ($theLen<Length:C16($tempFold)))
			$oldCreator:=Substring:C12($tempFold; $theLen+1)  //clip the doc.type
			If ($oldCreator#$1)  //if they are the same leave it alone
				$tempFold:=Substring:C12($tempFold; 1; $theLen-1)  //clip suffix/double suffix from the document
				$theLen:=Position:C15("."; $1)  //clip the . if there is one from new suffix
				If ($theLen>0)
					$1:=Substring:C12($1; $theLen+1)
				End if 
				If ($1="")
					$1:="txt"
				End if 
				$tempFold:=$tempFold+"."+$1
				$err:=HFS_Rename(document; $tempFold)
			End if 
		Else 
			$tempFold:=$tempFold+"."+$1
			$err:=HFS_Rename(document; $tempFold)
		End if 
		$doThis:=False:C215
		
	: (Count parameters:C259=2)
		$tempFold:=Storage:C1525.wc.webFolder
		$doThis:=True:C214
		$oldCreator:=$1
		$myCreator:=$2
		$doCnt:=False:C215
		$err:=HFS_CatToArray($tempFold; "aText1")
End case 
//TRACE
If ($doThis)
	$theLen:=Length:C16($oldCreator)
	COPY ARRAY:C226(aText1; $aListFiles)
	$k:=Size of array:C274($aListFiles)
	For ($i; 1; $k)
		//If ($doCnt)
		//MESSAGE(String($i)+" of "+String($k))
		//End if 
		Case of 
			: ($aListFiles{$i}="")  // Modified by: williamjames (111216 checked for <= length protection)
				TRACE:C157
			: (($aListFiles{$i}[[Length:C16($aListFiles{$i})]]=Folder separator:K24:12) & ($doSubFolders#""))
				//$oldCreator:=$1
				//$myCreator:=$2
				//$doSubFolders:=$3
				//$tempFold:=$4
				//App_SetSuffix ($oldCreator;$myCreator;$doSubFolders;$tempFold+$aListFiles{$i})
			: ($theLen=0)
				$err:=HFS_Rename($tempFold+$aListFiles{$i}; $aListFiles{$i}+$myCreator)
			: (Position:C15($oldCreator; $aListFiles{$i})>0)
				$newName:=Replace string:C233($aListFiles{$i}; $oldCreator; $myCreator)
				$err:=HFS_Rename($tempFold+$aListFiles{$i}; $newName)
				document:=$aListFiles{$i}
		End case 
	End for 
End if 

REDRAW WINDOW:C456

//vText1:=GetFolderName ("Select folder for setting suffix.")
//If (vText1#"")
//vi4:=1000
//vi8:=HFS_CatToArray (vText1;"$aListFiles")
//vi2:=Size of array($aListFiles)
//For (vi1;1;vi2)
//MESSAGE(String(vi1))
//vi4:=vi4+1
//vi8:=HFS_Rename (vText1+$aListFiles{vi1};String(vi4)+".gif")
//End for 
//End if //
//
//
//
//
