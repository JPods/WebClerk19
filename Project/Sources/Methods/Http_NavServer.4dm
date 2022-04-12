//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 101226
// ----------------------------------------------------
// Method: Http_NavServer
// Description
// 
//
// Parameters
// ----------------------------------------------------

//
C_LONGINT:C283($1; $c; $doThis; <>vbSaleLevel)
C_TEXT:C284(vResponse)
C_POINTER:C301($2)
$c:=$1
$suffix:=""
$doThis:=0
vResponse:="Incomplete request: "+vText11
vRelateLevel:=1
$doPage:="Error.html"
C_LONGINT:C283($w; $recNum)
$recNum:=Num:C11(WCapi_GetParameter("RecordNum"; ""))
$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
$jitPageList:=WCapi_GetParameter("jitPageList"; "")
$tableName:=WCapi_GetParameter("TableName"; "")
$tableNum:=STR_GetTableNumber($tableName)
ARRAY LONGINT:C221($aRecNums; 0)
//MESSAGES OFF
BLOB TO VARIABLE:C533([EventLog:75]recordArray:43; $aRecNums)
error:=0
Case of 
	: (<>viSkipFeature=1)
		vResponse:="Feature currently turned off."
	: ($recNum<0)
		vResponse:="Record number is -1."
	: ($tableNum<1)
		vResponse:="TableName ("+$tableName+") not provided or invalid."
	: ($tableNum#[EventLog:75]tableNumArray:44)
		vResponse:="Calling TableNumber: "+String:C10($tableNum)+" is different than saved TableNumber: "+String:C10([EventLog:75]tableNumArray:44)+")."
	: (voState.url="/Nav_List@")  //list the found items
		$doPage:=$jitPageList
		ARRAY LONGINT:C221($aRecNums; 0)
		BLOB TO VARIABLE:C533([EventLog:75]recordArray:43; $aRecNums)
		CREATE SELECTION FROM ARRAY:C640([Item:4]; $aRecNums)
		ARRAY LONGINT:C221($aRecNums; 0)
		If (False:C215)
			If ([EventLog:75]lastQueryScript:31#"")
				vURLQueryScript:=[EventLog:75]lastQueryScript:31
				ExecuteText(0; vURLQueryScript)
			End if 
		End if 
		// check to see if records are returned in sorted order 
		//  if(voState.url="/@sort@")
		ExecuteText(0; [EventLog:75]wccEmail:33)
		// end if
	: (Size of array:C274($aRecNums)=0)
		vResponse:="No stored list available."
	: (Size of array:C274($aRecNums)<2)
		vResponse:="Only one record."
	: (voState.url="/Nav_Prev@")  //list the found items
		$w:=Find in array:C230($aRecNums; $recNum)
		Case of 
			: (Size of array:C274($aRecNums)<2)
				
			: ($w=-1)
				
			: ($w>1)
				GOTO RECORD:C242(Table:C252($tableNum)->; $aRecNums{$w-1})
			Else 
				GOTO RECORD:C242(Table:C252($tableNum)->; $aRecNums{Size of array:C274($aRecNums)})
		End case 
		vResponse:="Nav_Prev: Found "+$tableName+", "+String:C10($w)+" List Size: "+String:C10(Size of array:C274($aRecNums))
		$doPage:=$jitPageOne
	: (voState.url="/Nav_Next@")  //list the found items
		$w:=Find in array:C230($aRecNums; $recNum)
		Case of 
			: ($w=-1)
			: ($w<Size of array:C274($aRecNums))
				GOTO RECORD:C242(Table:C252($tableNum)->; $aRecNums{$w+1})
			Else 
				GOTO RECORD:C242(Table:C252($tableNum)->; $aRecNums{1})
		End case 
		vResponse:="Nav_Prev: Found "+$tableName+", "+String:C10($w)+" List Size: "+String:C10(Size of array:C274($aRecNums))
		$doPage:=$jitPageOne
	: (voState.url="/Nav_LastQuery")
		ARRAY LONGINT:C221($aRecNums; 0)
		BLOB TO VARIABLE:C533([EventLog:75]recordArray:43; $aRecNums)
		CREATE SELECTION FROM ARRAY:C640([Item:4]; $aRecNums)
		ARRAY LONGINT:C221($aRecNums; 0)
		
End case 
C_LONGINT:C283(vSize; vIndex)
vIndex:=$w
vSize:=Size of array:C274($aRecNums)

$err:=WC_PageSendWithTags($1; WC_DoPage($doPage; ""); 0)
//MESSAGES ON
