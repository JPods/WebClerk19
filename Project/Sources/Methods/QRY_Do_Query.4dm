//%attributes = {}
// 4D_25Invoice - 2022-01-15

// Modified by: Bill James (2022-01-15T06:00:00Z)
// Method: QRY_Do_Query
// Description 
// Parameters
// ----------------------------------------------------
#DECLARE($dataStore : Object; $dataClassName : Text; $ents : Object)

C_OBJECT:C1216($0; $3; $4; $dataStore; $formData; $dataClass; $criteria; $displayedSelection; $lineInfos; $dsDescription)
C_BOOLEAN:C305($inSelection)
C_TEXT:C284($2)

//This method provides an example of what could be a generic Query Editor that you can modify and/or adapt to your own needs

C_PICTURE:C286($pict)
$indent:=Char:C90(NBSP ASCII CODE:K15:43)*2
$formData:=New object:C1471  //To prepare the data to use with the Generic_Query Form

$formData.dataStore:=$dataStore  // $1
$formData.dataClassName:=$dataClassName  // $2  //  The DataClass to Query //This is the  Table search on
$formData.dataClass:=ds:C1482[$formData.dataClassName]
If ($ents=Null:C1517)  //($3=Null)
	$formData.displayedSelection:=New object:C1471
	$formData.ents:=New object:C1471
	qryCount_i:=0
Else 
	$formData.displayedSelection:=$ents  // $3  //  The Entity Selection of this DataClass to sort (In case of QUERY SELECTION)
	$formData.ents:=$formData.displayedSelection
	qryCount_i:=$formData.displayedSelection.length
End if 
TRACE:C157
If (choices_o=Null:C1517)
	choices_o:=cs:C1710.cChoices($dataClassName)
End if 


$formData.propertyList:=New collection:C1472  //We can also use $formData.dataClass.keys() if we just need the names
$formData.propertySelected:=New object:C1471  //will be the current selected element in the propertyList
$formData.propertyPosition:=0  //will be the current selected element position in the propertyList (starting from 0)
$formData.ck_CurrentSel:=$formData.queryLast.inSelection
$formData.dataClassName:=$formData.dataClass.getInfo().name
var qryDraft_o : Object
qryDraft_o:=$formData.queryLast.current

$formData.propertyListOriginal:=QRY_GetPropertyList("QRY"; $formData; $formData.dataClass.all())
//$formData.propertyListOriginal

$formData.criteria:=New collection:C1472
$formData.criteria_Cur:=New object:C1471
$formData.criteria_Pos:=0
$formData.clipObject:=Null:C1517  //This object will be used by the Drag & Drop
$formData.ck_CurrentSel:=$inSelection

$w:=Open form window:C675("QRY_Query"; Movable form dialog box:K39:8; Horizontally centered:K39:1; Vertically centered:K39:4; *)
SET WINDOW TITLE:C213("Query "+$formData.dataClass.getInfo().name+" with..."; $w)

DIALOG:C40("QRY_Query"; $formData)

//$0:=(OK=1)

//If ($formData.criteria.length>0)

//$inSelection:=$formData.ck_CurrentSel

//$queryString:=""

//$queryParams:=New object
////$queryParams.queryPlan:=False
////$queryParams.queryPath:=False
//$queryParams.queryPlan:=True
//$queryParams.queryPath:=True
//$queryParams.parameters:=New collection

//$index:=0
//$parmIndex:=0
//For each ($criteria; $formData.criteria)
//$index:=$index+1
//If ($index=1)  //First line

//Else 
//$queryString:=$queryString+" "+$criteria.logicOperatorChoice+" "
//End if 
//$condition:=$criteria.condition
//$fl_AtBefore:="@"*Num(Position("["; $condition)>0)
//$fl_AtAfter:="@"*Num(Position("]"; $condition)>0)
//$linePrefix:=""
//$lineSuffix:=""
//$condition:=Replace string($condition; "["; "")
//$condition:=Substring(Replace string($condition; "]"; ""); 2)
//$fl_HasParm:=False
//Case of   // Analyse of special cases (See Util25_Query_PrepareMenus method)
//: ($criteria.originalType="image")  //it's a picture
//$fl_HasParm:=True
//$criteria.path:="eval("


//: (Position("0"; $condition)>0)  //Text is empty or not
//$condition:=Replace string($condition; "0"; " ''")

//: (Position("?"; $condition)>0)  // is defined or not
//$condition:=Replace string($condition; "?"; " null")

//: (Position("W"; $condition)>0)  // contains keywords
//If ($condition="#W")  //  Doesn't contain KW -> Not(contains KW)
//$linePrefix:="not("
//$lineSuffix:=")"
//End if 
//$condition:=Replace string($condition; "W"; " % ")
//$fl_HasParm:=True

//: ($condition="=D@")  //Today
//$condition:="="
//$criteria.value:=Current date
//$fl_HasParm:=True
//Case of 
//: ($condition="=D+")  //Tomorrow
//$criteria.value:=Current date+1
//: ($condition="=D-")  //Yesterday
//$criteria.value:=Current date-1
//End case 

//: ($criteria.condition="B=")  //Booleans
//$condition:=" is true"
//: ($criteria.condition="B#")
//$condition:=" is false"

//: ($criteria.condition="P=")  //Properties
//If (($criteria.valueType="object") & ($criteria.path#"@[]"))
//$criteria.path:=$criteria.path+"[]"
//End if 
//$condition:=" is not null"
//: ($criteria.condition="P#")
//If (($criteria.valueType="object") & ($criteria.propertyName#"@[]"))
//$criteria.path:=$criteria.path+"[]"
//End if 
//$condition:=" is null"

//: ($criteria.condition="T@")
//$criteria.value:=$fl_AtBefore+$criteria.value+$fl_AtAfter
//$fl_HasParm:=True

//Else 
//$fl_HasParm:=True
//End case 

//$queryString:=$queryString+$linePrefix+$criteria.path+" "+$condition+" "
//If ($fl_HasParm)
//$parmIndex:=$parmIndex+1
//$queryString:=$queryString+":"+String($parmIndex)
//$queryParams.parameters.push($criteria.value)
//End if 

//$queryString:=$queryString+$lineSuffix

//End for each 

//If ($queryParams.queryPlan)
//$qryPlan:=Get last query plan(Description in text format)
//End if 
//If ($queryParams.queryPath)
//$qryPath:=Get last query path(Description in text format)
//End if 

//If ($inSelection)
//$displayedSelection:=$displayedSelection.query($queryString; $queryParams)
//Else 
//$displayedSelection:=$formData.dataClass.query($queryString; $queryParams)
//End if 

//End if 


//// QQQ save queries
//If (process_o.query=Null)
//process_o.query:=New object
//End if 
//process_o.query.current:=New object(\
"length"; $formData.criteria.length; \
"queryString"; $queryString; \
"queryParams"; $queryParams; \
"queryPlan"; $queryPlan; \
"queryPath"; $queryPath)


//$0:=$displayedSelection
//End if 



