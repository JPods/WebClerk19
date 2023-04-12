//%attributes = {"publishedWeb":true}
//Nxpr_TallyResul
If (Is new record:C668([TallyResult:73]))
	[TallyResult:73]dtCreated:11:=DateTime_DTTo
End if 
Case of 
	: (myOK<10)
		Case of 
			: (myOK=9)
				[TallyResult:73]purpose:2:="webClerk1"
				[TallyResult:73]publish:36:=1
			: (myOK=8)
				[TallyResult:73]purpose:2:="webClerk2"
				[TallyResult:73]publish:36:=1
			: (myOK=7)
				[TallyResult:73]purpose:2:="FAQ"
				[TallyResult:73]publish:36:=1
		End case 
		[TallyResult:73]nameProfile1:26:="Who"
		[TallyResult:73]nameProfile2:27:="Topic"
		[TallyResult:73]nameProfile3:28:="Subject"
	: (myOK=10)
		[TallyResult:73]customerID:30:=[Customer:2]customerID:1
		[TallyResult:73]purpose:2:="Service Contract"
		[TallyResult:73]name:1:=String:C10(Year of:C25(Current date:C33); "####")
		[TallyResult:73]nameReal1:20:="Contract hours"
		[TallyResult:73]nameReal2:21:="Hours avail"
		[TallyResult:73]real1:13:=8
		[TallyResult:73]real2:14:=8
		[TallyResult:73]nameReal3:22:="Time Billed"
		[TallyResult:73]nameReal4:23:="Time Courtesy"
		[TallyResult:73]nameProfile1:26:="Start Service"
		[TallyResult:73]nameProfile2:27:="End Service"
		[TallyResult:73]nameLong1:24:="$ Contract"
		[TallyResult:73]profile1:17:=String:C10(Current date:C33)
		[TallyResult:73]profile2:18:=String:C10(Date_AddPeriod("year"; Current date:C33))
		[TallyResult:73]longint1:7:=0
		[TallyResult:73]dtReport:12:=DateTime_DTTo(Date:C102([TallyResult:73]profile2:18); ?00:00:00?)
End case 
myOK:=0