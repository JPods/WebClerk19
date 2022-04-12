//%attributes = {"publishedWeb":true}
C_POINTER:C301($1; $2; $3; $4; $5; $6; $7; $8; $9)
C_LONGINT:C283($10)

C_LONGINT:C283($w; $i; $len)
$i:=1  //skip the Type Sale header
$w:=0

C_TEXT:C284($PricePoint)

If ($1->#"")
	$PricePoint:=$1->+"@"
	$w:=Find in array:C230(<>aTypeSale; $PricePoint)
Else 
	$w:=-1
End if 
If ($w>1)
	pPartNum:=$3->  //Set the item number
	If ([Item:4]itemNum:1#$3->)
		QUERY:C277([Item:4]; [Item:4]itemNum:1=$3->)
	End if 
	If (Records in selection:C76([Item:4])=1)
		DscntSetAll(<>tcbManyType; [Customer:2]customerID:1; $1->; $4->; 0)
		OrdSetPrice($5; $6; $7->; ->pComm)
		$8->:=Round:C94(vComRep*pComm*0.01; 1)
		$9->:=Round:C94(vComSales*pComm*0.01; 1)
		UNLOAD RECORD:C212([Item:4])
	Else 
		If (allowAlerts_boo)
			BEEP:C151
			BEEP:C151
			ALERT:C41("No ItemNum: "+pPartNum)
		End if 
	End if 
Else 
	BEEP:C151
	BEEP:C151
	$1->:=$2->
End if 