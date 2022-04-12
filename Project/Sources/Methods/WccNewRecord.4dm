//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/11/11, 15:13:18
// ----------------------------------------------------
// Method: WccNewRecord
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1)
C_POINTER:C301($2)
C_TEXT:C284($suffix)
//
vResponse:="Table is not available."
$doPage:=WC_DoPage("Error"+$suffix+".html"; "")
$tableName:=WCapi_GetParameter("TableName"; "")

C_LONGINT:C283($vbeenHere; $recordNum; $tableNum)
$vbeenHere:=Num:C11(WCapi_GetParameter("vBeenHere"; ""))
$recordID:=Num:C11(WCapi_GetParameter("recordID"; ""))
$tableNum:=Num:C11(WCapi_GetParameter("tableNum"; ""))
$newRecord:=True:C214
If (([EventLog:75]targetRecordNum:52>0) & ([EventLog:75]tableNumTarget:53>0))
	If ([EventLog:75]tableNumTarget:53<=Get last table number:C254)
		GOTO RECORD:C242(Table:C252([EventLog:75]tableNumTarget:53)->; [EventLog:75]targetRecordNum:52)
		// Modified by: William James (2014-09-06T00:00:00 Subrecord eliminated)
		// Generalize this qqqqq
		Case of 
			: (($tableName="Order") & ([Order:3]idNum:2=0))
				$newRecord:=False:C215
			: (($tableName="Invoice") & ([Invoice:26]idNum:2=0))
				$newRecord:=False:C215
			Else 
				$tableName:=Table name:C256([EventLog:75]tableNumTarget:53)
				$thePrimary:=IEA_SaveRecord($ptTable; 0)
				
				$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")  //look for a missing quote if page does cannot be found
				$doPage:=WC_DoPage("Wcc"+$tableName+"One.html"; $jitPageOne)
				
				
				$newRecord:=False:C215
		End case 
	End if 
