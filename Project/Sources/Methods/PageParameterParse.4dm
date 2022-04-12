//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-01-07T00:00:00, 21:34:44
// ----------------------------------------------------
// Method: PageParameterParse
// Description
// Modified: 01/07/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($0; $1; $2)

$p:=Position:C15(($2+"="); $1)  //Wednesday, September 23, 1998  for speed
If ($p#0)
	//$request:=Substring($1;$p-5;$p+40)   //this looks like a good idea
	$request:=$1
	If (Position:C15(($2+"="); $request)#0)
		$0:=Substring:C12($request; Position:C15(($2+"="); $request)+Length:C16($2)+1)
		$0:=Replace string:C233($0; "?"; "&")
		$0:=Replace string:C233($0; Char:C90(13); "")  // suppression des CR
		$0:=Replace string:C233($0; Char:C90(10); "")  // suppression des LF
		$0:=Replace string:C233($0; " HTTP"; "&")+"&"
		$0:=Substring:C12($0; 1; Position:C15("&"; $0)-1)
		Repeat 
			$p:=Position:C15(Char:C90(64); $0)  // suppression @
			Case of 
				: (($p=0) | (<>vlWildSrch=1))  //allow wild card searches
					$p:=0
				: (Length:C16($0)=0)
					$p:=0
				: (Character code:C91($0)=64)
					$0:=Substring:C12($0; 2)
				: (Length:C16($0)=1)
					$p:=0
				Else 
					$0:=Substring:C12($0; 1; $p-1)
			End case 
		Until ($p=0)
	End if 
End if 