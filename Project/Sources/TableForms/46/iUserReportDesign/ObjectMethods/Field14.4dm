// Modified by: William James (2013-07-29T00:00:00)


doSearch:=3
Case of 
	: ([UserReport:46]NumLines:10=0)
		aURpLnType:=1  //By Record Count of the default file
	: ([UserReport:46]NumLines:10=-99)
		aURpLnType:=2  //Loop once for each default file record
	: ([UserReport:46]NumLines:10<0)
		aURpLnType:=3  //Custom iterations; set-up in the editor for each report
	Else 
		aURpLnType:=4  //Fixed number of lines per page, uses P_... vars
End case 