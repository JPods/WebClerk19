
If (atDelimiter>0)
	
	Case of 
		: (atDelimiter{atDelimiter}="tab@")
			[UserReport:46]FieldDelimiter:50:=Character code:C91("\t")  // Tab = 9
			
			
		: (atDelimiter{atDelimiter}="Comma@")
			[UserReport:46]FieldDelimiter:50:=Character code:C91(",")  //   Comma = 44
			
			
		: (atDelimiter{atDelimiter}="Semicolon@")
			[UserReport:46]FieldDelimiter:50:=Character code:C91(";")  //   Semicolon = 59
			
			
	End case 
	
End if 
