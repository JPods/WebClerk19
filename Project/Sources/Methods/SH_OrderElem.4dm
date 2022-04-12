//%attributes = {"publishedWeb":true}
//Procedure: SH_OrderElem
$cntRecs:=Records in selection:C76([DInventory:36])
$index:=0
ORDER BY:C49([DInventory:36]; [DInventory:36]docid:9; <)
//
READ ONLY:C145([Customer:2])
//READ ONLY([Order])
//READ ONLY([Rep])
//READ ONLY([Invoice])
//READ ONLY([TallyResult])
TRACE:C157
READ WRITE:C146([DInventory:36])
C_LONGINT:C283($index; $cntRecs; $1)
C_BOOLEAN:C305($doThis)
C_REAL:C285($rateFOB)
FIRST RECORD:C50([DInventory:36])
For ($index; 1; $cntRecs)
	LOAD RECORD:C52([DInventory:36])
	If (Locked:C147([DInventory:36]))
		CREATE RECORD:C68([TallyChange:65])
		
		[TallyChange:65]fileNum:1:=Table:C252(->[DInventory:36])
		[TallyChange:65]fieldNum:2:=Table:C252(->[DInventory:36]pacing:23)
		[TallyChange:65]longIntKey:4:=Record number:C243([DInventory:36])
		[TallyChange:65]booleanValue:8:=True:C214
		SAVE RECORD:C53([TallyChange:65])
	End if 
	$doOrd:=False:C215
	$doInv:=False:C215
	Case of 
		: ([DInventory:36]pacing:23=False:C215)
		: ([DInventory:36]typeid:14="so")
			$doOrd:=True:C214
		: ([DInventory:36]typeid:14="iv")
			$doInv:=True:C214
			//(([dInventory]QtyOnSO#0)&([dInventory]TakeAction=4))   //invoice direct
			If ((([DInventory:36]qtyOnHand:2<0) & ([DInventory:36]qtyOnSO:3>[DInventory:36]qtyOnHand:2)) | (([DInventory:36]qtyOnHand:2>0) & ([DInventory:36]qtyOnSO:3<[DInventory:36]qtyOnHand:2)) | (([DInventory:36]qtyOnSO:3#0) & ([DInventory:36]takeAction:19=4)))
				TRACE:C157
				$doOrd:=True:C214
			End if 
	End case 
	If ($doInv)
		$w:=Size of array:C274(aTmpLong1)+1
		SH_FillRays(-3; $w; 1)
		aTmpLong2{$w}:=2
		aQtyNact{$w}:=-[DInventory:36]qtyOnHand:2
		If ([Invoice:26]invoiceNum:2#[DInventory:36]docid:9)
			QUERY:C277([Invoice:26]; [Invoice:26]invoiceNum:2=[DInventory:36]docid:9)
		End if 
		Case of 
			: ([Invoice:26]orderNum:1=1)
				REDUCE SELECTION:C351([Order:3]; 0)
			: ([Order:3]orderNum:2#[Invoice:26]orderNum:1)
				QUERY:C277([Order:3]; [Order:3]orderNum:2=[Invoice:26]orderNum:1)
		End case 
		If ([Rep:8]repID:1#[Invoice:26]repID:22)
			QUERY:C277([Rep:8]; [Rep:8]repID:1=[Invoice:26]repID:22)
		End if 
		If ([Customer:2]customerID:1#[DInventory:36]custVendid:12)
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[DInventory:36]custVendid:12)
		End if 
		If ([TallyResult:73]name:1#[Invoice:26]fob:39)
			QUERY:C277([TallyResult:73]; [TallyResult:73]name:1=[Invoice:26]fob:39; *)
			QUERY:C277([TallyResult:73];  & [TallyResult:73]purpose:2="FOB")
			$rateFOB:=[TallyResult:73]real1:13
			UNLOAD RECORD:C212([TallyResult:73])
		End if 
		aTmp20Str1{$w}:=[Invoice:26]fob:39
		aTmp20Str2{$w}:=[Invoice:26]profile2:66
		aTmp20Str3{$w}:=[Invoice:26]profile3:70
		aTmpLong1{$w}:=[Invoice:26]invoiceNum:2
		//aTmpLong2{$w}:=[Invoice]OrderNum
		aCustRep{$w}:=[Invoice:26]repID:22
		aText1{$w}:=Substring:C12([Customer:2]customerID:1; 1; 1)
		aCustomers{$w}:=[Customer:2]company:2
		aCustAcct{$w}:=[Customer:2]customerID:1
		aQueryFieldNames{$w}:=[Customer:2]city:6
		aText2{$w}:=[Customer:2]country:9
		If ([DInventory:36]itemNum:1#[Item:4]itemNum:1)
			QUERY:C277([Item:4]; [Item:4]itemNum:1=[DInventory:36]itemNum:1)
		End if 
		aPartNum{$w}:=[DInventory:36]itemNum:1
		aPartDesc{$w}:=[Item:4]description:7
		aText3{$w}:=[Item:4]typeid:26  //Group
		aText4{$w}:=[Item:4]profile1:35  //Model
		aSaleNact{$w}:=Round:C94([DInventory:36]unitPrice:21*aQtyNact{$w}; 2)  // Sales
		aScpNPlan{$w}:=Round:C94(aSaleNact{$w}*$rateFOB*0.01; 2)  // hidden Frieght
		$itemCnt:=Num:C11([Order:3]profile1:61)
		If ($itemCnt#0)
			vR4:=Round:C94(Num:C11([Order:3]profile2:62)/$itemCnt; 2)
		Else 
			vR4:=0
		End if 
		aScpNact{$w}:=-Round:C94(vR4*[DInventory:36]qtyOnHand:2; 2)  // FOB expense
		aInvNact{$w}:=aSaleNact{$w}-aScpNPlan{$w}-aScpNact{$w}  //net sales    
	End if 
	If ($doOrd)
		$w:=Size of array:C274(aTmpLong1)+1
		SH_FillRays(-3; $w; 1)
		aTmpLong2{$w}:=1
		If ([Order:3]orderNum:2#[DInventory:36]docid:9)
			QUERY:C277([Order:3]; [Order:3]orderNum:2=[DInventory:36]docid:9)
		End if 
		If ([Customer:2]customerID:1#[DInventory:36]custVendid:12)
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[DInventory:36]custVendid:12)
		End if 
		If ([TallyResult:73]name:1#[Order:3]fob:45)
			QUERY:C277([TallyResult:73]; [TallyResult:73]name:1=[Order:3]fob:45)
			$rateFOB:=[TallyResult:73]real1:13
			UNLOAD RECORD:C212([TallyResult:73])
		End if 
		If ([DInventory:36]itemNum:1#[Item:4]itemNum:1)
			QUERY:C277([Item:4]; [Item:4]itemNum:1=[DInventory:36]itemNum:1)
		End if 
		//aTmpLong2{$w}:=[Order]OrderNum
		aTmp20Str1{$w}:=[Order:3]fob:45
		aTmp20Str2{$w}:=[Order:3]profile2:62
		aTmp20Str3{$w}:=[Order:3]profile3:63
		//If ([Rep]RepID#[Order]RepID)
		//SEARCH([Rep];[Rep]RepID=[Order]RepID)
		//End if 
		If ([DInventory:36]typeid:14="i@")
			aQtyNact{$w}:=Abs:C99([DInventory:36]qtyOnSO:3-[DInventory:36]qtyOnHand:2)  //Qty
		Else 
			aQtyNact{$w}:=[DInventory:36]qtyOnSO:3  //Qty
		End if 
		aTmpLong1{$w}:=[Order:3]orderNum:2
		aText1{$w}:=Substring:C12([Customer:2]customerID:1; 1; 1)
		aCustomers{$w}:=[Customer:2]company:2
		aCustAcct{$w}:=[Customer:2]customerID:1
		aQueryFieldNames{$w}:=[Customer:2]city:6
		aText2{$w}:=[Customer:2]country:9
		aPartNum{$w}:=[DInventory:36]itemNum:1
		aPartDesc{$w}:=[Item:4]description:7
		aText3{$w}:=[Item:4]typeid:26  //Group
		aText4{$w}:=[Item:4]profile1:35  //Model
		aCustRep{$w}:=[Order:3]repID:8  //
		aSaleNact{$w}:=Round:C94([DInventory:36]unitPrice:21*aQtyNact{$w}; 2)  // vR1, sales
		aScpNPlan{$w}:=Round:C94(aSaleNact{$w}*$rateFOB*0.01; 2)  // vR2, 
		vR4:=Round:C94(Num:C11([Order:3]profile2:62)/(Num:C11([Order:3]profile1:61)+(Num:C11(Num:C11([Order:3]profile1:61)=0))); 2)
		aScpNact{$w}:=Round:C94(vR4*[DInventory:36]qtyOnSO:3; 2)  // vR5
		aInvNact{$w}:=aSaleNact{$w}-aScpNPlan{$w}-aScpNact{$w}  // vR6, net sales    
	End if 
	If (($doInv) | ($doOrd))
		[DInventory:36]paceTallied:24:=True:C214
		SAVE RECORD:C53([DInventory:36])
	End if 
	NEXT RECORD:C51([DInventory:36])
End for 
READ ONLY:C145([DInventory:36])
//READ WRITE([Customer])
//READ WRITE([Order])
//READ WRITE([Rep])
//READ WRITE([Invoice])
//READ WRITE([TallyResult])