//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-29T00:00:00, 06:40:24
// ----------------------------------------------------
// Method: SyncFindLoad
// Description
// Modified: 08/29/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
If (UserInPassWordGroup("Import"))
	C_LONGINT:C283(calSupport; $i; $k; bCust; bLead; bService)
	C_TEXT:C284(vAction)
	MESSAGES OFF:C175
	READ WRITE:C146([Control:1])
	$i:=1
	$k:=Records in table:C83([Control:1])-1
	$Done:=False:C215
	READ WRITE:C146([Control:1])
	Repeat 
		If ($i>$k)
			CREATE RECORD:C68([Control:1])
			ControlFill
			SAVE RECORD:C53([Control:1])
			GOTO RECORD:C242([Control:1]; $i)
			$Done:=True:C214
		Else 
			GOTO RECORD:C242([Control:1]; $i)
			LOAD RECORD:C52([Control:1])
			If (Not:C34(Locked:C147([Control:1])))
				$Done:=True:C214
			End if 
		End if 
		$i:=$i+1
	Until ($Done)
	DISABLE MENU ITEM:C150(1; 4)
	DISABLE MENU ITEM:C150(1; 5)
	DISABLE MENU ITEM:C150(1; 6)
	DISABLE MENU ITEM:C150(1; 7)
	ARRAY LONGINT:C221(aSyFile; 0)
	ARRAY LONGINT:C221(aSyField; 0)
	ARRAY LONGINT:C221(aSyType; 0)
	ARRAY TEXT:C222(aSyMatWas; 0)
	ARRAY TEXT:C222(aSyMatIs; 0)
	FORM SET INPUT:C55([Control:1]; "SyncMatch")
	//curFile:=File([Control])
	// calSupport:=File([Service])//to be used for mixing calanders between files
	ProcessTableOpen(->[Control:1]; "skip")
	ARRAY TEXT:C222(theFields; 0)
	//
	SET CHANNEL:C77(11)
	aSyncCnt:=0
	vi1:=1000
	vdDateBeg:=Current date:C33
	vTimeBeg:=?00:00:00?
	vText1:=""
	SyncArraysInit(0)
	ARRAY TEXT:C222(aText1; 0)
	ARRAY TEXT:C222(aText2; 0)
	ARRAY TEXT:C222(aText3; 0)
	ARRAY TEXT:C222(aSyncChoose; 0)
	ARRAY LONGINT:C221(aSyFile; 0)
	ARRAY LONGINT:C221(aSyField; 0)
	ARRAY LONGINT:C221(aSyType; 0)
	ARRAY TEXT:C222(aSyMatWas; 0)
	ARRAY TEXT:C222(aSyMatIs; 0)
End if 