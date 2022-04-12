//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: FieldCharExport
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
If (UserInPassWordGroup("AdminControl"))
	CONFIRM:C162("Export Selected Field Characteristics")
	If (OK=1)
		C_LONGINT:C283($i; $k)
		$k:=Records in selection:C76([FieldCharacteristic:94])
		If ($k>0)
			myDoc:=Create document:C266("")
			If (OK=1)
				FIRST RECORD:C50([FieldCharacteristic:94])
				SEND PACKET:C103(myDoc; "TableName"+"\t"+"FieldName"+"\t"+"TableNum"+"\t"+"FieldNum"+"\t"+"Security"+"\t"+"idNum"+"\r")
				For ($i; 1; $k)
					SEND PACKET:C103(myDoc; Table name:C256([FieldCharacteristic:94]tableNum:1)+"\t"+Field name:C257([FieldCharacteristic:94]tableNum:1; [FieldCharacteristic:94]fieldNumber:5)+"\t")
					SEND PACKET:C103(myDoc; String:C10([FieldCharacteristic:94]tableNum:1)+"\t"+String:C10([FieldCharacteristic:94]fieldNumber:5)+"\t"+String:C10([FieldCharacteristic:94]securityLevel:3)+"\t")
					SEND PACKET:C103(myDoc; String:C10([FieldCharacteristic:94]idNum:4)+"\r")
					NEXT RECORD:C51([FieldCharacteristic:94])
				End for 
				CLOSE DOCUMENT:C267(myDoc)
			End if 
		End if 
	End if 
End if 