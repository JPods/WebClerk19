//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/13/19, 09:49:13
// ----------------------------------------------------
// Method: Parse_UnWanted
// Description
// 
//
// Parameters
// ----------------------------------------------------
// [Customer]City:=Parse_UnWanted([Customer]City)

C_TEXT:C284($1; $working_t)
$working_t:=$1
If ((Type:C295($working_t)=Is alpha field:K8:1) | (Type:C295($working_t)=Is string var:K8:2) | (Type:C295($working_t)=Is text:K8:3))
	C_TEXT:C284($working)
	C_TEXT:C284($result)
	C_LONGINT:C283($i; $k)
	// escapeChar
	C_TEXT:C284($vtEscape1; $vtEscape2)
	$vtEscape1:="\"\""
	$vtEscape2:="qzq"
	$working:=$working_t
	
	$result:=""
	$k:=Length:C16($working)
	If ($k>0)
		If ($working[[1]]="\"")
			If ($working[[$k]]="\"")
				$working:=Substring:C12($working; 2; $k-2)
			End if 
		End if 
	End if 
	$working:=Replace string:C233($working; $vtEscape1; $vtEscape2)
	// was stripping inch markers
	$k:=Length:C16($working)
	For ($i; 1; $k)
		Case of 
			: (($working[[$i]]=" ") & ((Length:C16($result)=0)) | ($i=$k))
				If (($i=$k) & ($working[[$i]]#" "))  //  & ($working[[$i]]#Char(34)))
					$result:=$result+$working[[$i]]
				End if 
				//no action, delete leading spaces 
			: ($working[[$i]]=" ")
				//      $result:=$result+" "
				$endLoop:=False:C215
				Repeat 
					Case of 
						: ($i=$k)
							$endLoop:=True:C214
							If ($working[[$i]]>" ")
								$result:=$result+" "+$working[[$i]]
							End if 
						: (($working[[$i+1]]=" ") | (Character code:C91($working[[$i+1]])<32))
							$i:=$i+1
						Else 
							$result:=$result+" "
							$endLoop:=True:C214
					End case 
				Until ($endLoop)
			: ($working[[$i]]=Char:C90(34))
				If ($working[[$i+1]]=Char:C90(34))
					$result:=$result+Char:C90(34)
					$endLoop:=False:C215
					Repeat 
						$i:=$i+1
						Case of 
							: ($i+1>Length:C16($working))
								$endLoop:=True:C214
							: (($i>=$k) | (($i+1=$k) & ($working[[$i+1]]#Char:C90(34))))
								$endLoop:=True:C214
							: ($working[[$i+1]]#Char:C90(34))
								$endLoop:=True:C214
						End case 
					Until ($endLoop)
				End if 
			: (Character code:C91($working[[$i]])<32)  //less than a "space bar"
				//$result:=$result+Char(249)
				//no action, skip adding char
			Else 
				$result:=$result+$working[[$i]]
		End case 
	End for 
	$result:=Replace string:C233($result; $vtEscape2; "\"")
	$0:=$result
Else 
	// do nothing
End if 