//%attributes = {"publishedWeb":true}
C_LONGINT:C283(grType; $k)
If (aPartNum=1)
	QUERY:C277([UsageSummary:33]; [UsageSummary:33]periodDate:2>=vdDateBeg; *)
	QUERY:C277([UsageSummary:33];  & [UsageSummary:33]periodDate:2<=vdDateEnd)
	$k:=Records in selection:C76([UsageSummary:33])
	SELECTION TO ARRAY:C260([UsageSummary:33]salesPlan:9; aSalesPlan; [UsageSummary:33]salesActual:10; aSalesAct; [UsageSummary:33]salesQtyPlan:3; aQtyPlan; [UsageSummary:33]salesQtyActual:4; aQtyAct; [UsageSummary:33]inventoryPlan:5; aInvenPlan; [UsageSummary:33]inventoryActual:6; aInvenAct; [UsageSummary:33]scrapPlan:7; aScrpPlan; [UsageSummary:33]scrapActual:8; aScrpAct; [UsageSummary:33]capacity:14; aCapacity; [UsageSummary:33]periodDate:2; aMonths)
	SORT ARRAY:C229(aMonths; aSalesPlan; aSalesAct; aQtyPlan; aQtyAct; aInvenPlan; aInvenAct; aScrpPlan; aScrpAct; aCapacity; >)
	grafNorTrend(Size of array:C274(aMonths))
	aChoicePlAc:=1
	grType:=4
	Title:="Trends:  "+aPartNum{aPartNum}
	GRAPH:C169(grItemP2A; grType; aMonths; aInvNact; aScpNact; aSaleNact; aQtyNact; aCapN)
	GRAPH SETTINGS:C298(grItemP2A; 0; 0; 0; 5; False:C215; False:C215; True:C214; "Inv"; "Scrp"; "Sales"; "Qty"; "Cpcty")
Else   //: (aPartNum>1)
	QUERY:C277([Usage:5]; [Usage:5]itemNum:1=aPartNum{aPartNum}; *)
	QUERY:C277([Usage:5];  & [Usage:5]periodDate:2>=vdDateBeg; *)
	QUERY:C277([Usage:5];  & [Usage:5]periodDate:2<=vdDateEnd)
	$k:=Records in selection:C76([Usage:5])
	SELECTION TO ARRAY:C260([UsageSummary:33]salesPlan:9; aSalesPlan; [UsageSummary:33]salesActual:10; aSalesAct; [UsageSummary:33]salesQtyPlan:3; aQtyPlan; [UsageSummary:33]salesQtyActual:4; aQtyAct; [UsageSummary:33]inventoryPlan:5; aInvenPlan; [UsageSummary:33]inventoryActual:6; aInvenAct; [UsageSummary:33]scrapPlan:7; aScrpPlan; [UsageSummary:33]scrapActual:8; aScrpAct; [UsageSummary:33]capacity:14; aCapacity; [UsageSummary:33]periodDate:2; aMonths)
	SORT ARRAY:C229(aMonths; aSalesPlan; aSalesAct; aQtyPlan; aQtyAct; aInvenPlan; aInvenAct; aScrpPlan; aScrpAct; aCapacity; >)
	grafNorTrend(Size of array:C274(aMonths))
	grType:=4
	Case of 
		: (aChoicePlAc=1)
			Title:="Trends:  "+aPartNum{aPartNum}
			GRAPH:C169(grItemP2A; grType; aMonths; aInvNact; aScpNact; aSaleNact; aQtyNact; aCapN)
			GRAPH SETTINGS:C298(grItemP2A; 0; 0; 0; 0; False:C215; False:C215; True:C214; "Inv"; "Scrp"; "Sales"; "Qty"; "Cpcty")
		: (aChoicePlAc=2)
			ptPlan:=->aSalesPlan
			ptAct:=->aSalesAct
			Title:="Sales: Plan to Actual:  "+aPartNum{aPartNum}
		: (aChoicePlAc=3)
			ptPlan:=->aQtyPlan
			ptAct:=->aQtyAct
			Title:="Sales Quantities: Plan to Actual:  "+aPartNum{aPartNum}
		: (aChoicePlAc=4)
			ptPlan:=->aInvenPlan
			ptAct:=->aInvenAct
			Title:="Inventory: Plan to Actual:  "+aPartNum{aPartNum}
		: (aChoicePlAc=5)
			ptPlan:=->aScrpPlan
			ptAct:=->aScrpAct
			Title:="Scrap: Plan to Actual:  "+aPartNum{aPartNum}
	End case 
	SET WINDOW TITLE:C213(Title)
	If (aChoicePlAc>1)
		If (aChoicePlAc=3)
			GRAPH:C169(grItemP2A; grType; aMonths; ptPlan->; ptAct->; aCapacity)
			GRAPH SETTINGS:C298(grItemP2A; 0; 0; 0; 0; False:C215; False:C215; True:C214; "Plan"; "Actual"; "Cpcty")
		Else 
			GRAPH:C169(grItemP2A; grType; aMonths; ptPlan->; ptAct->)
			GRAPH SETTINGS:C298(grItemP2A; 0; 0; 0; 0; False:C215; False:C215; True:C214; "Plan"; "Actual")
		End if 
	End if 
End if 