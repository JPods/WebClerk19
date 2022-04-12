//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: jStart3
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
//TRACE
<>syncByBlob:=True:C214
C_BOOLEAN:C305(<>syncByBlob)

KeywordsList
//
$k:=Records in table:C83([FieldCharacteristic:94])
If ($k=0)
	UtilParseAllow(1)
	UtilParseAllow(5000)
	UtilParseAllow(5)
End if 
ARRAY TEXT:C222(<>aCloneOrderStatus; 0)
ARRAY LONGINT:C221(<>aCloneOrderID; 0)
ARRAY TEXT:C222(<>aCloneOrderComment; 0)
ARRAY LONGINT:C221($aLineCount; 0)
ARRAY REAL:C219($aAmount; 0)

QUERY:C277([Order:3]; [Order:3]salesNameID:10="CloneAllowed")
If (Records in selection:C76([Order:3])>0)
	SELECTION TO ARRAY:C260([Order:3]orderNum:2; <>aCloneOrderID; [Order:3]status:59; <>aCloneOrderStatus; [Order:3]comment:33; <>aCloneOrderComment; [Order:3]lineCount:35; $aLineCount; [Order:3]amount:24; $aAmount)
End if 
C_LONGINT:C283($inc; $cnt)
$cnt:=Size of array:C274(<>aCloneOrderComment)
For ($inc; 1; $cnt)
	//<>aCloneOrderComment{$inc}:="lc: "+String($aLineCount{$inc})+"  "+"\r"+"$: "+String($aAmount{$inc})+"  "+"\r"+<>aCloneOrderComment{$inc}
	<>aCloneOrderComment{$inc}:="$: "+String:C10($aAmount{$inc})+"  "+"\r"+<>aCloneOrderComment{$inc}
End for 
SORT ARRAY:C229(<>aCloneOrderStatus; <>aCloneOrderID; <>aCloneOrderComment)

ARRAY TEXT:C222(<>aClonePpStatus; 0)
ARRAY LONGINT:C221(<>aClonePpID; 0)
ARRAY TEXT:C222(<>aClonePpComment; 0)
ARRAY LONGINT:C221($aLineCount; 0)
ARRAY REAL:C219($aAmount; 0)
QUERY:C277([Proposal:42]; [Proposal:42]salesNameID:9="CloneAllowed")
If (Records in selection:C76([Proposal:42])>0)
	SELECTION TO ARRAY:C260([Proposal:42]proposalNum:5; <>aClonePpID; [Proposal:42]status:2; <>aClonePpStatus; [Proposal:42]comment:36; <>aClonePpComment; [Proposal:42]lineCount:48; $aLineCount; [Proposal:42]amount:26; $aAmount)
End if 
$cnt:=Size of array:C274(<>aClonePpComment)
For ($inc; 1; $cnt)
	//<>aClonePpComment{$inc}:="lc: "+String($aLineCount{$inc})+"  "+"\r"+"$: "+String($aAmount{$inc})+"  "+"\r"+<>aClonePpComment{$inc}
	<>aClonePpComment{$inc}:="$: "+String:C10($aAmount{$inc})+"  "+"\r"+<>aClonePpComment{$inc}
End for 
SORT ARRAY:C229(<>aClonePpStatus; <>aClonePpID; <>aClonePpComment)
C_LONGINT:C283(<>vTicDelay)
If (<>vTicDelay=0)
	<>vTicDelay:=10
End if 
//