End if 
If ($newRecord)
	$relatedTableName:=WCapi_GetParameter("RelatedTableName"; "")
	$field1:=WCapi_GetParameter("RelatedField1"; "")
	$value1:=WCapi_GetParameter("RelatedValue1"; "")
	$field2:=WCapi_GetParameter("RelatedField2"; "")
	$value2:=WCapi_GetParameter("RelatedValue2"; "")
	$field3:=WCapi_GetParameter("RelatedField3"; "")
	$value3:=WCapi_GetParameter("RelatedValue3"; "")
	$field4:=WCapi_GetParameter("RelatedField4"; "")
	$value4:=WCapi_GetParameter("RelatedValue4"; "")
	//
	//$fieldName:=WCapi_GetParameter("FieldName";"")
	//$recordNum:=Num(WCapi_GetParameter("RecordNum";""))
	//$recordID:=WCapi_GetParameter("RecordID";"")
	C_TEXT:C284($returnTable; $returnField; $returnID; $returnPage)
	returnTable:=WCapi_GetParameter("ReturnTable"; "")
	returnField:=WCapi_GetParameter("ReturnField"; "")
	If (returnField="")
		returnField:=WCapi_GetParameter("ReturnKeyField"; "")
	End if 
	returnValue:=WCapi_GetParameter("ReturnValue"; "")
	If (returnValue="")
		returnValue:=WCapi_GetParameter("ReturnID"; "")
	End if 
	returnPage:=WCapi_GetParameter("ReturnPage"; "")
	//$returnRecNum:=Num(WCapi_GetParameter("ReturnRecordNum";""))
	//
	C_LONGINT:C283($tableNum; $fieldNum; $relatedtableNum)
	If ($tableName#"")
		$tableNum:=STR_GetTableNumber($tableName)
		$relatedtableNum:=STR_GetTableNumber($tableName)
		If ($relatedtableNum>0)
			ptCurTable:=(Table:C252($relatedtableNum))
		Else 
			ptCurTable:=(->[Reference:7])
		End if 
		////  $w:=Find in array(<>aTableNames;$tableName)
		If ($tableNum>0)
			$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")  //look for a missing quote if page does cannot be found
			$doPage:=WC_DoPage("Wcc"+$tableName+"One.html"; $jitPageOne)
			CREATE RECORD:C68(Table:C252($tableNum)->)
			pvTableName:=$tableName
			WC_Parse($tableNum; $2)
			$fieldNum:=STR_GetFieldNumber($tableName; $field1)
			C_LONGINT:C283($searchMore)
			$searchMore:=0
			If (($fieldNum>0) & ($value1#""))
				$searchMore:=WccQueryFieldFromText(Field:C253($tableNum; $fieldNum); $value1; 0)
			End if 
			$fieldNum:=STR_GetFieldNumber($tableName; $field2)
			If (($fieldNum>0) & ($value2#""))
				$searchMore:=WccQueryFieldFromText(Field:C253($tableNum; $fieldNum); $value2; $searchMore)
			End if 
			$fieldNum:=STR_GetFieldNumber($tableName; $field3)
			If (($fieldNum>0) & ($value3#""))
				$searchMore:=WccQueryFieldFromText(Field:C253($tableNum; $fieldNum); $value3; $searchMore)
			End if 
			$fieldNum:=STR_GetFieldNumber($tableName; $field4)
			If (($fieldNum>0) & ($value4#""))
				$searchMore:=WccQueryFieldFromText(Field:C253($tableNum; $fieldNum); $value4; $searchMore)
			End if 
			
			Case of   //added 6/1/03
				: ($tableNum=3)  //orders
					QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerID:1)
					LoadCustOrder
					[Order:3]dateDocument:4:=Current date:C33
					// what other changes
				: ($tableNum=6)  //service
					QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Service:6]customerID:1)
					[Service:6]actionBy:12:=Current user:C182
					[Service:6]actionCreatedBy:40:=Current user:C182
					NxPvServiceNewRec(Table:C252(->[Customer:2]))
				: ($tableNum=13)  //contacts
					QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Contact:13]customerID:1)
					
				: ($tableNum=26)  //Invoice
					[Invoice:26]dateDocument:35:=Current date:C33
					[Invoice:26]dateShipped:4:=Current date:C33
					NxPvInvoices
				: ($tableNum=34)  //call reports
					[CallReport:34]dtAction:4:=DateTime_Enter
					[CallReport:34]dateDocument:17:=Current date:C33
					[CallReport:34]complete:7:=False:C215
					[CallReport:34]initiatedBy:23:=Current user:C182
					[CallReport:34]actionBy:3:=Current user:C182
					Case of 
						: (([CallReport:34]tableNum:2<1) | ([CallReport:34]tableNum:2>Get last table number:C254))
							vResponse:="No related Table Defined for this Call Report."
						: ([CallReport:34]tableNum:2=(Table:C252(->[zzzLead:48])))
							QUERY:C277([zzzLead:48]; [zzzLead:48]idNum:32=Num:C11([CallReport:34]customerID:1))
						: ([CallReport:34]tableNum:2=(Table:C252(->[Contact:13])))
							QUERY:C277([Contact:13]; [Contact:13]idNum:28=Num:C11([CallReport:34]customerID:1))
						: ([CallReport:34]tableNum:2=(Table:C252(->[Customer:2])))
							QUERY:C277([Customer:2]; [Customer:2]customerID:1=[CallReport:34]customerID:1)
						: ([CallReport:34]tableNum:2=(Table:C252(->[Item:4])))
							QUERY:C277([Item:4]; [Item:4]itemNum:1=[CallReport:34]itemNum:24)
							If ([CallReport:34]profile1:26="AutoLoad")
								[CallReport:34]profile1:26:=[Item:4]type:26
								[CallReport:34]profile2:27:=[Item:4]profile1:35
								[CallReport:34]profile3:28:=[Item:4]profile2:36
								[CallReport:34]profileName1:30:=<>vItemsType
								[CallReport:34]profileName2:31:=<>vItemsProfile1
								[CallReport:34]profileName3:32:=<>vItemsProfile2
								//[CallReport]actionDate:=jDateTimeRDate([Item]dtItemDate)
							End if 
					End case 
					[CallReport:34]actionBy:3:=[RemoteUser:57]userName:2
				: ($tableNum=39)  //PO        
					NxPvPOs
				: ($tableNum=42)  //proposals
					NxPvProposals
				: ($tableNum=66)  //WO        
					
			End case 
			SAVE RECORD:C53(Table:C252($tableNum)->)
			pvRecordNum:=Record number:C243(Table:C252($tableNum)->)
			vResponse:="New Record Issued."
			
			[EventLog:75]tableNumTarget:53:=$tableNum
			[EventLog:75]targetRecordNum:52:=pvRecordNum
			SAVE RECORD:C53([EventLog:75])
		End if 
	End if 
End if 


$err:=WC_PageSendWithTags($1; $doPage; 0)
//
TableName:=""
RecordNum:=""
C_TEXT:C284(TableName; RecordNum)
