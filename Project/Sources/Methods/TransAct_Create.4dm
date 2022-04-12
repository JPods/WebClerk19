//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-05-01T00:00:00, 10:28:04
// ----------------------------------------------------
// Method: TransAct_Create
// Description
// Modified: 05/01/17
// 
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($1; $4)
C_REAL:C285($2)
C_TEXT:C284($3; $5)
//
C_LONGINT:C283($docID)
C_TEXT:C284($theComment; $docAcct)
//
If ($2=0)
	If (allowAlerts_boo)
		ALERT:C41("Zero value creation of dCash attempted.")
	End if 
Else 
	CREATE RECORD:C68([DCash:62])
	
	Case of 
		: (Count parameters:C259=2)
			$theComment:=""
			$docID:=0
			$docAcct:=""
		: (Count parameters:C259=3)
			$docID:=0
			$docAcct:=""
			$theComment:=$3
		Else 
			$theComment:=$3
			$docID:=$4
			$docAcct:=$5
	End case 
	Case of 
			
		: ($1=1)
			[DCash:62]customerIDReceive:7:=[Invoice:26]customerID:3
			[DCash:62]tableReceive:8:=26
			[DCash:62]docReceive:4:=[Invoice:26]invoiceNum:2
			[DCash:62]terms:9:=[Invoice:26]terms:24
			[DCash:62]changeAmount:5:=-$2
			//
			//If (sAltAcct="")
			//[TransAct]customerIDApply:=sAltAcct
			//Else 
			[DCash:62]customerIDApply:1:=[Payment:28]customerID:4
			//End if 
			[DCash:62]tableApply:2:=28
			[DCash:62]docApply:3:=[Payment:28]idNum:8
			[DCash:62]comment:10:=$theComment
			[DCash:62]dateEvent:6:=Current date:C33
			[DCash:62]nameID:12:=Current user:C182
		: ($1=2)  //Credits between in voices
			[DCash:62]customerIDReceive:7:=$docAcct
			[DCash:62]tableReceive:8:=26
			[DCash:62]docReceive:4:=$docID
			[DCash:62]changeAmount:5:=$2
			//
			[DCash:62]customerIDApply:1:=[Invoice:26]customerID:3
			[DCash:62]tableApply:2:=26
			[DCash:62]terms:9:=[Invoice:26]terms:24
			[DCash:62]docApply:3:=[Invoice:26]invoiceNum:2
			[DCash:62]comment:10:=$theComment
			[DCash:62]dateEvent:6:=Current date:C33
			[DCash:62]nameID:12:=Current user:C182
		Else 
			[DCash:62]customerIDReceive:7:=[Invoice:26]customerID:3
			[DCash:62]tableReceive:8:=26
			[DCash:62]docReceive:4:=[Invoice:26]invoiceNum:2
			[DCash:62]terms:9:=[Invoice:26]terms:24
			[DCash:62]changeAmount:5:=-$2
			//
			[DCash:62]customerIDApply:1:=[Invoice:26]customerID:3
			[DCash:62]tableApply:2:=0
			[DCash:62]docApply:3:=0
			[DCash:62]comment:10:=$theComment
			[DCash:62]dateEvent:6:=Current date:C33
			[DCash:62]nameID:12:=Current user:C182
	End case 
	
	SAVE RECORD:C53([DCash:62])
End if 