//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-06-24T00:00:00, 05:13:03
// ----------------------------------------------------
// Method: CR_AddAction
// Description
// Modified: 06/24/17
// 
// 
//
// Parameters
// ----------------------------------------------------



C_POINTER:C301($1; $2)
C_TEXT:C284($3)
KeyModifierCurrent
Case of 
	: ((OptKey=1) & ($1->#""))
		CREATE SET:C116([CallReport:34]; "Current")
		CREATE RECORD:C68([CallReport:34])
		
		[CallReport:34]customerID:1:=$3
		[CallReport:34]tableNum:2:=Table:C252($1)
		[CallReport:34]actionBy:3:=Current user:C182
		[CallReport:34]dtAction:4:=DateTime_Enter
		[CallReport:34]dateDocument:17:=Current date:C33
		[CallReport:34]complete:7:=True:C214
		[CallReport:34]action:15:=$1->
		SAVE RECORD:C53([CallReport:34])
		ADD TO SET:C119([CallReport:34]; "Current")
		USE SET:C118("Current")
		CLEAR SET:C117("Current")
	: (CmdKey=1)
		If ((Old:C35($1->)#"") & (Old:C35($1->)#$1->))
			$temp:=String:C10(Current date:C33; 1)+":  "+String:C10(Current time:C178; 2)+" -  "+Old:C35($1->)+"\r"
			$2->:=Insert string:C231($2->; $Temp; -10)
		End if 
End case 