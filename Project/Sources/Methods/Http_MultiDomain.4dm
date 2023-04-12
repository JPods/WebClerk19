//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/27/12, 22:01:13
// ----------------------------------------------------
// Method: Http_MultiDomain
// Description
// 
//
// Parameters
// ----------------------------------------------------

//jit_MultiDomain.txt in the jitWeb folder defines multiple domains
C_TEXT:C284($0; $url; tcDomain)
C_LONGINT:C283($w; $k)
$0:=Storage:C1525.wc.webFolder
$w:=Position:C15("Host: "; vText11)
If ($w>0)
	$url:=Substring:C12(vText11; $w+6)
	$w:=Position:C15("\r"; $url)
	If ($w>0)
		$url:=Substring:C12($url; 1; $w-1)
		$w:=Find in array:C230(<>aWebSites; $url)
		If ($w>0)
			$0:=<>aWebRoot{$w}
			tcDomain:=<>aWebSites{$w}
		End if 
	End if 
	$k:=Length:C16($0)
	If ($k>0)
		If (($0[[$k]]=":") | ($0[[$k]]="\\"))
			$0:=Substring:C12($0; 1; $k-1)
		End if 
	End if 
End if 