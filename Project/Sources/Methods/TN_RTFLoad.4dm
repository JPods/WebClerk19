//%attributes = {"publishedWeb":true}
//Procedure: TN_RTFLoad
ARRAY TEXT:C222(a1Text; 0)
ARRAY TEXT:C222(aText2; 0)
C_LONGINT:C283($err; $i; $k; $offArea; $CntFold; $incFold)
C_PICTURE:C286($thePict)
C_TEXT:C284($subject; $tempFold; $loadFold)
KeyModifierCurrent
TRACE:C157
$tempFold:=""
$tempFold:=Get_FolderName("Select Group folder.")
If ($tempFold#"")
	$err:=HFS_CatToArray($tempFold; "aText2")
	$CntFold:=Size of array:C274(aText2)
	For ($incFold; 1; $cntFold)
		$subject:=aText2{$incFold}
		$loadFold:=$tempFold+aText2{$incFold}
		$err:=HFS_CatToArray($loadFold; "a1Text")
		$k:=Size of array:C274(a1Text)
		For ($i; 1; $k)
			//$offArea:=  //**WR New offscreen area 
			CREATE RECORD:C68([TechNote:58])
			
			[TechNote:58]Name:2:=a1Text{$i}
			MESSAGE:C88(a1Text{$i})
			[TechNote:58]Subject:6:=$subject
			[TechNote:58]DocReference:8:=$loadFold+a1Text{$i}
			[TechNote:58]DocType:7:="RTF"
			//**WR OPEN DOCUMENT ($offArea;[TechNote]DocReference)
			//*[TechNote]Body_:=  //**WR Area to picture ($offArea)
			[TechNote:58]DatePublished:5:=Current date:C33
			//$err:=//**WR Close document (Ref)
			[TechNote:58]Author:10:="check these"
			SAVE RECORD:C53([TechNote:58])
			//**WR DELETE OFFSCREEN AREA ($offArea)
		End for 
	End for 
End if 
REDRAW WINDOW:C456



//KeyModifierCurrent 
//TRACE
//$tempFold:=GetFolderName ("Select RTF TechNote folder.")
//If (OK=1)
//$subject:=Request("Enter the Subject for these notes.")
//$err:=HFS_CatToArray ($tempFold;"a1Text")
//$k:=Size of array(a1Text)
//For ($i;1;$k)
//$offArea:=//**WR New offscreen area 
//CREATE RECORD([TechNote])
//
//[TechNote]Name:=a1Text{$i}
//[TechNote]Subject:=$subject
//[TechNote]DocReference:=$tempFold+a1Text{$i}
//[TechNote]DocType:="RTF"
////**WR OPEN DOCUMENT ($offArea;[TechNote]DocReference)
////*[TechNote]Body_:=//**WR Area to picture ($offArea)
//[TechNote]DatePublished:=Current date
////$err:=//**WR Close document (Ref)
//[TechNote]Author:="check these"
//SAVE RECORD([TechNote])
////**WR DELETE OFFSCREEN AREA ($offArea)
//End for 
//End if 