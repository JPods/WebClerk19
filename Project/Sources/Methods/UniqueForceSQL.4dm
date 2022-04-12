//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-03-04T00:00:00, 13:50:13
// ----------------------------------------------------
// Method: UniqueForceSQL
// Description
// Modified: 03/04/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


If (False:C215)  // Not run but an example of how to us SQL to create UUIKey
	// Keep as an example
	
	// UniqueRunForceSQL   // was run
	
	C_LONGINT:C283($Primary_key_field_id_L)
	C_TEXT:C284($TableName_txt; $KeyName_txt)
	C_TEXT:C284($OUTPUT_txt; $Output1_txt)
	
	C_TEXT:C284($ConstraintID_txt)
	C_LONGINT:C283($TableNumber_L)
	For ($TableNumber_L; 1; Get last table number:C254)
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
			$TableName_txt:=Table name:C256($TableNumber_L)
			$KeyName_txt:=Substring:C12($TableName_txt; 1; 21)+"_UUIDKey_s"
			$OUTPUT_txt:=$OUTPUT_txt+"Begin SQL"+Char:C90(Carriage return:K15:38)+"ALTER TABLE ["+$TableName_txt+"] ADD ["+$KeyName_txt+"] UUID AUTO_GENERATE PRIMARY KEY;"+Char:C90(Carriage return:K15:38)+"End SQL"+Char:C90(Carriage return:K15:38)
			$Output1_txt:=$Output1_txt+"EXECUTE FORMULA("+Char:C90(Double quote:K15:41)+"SET INDEX(["+$TableName_txt+"]"+$KeyName_txt+";true)"+Char:C90(Double quote:K15:41)+")"+Char:C90(Carriage return:K15:38)
			
		End if 
	End for 
	C_TIME:C306($Doc_tm)
	If (OK=1)
		$Doc_tm:=Create document:C266("")
		SEND PACKET:C103($Doc_tm; $OUTPUT_txt)
		SEND PACKET:C103($Doc_tm; $Output1_txt)
		
		CLOSE DOCUMENT:C267($Doc_tm)
	End if 
	
End if 