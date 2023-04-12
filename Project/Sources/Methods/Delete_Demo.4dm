//%attributes = {"publishedWeb":true}
//
If (False:C215)
	//Method: Delete_Demo  
	//Date: 02/27/02
	//Who: Bill James, JIT
	//Description:
	VERSION_960
End if 
C_LONGINT:C283($i; $k)
CONFIRM:C162("Are you sure you wish to Delete this data set to zero?")
If (OK=1)
	CONFIRM:C162("Ask between deleting each table?"; "Ask"; "Auto")
	$i0:=OK
	CONFIRM:C162("This change cannot be undone!!!")
	If (OK=1)
		$k:=Get last table number:C254
		For ($i; 1; $k)
			$tableName:=Table name:C256($i)
			Case of 
					
				: ($tableName="Customer")  //  
					
					
				: ($tableName="Control")  //($i=1)//Control
				: ($tableName="DefaultAcct")  //($i=32)//DefaultsAcount
				: ($tableName="TechNote")
				: ($tableName="Term")  //($i=37)//Terms
				: ($tableName="Counter")  //($i=41)//Counters
					// Reset
				: ($tableName="CronJob")
				: ($tableName="FieldCharacteristic")
				: ($tableName="Report")
				: ($tableName="Carrier")  //($i=11)//Carriers
				: ($tableName="CarrierWeight")  //($i=11)//Carriers
				: ($tableName="CarrierZone")  //($i=11)//Carriers
				: ($tableName="Default")  //($i=15)//Defaults
				: ($tableName="PopUp")  //($i=23)//Popups
				: ($tableName="TallyMaster")
				: ($tableName="Param")  //: ($i=78)//Params
				: ($tableName="Script")  //: ($i=78)//Params
				: ($tableName="Employee")  //($i=19)//Employees
					
					QUERY:C277([Employee:19]; [Employee:19]nameID:1#"admin@")
					DELETE SELECTION:C66(Table:C252($i)->)
				Else 
					vi9:=1
					If ($i0=1)
						CONFIRM:C162("Delete Records!!! Table "+$tableName)
						vi9:=OK
					End if 
					If (vi9=1)
						READ WRITE:C146(Table:C252($i)->)
						
						Case of 
							: ($tableName="Employee")
								QUERY:C277([Employee:19]; [Employee:19]nameID:1#"Admin@")
								// ### bj ### 20210219_1123  Why is this here? QQQ
							Else 
								ALL RECORDS:C47(Table:C252($i)->)
						End case 
						DELETE SELECTION:C66(Table:C252($i)->)
					End if 
			End case 
		End for 
	End if 
End if 

