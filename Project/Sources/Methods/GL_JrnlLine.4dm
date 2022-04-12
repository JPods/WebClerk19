//%attributes = {"publishedWeb":true}
//(P) GL_JrnlLine
C_TEXT:C284($1)  //Item
C_REAL:C285($2; $3)  //Price;Cost
C_POINTER:C301(ptSales; ptCost; ptInv)
If (Not:C34(($2=0) & ($3=0)))
	If ($1#[Item:4]itemNum:1)
		QUERY:C277([Item:4]; [Item:4]itemNum:1=$1)
	End if 
	If (Records in selection:C76([Item:4])=1)
		ptSales:=(->[Item:4]salesGlAccount:21)
		ptCost:=(->[Item:4]costGLAccount:22)
		ptInv:=(->[Item:4]inventoryGlAccount:23)
	Else 
		SEND PACKET:C103(sumDoc; "Default account:  Item "+$1+"; Price "+String:C10($2)+"; Cost "+String:C10($3)+".")
		ptSales:=(->[DefaultAccount:32]ItemSalesAcct:24)
		ptCost:=(->[DefaultAccount:32]ItemCostofGoods:25)
		ptInv:=(->[DefaultAccount:32]ItemInventory:26)
	End if 
	If ([QQQCustomer:2]salesGL:80#"")
		ptSales:=(->[QQQCustomer:2]salesGL:80)
	End if 
	If ($2#0)  //extended price
		GL_JrnlLineAdd(->aGLAll; ptSales; ->LSDistAmts; -$2)
	End if 
	//
	If ($3#0)  //Cost
		GL_JrnlLineAdd(->aGLAll; ptCost; ->LSDistAmts; $3)
		GL_JrnlLineAdd(->aGLAll; ptInv; ->LSDistAmts; -$3)
	End if 
Else 
	ptSales:=(->[DefaultAccount:32]ItemSalesAcct:24)
	ptCost:=(->[DefaultAccount:32]ItemCostofGoods:25)
	ptInv:=(->[DefaultAccount:32]ItemInventory:26)
End if 