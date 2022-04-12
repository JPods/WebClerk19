//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/30/18, 12:55:06
// ----------------------------------------------------
// Method: AdSourceCalc
// Description
// 
//
// Parameters
// ----------------------------------------------------



If (([QQQAdSource:35]NumCustPlan:17+[QQQAdSource:35]NumLeadPlan:19)>0)
	[QQQAdSource:35]CostRespPlan:21:=Round:C94([QQQAdSource:35]CostPlan:23/([QQQAdSource:35]NumCustPlan:17+[QQQAdSource:35]NumLeadPlan:19); 2)
Else 
	[QQQAdSource:35]CostRespPlan:21:=[QQQAdSource:35]CostPlan:23
End if 

If (([QQQAdSource:35]NumCustAct:16+[QQQAdSource:35]NumLeadAct:18)>0)
	[QQQAdSource:35]CostRespAct:20:=Round:C94([QQQAdSource:35]CostAct:22/([QQQAdSource:35]NumCustAct:16+[QQQAdSource:35]NumLeadAct:18); 2)
Else 
	[QQQAdSource:35]CostRespAct:20:=[QQQAdSource:35]CostAct:22
End if 

If ([QQQAdSource:35]ValueOrdAct:13>0)
	vRM1:=Round:C94([QQQAdSource:35]PaceSales1:42/[QQQAdSource:35]ValueOrdAct:13*100; 1)
	vRM2:=Round:C94([QQQAdSource:35]PaceSales2:43/[QQQAdSource:35]ValueOrdAct:13*100; 1)
	vRM3:=Round:C94([QQQAdSource:35]PaceSales3:44/[QQQAdSource:35]ValueOrdAct:13*100; 1)
	vRM4:=Round:C94([QQQAdSource:35]PaceSales4:45/[QQQAdSource:35]ValueOrdAct:13*100; 1)
	vRM5:=Round:C94([QQQAdSource:35]PaceSales5:46/[QQQAdSource:35]ValueOrdAct:13*100; 1)
Else 
	vRM1:=0
	vRM2:=0
	vRM3:=0
	vRM4:=0
	vRM5:=0
End if 

C_PICTURE:C286(vPGraf)
ARRAY TEXT:C222($aXaxis; 4)
$aXaxis{1}:="$"
$aXaxis{2}:="$/R"
$aXaxis{3}:="#I"
$aXaxis{4}:="$I"


ARRAY TEXT:C222($aColors; 4)
ARRAY REAL:C219($aYDollars; 1)
ARRAY REAL:C219($aYDollarsPerLead; 1)
ARRAY REAL:C219($aYOrdersCount; 1)
ARRAY REAL:C219($aYOrdersValue; 1)


ARRAY REAL:C219($aY; 4)

C_REAL:C285($rCostperPlan; $rResponse; $rOrderCount)



If ([QQQAdSource:35]CostPlan:23>0)
	$rCostperPlan:=[QQQAdSource:35]CostAct:22/[QQQAdSource:35]CostPlan:23
	$aYDollars{1}:=$rCostperPlan
	$aY{1}:=$rCostperPlan
Else 
	$aYDollars{1}:=-0.1
End if 
If ($aYDollars{1}<1)
	$aColors{1}:="#FF0000"
Else 
	$aColors{1}:="#00FF00"
End if 

If ([QQQAdSource:35]CostRespPlan:21>0)
	$rResponse:=[QQQAdSource:35]CostRespAct:20/[QQQAdSource:35]CostRespPlan:21
	$aYDollarsPerLead{1}:=$rResponse
	$aY{2}:=$rResponse
Else 
	$aYDollarsPerLead{1}:=-0.1
End if 
If ($aYDollarsPerLead{1}<1)
	$aColors{2}:="#FF0000"
Else 
	$aColors{2}:="#00FF00"
End if 


If ([QQQAdSource:35]NumOrdPlan:14>0)
	$rOrderCount:=[QQQAdSource:35]NumOrdAct:12/[QQQAdSource:35]NumOrdPlan:14
	$aYOrdersCount{1}:=$aYOrdersCount
	$aY{3}:=$rResponse
Else 
	$aYOrdersCount{1}:=-0.1
End if 
If ($aYOrdersCount{1}>1)
	$aColors{3}:="#FF0000"
Else 
	$aColors{3}:="#00FF00"
End if 


If ([QQQAdSource:35]ValueOrdPlan:15>0)
	$rOrderValue:=[QQQAdSource:35]ValueOrdAct:13/[QQQAdSource:35]ValueOrdPlan:15
	$aYOrdersValue{1}:=$rOrderValue
	$aY{4}:=$rOrderValue
Else 
	$aYOrdersValue{1}:=-0.1
End if 

If ($aYOrdersValue{1}>1)
	$aColors{4}:="#FF0000"
Else 
	$aColors{4}:="#00FF00"
End if 

//  http://doc.4d.com/4Dv15/4D/15.4/GRAPH.301-3273700.en.html
// 1 column
// 2 Proportional Columns
// 3 Stacked Columns
// 4 Line
// 5 Area
// 6 Scatter
// 7 Pie
// 8 Picture

C_OBJECT:C1216($vSettings)
OB SET:C1220($vSettings; Graph type:K82:1; 1)
OB SET:C1220($vSettings; Graph font size:K82:20; 32)
OB SET ARRAY:C1227($vSettings; Graph colors:K82:22; $aColors)
OB SET:C1220($vSettings; Graph display legend:K82:10; False:C215)

C_REAL:C285($opt)
$opt:=0
If ($opt=1)
	// does not work
	// GRAPH(vPGraf;$vSettings;$aXaxis;$aYDollars;$aYDollarsPerLead;'$aYOrdersDollar;'$aYOrdersCount)
Else 
	GRAPH:C169(vPGraf; $vSettings; $aXaxis; $aY)
End if 

// graphPicture Picture variableinPicture variable
// xmin Longint, Date, TimeinMinimum x-axis value for proportional graph (line or scatter plot only)
// xmax Longint, Date, TimeinMaximum x-axis value for proportional graph (line or scatter plot only)
// ymin LongintinMinimum y-axis value
// ymax LongintinMaximum y-axis value
// xprop BooleaninTRUE for proportional x-axis; FALSE for normal x-axis (line or scatter plot only)
// xgrid BooleaninTRUE for x-axis grid; FALSE for no x-axis grid (only if xprop is TRUE)
// ygrid BooleaninTRUE for y-axis grid; FALSE for no y-axis grid
// title StringinTitle(s) for graph legend(s)

GRAPH SETTINGS:C298(vPGraf; 0; 0; 0; 0; False:C215; False:C215; True:C214)