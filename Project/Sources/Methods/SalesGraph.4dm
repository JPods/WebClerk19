//%attributes = {}

//<declarations>
//==================================
//  Type variables 
//==================================

// $aiYear;$arYear;variable;vgSalesGraph;vSettings
C_LONGINT:C283($vi1; $viCurrentYear; $viYears)
C_TEXT:C284($1; $vtArray; $vtFormula)
C_POINTER:C301($vpArray)

//==================================
//  Initialize variables 
//==================================

$vi1:=0
$viCurrentYear:=0
$viYears:=0
$vtArray:=""
$vtFormula:=""
//</declarations>

ARRAY REAL:C219($arYear1; 12)
ARRAY REAL:C219($arYear2; 12)
ARRAY REAL:C219($arYear3; 12)
ARRAY REAL:C219($arYear4; 12)

ARRAY POINTER:C280($apYear; 4)
$apYear{1}:=->$arYear1
$apYear{2}:=->$arYear2
$apYear{3}:=->$arYear3
$apYear{4}:=->$arYear4

$vtGraphSelected:=$1
ConsoleLog("$vtGraphSelected\t"+$vtGraphSelected)

ARRAY LONGINT:C221($aiYear; 0)
ARRAY TEXT:C222($atYear; 0)
$viCurrentYear:=Year of:C25(Current date:C33)
APPEND TO ARRAY:C911($aiYear; $viCurrentYear)
APPEND TO ARRAY:C911($atYear; String:C10($viCurrentYear))
$viYears:=3

For ($vi1; 1; $viYears)
	APPEND TO ARRAY:C911($aiYear; $viCurrentYear-$vi1)
	APPEND TO ARRAY:C911($atYear; String:C10($viCurrentYear-$vi1))
End for 

SORT ARRAY:C229($aiYear; $atYear; >)

For ($vi1; 1; Size of array:C274($aiYear))
	ConsoleLog("$atYear{$vi1}\t"+$atYear{$vi1})
	QUERY:C277([GenericChild1:90]; [GenericChild1:90]purpose:4="SalesStats"; *)
	QUERY:C277([GenericChild1:90];  & [GenericChild1:90]lI05:10=$aiYear{$vi1})
	ConsoleLog("Records\t"+String:C10(Records in selection:C76([GenericChild1:90])))
	$vtArray:="$arYear"+String:C10($vi1)
	ConsoleLog("$vtArray\t"+$vtArray)
	
	
	FIRST RECORD:C50([GenericChild1:90])
	For ($vi2; 1; Size of array:C274($apYear{$vi1}->))
		
		Case of 
			: ($vtGraphSelected="Orders Total")
				$apYear{$vi1}->{$vi2}:=[GenericChild1:90]r01:18
				
			: ($vtGraphSelected="Orders Amount")
				$apYear{$vi1}->{$vi2}:=[GenericChild1:90]r02:19
				
			: ($vtGraphSelected="Invoices Total")
				$apYear{$vi1}->{$vi2}:=[GenericChild1:90]r03:20
				
			: ($vtGraphSelected="Invoices Amount")
				$apYear{$vi1}->{$vi2}:=[GenericChild1:90]r04:21
		End case 
		NEXT RECORD:C51([GenericChild1:90])
	End for 
	
End for 

ARRAY TEXT:C222($atMonth; 12)
$atMonth{1}:="Jan"
$atMonth{2}:="Feb"
$atMonth{3}:="Mar"
$atMonth{4}:="Apr"
$atMonth{5}:="May"
$atMonth{6}:="Jun"
$atMonth{7}:="Jul"
$atMonth{8}:="Aug"
$atMonth{9}:="Sep"
$atMonth{10}:="Oct"
$atMonth{11}:="Nov"
$atMonth{12}:="Dec"

