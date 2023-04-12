//%attributes = {}

// Modified by: Bill James (2022-06-30T05:00:00Z)
// Method: TallyMasterExecuteOrderBy
// Description 
// Parameters
// ----------------------------------------------------

C_POINTER:C301($ptSelf; $1)
$ptSelf:=$1
Case of 
	: (process_o=Null:C1517)
	: (process_o.dataClassName=Null:C1517)
	: ($ptSelf-><2)
		// do nothing
	: ($theRecName="Edit TallyMasters")
		// ### bj ### 20200330_1808  open the queries
		If (UserInPassWordGroup("AdminControl"))
			var $data; $rec; $new_o : Object
			// $new_o:=cs.TableShow.new("Customer")
			$new_o:=cs:C1710.cProcess.new("OutputDS"; "TallyMaster")
			$data:=ds:C1482.TallyMaster.query("purpose = :1 and tableName = :2"; "orderBy"; process_o.dataClassName)
			$new_o.setSource($data)
			$childProcess:=New process:C317("Process_ShowTableDS"; 0; String:C10(Count user processes:C343)+"-"+$new_o.dataClassName; $new_o)
			
		End if 
	Else 
		var $o : Object
		$o:=ds:C1482.TallyMaster.query("name = :1 and purpose = :2 and tableName = :3"; $ptSelf->{$ptSelf->}; "orderBy"; process_o.dataClassName).first()
		If ($o.script#Null:C1517)
			ExecuteText(0; $oscript; "ExecuteTM Name: "+$o.name+"; Purpose: "+$o.purpose)
		End if 
End case 