//%attributes = {"publishedWeb":true}
//Procedure: GR_Perform
//QtyAct;QtyPlan;InvtAct;CostAct;DaysLeadTime
ARRAY TEXT:C222(aX; 1)
aX{1}:="Sc/Tm/Qty/Mtl"
ARRAY REAL:C219(aY1; 1)
ARRAY REAL:C219(aY2; 1)
ARRAY REAL:C219(aY3; 1)
ARRAY REAL:C219(aY4; 1)
$PlanPeriod:=[WorkOrder:66]DTAction:5-[WorkOrder:66]DTReleased:4
$ActPeriod:=[WorkOrder:66]DTCompleted:6-[WorkOrder:66]DTReleased:4
If (($PlanPeriod>0) & ([WorkOrder:66]DTCompleted:6#0))
	aY1{1}:=($ActPeriod/$PlanPeriod)
Else 
	aY1{1}:=0
End if 
If (([WorkOrder:66]DurationPlanned:10>0) & ([WorkOrder:66]DurationActual:11#0))
	aY2{1}:=[WorkOrder:66]DurationActual:11/[WorkOrder:66]DurationPlanned:10
Else 
	aY2{1}:=0
End if 
If (([WorkOrder:66]QtyOrdered:13>0) & ([WorkOrder:66]QtyActual:14>0))
	aY3{1}:=[WorkOrder:66]QtyActual:14/[WorkOrder:66]QtyOrdered:13
Else 
	aY3{1}:=0
End if 
If (([WorkOrder:66]CostPlanned:15>0) & ([WorkOrder:66]CostActual:16>0))
	aY4{1}:=[WorkOrder:66]CostActual:16/[WorkOrder:66]CostPlanned:15
Else 
	aY4{1}:=0
End if 
GRAPH:C169(useGraf; 1; aX; aY1; aY2; aY3; aY4)
If ((aY1{1}=0) & (aY2{1}=0) & (aY3{1}=0) & (aY4{1}=0))
	GRAPH SETTINGS:C298(useGraf; 0; 0; 0; 2; False:C215; False:C215; True:C214; "S"; "T"; "Q"; "C")
Else 
	GRAPH SETTINGS:C298(useGraf; 0; 0; 0; 0; False:C215; False:C215; True:C214; "S"; "T"; "Q"; "C")
End if 