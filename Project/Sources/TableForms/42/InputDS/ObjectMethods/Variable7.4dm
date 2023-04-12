C_LONGINT:C283($myOK; $p)
C_TEXT:C284($theDoc; $myDocName)
KeyModifierCurrent
Case of 
	: (OptKey=1)
		Path_Set(Storage:C1525.wc.webFolder+"jitimages"+<>foldSep+"movies"+<>foldSep)
	: (OptKey=1)
		Path_Set(Storage:C1525.wc.webFolder+"jitimages"+<>foldSep)
	Else 
		Path_Set(Storage:C1525.wc.webFolder)
End case 
$myDocName:=Get_FileName("Locate document"; "")
If ($myDocName#"")
	$p:=Position:C15("jitWeb"; $myDocName)
	If ($p>0)
		$myDocName:="<A HREF="+<>vQuote+"http://"+<>tcDomain+"/"+Substring:C12($myDocName; $p)+<>vQuote+" TARGET="+<>vQuote+"_blank"+<>vQuote+">"+HFS_ShortName($myDocName)+"</A>"
		$myDocName:=Replace string:C233($myDocName; <>foldSep; "/")
	End if 
	SET TEXT TO PASTEBOARD:C523($myDocName)
End if 