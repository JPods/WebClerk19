//%attributes = {"publishedWeb":true}
C_LONGINT:C283(bNewRec)
C_BOOLEAN:C305(myDoNew; $doLabel)
C_POINTER:C301($1)
If (bNewRec=1)
	vComRep:=0
	vComSales:=0
	srCustomer:=""
	srPhone:=""
	srZip:=""
	REDUCE SELECTION:C351([Contact:13]; 0)
	CREATE RECORD:C68([Customer:2])
	DBCustomer_init
	srAcct:=[Customer:2]customerID:1
	vRunningBal:=0
	_O_OBJECT SET COLOR:C271(vRunningBal; -(15+(256*0)))
	vCreditStat:="New"
	_O_OBJECT SET COLOR:C271(vCreditStat; -(15+(256*0)))
	Case of 
		: (Table:C252($1)=Table:C252(->[Order:3]))
			[Order:3]customerID:1:=srAcct
			[Order:3]company:15:=""
			[Order:3]address1:16:=""
			[Order:3]address2:17:=""
			[Order:3]city:18:=""
			[Order:3]state:19:=""
			[Order:3]zip:20:=""
			[Order:3]country:21:=""
			[Order:3]zone:14:=-1
			[Order:3]attention:44:=""
			[Order:3]adSource:41:=""
			[Order:3]terms:23:=Storage:C1525.default.terms
			[Order:3]phone:67:=""
			[Order:3]fax:81:=""
			[Order:3]email:82:=""
			[Order:3]taxJuris:43:=""
			[Order:3]salesNameID:10:=""
			[Order:3]repID:8:=""
			[Order:3]billToCompany:76:=""
			[Order:3]addressBillTo:71:=""
			[Order:3]addressShipFrom:72:=""
			[Order:3]shipInstruct:46:=""
			[Order:3]orderedBy:66:=""
			[Order:3]shipVia:13:=Storage:C1525.default.shipVia
			[Order:3]typeSale:22:=Storage:C1525.default.typeSale
			[Order:3]division:48:=Storage:C1525.default.division
			[Order:3]salesCommission:11:=0
			[Order:3]repCommission:9:=0
			C_LONGINT:C283($cntRay; $incRay)
			$cntRay:=Size of array:C274(aoRepRate)
			For ($incRay; 1; $cntRay)
				aoRepRate{$incRay}:=0
				aoRepComm{$incRay}:=0
				aoSalesRate{$incRay}:=0
				aoSaleComm{$incRay}:=0
			End for 
			vMod:=calcOrder(True:C214)
			DscntSetAll(<>tcbManyType; [Customer:2]customerID:1; [Order:3]typeSale:22; [Order:3]dateOrdered:4)
		: (Table:C252($1)=Table:C252(->[Invoice:26]))
			[Invoice:26]customerID:3:=srAcct
			[Invoice:26]company:7:=""
			[Invoice:26]address1:8:=""
			[Invoice:26]address2:9:=""
			[Invoice:26]city:10:=""
			[Invoice:26]state:11:=""
			[Invoice:26]zip:12:=""
			[Invoice:26]country:13:=""
			[Invoice:26]zone:6:=-1
			[Invoice:26]terms:24:=Storage:C1525.default.terms
			[Invoice:26]phone:54:=""
			[Invoice:26]shipVia:5:=Storage:C1525.default.shipVia
			[Invoice:26]typeSale:49:=Storage:C1525.default.typeSale
			[Invoice:26]division:41:=Storage:C1525.default.division
			[Invoice:26]adSource:52:=""
			[Invoice:26]attention:38:=""
			[Invoice:26]phone:54:=""
			[Invoice:26]fax:75:=""
			[Invoice:26]email:76:=""
			[Invoice:26]taxJuris:33:=""
			[Invoice:26]salesNameID:23:=""
			[Invoice:26]repID:22:=""
			[Invoice:26]bill2Company:69:=""
			[Invoice:26]addressBillTo:67:=""
			[Invoice:26]addressShipFrom:68:=""
			//[Invoice]ShipToContact:=""
			[Invoice:26]shipInstruct:40:=""
			[Invoice:26]salesCommission:36:=0
			[Invoice:26]repCommission:28:=0
			C_LONGINT:C283($cntRay; $incRay)
			$cntRay:=Size of array:C274(aiLineAction)
			For ($incRay; 1; $cntRay)
				aiRepRate{$incRay}:=0
				aiRepComm{$incRay}:=0
				aiSalesRate{$incRay}:=0
				aiSaleComm{$incRay}:=0
			End for 
			vMod:=True:C214
			calcInvoice
			DscntSetAll(<>tcbManyType; [Customer:2]customerID:1; [Invoice:26]typeSale:49; <>ptInvoiceDateFld->)
		: (Table:C252($1)=Table:C252(->[Proposal:42]))
			[Proposal:42]customerID:1:=srAcct
			[Proposal:42]company:11:=""
			[Proposal:42]address1:12:=""
			[Proposal:42]address2:13:=""
			[Proposal:42]city:14:=""
			[Proposal:42]state:15:=""
			[Proposal:42]zip:16:=""
			[Proposal:42]country:17:=""
			[Proposal:42]zone:19:=-1
			[Proposal:42]terms:21:=Storage:C1525.default.terms
			[Proposal:42]phone:24:=""
			[Proposal:42]shipVia:18:=Storage:C1525.default.shipVia
			[Proposal:42]typeSale:20:=Storage:C1525.default.typeSale
			[Proposal:42]attention:37:=""
			[Proposal:42]adSource:47:=""
			[Proposal:42]attention:37:=""
			[Proposal:42]phone:24:=""
			[Proposal:42]fax:67:=""
			[Proposal:42]email:68:=""
			[Proposal:42]taxJuris:33:=""
			[Proposal:42]salesNameID:9:=""
			[Proposal:42]repID:7:=""
			[Proposal:42]bill2Company:57:=""
			//[Proposal]ShipToContact:=""
			//[Proposal]AddressBillTo:=""
			//[Proposal]AddressShipFrom:=""
			[Proposal:42]shipInstruct:35:=""
			[Proposal:42]repCommission:8:=0
			[Proposal:42]salesCommission:10:=0
			C_LONGINT:C283($cntRay; $incRay)
			$cntRay:=Size of array:C274(aPRepRate)
			For ($incRay; 1; $cntRay)
				aPRepRate{$incRay}:=0
				aPRepComm{$incRay}:=0
				aPSalesRate{$incRay}:=0
				aPSaleComm{$incRay}:=0
			End for 
			vMod:=calcProposal(True:C214)
			DscntSetAll(<>tcbManyType; [Customer:2]customerID:1; [Proposal:42]typeSale:20; [Proposal:42]dateNeeded:4)
	End case 
	myDoNew:=False:C215
	FontSrchLabels(2)
	GOTO OBJECT:C206(srCustomer)
Else 
	Case of 
		: (ptCurTable=(->[Order:3]))
			$doLabel:=newOrd
		: (ptCurTable=(->[Invoice:26]))
			$doLabel:=newInv
		: (ptCurTable=(->[InventoryStack:29]))
			$doLabel:=newStak
		: (ptCurTable=(->[PO:39]))
			$doLabel:=newPo
		: (ptCurTable=(->[Proposal:42]))
			$doLabel:=newProp
	End case 
	If ($doLabel)
		FontSrchLabels(1)
	Else 
		FontSrchLabels(3)
	End if 
End if 