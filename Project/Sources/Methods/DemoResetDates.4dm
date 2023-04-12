//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/11/18, 10:46:54
// ----------------------------------------------------
// Method: DemoResetDates
// Description
// 
// ONLY FOR MASSIVE 
// Parameters
// ----------------------------------------------------
// use DemoResetDatesDaily
If (False:C215)  // only use in interpreted
	If (Records in table:C83([Customer:2])>100)
		ALERT:C41("There is more than 100 customers so this dates cannot be reset.")
	Else 
		C_LONGINT:C283($tableNum; $cntTables; $fieldNum; $type)
		C_LONGINT:C283($incRecords; $cntRecords)
		C_TEXT:C284($tableName; $uniqueFieldName)
		C_POINTER:C301($ptTable; $ptArray; $ptUniqueField; $ptField)
		C_TEXT:C284($fieldName; $vtPassword)
		C_LONGINT:C283($i; $k)
		$cntTables:=Get last table number:C254
		
		
		C_LONGINT:C283($monthOf; $yearOf; $dayOf)
		C_TEXT:C284($strDate)
		C_DATE:C307($dateNew)
		CONFIRM:C162("Reset Demo Date")
		If (OK=1)
			CONFIRM:C162("Really??"+"\r"+"Resetting Demo Date cannot be undone!!!")
			If (OK=1)
				$vtPassword:=Request:C163("Enter password.")
				If ((OK=1) & ($vtPassword="coffeeReset"))
					
					For ($tableNum; 1; $cntTables)  //  Tables  
						If (Is table number valid:C999($tableNum))
							Case of 
								: ($tableName="(@")
								: ($tableName="zz@")  // this also excludes the window database
								Else 
									$ptTable:=Table:C252($tableNum)
									ALL RECORDS:C47($ptTable->)
									$tableName:=Table name:C256($tableNum)
									$cntRecords:=Records in table:C83(Table:C252($tableNum)->)
									FIRST RECORD:C50($ptTable->)
									$cntFlds:=Get last field number:C255($tableNum)
									For ($incRecords; 1; $cntRecords)
										$dateNew:=Current date:C33+((Random:C100%(28-1+1)+1)-5)  // spread over a month
										For ($fieldNum; 1; $cntFlds)
											If (Is field number valid:C1000($tableNum; $fieldNum))
												$ptField:=Field:C253($tableNum; $fieldNum)
												$fieldName:=Field name:C257($ptField)
												GET FIELD PROPERTIES:C258($tableNum; $fieldNum; $type)
												Case of 
													: (($fieldName="DT@") & ($type=Is longint:K8:6))
														$ptField->:=DateTime_DTTo($dateNew)
													: (($type=Is date:K8:7))
														If ($ptField-><!2018-06-15!)
															$ptField->:=$dateNew
														End if 
												End case 
											End if 
										End for 
										SAVE RECORD:C53($ptTable->)
										NEXT RECORD:C51($ptTable->)
									End for 
									REDUCE SELECTION:C351($ptTable->; 0)
							End case 
						End if 
					End for 
					ALERT:C41("Compete Date Reset")
				End if 
			End if 
			// maybe rework dinventories, invoices, and payments to orders
		End if 
	End if 
End if 