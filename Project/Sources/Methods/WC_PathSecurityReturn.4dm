//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/19/08, 21:57:53
// ----------------------------------------------------
// Method: WC_PathSecurityReturn
// Description
// 
//
// Parameters
C_TEXT:C284($1; $thePath)
C_LONGINT:C283($0)
// ----------------------------------------------------
$thePath:=$1

C_TEXT:C284($header; $expires)
C_LONGINT:C283($p; $maxSecurity; $curSecurity)
C_TEXT:C284($thePath)
$curSecurity:=0
$maxRequiredSecurity:=0
Repeat 
	$p:=Position:C15("jits_"; $thePath)
	If ($p>0)
		$cached:=False:C215
		$thePath:=Substring:C12($thePath; $p+5)  // jitWebFolder/folder/folder_jits_6_sfsd/folder/document  requires security >=6
		$p:=Position:C15("_"; $thePath)
		If ($p>0)
			$curSecurity:=Num:C11(Substring:C12($thePath; 1; $p-1))
			If ($maxSecurity<$curSecurity)
				$maxSecurity:=$curSecurity
			End if 
		End if 
	End if 
Until ($p=0)
$0:=$maxSecurity
