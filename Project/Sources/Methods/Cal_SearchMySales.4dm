//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 07/24/21, 17:17:14
// ----------------------------------------------------
// Method: Cal_SearchMySales
// Description
//
//
// Parameters
// ----------------------------------------------------



var bExecute : Integer
var $1; $vtUserName; $tableName : Text


var $cntDoCust; $cntOpt; $sizeArray : Integer
var $vtUserName : Text
var $QQQTesting; $vtUserAction : Text


If (Storage:C1525.user.testing)
	$QQQTesting:="dotest"
End if 
If (Count parameters:C259>0)
	$vtUserName:=$1
Else 
	If (<>aNameID>1)
		$vtUserName:=<>aNameID{<>aNameID}
	Else 
		$vtUserName:="@"
	End if 
End if 
If ($vtUserName="All User@")
	$vtUserName:="@"
End if 


Case of 
	: (Value type:C1509(<>aActions)=Is real:K8:4)
		ARRAY TEXT:C222(<>aActions; 0)
	: (Value type:C1509(<>aActions)=Is undefined:K8:13)
		ARRAY TEXT:C222(<>aActions; 0)
End case 
If (Size of array:C274(<>aActions)=0)
	ARRAY TEXT:C222(<>aActions; 1)
	<>aActions{1}:="Actions"
End if 
If (<>aActions>1)
	$vtUserAction:=<>aActions{<>aActions}
Else 
	$vtUserAction:="@"
End if 
// from outside variables
//vdDateBeg:=!2021-01-01!
//vdDateEnd:=Current date+2
If (<>viDebugMode>410)
	ConsoleLog("Cal_SearchMySales: user: "+$vtUserName+", and action: "+$vtUserAction+" length: "+String:C10(cServiceBuild.length))
End if 
var cServiceBuild : Collection
cServiceBuild:=New collection:C1472

var $obSel : Object
$obSel:=New object:C1471
var $filter_c : Collection
$filter_c:=New collection:C1472
//cServiceBuild:=New collection
var $obRec : Object
var $temp_c; $setup_c : Collection

var $vtQuery : Text
$setup_c:=New collection:C1472  //  look a generalizing
var vdDateBeg; vdDateEnd : Date
If (vdDateEnd=!00-00-00!)
	vdDateEnd:=Current date:C33+365
