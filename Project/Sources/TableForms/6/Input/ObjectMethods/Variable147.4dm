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
$myDocName:=Get_FileName("Locate document"; "")
If ($myDocName#"")
	TRACE:C157
	$p:=Position:C15("jitWeb"; $myDocName)
	If ((CmdKey=0) & ($p>0))
		$myDocName:="<A HREF="+<>vQuote+Substring:C12($myDocName; $p+6)+<>vQuote+" TARGET="+<>vQuote+"_blank"+<>vQuote+">"+HFS_ShortName($myDocName)+"</A>"
		$myDocName:=Replace string:C233($myDocName; <>foldSep; "/")
	Else 
		$myDocName:=<>tcDomain+"/"+$myDocName+<>vQuote+" TARGET="+<>vQuote+"_blank"+<>vQuote+">"+HFS_ShortName($myDocName)+"</A>"
		$myDocName:=Replace string:C233($myDocName; <>foldSep; "/")
		$myDocName:="<A HREF="+<>vQuote+"http://"+$myDocName
	End if 
	SET TEXT TO PASTEBOARD:C523($myDocName)
End if 
