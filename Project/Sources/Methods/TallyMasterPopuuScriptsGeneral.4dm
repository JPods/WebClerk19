//%attributes = {}
// $1 - pointer to associated table
// $2 - [TallyMaster]Purpose+"Script"
// $3 - [TallyMaster]Profile1
// $4 - pointer to array
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/12/07, 16:19:51
// ----------------------------------------------------
// Method: TallyMasterPopuuScriptsGeneral
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20141024_1649 removed Table name from scripts popoup label
// ### jwm ### 20170928_1128 added sort and security level to sort and Query Dropdowns
// ### jwm ### 20170928_1452 added $viTableNum 

C_POINTER:C301($1)  //associated table
C_POINTER:C301($ptArray)  //array name
C_TEXT:C284($2; $3)
C_TEXT:C284($4; $arrayName)
$arrayName:=""
If ($4#"")
	$arrayName:=$4
	$ptArray:=Get pointer:C304($4)
Else 
	$ptArray:=(->aLoScripts)
End if 
C_LONGINT:C283($viTableNum)

$viTableNum:=Table:C252($1)  // ### jwm ### 20170928_1446

ARRAY TEXT:C222($ptArray->; 0)
Case of 
	: (($ptArray=(->aLoScripts)) | ($arrayName="aLooLoScripts"))
		If ($3#"")
			QUERY:C277([TallyMaster:60]; [TallyMaster:60]profile1:23=$3; *)
			QUERY:C277([TallyMaster:60];  | [TallyMaster:60]profile1:23="all"; *)
			QUERY:C277([TallyMaster:60];  & [TallyMaster:60]purpose:3=$2+"Script@"; *)
		Else 
			QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3=$2+"Script@"; *)
		End if 
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25>0; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25<=Storage:C1525.user.securityLevel; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]tableNum:1=$viTableNum)  // ### jwm ### 20170928_1452 added $viTableNum 
		
		SELECTION TO ARRAY:C260([TallyMaster:60]name:8; $ptArray->)
		SORT ARRAY:C229($ptArray->)
		//
		// Modified by: williamjames (3/25/13) ADDED UserSet to new process
		
		C_BOOLEAN:C305($restrictNotice; $doChange)
		$doChange:=(UserInPassWordGroup("UnlockRecord"))
		
		
		INSERT IN ARRAY:C227($ptArray->; 1; 1)
		$ptArray->{1}:="-- TallyMasters below --"
		
		If ($doChange)
			
			INSERT IN ARRAY:C227($ptArray->; 1; 1)
			$ptArray->{1}:="New Script"
			
			INSERT IN ARRAY:C227($ptArray->; 1; 1)
			$ptArray->{1}:="Edit Scripts"
			
		End if 
		
		INSERT IN ARRAY:C227($ptArray->; 1; 1)
		$ptArray->{1}:="Index/Duplicates"
		
		INSERT IN ARRAY:C227($ptArray->; 1; 1)
		$ptArray->{1}:="Distinct Values"  // ### jwm ### 20190718_1250
		
		INSERT IN ARRAY:C227($ptArray->; 1; 1)
		$ptArray->{1}:="UserSet"
		//
		INSERT IN ARRAY:C227($ptArray->; 1; 1)
		$ptArray->{1}:="Help-"+Table name:C256($1)
		//
		INSERT IN ARRAY:C227($ptArray->; 1; 1)
		$ptArray->{1}:="Scripts"  // ### jwm ### 20141024_1649 table name not needed ???
		
	: ($arrayName="aLooLoQueries")
		QUERY:C277([TallyMaster:60]; [TallyMaster:60]tableNum:1=$viTableNum; *)  // ### jwm ### 20170928_1452 added $viTableNum 
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25>0; *)  // ### jwm ### 20170928_1128
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25<=Storage:C1525.user.securityLevel; *)  // ### jwm ### 20170928_1128
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]purpose:3="search")
		SELECTION TO ARRAY:C260([TallyMaster:60]name:8; $ptArray->)
		SORT ARRAY:C229($ptArray->; >)  // ### jwm ### 20170928_1128
		
		INSERT IN ARRAY:C227($ptArray->; 1; 1)
		$ptArray->{1}:="Query Editor"
		
		If (UserInPassWordGroup("AdminControl"))
			INSERT IN ARRAY:C227($ptArray->; 1; 1)
			$ptArray->{1}:="Edit TallyMasters"
		End if 
		
		INSERT IN ARRAY:C227($ptArray->; 1; 1)
		$ptArray->{1}:="Query"
		
	: ($arrayName="aLooLoOrderBy")
		QUERY:C277([TallyMaster:60]; [TallyMaster:60]tableNum:1=$viTableNum; *)  // ### jwm ### 20170928_1452 added $viTableNum 
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25>0; *)  // ### jwm ### 20170928_1128
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25<=Storage:C1525.user.securityLevel; *)  // ### jwm ### 20170928_1128
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]purpose:3="sort")
		SELECTION TO ARRAY:C260([TallyMaster:60]name:8; $ptArray->)
		SORT ARRAY:C229($ptArray->; >)  // ### jwm ### 20170928_1128
		
		INSERT IN ARRAY:C227($ptArray->; 1; 1)
		$ptArray->{1}:="Sort Editor"
		
		INSERT IN ARRAY:C227($ptArray->; 1; 1)
		$ptArray->{1}:="Order By"
		
End case 
$ptArray->:=1
REDUCE SELECTION:C351([TallyMaster:60]; 0)
//
