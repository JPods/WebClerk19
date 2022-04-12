
If (atLineEnding>0)
	
	Case of 
		: (atLineEnding{atLineEnding}="CR")
			[UserReport:46]LineEnding:51:=Character code:C91("\r")  // CArriage Return
			
			
		: (atLineEnding{atLineEnding}="LF")
			[UserReport:46]LineEnding:51:=Character code:C91("\n")  //   Line Feed
			
			
		: (atLineEnding{atLineEnding}="CRLF")  //               Carriage Return + Line Feed
			[UserReport:46]LineEnding:51:=0x000A000D
			
		Else 
			
			[UserReport:46]LineEnding:51:=Character code:C91("\r")  // Carriage Return
			
	End case 
	
End if 
