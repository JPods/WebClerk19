C_LONGINT:C283($myOK; $p)
C_TEXT:C284($theDoc; $myDocName)
KeyModifierCurrent
Case of 
	: (OptKey=1)
		Path_Set(<>WebFolder+"jitimages"+<>foldSep+"movies"+<>foldSep)
	: (ShftKey=1)
		Path_Set(<>WebFolder+"jitimages"+<>foldSep)
	Else 
		Path_Set(<>WebFolder)
End case 
TRACE:C157
$myDocName:=Get_FileName("Locate document"; "")
If ($myDocName#"")
	$p:=Position:C15("jitWeb"; $myDocName)
	If ($p>0)
		$myDocName:=Replace string:C233($myDocName; <>foldSep; "/")
		If (CmdKey=1)
			$myDocName:="<A HREF="+<>vQuote+"http://"+<>tcDomain+"/"+Substring:C12($myDocName; $p)+<>vQuote+" TARGET="+<>vQuote+"_blank"+<>vQuote+">"+HFS_ShortName($myDocName)+"</A>"
		Else 
			$theDoc:=Substring:C12($myDocName; $p+6)
			$myDocName:="<A HREF="+<>vQuote+$theDoc+<>vQuote+" TARGET="+<>vQuote+"_blank"+<>vQuote+">"+$theDoc+"</A>"
		End if 
	End if 
	SET TEXT TO PASTEBOARD:C523($myDocName)
End if 