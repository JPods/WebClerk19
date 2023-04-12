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

ARRAY TEXT:C222(<>aCloneOrderStatus; 0)
ARRAY LONGINT:C221(<>aCloneOrderID; 0)
ARRAY TEXT:C222(<>aCloneOrderComment; 0)
ARRAY LONGINT:C221($aLineCount; 0)
ARRAY REAL:C219($aAmount; 0)

QUERY:C277([Order:3]; [Order:3]salesNameID:10="CloneAllowed")
If (Records in selection:C76([Order:3])>0)
	
	// Fix_QQQ by: Bill James (2023-03-24T05:00:00Z)
	// change linecount to object
	//SELECTION TO ARRAY([Order]idNum; <>aCloneOrderID; [Order]status; <>aCloneOrderStatus; [Order]comment; <>aCloneOrderComment; [Order]lines; $aLineCount; [Order]amount; $aAmount)
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
	
	// Fix_QQQ by: Bill James (2023-03-24T05:00:00Z)
	// reused line to object
	//SELECTION TO ARRAY([Proposal]idNum; <>aClonePpID; [Proposal]status; <>aClonePpStatus; [Proposal]comment; <>aClonePpComment; [Proposal]lines; $aLineCount; [Proposal]amount; $aAmount)
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




