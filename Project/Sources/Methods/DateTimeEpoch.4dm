//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/22/18, 10:25:37
// ----------------------------------------------------
// Method: DateTimeEpochDT
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Count parameters:C259=0)
		C_LONGINT:C283($currentDT)
		$currentDT:=DateTime_Enter
		C_TEXT:C284(dtEpochCurrent)
		
		DateTimeDTEpoch("ToEpoch"; ->$currentDT; ->dtEpochCurrent)
		
End case 
If (False:C215)
	
	C_LONGINT:C283($0; $cp)
	C_DATE:C307($1; $zDate)
	C_TIME:C306($2; $zTime)
	$cp:=Count parameters:C259
	Case of 
		: ($cp=0)
			$zDate:=Current date:C33
			$zTime:=Current time:C178
		: ($cp=1)
			$zDate:=$1
			$zTime:=Current time:C178
		: ($cp=2)
			$zDate:=$1
			$zTime:=$2
	End case 
	Case of 
		: (($zDate=!00-00-00!) & ($zTime=?00:00:00?))
			$0:=0
		: ($zDate=!00-00-00!)
			$zDate:=!1904-01-01!
		Else 
			$0:=($zDate-!1990-01-01!)*86400  //86400=24*60*60 date from 1990
			If ($0>=0)
				$0:=$0+($zTime+0)
			Else 
				$0:=$0-($zTime+0)
			End if 
			If ($0=0)
				$0:=1  //0 (zero) is reservered for undefined
			End if 
	End case 
End if 