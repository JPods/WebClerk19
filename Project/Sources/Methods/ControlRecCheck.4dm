//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/20/10, 12:25:52
// ----------------------------------------------------
// Method: ControlRecCheck
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($i; $k)
C_BOOLEAN:C305($Done)
READ WRITE:C146([Base:1])
$i:=1
$k:=Records in table:C83([Base:1])
ALL RECORDS:C47([Base:1])
$Done:=False:C215
FIRST RECORD:C50([Base:1])
While (($i<$k) & (Locked:C147([Base:1])))
	NEXT RECORD:C51([Base:1])
	$i:=$i+1
End while 
If (($i=$k) | ($k=0) | (Locked:C147([Base:1])))
	CREATE RECORD:C68([Base:1])
	SAVE RECORD:C53([Base:1])
	$Done:=True:C214
End if 
ONE RECORD SELECT:C189([Base:1])
Process_ListActive