End if 
$tableName:="Order"
$vtQuery:="actionBy = :1 AND actionDate >= :2 AND actionDate <= :3 AND action = :4"
$filter_c:=Split string:C1554("actionBy;action;actionDate;actionTime;company;address1;city;state;zip;phone;phoneCell;email;attention;profile1;comment;id"; ";")
$obSel:=ds:C1482[$tableName].query($vtQuery; $vtUserName; vdDateBeg; vdDateEnd; $vtUserAction)
process_o.ents.Order:=$obSel  // populate .ents.
If ($obSel.length=0)
	If ($QQQTesting#"")
		$obSel:=ds:C1482[$tableName].all().slice(1; 3)
	End if 
End if 
If ($obSel#Null:C1517)
	$temp_c:=$obSel.toCollection($filter_c)
	For each ($obRec; $temp_c)
		$obRec.tableName:=$tableName
		$obRec.variable:=$obRec.profile1
		cServiceBuild.push($obRec)
	End for each 
End if 

$obSel:=ds:C1482.Invoice.query($vtQuery; $vtUserName; vdDateBeg; vdDateEnd; $vtUserAction)
process_o.ents.Invoice:=$obSel  // populate .ents.
$tableName:="Invoice"
If ($obSel.length=0)
	If ($QQQTesting#"")
		$obSel:=ds:C1482[$tableName].all().slice(1; 3)
	End if 
End if 
If ($obSel#Null:C1517)
	$temp_c:=$obSel.toCollection($filter_c)
	For each ($obRec; $temp_c)
		$obRec.tableName:="Invoice"
		$obRec.variable:=$obRec.profile1
		cServiceBuild.push($obRec)
	End for each 
End if 


$obSel:=ds:C1482.Proposal.query($vtQuery; $vtUserName; vdDateBeg; vdDateEnd; $vtUserAction)
process_o.ents.Proposal:=$obSel  // populate .ents.
$tableName:="Proposal"
If ($obSel.length=0)
	If ($QQQTesting#"")
		$obSel:=ds:C1482[$tableName].all().slice(1; 3)
	End if 
End if 
If ($obSel#Null:C1517)
	$temp_c:=$obSel.toCollection($filter_c)
	For each ($obRec; $temp_c)
		$obRec.tableName:="Proposal"
		$obRec.variable:=$obRec.profile1
		cServiceBuild.push($obRec)
	End for each 
End if 


$filter_c:=Split string:C1554("actionBy;action;actionDate;actionTime;company;address1;city;state;zip;phone;phoneCell;email;nameFirst;nameLast;need;id"; ";")

$vtQuery:="actionBy = :1 OR salesNameID = :1 AND actionDate >= :2 AND actionDate <= :3 AND action = :4"

$obSel:=ds:C1482.Customer.query($vtQuery; $vtUserName; vdDateBeg; vdDateEnd; $vtUserAction)
process_o.ents.Customer:=$obSel  // populate .ents.
$tableName:="Customer"
If ($obSel.length=0)
	If ($QQQTesting#"")
		$obSel:=ds:C1482[$tableName].all().slice(1; 7)
	End if 
End if 
If ($obSel#Null:C1517)
	$temp_c:=$obSel.toCollection($filter_c)
	For each ($obRec; $temp_c)
		$obRec.tableName:="Customer"
		$obRec.variable:=$obRec.need
		$obRec.attention:=$obRec.nameFirst+(" "*Num:C11(Not:C34(($obRec.nameFirst="") | ($obRec.nameLast=""))))+$obRec.nameLast
		cServiceBuild.push($obRec)
	End for each 
End if 



If (False:C215)
	$filter_c:=Split string:C1554("actionBy;action;actionDate;actionTime;company;address1;city;state;zip;phone;phoneCell;email;attention;description;id"; ";")
	
	$obSel:=ds:C1482.WorkOrder.query($vtQuery; $vtUserName; vdDateBeg; vdDateEnd; $vtUserAction)
	process_o.ents.WorkOrder:=$obSel  // populate .ents.
	$tableName:="WorkOrder"
	If ($obSel.length=0)
		If ($QQQTesting#"")
			$obSel:=ds:C1482[$tableName].all().slice(1; 3)
		End if 
	End if 
	If ($obSel#Null:C1517)
		$temp_c:=$obSel.toCollection($filter_c)
		For each ($obRec; $temp_c)
			$obRec.tableName:="WorkOrder"
			$obRec.variable:=$obRec.description
			cServiceBuild.push($obRec)
		End for each 
	End if 
	
	$filter_c:=Split string:C1554("actionBy;action;actionDate;actionTime;company;address1;city;state;zip;phone;phoneCell;email;attention;description;id"; ";")
	$obSel:=ds:C1482.Project.query($vtQuery; $vtUserName; vdDateBeg; vdDateEnd; $vtUserAction)
	process_o.ents.Project:=$obSel  // populate .ents.
	$tableName:="Project"
	If ($obSel.length=0)
		If ($QQQTesting#"")
			$obSel:=ds:C1482[$tableName].all().slice(1; 3)
		End if 
	End if 
	If ($obSel#Null:C1517)
		$temp_c:=$obSel.toCollection($filter_c)
		For each ($obRec; $temp_c)
			$obRec.tableName:="Project"
			$obRec.variable:=$obRec.description
			cServiceBuild.push($obRec)
		End for each 
	End if 
	
	
	$filter_c:=Split string:C1554("actionBy;action;actionDate;actionTime;company;address1;city;state;zip;phone;phoneCell;email;nameFirst;nameLast;profile1;id"; ";")
	$obSel:=ds:C1482.Contact.query($vtQuery; $vtUserName; vdDateBeg; vdDateEnd; $vtUserAction)
	process_o.ents.Contact:=$obSel
	$tableName:="Contact"
	If ($obSel.length=0)
		If ($QQQTesting#"")
			$obSel:=ds:C1482[$tableName].all().slice(1; 3)
		End if 
	End if 
	If ($obSel#Null:C1517)
		// filter the needed values
		$temp_c:=$obSel.toCollection($filter_c)
		
		// add additional things required to make it uniform to the This. columns
		For each ($obRec; $temp_c)
			$obRec.tableName:="Contact"
			$obRec.variable:=$obRec.profile1
			$obRec.attention:=$obRec.nameFirst+" "+$obRec.nameLast
			cServiceBuild.push($obRec)
		End for each 
	End if 
	
	$filter_c:=Split string:C1554("actionBy;action;dtAction;company;address1;city;state;zip;phone;phoneCell;email;attention;description;id"; ";")
	var $dtBegin_l; $dtEnd_l : Integer
	$dtBegin_l:=DateTime_DTTo(vdDateBeg; ?00:00:00?)
	$dtEnd_l:=DateTime_DTTo(vdDateEnd; ?23:59:59?)
	$vtQuery:="actionBy = :1 AND dtAction >= :2 AND dtAction <= :3 AND action = :4"
	$obSel:=ds:C1482.Service.query($vtQuery; $vtUserName; $dtBegin_l; $dtEnd_l; $vtUserAction)
	process_o.ents.Service:=$obSel  // populate .ents.
	$tableName:="Service"
	If ($obSel.length=0)
		If ($QQQTesting#"")
			$obSel:=ds:C1482[$tableName].all().slice(1; 3)
		End if 
	End if 
	If ($obSel#Null:C1517)
		$temp_c:=$obSel.toCollection($filter_c)
		
		var $vActionDate : Date
		var $vActionTime : Time
		For each ($obRec; $temp_c)
			$obRec.tableName:="Service"
			DateTime_DTFrom($obRec.dtAction; ->$vActionDate; ->$vActionTime)
			$obRec.actionDate:=$vActionDate
			$obRec.actionTime:=$vActionTime
			$obRec.variable:=$obRec.description
			cServiceBuild.push($obRec)
		End for each 
	End if 
	
	
	$obSel:=ds:C1482.CallReport.query($vtQuery; $vtUserName; $dtBegin_l; $dtEnd_l; $vtUserAction)
	process_o.ents.CallReport:=$obSel  // populate .ents.
	$tableName:="CallReport"
	If ($obSel.length=0)
		If ($QQQTesting#"")
			$obSel:=ds:C1482[$tableName].all().slice(1; 3)
		End if 
	End if 
	If ($obSel#Null:C1517)
		// filter the needed values
		$filter_c:=Split string:C1554("actionBy,action,dtAction,company,address1,city,state,zip,phone,phoneCell,email,attention,status,id"; ";")
		$temp_c:=$obSel.toCollection($filter_c)
		// add additional things required to make it uniform to the This. columns
		For each ($obRec; $temp_c)
			$obRec.tableName:="CallReport"
			DateTime_DTFrom($obRec.dtAction; ->$vActionDate; ->$vActionTime)
			$obRec.actionDate:=$vActionDate
			$obRec.actionTime:=$vActionTime
			$obRec.variable:=$obRec.description
			cServiceBuild.push($obRec)
		End for each 
	End if 
End if 
viLengthC:=cServiceBuild.length


// QQQents
var cServiceAction : Object
cServiceAction:=New object:C1471("ents"; New collection:C1472; "cur"; New object:C1471; "sel"; New collection:C1472; "pos"; 0)

cServiceAction.data:=cServiceBuild
