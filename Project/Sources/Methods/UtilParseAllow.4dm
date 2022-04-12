//%attributes = {"publishedWeb":true}


// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-25T00:00:00, 18:02:40
// ----------------------------------------------------
// Method: UtilParseAllow
// Description
// Modified: 08/25/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

// Modified by: William James (2014-08-25T00:00:00 PasswordByScript)
If (UserInPassWordGroup("AdminControl"))
	C_LONGINT:C283($1; $securityLevel; $numTable; $2)
	C_BOOLEAN:C305($doTable)
	$doTable:=False:C215
	If ((vHere=1) & (ptCurTable=(->[FieldCharacteristic:94])))
		$numTable:=<>aTableNums{<>aTableNames}
		$securityLevel:=$1
		QUERY:C277([FieldCharacteristic:94]; [FieldCharacteristic:94]tableNumber:1=$numTable; *)
		QUERY:C277([FieldCharacteristic:94];  & [FieldCharacteristic:94]securityLevel:3=$securityLevel)
		If (Records in selection:C76([FieldCharacteristic:94])>0)
			DELETE SELECTION:C66([FieldCharacteristic:94])
		End if 
		$cntFields:=Get last field number:C255($numTable)
		For ($incFields; 1; $cntFields)  //Loop for fields
			CREATE RECORD:C68([FieldCharacteristic:94])
			
			[FieldCharacteristic:94]tableNumber:1:=$numTable
			[FieldCharacteristic:94]fieldNumber:5:=$incFields
			[FieldCharacteristic:94]securityLevel:3:=$securityLevel
			[FieldCharacteristic:94]tableName:7:=Table name:C256(Table:C252($numTable))
			[FieldCharacteristic:94]fieldName:8:=Field name:C257(Field:C253($numTable; $incFields))
			SAVE RECORD:C53([FieldCharacteristic:94])
		End for 
		QUERY:C277([FieldCharacteristic:94]; [FieldCharacteristic:94]tableNumber:1=$numTable; *)
		QUERY:C277([FieldCharacteristic:94];  & [FieldCharacteristic:94]securityLevel:3=$securityLevel)
	Else 
		If (Count parameters:C259=1)
			$securityLevel:=$1
			If (Count parameters:C259>1)
				$numTable:=$2
				$doTable:=True:C214
			End if 
			If ($doTable)
				$numTable:=<>aTableNums{<>aTableNames}
				QUERY:C277([FieldCharacteristic:94]; [FieldCharacteristic:94]tableNumber:1=$numTable; *)
				QUERY:C277([FieldCharacteristic:94];  & [FieldCharacteristic:94]securityLevel:3=$securityLevel)
				If (Records in selection:C76([FieldCharacteristic:94])>0)
					DELETE SELECTION:C66([FieldCharacteristic:94])
				End if 
				$cntFields:=Get last field number:C255($numTable)
				For ($incFields; 1; $cntFields)  //Loop for fields
					CREATE RECORD:C68([FieldCharacteristic:94])
					
					[FieldCharacteristic:94]tableNumber:1:=$numTable
					[FieldCharacteristic:94]fieldNumber:5:=$incFields
					[FieldCharacteristic:94]securityLevel:3:=$securityLevel
					SAVE RECORD:C53([FieldCharacteristic:94])
				End for 
			Else 
				QUERY:C277([FieldCharacteristic:94]; [FieldCharacteristic:94]securityLevel:3=$securityLevel)
				If (Records in selection:C76([FieldCharacteristic:94])>0)
					DELETE SELECTION:C66([FieldCharacteristic:94])
				End if 
				C_LONGINT:C283($cntFields; $incFields)
				
				$k:=Get last table number:C254
				For ($i; 1; $k)  //Loop for files  
					$cntFields:=Get last field number:C255($i)
					For ($incFields; 1; $cntFields)  //Loop for fields
						CREATE RECORD:C68([FieldCharacteristic:94])
						
						[FieldCharacteristic:94]tableNumber:1:=$i
						[FieldCharacteristic:94]fieldNumber:5:=$incFields
						[FieldCharacteristic:94]securityLevel:3:=$securityLevel
						SAVE RECORD:C53([FieldCharacteristic:94])
					End for 
				End for 
			End if 
		End if 
	End if 
End if 