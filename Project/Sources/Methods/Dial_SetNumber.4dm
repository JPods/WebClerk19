//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/03/09, 15:34:28
// ----------------------------------------------------
// Method: Di// -- AL_SetNumber
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($0)
C_TEXT:C284($1; $dialStr)
$dialStr:=$1
C_TEXT:C284($2; $Prefix)
If (Count parameters:C259>=2)
	$Prefix:=$2
Else 
	$Prefix:=""
End if 
C_TEXT:C284($3; $Suffix)
If (Count parameters:C259>=3)
	$Suffix:=$3
Else 
	$Suffix:=""
End if 

//Strip off any extension
C_LONGINT:C283($pos)
$pos:=Position:C15("ext"; $dialStr)
If ($pos<=0)
	$pos:=Position:C15("x"; $dialStr)
End if 
If ($pos>0)
	$dialStr:=Substring:C12($dialStr; 1; ($pos-1))
End if 
//check for any applicable DialingInfo records
C_BOOLEAN:C305($NotDialInfo)
$NotDialInfo:=True:C214
C_LONGINT:C283($index; $AreaLen)
If (Size of array:C274(<>yDIAreaPrfx)>0)
	For ($index; 1; Size of array:C274(<>yDIAreaPrfx))
		$AreaLen:=Length:C16(<>yDIAreaPrfx{$index})
		If ((Length:C16($dialStr)=<>yDITotalLen{$index}) & (Substring:C12($dialStr; 1; $AreaLen)=<>yDIAreaPrfx{$index}))
			If (<>yDILeaveOut{$index})
				$0:=<>yDIProceedW{$index}+Substring:C12($dialStr; $AreaLen+1)+<>yDIFollowW{$index}
			Else 
				$0:=<>yDIProceedW{$index}+$dialStr+<>yDIFollowW{$index}
			End if 
			$NotDialInfo:=False:C215
			$index:=32767  //terminate loop
		End if 
	End for 
End if 
If ($NotDialInfo)
	//otherwise handle by USA standard  
	Case of 
		: ($dialStr="")
			$0:=""
		: ((Length:C16($dialStr)=7) | (Substring:C12($dialStr; 1; 3)="011") | (Substring:C12($dialStr; 1; 1)="1"))
			$0:=$dialStr
		: ((Length:C16($dialStr)=10) & (Substring:C12($dialStr; 1; 3)=<>tcLocalArea))
			$0:=Substring:C12($dialStr; 4)
		: ((Length:C16($dialStr)=10) & (Substring:C12($dialStr; 1; 3)#<>tcLocalArea))
			$0:="1"+$dialStr
		Else 
			$0:=$dialStr
	End case 
End if 
//prefix all dialed numbers with the dial out string (i.e. 9,)
$0:=<>tcDialOut+$0