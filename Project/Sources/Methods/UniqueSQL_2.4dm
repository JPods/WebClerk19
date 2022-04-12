//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-03-05T00:00:00, 00:07:07
// ----------------------------------------------------
// Method: UniqueSQL_2
// Description
// Modified: 03/05/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


If (False:C215)  // Not run but an example of how to us SQL to create UUIKey
	// Keep as an example
	
	// UniqueRunForceSQL   // was run
	
	C_TIME:C306($timeStart; $timeElapsed)
	$timeStart:=Current time:C178
	
	C_LONGINT:C283($Primary_key_field_id_L)
	C_TEXT:C284($tableName; $KeyName_txt)
	C_TEXT:C284($OUTPUT_txt; $Output1_txt)
	
	C_TEXT:C284($ConstraintID_txt)
	C_LONGINT:C283($TableNumber_L)
	$OUTPUT_txt:="ConsoleMessage ("+Txt_Quoted("ConsoleLaunch")+")"+Char:C90(Carriage return:K15:38)
	$Output1_txt:="ConsoleMessage ("+Txt_Quoted("ConsoleLaunch")+")"+Char:C90(Carriage return:K15:38)
	For ($TableNumber_L; 1; Get last table number:C254)
		If (False:C215)
			If (Is table number valid:C999($TableNumber_L))
				Begin SQL
					
					SELECT CONSTRAINT_ID
					FROM _USER_CONSTRAINTS
					WHERE TABLE_ID = :$TableNumber_L AND CONSTRAINT_TYPE = 'P'
					INTO :$ConstraintID_txt;
					
					SELECT COLUMN_ID
					FROM _USER_CONS_COLUMNS
					WHERE CONSTRAINT_ID = :$ConstraintID_txt
					INTO :$Primary_key_field_id_L;
				End SQL
			End if 
			If ($Primary_key_field_id_L#0)
				ALERT:C41("Table named "+Table name:C256($TableNumber_L)+" has a primary key named "+Field name:C257($TableNumber_L; $Primary_key_field_id_L))
				
			Else 
				
			End if 
		End if 
		ALL RECORDS:C47(Table:C252($TableNumber_L)->)
		$cntRecords:=Records in selection:C76(Table:C252($TableNumber_L)->)
		$tableName:=Table name:C256($TableNumber_L)
		$KeyName_txt:="id"  // Substring($tableName;1;21)+"_UUIDKey_s"
		//$OUTPUT_txt:=$OUTPUT_txt+"Begin SQL"+Char(Carriage return)+"ALTER TABLE ["+$tableName+"] ADD ["+$KeyName_txt+"] UUID AUTO_GENERATE PRIMARY KEY;"+Char(Carriage return)+"End SQL"+Char(Carriage return)
		
		$Output1_txt:=$Output1_txt+"ConsoleMessage ("+Char:C90(Double quote:K15:41)+$tableName+": records "+String:C10($cntRecords)+Char:C90(Double quote:K15:41)+")"+Char:C90(Carriage return:K15:38)
		$Output1_txt:=$Output1_txt+"EXECUTE FORMULA("+Char:C90(Double quote:K15:41)+"SET INDEX(["+$tableName+"]"+$KeyName_txt+";true)"+Char:C90(Double quote:K15:41)+")"+Char:C90(Carriage return:K15:38)
		
	End for 
	$OUTPUT_txt:=$OUTPUT_txt+"ConsoleMessage ("+"Completed"+")"+Char:C90(Carriage return:K15:38)
	OK:=1
	C_TIME:C306($Doc_tm)
	If (OK=1)
		$Doc_tm:=Create document:C266("")
		// SEND PACKET($Doc_tm;$OUTPUT_txt)
		SEND PACKET:C103($Doc_tm; $Output1_txt)
		
		CLOSE DOCUMENT:C267($Doc_tm)
	End if 
	SelectionToZero
	
	
End if 
