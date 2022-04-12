//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-08-27T00:00:00, 01:54:42
// ----------------------------------------------------
// Method: jsonArrayBuildParse
// Description
// Modified: 08/27/17
// 
// 
//
// Parameters
// ----------------------------------------------------

//
//JSON syntax is based on the following principles:
//
//data consists of name/value pairs,
//data is separated by commas,
//objects are defined by braces {},
//arrays are defined by brackets [ ].

If (False:C215)
	C_OBJECT:C1216($ref)
	ARRAY OBJECT:C1221($sel; 0)
	ARRAY OBJECT:C1221($sel2; 0)
	C_TEXT:C284($v_String)
	
	OB SET:C1220($ref; "name"; ->[Customer:2]company:2)
	OB SET:C1220($ref; "city"; ->[Customer:2]city:6)
	
	While (Not:C34(End selection:C36([Customer:2])))
		$ref_company:=OB Copy:C1225($ref; True:C214)
		APPEND TO ARRAY:C911($sel; $ref_company)
		// $sel{1}={"name":"4D SAS","city":"Clichy"}
		// $sel{2}={"name":"MyComp","city":"Lyon"}
		// ...
		NEXT RECORD:C51([Customer:2])
	End while 
	
	v_String:=JSON Stringify array:C1228($sel)
	// v_String= [{"name":"4D SAS","city":"Clichy"},{"name":"MyComp","city":"Lyon"}...]
	JSON PARSE ARRAY:C1219(v_String; $sel2)
	// $sel2{1}={"name":"4D SAS","city":"Clichy"}
	// $sel2{2}={"name":"MyComp","city":"Lyon"}
	//...
End if 


C_OBJECT:C1216($template)
C_TEXT:C284($tableName; $0)
C_LONGINT:C283($inc; $cnt; $tableNum)
C_POINTER:C301($ptTable; $ptField; $1; $2)
ARRAY LONGINT:C221($aFieldNums; 0)
ARRAY POINTER:C280($aPtFields; 0)

If (Count parameters:C259=0)  // to work in Summary Editor
	curTableNum:=2
	// gngngn qqqq testing
	////
	$tableNum:=curTableNum
	$ptTable:=Table:C252($tableNum)
	$cnt:=Size of array:C274(aFieldLns)
	ARRAY POINTER:C280($aPtFields; $cnt)
	For ($inc; 1; $cnt)
		$aPtFields{$inc}:=Field:C253(curTableNum; theFldNum{aFieldLns{$inc}})
	End for 
	ALL RECORDS:C47($ptTable->)
	REDUCE SELECTION:C351(Table:C252(curTableNum)->; 10)
Else 
	$ptTable:=$1
	COPY ARRAY:C226($2; $aPtFields)
End if 
$tableName:="["+Table name:C256($ptTable)+"]"
$cnt:=Size of array:C274(aFieldLns)


For ($inc; 1; 5)
	OB SET:C1220($template; Field name:C257($aPtFields{$inc}); $aPtFields{$inc})  //custom label and a single field
End for 
$0:=Selection to JSON:C1234($ptTable->; $template)

// above works


ARRAY OBJECT:C1221($sel; 0)
ARRAY OBJECT:C1221($sel2; 0)
C_OBJECT:C1216($template_customer)
C_TEXT:C284($v_String)
FIRST RECORD:C50([Customer:2])
While (Not:C34(End selection:C36([Customer:2])))
	$template_customer:=OB Copy:C1225($template; True:C214)
	APPEND TO ARRAY:C911($sel; $template_customer)
	// $sel{1}={"name":"4D SAS","city":"Clichy"}
	// $sel{2}={"name":"MyComp","city":"Lyon"}
	// ...
	NEXT RECORD:C51([Customer:2])
End while 
$v_String:=JSON Stringify array:C1228($sel)
$0:=$0+(3*"\r")+$v_String
REDUCE SELECTION:C351(Table:C252(curTableNum)->; 0)

// above works

ARRAY OBJECT:C1221($sel; 0)
ARRAY OBJECT:C1221($selOrderLines; 0)
C_OBJECT:C1216($template_customer)
C_TEXT:C284($v_String)
FIRST RECORD:C50([Customer:2])
While (Not:C34(End selection:C36([Customer:2])))
	$template_customer:=OB Copy:C1225($template; True:C214)
	APPEND TO ARRAY:C911($sel; $template_customer)
	// $sel{1}={"name":"4D SAS","city":"Clichy"}
	// $sel{2}={"name":"MyComp","city":"Lyon"}
	// ...
	NEXT RECORD:C51([Customer:2])
End while 
$v_String:=JSON Stringify array:C1228($sel)
$0:=$0+(3*"\r")+$v_String
REDUCE SELECTION:C351(Table:C252(curTableNum)->; 0)



ARRAY OBJECT:C1221($sel2; 0)
JSON PARSE ARRAY:C1219($v_String; $sel2)
// copy array($sel2;aText1)  // OBJECTIVE NOT ARRAY
$v_String:=TextFromArray(->aText1)
C_LONGINT:C283($i; $k)
C_TEXT:C284($outPut; $line)

// $k:=Size of array($sel2)  // OBJECTIVE NOT ARRAY
For ($i; 1; $k)
	// $line:=$sel2{$i}
	$outPut:=$outPut+$line+"\r"
End for 


$0:=$0+(3*"\r")+$outPut

C_LONGINT:C283($cntLine; $incLines)
$ptTable:=(->[Order:3])
ALL RECORDS:C47($ptTable->)
REDUCE SELECTION:C351($ptTable->; 10)
FIRST RECORD:C50($ptTable->)
C_TEXT:C284($MyOrders)
C_TEXT:C284($MyOrderlines)
C_OBJECT:C1216($Orders; $Lines)
$k:=Records in selection:C76($ptTable->)
For ($i; 1; $k)
	OB SET:C1220($obOrder; Field name:C257(->[Order:3]orderNum:2); String:C10([Order:3]orderNum:2); Field name:C257(->[Order:3]company:15); [Order:3]company:15)
	$MyOrders:=JSON Stringify:C1217($Orders)
	QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2)
	$cntLine:=Records in selection:C76([OrderLine:49])
	For ($incLines; 1; $cntLine)
		OB SET:C1220($Lines; Field name:C257(->[OrderLine:49]itemNum:4); [OrderLine:49]itemNum:4; Field name:C257(->[OrderLine:49]seq:30); String:C10([OrderLine:49]seq:30))
		NEXT RECORD:C51([OrderLine:49])
	End for 
	
	// not correct needs to be an array
	
	$MyOrderlines:=JSON Stringify:C1217($Lines; *)
	OB SET:C1220($Orders; "OrderLine"; $Lines)
	//$MyOrders:=JSON Stringify($Orders)
	//$MyOrderlines:=JSON Stringify($Lines;*)
	// above works
	NEXT RECORD:C51($ptTable->)
End for 