C_PICTURE:C286(vgSalesGraph)  //Graph variable
// C_OBJECT(voSettings)  //Initialize graph settings
// OB SET(voSettings;Graph type;1)  //Line type
// OB SET ARRAY(voSettings;Graph legend labels;$atYear)
// OB SET(voSettings;Graph column width min;40)
// OB SET(voSettings;Graph default height;1000)
// OB SET(voSettings;Graph column gap;20)
// OB SET(voSettings;Graph font size;48)
// OB SET(voSettings;Graph left margin;100)wa
// OB SET(voSettings;Graph right margin;100)
// OB SET(voSettings;Graph top margin;100)
// OB SET(voSettings;Graph bottom margin;100)
// OB SET(voSettings;Graph legend icon gap;50)
// OB SET(voSettings;Graph legend icon height;40)
// OB SET(voSettings;Graph legend icon width;40)

// check size of arrays
ConsoleLog("$atMonth\t"+String:C10(Size of array:C274($atMonth)))
ConsoleLog("$arYear1\t"+String:C10(Size of array:C274($arYear1)))
ConsoleLog("$arYear2\t"+String:C10(Size of array:C274($arYear2)))
ConsoleLog("$arYear3\t"+String:C10(Size of array:C274($arYear3)))
ConsoleLog("$arYear4\t"+String:C10(Size of array:C274($arYear4)))

//GRAPH(vgSalesGraph;voSettings;$atMonth;$arYear1;$arYear2;$arYear3;$arYear4)  //Draw graph

GRAPH:C169(vgSalesGraph; 1; $atMonth; $arYear1; $arYear2; $arYear3; $arYear4)  //Draw graph
GRAPH SETTINGS:C298(vgSalesGraph; 0; 12; 0; 3000000; False:C215; True:C214; True:C214; $atYear{1}; $atYear{2}; $atYear{3}; $atYear{4})
// GRAPH SETTINGS ( graphPicture ; xmin ; xmax ; ymin ; ymax ; xprop ; xgrid ; ygrid ; title {; title2 ; ... ; titleN} )  
// 
// Parameter Type Description 
// graphPicture  Picture variable Picture variable 
// xmin  Longint, Date, Time Minimum x-axis value for proportional graph (line or scatter plot only) 
// xmax  Longint, Date, Time Maximum x-axis value for proportional graph (line or scatter plot only) 
// ymin  Longint Minimum y-axis value 
// ymax  Longint Maximum y-axis value 
// xprop  Boolean TRUE for proportional x-axis; FALSE for normal x-axis (line or scatter plot only) 
// xgrid  Boolean TRUE for x-axis grid; FALSE for no x-axis grid (only if xprop is TRUE) 
// ygrid  Boolean TRUE for y-axis grid; FALSE for no y-axis grid 
// title  String Title(s) for graph legend(s)


$vdSOM:=Current date:C33-Day of:C23(Current date:C33)+1
$vdEOM:=Add to date:C393($vdSOM; 0; 1; -1)
$vdToday:=Current date:C33

// testing 3 tears ago 
If (<>VIDEBUGMODE=333)
	$vdSOM:=Add to date:C393($vdSOM; -3; 0; 0)
	$vdEOM:=Add to date:C393($vdEOM; -3; 0; 0)
	$vdToday:=Add to date:C393($vdToday; -3; 0; 0)
End if 

Case of 
	: ($vtGraphSelected="@Total")
		$vpOrderField:=->[Order:3]total:27
		$vpInvoiceField:=->[Invoice:26]total:18
		
	: ($vtGraphSelected="@Amount")
		$vpOrderField:=->[Order:3]amount:24
		$vpInvoiceField:=->[Invoice:26]amount:14
End case 

QUERY:C277([Order:3]; [Order:3]dateDocument:4>=$vdSOM; *)
QUERY:C277([Order:3]; [Order:3]dateDocument:4<=$vdEOM)
vrOrdersThisMonth:=Sum:C1($vpOrderField->)

QUERY:C277([Order:3]; [Order:3]dateDocument:4=$vdToday)
vrOrdersToday:=Sum:C1($vpOrderField->)

QUERY:C277([Invoice:26]; [Invoice:26]dateDocument:35>=$vdSOM; *)
QUERY:C277([Invoice:26]; [Invoice:26]dateDocument:35<=$vdEOM)
vrInvoicesThisMonth:=Sum:C1($vpInvoiceField->)

QUERY:C277([Invoice:26]; [Invoice:26]dateDocument:35=$vdToday)
vrInvoicesToday:=Sum:C1($vpInvoiceField->)

