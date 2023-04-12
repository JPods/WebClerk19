//%attributes = {}

// Modified by: Bill James (2022-07-01T05:00:00Z)
// Method: TallyMastersExecuteSearch
// Description 
// Parameters
// ----------------------------------------------------


C_POINTER:C301($ptSelf; $1)
$ptSelf:=$1
C_TEXT:C284($theRecName)
$theRecName:=$ptSelf->{$ptSelf->}

Case of 
	: ($ptSelf-><2)
		// do nothing
	: ($theRecName="Edit TallyMasters")
		// ### bj ### 20200330_1808  open the queries
		If (UserInPassWordGroup("AdminControl"))
			var $data; $rec; $new_o : Object
			// $new_o:=cs.TableShow.new("Customer")
			$new_o:=cs:C1710.cProcess.new("OutputDS"; "TallyMaster")
			$data:=ds:C1482.TallyMaster.query("purpose = :1 and tableName = :2"; "query"; process_o.dataClassName)
			$new_o.setSource($data)
			$childProcess:=New process:C317("Process_ShowTableDS"; 0; String:C10(Count user processes:C343)+"-"+$new_o.dataClassName; $new_o)
		End if 
		
	: ($theRecName="Query Editor")  // ### jwm ### 20170928_1147
		jSrchEditor
	Else 
		var $rec : Object
		$rec:=ds:C1482.TallyMaster.query("name = :1 and purpose = :2 and tableName = :3"; $ptSelf->{$ptSelf->}; "query"; process_o.dataClassName).first()
		If ($rec.length=1)
			ExecuteText(0; $rec.script; "ExecuteTM Name: "+$rec.name+"; Purpose: "+$rec.purpose)
		End if 
End case 
$ptSelf->:=1
