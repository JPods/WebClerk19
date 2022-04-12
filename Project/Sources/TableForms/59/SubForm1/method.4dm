
Case of 
	: (Form event code:C388=On Double Clicked:K2:5)
		
		//Add Record([Profile])
		
		If (True:C214)
			viTableNum:=Table:C252(ptCurTable)
			viFieldNum:=STR_GetUniqueFieldNum(Table name:C256(viTableNum))
			vpField:=Field:C253(viTableNum; viFieldNum)
			viType:=Type:C295(vpField->)
			If (viType=Is longint:K8:6)
				vtDocAlphaID:=String:C10(vpField->)
			Else 
				vtDocAlphaID:=vpField->
			End if 
			viResult:=AddProfile(viTableNum; vtDocAlphaID; ""; "")
			
			
			If (viResult>0)
				GOTO RECORD:C242([Profile:59]; viResult)
				MODIFY RECORD:C57([Profile:59])
			End if 
		End if 
		
End case 
