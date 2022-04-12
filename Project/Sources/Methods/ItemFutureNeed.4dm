//%attributes = {"publishedWeb":true}
//C_LONGINT($k;$i;$w;$t;$e;$eCnt)
//If (vHere=0)
//jsetDefaultFile (File([Item]))
//SEARCH([Item])
//If (OK=1)
//myOK:=1
//Else 
//myOK:=0
//End if 
//Else 
//myOK:=1
//End if 
//If (myOK=1)
//$k:=Records in selection([Item])
//If ($k>0)
//FIRST RECORD([Item])
//$curMon:=Month of(Date(Request("Project estimates for month beginning 
//"+String(Month of(Current date))+"/1/"+String(Year of(Current date)))))
//$1mon:=Date(String(($curMon-1)+(12*Num($curMon<=1)))+"/1/"+String(Year
// of(Current date)-(1*Num($curMon=1))))
//$2mon:=Date(String(($curMon-2)+(12*Num($curMon<=2)))+"/1/"+String(Year
// of(Current date)-(1*Num($curMon=2))))
//$3mon:=Date(String(($curMon-3)+(12*Num($curMon<=3)))+"/1/"+String(Year
// of(Current date)-(1*Num($curMon=3))))
//For ($i;1;$k)
//MESSAGE("Processing record "+String($i)+" of "+String($k)+".")
//$avgQty:=0
//$avgSales:=0
//$avgInvCnts:=0
//$avgInvtry:=0
//$avgScrap:=0
//$avgCost:=0
//$avgOrdCnts:=0
//$avgOrds:=0
//$avgOrdQty:=0
//SEARCH([Usage];[Usage]ItemNum=[Item]ItemNum)
//CREATE SET([Usage];"Current")
//SEARCH SELECTION([Usage];([Usage]PeriodDate=$1mon)|([Usage
//]PeriodDate=$2mon)|([Usage]PeriodDate=$3mon))
//$recSel:=Records in selection([Usage])
//If ($recSel>0)
//$avgQty:=(Sum([Usage]SalesQtyActual)/$recSel)
//$avgSales:=(Sum([Usage]SalesActual)/$recSel)
//$avgInvCnts:=(Sum([Usage]NumInvoices)/$recSel)
//$avgInvtry:=(Sum([Usage]InventoryActual)/$recSel)
//$avgScrap:=(Sum([Usage]ScrapActual)/$recSel)
//$avgCost:=(Sum([Usage]CostActual)/$recSel)
//$avgOrdCnts:=(Sum([Usage]NumOrders)/$recSel)
//$avgOrds:=(Sum([Usage]OrdersActual)/$recSel)
//$avgOrdQty:=(Sum([Usage]OrdQtyActual)/$recSel)
//USE SET("Current")
//CLEAR SET("Current")
//SEARCH SELECTION([Usage];[Usage]PeriodDate=Date(String($curMon)+"
///1/"+String(Year of(Current date))))
//If (Records in selection([Usage])=0)
//CREATE RECORD([Usage])
//
//[Usage]ItemNum:=[Item]ItemNum
//End if 
//[Usage]SalesQtyPlan:=$avgQty
//[Usage]SalesPlan:=$avgSales
//[Usage]InventoryPlan:=$avgInvtry
//[Usage]ScrapPlan:=$avgScrap
//[Usage]CostPlan:=$avgCost
//[Usage]OrdersPlan:=$avgOrds
//[Usage]OrdQtyPlan:=$avgOrdQty
//SAVE RECORD([Usage])
//End if 
//// $avgInvCnts
////  $avgOrdCnts
//[Item]QtyMin:=(([Item]LeadTime/30)*[Usage]OrdQtyActual)
//SAVE RECORD([Item])
//NEXT RECORD([Item])
//End for 
//End if 
//End if 