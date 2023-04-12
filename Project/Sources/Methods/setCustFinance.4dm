//%attributes = {"publishedWeb":true}
C_LONGINT:C283($error)
C_TEXT:C284(<>tcPriceLvlA; <>tcPriceLvlB; <>tcPriceLvlC; <>tcPriceLvlD)
$doLabel:=False:C215
If (Record number:C243([Customer:2])<1)
	bCreditStat:=0
	vRunningBal:=0
Else 
	If (Modified record:C314([Customer:2]))
		SAVE RECORD:C53([Customer:2])
	End if 
	If (allowAlerts_boo)
		jLOADunLocked(->[Customer:2]; "The Customer is currently Locked."; ->unLocked)
		If (unlocked=0)
			OBJECT SET ENABLED:C1123(b21; False:C215)
			If (Not:C34(Locked:C147([Order:3])))
				ALERT:C41("The Order may be processed but changes may not be made to the Customer Record.")
			End if 
		End if 
	End if 
End if 
srVarLoad(Table:C252(->[Customer:2]))
//  CHOPPED  ContactsLoad(-1)
myTrap:=0  //set so recalc of running balance
//TRACE
Case of 
	: (ptCurTable=(->[Order:3]))
		If (([Customer:2]customerID:1="") | (vHere=2))
			$doLabel:=newOrd
		End if 
		//If (([Order]ContactBillTo=0)&([Customer]ContactBillTo>0))
		//[Order]ContactBillTo:=[Customer]ContactBillTo
		//End if 
		//If (([Order]ContactShipTo=0)&([Customer]ContactShipTo>0)
		//[Order]ContactShipTo:=[Customer]ContactShipTo
		//End if 
		If (allowAlerts_boo)
			If (([Customer:2]currency:89#"") & (Size of array:C274(aoLineAction)=0) & (Is new record:C668([Order:3])))
				[Order:3]currency:69:=[Customer:2]currency:89
				$error:=Exch_GetCurr([Order:3]currency:69)
				[Order:3]exchangeRate:68:=vrExRate
				Exch_FillRays
				UNLOAD RECORD:C212([Currency:61])
			End if 
		End if 
		//
		vrOldValue:=Old:C35([Order:3]amount:24)
		RunningBalance(->vRunningBal; ->myTrap; [Customer:2]creditLimit:37; [Customer:2]balanceDue:42; [Order:3]amount:24-vrOldValue; [Customer:2]customerID:1)
	: (ptCurTable=(->[Invoice:26]))
		$doLabel:=newInv
		//If ([Invoice]JrnlID=0)
		//If (([Invoice]ContactBillTo=0)&([Customer]ContactBillTo>0))
		//[Invoice]ContactBillTo:=[Customer]ContactBillTo
		//End if 
		//If (([Invoice]ContactShipTo=0)&([Customer]ContactShipTo>0)
		//[Invoice]ContactShipTo:=[Customer]ContactShipTo
		//End if 
		//End if 
		If (allowAlerts_boo)
			If (([Customer:2]currency:89#"") & (Size of array:C274(aiLineAction)=0) & (Is new record:C668([Invoice:26])))
				[Invoice:26]currency:62:=[Customer:2]currency:89
				$error:=Exch_GetCurr([Invoice:26]currency:62)
				[Invoice:26]exchangeRate:61:=vrExRate
				Exch_FillRays
				UNLOAD RECORD:C212([Currency:61])
			End if 
		End if 
		//    
		vrOldValue:=Old:C35([Invoice:26]amount:14)*Num:C11([Invoice:26]idNumOrder:1=1)
		RunningBalance(->vRunningBal; ->myTrap; [Customer:2]creditLimit:37; [Customer:2]balanceDue:42; [Invoice:26]amount:14-vrOldValue; [Customer:2]customerID:1)
	: (ptCurTable=(->[InventoryStack:29]))
		$doLabel:=newStak
	: (ptCurTable=(->[PO:39]))
		$doLabel:=newPo
	: (ptCurTable=(->[Proposal:42]))
		If (([Customer:2]customerID:1="") | (vHere=2))
			$doLabel:=newProp
		End if 
		//
		//If (([Proposal]ContactBillTo=0)&([Customer]ContactBillTo>0))
		//[Proposal]ContactBillTo:=[Customer]ContactBillTo
		//End if 
		//If (([Proposal]ContactShipTo=0)&([Customer]ContactShipTo>0)
		//[Proposal]ContactShipTo:=[Customer]ContactShipTo
		//End if 
		//
		If (allowAlerts_boo)
			If (([Customer:2]currency:89#"") & (Size of array:C274(aPLineAction)=0) & (Is new record:C668([Proposal:42])))
				[Proposal:42]currency:55:=[Customer:2]currency:89
				$error:=Exch_GetCurr([Proposal:42]currency:55)
				[Proposal:42]exchangeRate:54:=vrExRate
				Exch_FillRays
				UNLOAD RECORD:C212([Currency:61])
			End if 
		End if 
		//        
		RunningBalance(->vRunningBal; ->myTrap; [Customer:2]creditLimit:37; [Customer:2]balanceDue:42; [Proposal:42]amount:26; [Customer:2]customerID:1)
End case 
If (allowAlerts_boo)
	If (($doLabel) | ([Customer:2]customerID:1=""))
		FontSrchLabels(1)
	Else 
		FontSrchLabels(3)
	End if 
	//  Put  the formating in the form  jFormatPhone(->[Customer]phone; ->[Customer]fax; ->srPhone)
	
	$creditRisk:=((([Customer:2]balPastPeriod1:43+[Customer:2]balPastPeriod2:44+[Customer:2]balPastPeriod3:45)>25) | ([Customer:2]badCheck:34))
	If ($creditRisk)
		vCreditStat:="Risk"
		//PLAY("CreditCheck")
		BEEP:C151
		OBJECT SET RGB COLORS:C628(*; "vCreditStat"; 15; 256*3)
	Else 
		vCreditStat:="Current"
		OBJECT SET RGB COLORS:C628(*; "vCreditStat"; 15; 256*0)
	End if 
End if 
//bCreditStat:=CustFinanceProb ([Customer]Due3160;
//[Customer]Due6190;[Customer]Due90Up;[Customer]BadCheck)