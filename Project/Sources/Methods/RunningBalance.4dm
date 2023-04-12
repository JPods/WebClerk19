//%attributes = {"publishedWeb":true}
//RunningBalance (
//vRunningBal;
//myTrap;
//[Customer]CreditLimit;
//[Customer]BalanceDue;
//[Invoice]Amount-vrOldValue
//[Invoice]AccountKey
C_POINTER:C301($1; $2)  //vRunningBal;myTrap
C_REAL:C285($3; $4; $5)  //[Customer]CreditLimit-([Customer]BalanceDue+[Proposal]Amount)
C_TEXT:C284($6)
//
If ($6="")
	$1->:=0
	If (allowAlerts_boo)
		OBJECT SET RGB COLORS:C628(*; "$1->"; Black:K11:16; White:K11:1)
	End if 
Else 
	$1->:=Round:C94([Customer:2]creditLimit:37-[Customer:2]balanceDue:42-$5-[Customer:2]balanceOpenOrders:78; 0)
	If (($1-><0) & ($2->=0))
		$2->:=1
		If (allowAlerts_boo)
			// PLAY("CreditCheck")
			BEEP:C151
			OBJECT SET RGB COLORS:C628(*; "$1->"; Black:K11:16; Yellow:K11:2)  //SET COLOR (bInfo;  (vForeground + (256 * vBackground)))
			//    INVERT BACKGROUND($1)
		End if 
	Else 
		If (allowAlerts_boo)
			OBJECT SET RGB COLORS:C628(*; "$1->"; Black:K11:16; White:K11:1)
		End if 
	End if 
End if 