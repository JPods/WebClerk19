//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/22/21, 20:34:01
// ----------------------------------------------------
// Method: LBX_DraftColumsFromArrays
// Description
// 
// Parameters
// list of array names
// list of array labels
// ----------------------------------------------------

var $arrayName_t; $labelNames_t; $vtColumnName; $lbName_t; $columnAdder_t; $vtHeader; $vtHeaderText; $vtFooter : Text
var $arrays_c; $labels_c : Collection
var $viCount; $align_i : Integer

$arrays_c:=Split string:C1554($1; ",")
$labels_c:=Split string:C1554($2; ",")
$lbName_t:="LBReplaceName"
$columnAdder_t:=""

C_POINTER:C301($ptArray)

var $result_o; $collumn_o; $0 : Object
var $columns_c : Collection
$columns_c:=New collection:C1472
$viCount:=0
For each ($arrayName_t; $arrays_c)
	$vtColumnName:="Column_"+$lbName_t+"_"+$arrayName_t+"_"+$columnAdder_t
	$vtHeader:="Header_"+$lbName_t+"_"+$arrayName_t+"_"+$columnAdder_t
	$vtFooter:="Footer_"+$lbName_t+"_"+$arrayName_t+"_"+$columnAdder_t
	$collumn_o:=New object:C1471
	If ($labels_c.length>$viCount)
		$vtHeaderText:=$labels_c[$viCount]
	Else 
		$vtHeaderText:="addName"
	End if 
	$collumn_o.name:=$vtColumnName
	$collumn_o.dataSource:=$arrayName_t
	//$collumn_o.className:=""
	//$collumn_o.valueName:=""
	$collumn_o.header:=New object:C1471("name"; $vtHeader; "text"; $vtHeaderText)
	$collumn_o.footer:=New object:C1471("name"; $vtFooter)
	$collumn_o.wordWrap:=0
	
	$ptArray:=Get pointer:C304($arrayName_t)
	If ($ptArray#Null:C1517)
		Case of 
			: (Type:C295($ptArray->)=LongInt array:K8:19)
				$collumn_o.format:=""
				$collumn_o.align:=3
				$collumn_o.displayType:=0
				$collumn_o.width:=80
			: (Type:C295($ptArray->)=Real array:K8:17)
				$collumn_o.format:=""
				$collumn_o.align:=3
				//$collumn_o.displayType:=0
				$collumn_o.width:=80
			: (Type:C295($ptArray->)=Time array:K8:29)
				$collumn_o.format:=""
				$collumn_o.align:=2
				//$collumn_o.displayType:=0
				$collumn_o.width:=70
			: (Type:C295($ptArray->)=Date array:K8:20)
				$collumn_o.format:=""
				$collumn_o.align:=2
				//$collumn_o.displayType:=0
				$collumn_o.width:=70
			: (Type:C295($ptArray->)=Boolean array:K8:21)
				$collumn_o.format:=""
				$collumn_o.align:=2
				//$collumn_o.displayType:=0
				$collumn_o.width:=30
			: ((Type:C295($ptArray->)=String array:K8:15) | (Type:C295($ptArray->)=Text array:K8:16))
				$collumn_o.format:=""
				$collumn_o.align:=1
				//$collumn_o.displayType:=0
				$collumn_o.width:=120
				
		End case 
	End if 
	$collumn_o.bgColor:=""
	$collumn_o.fontColor:=""
	$collumn_o.resizable:=True:C214
	
	$columns_c.push($collumn_o)
	$viCount:=$viCount+1
End for each 
$0:=New object:C1471("columns"; $columns_c)