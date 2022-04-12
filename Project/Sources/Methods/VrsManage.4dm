//%attributes = {"publishedWeb":true}
If (False:C215)
	//
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_DATE:C307($1; $2; $curVersion; $newVersion)
C_LONGINT:C283($0; $err)
$curVersion:=$1
$newVersion:=$2
$0:=1



If ($curVersion<!2008-08-08!)
	CC_Convert
	$0:=0
End if 


If ($curVersion<!2006-03-20!)
	C_LONGINT:C283($recInc; $recCnt)
	QUERY:C277([Item:4]; [Item:4]webPage:58="0")
	$recCnt:=Records in selection:C76([Item:4])
	FIRST RECORD:C50([Item:4])
	For ($recInc; 1; $recCnt)
		For ($i; 1; $k)
			[Item:4]webPage:58:=""
		End for 
		SAVE RECORD:C53([Item:4])
		NEXT RECORD:C51([Item:4])
	End for 
	
	
	
	$0:=0
End if 

If ($curVersion<!2004-09-10!)
	MESSAGE:C88("Updating PayType Changes")
	VrsPayTypes
	$0:=0
End if 



If ($curVersion<!2004-09-10!)
	MESSAGE:C88("Updating Tax Lines")
	VrsPayTypes
	$0:=0
End if 

