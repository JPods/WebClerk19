//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2021-12-10T06:00:00Z)
// Method: // zzzqqq PopUpWildCard
// Description 
// Parameters
// ----------------------------------------------------


C_POINTER:C301($1; $2; $3)
C_BOOLEAN:C305(vModPop)
C_LONGINT:C283($i; $k; $ii; $w; changePop)
Case of 
	: ($1->="")
		
	: ($1->[[1]]="*")
		$1->:=""
		If ($3=(->[PopUp:23]))
			If (Size of array:C274($2->)>0)
				QUERY:C277([PopUp:23]; [PopUp:23]listName:4=$2->{1})
				DB_ShowCurrentSelection($3)
			End if 
		Else 
			ALL RECORDS:C47($3->)
			DB_ShowCurrentSelection($3)
		End if 
		
	Else 
		$k:=Length:C16($1->)
		$size:=Size of array:C274($2->)
		$i:=0
		$w:=-1
		While ($i<$size)
			$i:=$i+1
			If ($1->=Substring:C12($2->{$i}; 1; $k))
				$w:=$i
				$i:=$size
			End if 
		End while 
		If ($w>0)
			$1->:=$2->{$w}
		Else 
			BEEP:C151
		End if 
End case 

