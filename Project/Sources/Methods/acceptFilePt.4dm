//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-07-05T00:00:00, 13:41:44
// ----------------------------------------------------
// Method: acceptFilePt
// Description
// Modified: 07/05/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_BOOLEAN:C305($1)
C_POINTER:C301($2; $3; $4; $5; $6; $7; $8)
C_LONGINT:C283($i; $k)
$k:=Count parameters:C259

For ($i; 3; $k)
	If (Modified record:C314(${$i}->))
		// ### jwm ### 20190716_1349 add methods to log changes and keywords
		// ### jwm ### 20190716_1350 Save Keywords
		// ### jwm ### 20190716_1350 Log Changes
		SAVE RECORD:C53(${$i}->)
		If ($1)
			UNLOAD RECORD:C212(${$i}->)
		End if 
	End if 
End for 
SAVE RECORD:C53(${2}->)

//C_POINTER($6)
//C_POINTER($7)
//C_POINTER($8)
//C_LONGINT($I)
//C_LONGINT($K)
//C_POINTER(${-1})
//C_BOOLEAN($1)
//C_POINTER($2)
//C_POINTER($3)
//C_POINTER($4)
//C_POINTER($5)//