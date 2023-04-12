//%attributes = {"publishedWeb":true}
If (False:C215)
	If (False:C215)
		//Method: B2BSycnAvailable
		//Date: 01/05/05
		//Who: Bill
		//Description: 
	End if 
	TCMod_606_67_03_04_Trans
End if 

C_LONGINT:C283($1; $err; $orderNum; $k)
C_POINTER:C301($2)
//
C_TEXT:C284($fieldDelim; $recDelim)
$fieldDelim:="jjzjj"
$recDelim:="zzjzz"
$dtLastUpdate:=Num:C11(WCapi_GetParameter("DTLastUpdate"; ""))
QUERY:C277([SyncRecord:109]; [SyncRecord:109]dtAction:2>=$dtLastUpdate; *)
//more protection QUERY([SyncRecord];[SyncRecord]DTAction>=$dtLastUpdate)
QUERY:C277([SyncRecord:109])
$dtNow:=DateTime_DTTo
C_LONGINT:C283($i; $k; $incRec; $cntRec; $dtNow; $fieldType)
C_POINTER:C301($ptField)
$k:=Records in selection:C76([SyncRecord:109])
SET BLOB SIZE:C606(iLoBlob1; 0)
vText6:="<SycRecords>"+$recDelim
FIRST RECORD:C50([SyncRecord:109])
For ($i; 1; $k)
	vText6:=vText6+String:C10([SyncRecord:109]idNum:1)+$fieldDelim+String:C10([SyncRecord:109]tableNum:4)+$fieldDelim+String:C10([SyncRecord:109]fieldNum:5)+$fieldDelim+[SyncRecord:109]fieldValue:6+$fieldDelim+[SyncRecord:109]statusSend:17+$recDelim
	//[DynamicCatalog]DTLastUpdate:=$dtNow
	//SAVE RECORD([DynamicCatalog])
	NEXT RECORD:C51([SyncRecord:109])
End for 
vText6:=vText6+$recDelim+"</SycRecords>"
Http_SendWWWHd($1; "text"; Length:C16(vText6))
$err:=TCP Send($1; vText6)
vText6:=""