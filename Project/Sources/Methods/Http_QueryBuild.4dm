//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 03/30/11, 11:12:48
// ----------------------------------------------------
// Method: Http_QueryBuild
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1; $error)
C_POINTER:C301($2)
C_TEXT:C284($0)
Case of 
	: ($1=1)
		C_TEXT:C284($theQuery)
		//$2->:=Replace string($2->;"-->";"&")//for an end of value
		$raySize:=10
		$tableNameMaster:=WCapi_GetParameter("TableNameMaster"; "")
		$tableName:=WCapi_GetParameter("TableName"; "")
		$allowEmpty:=WCapi_GetParameter("AllowEmpty"; "")
		If (($allowEmpty="1") | ($allowEmpty="t") | ($allowEmpty="y") | ($allowEmpty="Yes"))
			$allowEmpty:="true"
		End if 
		$tableNumMaster:=STR_GetTableNumber($tableNameMaster)
		$tableNum:=STR_GetTableNumber($tableName)
		
		vResponse:="Invalid TableName: "+$tableName+""
		$raySize:=20
		$queryText:=""
		C_LONGINT:C283($theType; $tableNum; $fieldNum; $recCount; $doQuery; $firstLine)
		
		ARRAY TEXT:C222(aQueryFieldName; 0)
		ARRAY LONGINT:C221(aQueryField; 0)
		ARRAY TEXT:C222(aQueryValue; 0)
		ARRAY TEXT:C222(aQueryBoolean; 0)
		ARRAY TEXT:C222(aQueryOperator; 0)
		
		If ($tableNum>0)
			C_POINTER:C301($ptTable)
			$ptTable:=Table:C252($tableNum)
			C_TEXT:C284(vResponseQuery)
			$i:=0
			$firstLine:=1
			Repeat 
				$i:=$i+1
				//
				$queryField0:="QueryField"+String:C10($i)
				$queryValue0:="QueryValue"+String:C10($i)
				$queryBoolean0:="QueryBoolean"+String:C10($i)
				$queryOperator0:="QueryOperator"+String:C10($i)
				$queryField0:=WCapi_GetParameter($queryField0; "")
				$queryValue0:=WCapi_GetParameter($queryValue0; "")
				$queryBoolean0:=WCapi_GetParameter($queryBoolean0; "")
				$queryOperator0:=WCapi_GetParameter($queryOperator0; "")
				//
				$fieldNum:=STR_GetFieldNumber($tableName; $queryField0)
				If ($fieldNum>0)
					$sizeRay:=Size of array:C274(aQueryField)+1
					
					INSERT IN ARRAY:C227(aQueryFieldName; $sizeRay; 1)
					INSERT IN ARRAY:C227(aQueryField; $sizeRay; 1)
					INSERT IN ARRAY:C227(aQueryValue; $sizeRay; 1)
					INSERT IN ARRAY:C227(aQueryBoolean; $sizeRay; 1)
					INSERT IN ARRAY:C227(aQueryOperator; $sizeRay; 1)
					aQueryFieldName{$sizeRay}:=$queryField0
					aQueryField{$sizeRay}:=$fieldNum
					aQueryValue{$sizeRay}:=$queryValue0
					aQueryBoolean{$sizeRay}:=$queryBoolean0
					aQueryOperator{$sizeRay}:=$queryOperator0
					
				Else 
					$i:=-1
				End if 
			Until ($i=-1)
		End if 
		$sizeRay:=Size of array:C274(aQueryField)
		$0:=String:C10($sizeRay)
		
		
	: ($1=2)
		$tableName:=WCapi_GetParameter("TableName"; "")
		$tableNum:=STR_GetTableNumber($tableName)
		C_LONGINT:C283($fia)
		$sizeRay:=Size of array:C274(aQueryField)
		If ($sizeRay>0)
			Case of 
				: (Table:C252(->[Customer:2])=$tableNum)
					$fia:=Find in array:C230(aQueryFieldName; "customerID")
					Case of 
						: ($fia=1)
							aQueryValue{1}:=[Customer:2]customerID:1
						Else 
							$tableNum:=-1
					End case 
				: (Table:C252(->[CallReport:34])=$tableNum)
					$fia:=Find in array:C230(aQueryFieldName; "customerID")
					If (($fia=1) & ([Customer:2]customerID:1#""))
						aQueryValue{1}:=[Customer:2]customerID:1
					Else 
						$tableNum:=-1
					End if 
				: (Table:C252(->[Contact:13])=$tableNum)
					$fia:=Find in array:C230(aQueryFieldName; "customerID")
					If (($fia=1) & ([Customer:2]customerID:1#""))
						aQueryValue{1}:=[Customer:2]customerID:1
					Else 
						$tableNum:=-1
					End if 
				: (Table:C252(->[InvoiceLine:54])=$tableNum)
					$fia:=Find in array:C230(aQueryFieldName; "customerID")
					If (($fia=1) & ([Customer:2]customerID:1#""))
						aQueryValue{1}:=[Customer:2]customerID:1
					Else 
						$tableNum:=-1
					End if 
				: (Table:C252(->[Invoice:26])=$tableNum)
					$fia:=Find in array:C230(aQueryFieldName; "customerID")
					If (($fia=1) & ([Customer:2]customerID:1#""))
						aQueryValue{1}:=[Customer:2]customerID:1
					Else 
						$tableNum:=-1
					End if 
				: (Table:C252(->[Item:4])=$tableNum)
					$fia:=Find in array:C230(aQueryFieldName; "Publish")
					If (($fia=1) & ([Customer:2]customerID:1#""))
						aQueryValue{1}:=String:C10([RemoteUser:57]securityLevel:4)
					Else 
						$tableNum:=-1
					End if 
					//: (Table(->[ItemSpec])=$tableNum)
					
				: (Table:C252(->[ItemSerial:47])=$tableNum)
					$fia:=Find in array:C230(aQueryFieldName; "customerID")
					If (($fia=1) & ([Customer:2]customerID:1#""))
						aQueryValue{1}:=[Customer:2]customerID:1
					Else 
						$tableNum:=-1
					End if 
				: (Table:C252(->[Ledger:30])=$tableNum)
					$fia:=Find in array:C230(aQueryFieldName; "customerID")
					If (($fia=1) & ([Customer:2]customerID:1#""))
						aQueryValue{1}:=[Customer:2]customerID:1
					Else 
						$tableNum:=-1
					End if 
				: (Table:C252(->[LoadItem:87])=$tableNum)
					$fia:=Find in array:C230(aQueryFieldName; "customerID")
					If (($fia=1) & ([Customer:2]customerID:1#""))
						aQueryValue{1}:=[Customer:2]customerID:1
					Else 
						$tableNum:=-1
					End if 
				: (Table:C252(->[LoadTag:88])=$tableNum)
					$fia:=Find in array:C230(aQueryFieldName; "customerID")
					If (($fia=1) & ([Customer:2]customerID:1#""))
						aQueryValue{1}:=[Customer:2]customerID:1
					Else 
						$tableNum:=-1
					End if 
					//: (Table(->[Manufacturer])=$tableNum)
					
				: (Table:C252(->[OrderLine:49])=$tableNum)
					$fia:=Find in array:C230(aQueryFieldName; "customerID")
					If (($fia=1) & ([Customer:2]customerID:1#""))
						aQueryValue{1}:=[Customer:2]customerID:1
					Else 
						$tableNum:=-1
					End if 
				: (Table:C252(->[Order:3])=$tableNum)
					$fia:=Find in array:C230(aQueryFieldName; "customerID")
					If (($fia=1) & ([Customer:2]customerID:1#""))
						aQueryValue{1}:=[Customer:2]customerID:1
					Else 
						$tableNum:=-1
					End if 
				: (Table:C252(->[Payment:28])=$tableNum)
					$fia:=Find in array:C230(aQueryFieldName; "customerID")
					If (($fia=1) & ([Customer:2]customerID:1#""))
						aQueryValue{1}:=[Customer:2]customerID:1
					Else 
						$tableNum:=-1
					End if 
				: (Table:C252(->[POLine:40])=$tableNum)
					$fia:=Find in array:C230(aQueryFieldName; "VendorID")
					If (($fia=1) & ([Vendor:38]vendorID:1#""))
						aQueryValue{1}:=[Vendor:38]vendorID:1
					Else 
						$tableNum:=-1
					End if 
				: (Table:C252(->[PO:39])=$tableNum)
					$fia:=Find in array:C230(aQueryFieldName; "VendorID")
					If (($fia=1) & ([Vendor:38]vendorID:1#""))
						aQueryValue{1}:=[Vendor:38]vendorID:1
					Else 
						$tableNum:=-1
					End if 
				: (Table:C252(->[ProposalLine:43])=$tableNum)
					$fia:=Find in array:C230(aQueryFieldName; "customerID")
					If (($fia=1) & ([Customer:2]customerID:1#""))
						aQueryValue{1}:=[Customer:2]customerID:1
					Else 
						$tableNum:=-1
					End if 
				: (Table:C252(->[Proposal:42])=$tableNum)
					$fia:=Find in array:C230(aQueryFieldName; "customerID")
					If (($fia=1) & ([Customer:2]customerID:1#""))
						aQueryValue{1}:=[Customer:2]customerID:1
					Else 
						$tableNum:=-1
					End if 
				: (Table:C252(->[QA:70])=$tableNum)
					$fia:=Find in array:C230(aQueryFieldName; "customerID")
					If (($fia=1) & ([Customer:2]customerID:1#""))
						aQueryValue{1}:=[Customer:2]customerID:1
					Else 
						$tableNum:=-1
					End if 
					//: (Table(->[RepContact])=$tableNum)
					
					//: (Table(->[Rep])=$tableNum)
					
				: (Table:C252(->[Reservation:79])=$tableNum)
					$fia:=Find in array:C230(aQueryFieldName; "customerID")
					If (($fia=1) & ([Customer:2]customerID:1#""))
						aQueryValue{1}:=[Customer:2]customerID:1
					Else 
						$tableNum:=-1
					End if 
				: (Table:C252(->[Service:6])=$tableNum)
					$fia:=Find in array:C230(aQueryFieldName; "customerID")
					If (($fia=1) & ([Customer:2]customerID:1#""))
						aQueryValue{1}:=[Customer:2]customerID:1
					Else 
						$tableNum:=-1
					End if 
				: (Table:C252(->[TallyResult:73])=$tableNum)
					$fia:=Find in array:C230(aQueryFieldName; "custVendID")
					If (($fia=1) & ([Customer:2]customerID:1#""))
						aQueryValue{1}:=[Customer:2]customerID:1
					Else 
						$tableNum:=-1
					End if 
					$fia:=Find in array:C230(aQueryFieldName; "TableNum")
					If ($fia=2)
						aQueryValue{2}:=String:C10(Table:C252(->[Customer:2]))
					Else 
						$tableNum:=-1
					End if 
					$fia:=Find in array:C230(aQueryFieldName; "Publish")
					If ($fia=3)
						aQueryValue{3}:=[Customer:2]customerID:1
					Else 
						$tableNum:=-1
					End if 
				: (Table:C252(->[TechNote:58])=$tableNum)
					$fia:=Find in array:C230(aQueryFieldName; "Publish")
					If ($fia=1)
						aQueryValue{1}:=String:C10([RemoteUser:57]securityLevel:4)
					Else 
						$tableNum:=-1
					End if 
					//: (Table(->[Territory])=$tableNum)
					
				: (Table:C252(->[WorkOrder:66])=$tableNum)
					$fia:=Find in array:C230(aQueryFieldName; "customerID")
					If (($fia=1) & ([Customer:2]customerID:1#""))
						aQueryValue{1}:=[Customer:2]customerID:1
					Else 
						$tableNum:=-1
					End if 
				Else 
					$tableNum:=-1
			End case 
		End if 
		$0:=String:C10($tableNum)
		
		
		
		
		
	: ($1=3)
		$allowEmpty:=WCapi_GetParameter("AllowEmpty"; "")
		$sizeRay:=Size of array:C274(aQueryField)
		C_LONGINT:C283($incRay; $sizeRay)
		For ($incRay; 1; $sizeRay)
			If ((aQueryValue{$incRay}#"") | ($allowEmpty="true"))
				If ($incRay=1)
					aQueryBoolean{$incRay}:="single"
					aQueryOperator{$incRay}:="literal"
				End if 
				$theQuery:=$theQuery+QueryBuild($tableNum; aQueryField{$incRay}; aQueryBoolean{$incRay}; aQueryOperator{$incRay}; aQueryValue{$incRay})
			End if 
		End for 
		$0:=$theQuery
End case 