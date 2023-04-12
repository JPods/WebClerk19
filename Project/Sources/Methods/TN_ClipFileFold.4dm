//%attributes = {"publishedWeb":true}


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/24/18, 18:55:36
// ----------------------------------------------------
// Method: TN_ClipFileFold
// Description
// 
//
// Parameters
// ----------------------------------------------------


//    gsgsgsgs
// funky old needs updating

C_LONGINT:C283($err; $i; $k; $1; $doHtml)
C_TEXT:C284($fileFold; $theSite; $thePath; $2)
ARRAY TEXT:C222(aText1; 0)
If (Count parameters:C259>0)
	$doHtml:=$1
	If (Count parameters:C259>1)
		$thePath:=PathToSystem($2)
	End if 
Else 
	$doHtml:=0
End if 
vText1:=""
KeyModifierCurrent
If ((OptKey=1) | (CmdKey=1))
	If ($thePath="")
		$fileFold:=Get_FolderName("Select folder to List Files.")
	Else 
		$fileFold:=$thePath
	End if 
	FOLDER LIST:C473($fileFold; aText1)
	$k:=Size of array:C274(aText1)
	For ($i; 1; $k)
		vText1:=vText1+aText1{$i}+"\r"
	End for 
	SET TEXT TO PASTEBOARD:C523(vText1)
Else 
	
	If ($thePath="")
		$fileFold:=Get_FolderName("Select folder to List Files.")
	Else 
		$fileFold:=$thePath
	End if 
	If ($fileFold#"")
		$error:=HFS_CatToArray($fileFold; "aText1")
		vText1:=vText1+"List of Files & Folders in "+$fileFold+"\r"+"\r"
		If ($doHtml=1)
			$theSite:=HFS_ShortName($fileFold)
			$theSite:=Storage:C1525.default.domain+"/"+Substring:C12($theSite; 1; Length:C16($theSite)-1)
			vText1:=vText1+"<BR><TABLE><TR><TD>Page</TD><TD>Explanation</TD></TR>"+"\r"
		End if 
		$k:=Size of array:C274(aText1)
		//TRACE
		For ($i; 1; $k)
			If ($doHtml=0)
				If ((":"=aText1{$i}[[Length:C16(aText1{$i})]]) | ("\\"=aText1{$i}[[Length:C16(aText1{$i})]]))
					vText1:=vText1+"Folder<--"+$fileFold+aText1{$i}+"-->"+"\r"+"\t"+"Explanation:  "+"\r"+"\r"
				Else 
					vText1:=vText1+"LaunchThis<--"+$fileFold+aText1{$i}+"-->"+"\r"+"\t"+"Explanation:  "+"\r"+"\r"
				End if 
			Else 
				//$p:=Position(".html";aText1{$i})
				//If ($p>0)
				vText1:=vText1+"<TR><TD><A HREF="+Char:C90(34)+$theSite+"/"+aText1{$i}+Char:C90(34)+">"+aText1{$i}+"</A></TD><TD></TD></TR>"+"\r"
				//End if 
			End if 
		End for 
		If ($doHtml=1)
			$theSite:=Storage:C1525.default.domain+$theSite+HFS_ShortName($fileFold)
			vText1:=vText1+"</TABLE>"
		End if 
		
		ConsoleLog(vText1)
	End if 
	
	INSERT IN ARRAY:C227(aText1; 1; 1)
	aText1{1}:=$fileFold
End if 
