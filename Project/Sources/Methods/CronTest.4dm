//%attributes = {}
//Script:   CronJobs dtNextStart 20120906
//Author:   James W. Medlen
//Comment:  Run Scheduled scripts 
//Created:  09/01/11
//Modified: 09/20/11
//Notes:    * matches all values

C_TEXT:C284(vtMinute; vtHour; vtDay; vtMonth; vtWeekday; vtYear)
C_TEXT:C284(vtCronMinute; vtCronHour; vtCronDay; vtCronMonth; vtCronWeekday; vtCronYear)
C_LONGINT:C283(viMinute; viHour; viDay; viMonth; viWeekday; viYear; viIndex; viEnd; viInterval; viNum; viDayNum)
C_LONGINT:C283(viNextMinute; viNextHour; viNextDay; viNextMonth; viNextWeekday; viNextYear)
C_DATE:C307(myDate)

vtCronMinute:=""
vtCronHour:=""
vtCronDay:=""
vtCronMonth:=""
vtCronWeekday:=""
vtCronYear:=""
vTab:=Char:C90(9)

If (True:C214)
	vtMinute:=""
	vtHour:=""
	vtDayOfMonth:=""
	vtMonth:=""
	vtDayOfWeek:=""
	vtYear:=""
	
	ARRAY TEXT:C222(atDayOfWeek; 7)
	atDayOfWeek{0}:="Sunday"
	atDayOfWeek{1}:="Monday"
	atDayOfWeek{2}:="Tuesday"
	atDayOfWeek{3}:="Wednesday"
	atDayOfWeek{4}:="Thursday"
	atDayOfWeek{5}:="Friday"
	atDayOfWeek{6}:="Saturday"
	atDayOfWeek{7}:="Sunday"
	
	ARRAY LONGINT:C221(aiEOM; 12)
	aiEOM{1}:=31
	aiEOM{2}:=29  //Leap year/day is available for interval calculations
	aiEOM{3}:=31
	aiEOM{4}:=30
	aiEOM{5}:=31
	aiEOM{6}:=30
	aiEOM{7}:=31
	aiEOM{8}:=31
	aiEOM{9}:=30
	aiEOM{10}:=31
	aiEOM{11}:=30
	aiEOM{12}:=31
	
	
	viMinute:=((Current time:C178\60)%60)
	viHour:=(Current time:C178\3600)
	viDay:=(Day of:C23(Current date:C33))
	viMonth:=(Month of:C24(Current date:C33))
	viWeekday:=(Day number:C114(Current date:C33)-1)  //Unix Cron weekdays (0-6) Sunday-Saturday (7 also = Sunday), 4D (1-7) Sunday-Saturday
	viYear:=Year of:C25(Current date:C33)
	
	//viNextMinute := viMinute
	//viNextHour := viHour
	//viNextDay := viDay
	//viNextMonth := viMonth
	//viNextWeekDay := viWeekday
	//viNextYear := viYear
	
	vtMinute:=String:C10(viMinute)
	vtHour:=String:C10(viHour)
	vtDay:=String:C10(viDay)
	vtMonth:=String:C10(viMonth)
	vtWeekday:=String:C10(viWeekday)
	vtYear:=String:C10(viYear)
	
	vText1:=""
	vText1:=vText1+"Current Minute "+vtMinute+"\r"
	vText1:=vText1+"Current Hour "+vtHour+"\r"
	vText1:=vText1+"Current Day "+vtDay+"\r"
	vText1:=vText1+"Current Month "+vtMonth+"\r"
	vText1:=vText1+"Current Weekday "+vtWeekday+" = "+atDayOfWeek{viWeekday}+"\r"
	vText1:=vText1+"Current Year "+vtYear+"\r"
	//Alert(vText1)
	
	//vText:="*"+vTab+"*"+vTab+"*"+vTab+"*"+vTab+"*"
	//vText:="*"+vTab+"*"+vTab+"1"+vTab+"9"+vTab+"*"
	//vText:=Request("Enter Cron Date Time * * * * *")
	//Alert(vText)
End if 

//vText := "0/5 9-17 * * 1-5 *"
vText:=[TallyMaster:60]alphaKey:26  //Alert(vText)

viPointer:=1
vi2:=Length:C16(vText)
For (vi1; 1; vi2)
	
	If ((vText[[vi1]]=vTab) | (vText[[vi1]]=" "))
		viPointer:=viPointer+1
	Else 
		Case of 
				
			: (viPointer=1)  //minute (0-59)
				vtCronMinute:=vtCronMinute+vText[[vi1]]
				
			: (viPointer=2)  //hour (0-23)
				vtCronHour:=vtCronHour+vText[[vi1]]
				
			: (viPointer=3)  //day of the month (1-31)
				vtCronDay:=vtCronDay+vText[[vi1]]
				
			: (viPointer=4)  //month (1-12)
				vtCronMonth:=vtCronMonth+vText[[vi1]]
				
			: (viPointer=5)  //day of the week (1-7) (Sunday = 1) 4D uses 1-7 as Sunday - Saturday
				vtCronWeekday:=vtCronWeekday+vText[[vi1]]
				
			: (viPointer=6)  //Year 4 digit match for one time scripts
				vtCronYear:=vtCronYear+vText[[vi1]]
				
		End case 
	End if 
	
End for 

//Parse Multiple Values

//==== vtCronMinute ====

//parse comma separated values

ARRAY TEXT:C222(atCronMinute; 0)
viDelimiter:=1
APPEND TO ARRAY:C911(atCronMinute; "")
For (vi1; 1; Length:C16(vtCronMinute))
	If (vtCronMinute[[vi1]]=",")
		viDelimiter:=viDelimiter+1
		APPEND TO ARRAY:C911(atCronMinute; "")
	Else 
		atCronMinute{viDelimiter}:=atCronMinute{viDelimiter}+vtCronMinute[[vi1]]
	End if 
End for 

//parse range values x-y

vi2:=Size of array:C274(atCronMinute)  //save current size of array
For (vi1; 1; vi2)
	vText:=atCronMinute{vi1}
	viLength:=Length:C16(vText)
	viPosition:=Position:C15("-"; vText)
	If ((viPosition#0) & (viPosition#1) & (viPosition#viLength))  //delimiter must exist and can't be the first or last character
		vText1:=Substring:C12(vText; 1; viPosition-1)
		vText2:=Substring:C12(vText; viPosition+1; (viLength-viPosition))
		//Alert(vText1)
		//Alert(vText2)
		viIndex:=Num:C11(vText1)
		viEnd:=Num:C11(vText2)
		While (viIndex<=viEnd)
			//Alert(String(viIndex))
			APPEND TO ARRAY:C911(atCronMinute; String:C10(viIndex))
			viIndex:=viIndex+1
		End while 
		DELETE FROM ARRAY:C228(atCronMinute; vi1)
	End if 
End for 

//parse interval values x/y

vi2:=Size of array:C274(atCronMinute)  //save current size of array
For (vi1; 1; vi2)
	vText:=atCronMinute{vi1}
	viLength:=Length:C16(vText)
	viPosition:=Position:C15("/"; vText)
	If ((viPosition#0) & (viPosition#1) & (viPosition#viLength))  //delimiter must exist and can't be the first or last character
		vText1:=Substring:C12(vText; 1; viPosition-1)
		vText2:=Substring:C12(vText; viPosition+1; (viLength-viPosition))
		//Alert(vText1)
		//Alert(vText2)
		viIndex:=Num:C11(vText1)
		viInterval:=Num:C11(vText2)
		viEnd:=59
		While (viIndex<=viEnd)
			//Alert(String(viIndex))
			APPEND TO ARRAY:C911(atCronMinute; String:C10(viIndex))
			viIndex:=viIndex+viInterval
		End while 
		DELETE FROM ARRAY:C228(atCronMinute; vi1)
	End if 
End for 


//==== vtCronHour ====

//parse comma separated values

ARRAY TEXT:C222(atCronHour; 0)
viDelimiter:=1
APPEND TO ARRAY:C911(atCronHour; "")
For (vi1; 1; Length:C16(vtCronHour))
	If (vtCronHour[[vi1]]=",")
		viDelimiter:=viDelimiter+1
		APPEND TO ARRAY:C911(atCronHour; "")
	Else 
		atCronHour{viDelimiter}:=atCronHour{viDelimiter}+vtCronHour[[vi1]]
	End if 
End for 

//parse range values x-y

vi2:=Size of array:C274(atCronHour)  //save current size of array
For (vi1; 1; vi2)
	vText:=atCronHour{vi1}
	viLength:=Length:C16(vText)
	viPosition:=Position:C15("-"; vText)
	If ((viPosition#0) & (viPosition#1) & (viPosition#viLength))  //delimiter must exist and can't be the first or last character
		vText1:=Substring:C12(vText; 1; viPosition-1)
		vText2:=Substring:C12(vText; viPosition+1; (viLength-viPosition))
		//Alert(vText1)
		//Alert(vText2)
		viIndex:=Num:C11(vText1)
		viEnd:=Num:C11(vText2)
		While (viIndex<=viEnd)
			//Alert(String(viIndex))
			APPEND TO ARRAY:C911(atCronHour; String:C10(viIndex))
			viIndex:=viIndex+1
		End while 
		DELETE FROM ARRAY:C228(atCronHour; vi1)
	End if 
End for 

//parse interval values x/y

vi2:=Size of array:C274(atCronHour)  //save current size of array
For (vi1; 1; vi2)
	vText:=atCronHour{vi1}
	viLength:=Length:C16(vText)
	viPosition:=Position:C15("/"; vText)
	If ((viPosition#0) & (viPosition#1) & (viPosition#viLength))  //delimiter must exist and can't be the first or last character
		vText1:=Substring:C12(vText; 1; viPosition-1)
		vText2:=Substring:C12(vText; viPosition+1; (viLength-viPosition))
		//Alert(vText1)
		//Alert(vText2)
		viIndex:=Num:C11(vText1)
		viInterval:=Num:C11(vText2)
		viEnd:=23
		While (viIndex<=viEnd)
			//Alert(String(viIndex))
			APPEND TO ARRAY:C911(atCronHour; String:C10(viIndex))
			viIndex:=viIndex+viInterval
		End while 
		DELETE FROM ARRAY:C228(atCronHour; vi1)
	End if 
End for 



//==== vtCronDay ====

//parse comma separated values

ARRAY TEXT:C222(atCronDay; 0)
viDelimiter:=1
APPEND TO ARRAY:C911(atCronDay; "")
For (vi1; 1; Length:C16(vtCronDay))
	If (vtCronDay[[vi1]]=",")
		viDelimiter:=viDelimiter+1
		APPEND TO ARRAY:C911(atCronDay; "")
	Else 
		atCronDay{viDelimiter}:=atCronDay{viDelimiter}+vtCronDay[[vi1]]
	End if 
End for 

//Replace L with last day of the month
vi2:=Size of array:C274(atCronDay)  //save current size of array
For (vi1; 1; vi2)
	If (atCronDay{vi1}="@L@")  //Last Day of Month
		myDate:=Add to date:C393(Current date:C33; 0; 1; 0)  //next Month
		myDate:=myDate-(Day of:C23(myDate))  //End of this month
		vtLastDay:=String:C10(Day of:C23(myDate))  //last day of the month
		atCronDay{vi1}:=Replace string:C233(atCronDay{vi1}; "L"; vtLastDay)
		//Alert("atCronDay{vi1} = "+atCronDay{vi1}+" vtLastDay = "+vtLastDay)
	End if 
End for 

//parse range values x-y

vi2:=Size of array:C274(atCronDay)  //save current size of array
For (vi1; 1; vi2)
	vText:=atCronDay{vi1}
	viLength:=Length:C16(vText)
	viPosition:=Position:C15("-"; vText)
	If ((viPosition#0) & (viPosition#1) & (viPosition#viLength))  //delimiter must exist and can't be the first or last character
		vText1:=Substring:C12(vText; 1; viPosition-1)
		vText2:=Substring:C12(vText; viPosition+1; (viLength-viPosition))
		viIndex:=Num:C11(vText1)
		viEnd:=Num:C11(vText2)
		While (viIndex<=viEnd)
			//Alert(String(viIndex))
			APPEND TO ARRAY:C911(atCronDay; String:C10(viIndex))
			viIndex:=viIndex+1
		End while 
		DELETE FROM ARRAY:C228(atCronDay; vi1)
	End if 
End for 

//parse interval values x/y

vi2:=Size of array:C274(atCronDay)  //save current size of array
For (vi1; 1; vi2)
	vText:=atCronDay{vi1}
	viLength:=Length:C16(vText)
	viPosition:=Position:C15("/"; vText)
	If ((viPosition#0) & (viPosition#1) & (viPosition#viLength))  //delimiter must exist and can't be the first or last character
		vText1:=Substring:C12(vText; 1; viPosition-1)
		vText2:=Substring:C12(vText; viPosition+1; (viLength-viPosition))
		//Alert(vText1)
		//Alert(vText2)
		viIndex:=Num:C11(vText1)
		viInterval:=Num:C11(vText2)
		viEnd:=31
		While (viIndex<=viEnd)
			//Alert(String(viIndex))
			APPEND TO ARRAY:C911(atCronDay; String:C10(viIndex))
			viIndex:=viIndex+viInterval
		End while 
		DELETE FROM ARRAY:C228(atCronDay; vi1)
	End if 
End for 



//==== vtCronMonth ====

//parse comma separated values

ARRAY TEXT:C222(atCronMonth; 0)
viDelimiter:=1
APPEND TO ARRAY:C911(atCronMonth; "")
For (vi1; 1; Length:C16(vtCronMonth))
	If (vtCronMonth[[vi1]]=",")
		viDelimiter:=viDelimiter+1
		APPEND TO ARRAY:C911(atCronMonth; "")
	Else 
		atCronMonth{viDelimiter}:=atCronMonth{viDelimiter}+vtCronMonth[[vi1]]
	End if 
End for 

//parse range values x-y

vi2:=Size of array:C274(atCronMonth)  //save current size of array
For (vi1; 1; vi2)
	vText:=atCronMonth{vi1}
	viLength:=Length:C16(vText)
	viPosition:=Position:C15("-"; vText)
	If ((viPosition#0) & (viPosition#1) & (viPosition#viLength))  //delimiter must exist and can't be the first or last character
		vText1:=Substring:C12(vText; 1; viPosition-1)
		vText2:=Substring:C12(vText; viPosition+1; (viLength-viPosition))
		//Alert(vText1)
		//Alert(vText2)
		viIndex:=Num:C11(vText1)
		viEnd:=Num:C11(vText2)
		While (viIndex<=viEnd)
			//Alert(String(viIndex))
			APPEND TO ARRAY:C911(atCronMonth; String:C10(viIndex))
			viIndex:=viIndex+1
		End while 
		DELETE FROM ARRAY:C228(atCronMonth; vi1)
	End if 
End for 

//parse interval values x/y

vi2:=Size of array:C274(atCronMonth)  //save current size of array
For (vi1; 1; vi2)
	vText:=atCronMonth{vi1}
	viLength:=Length:C16(vText)
	viPosition:=Position:C15("/"; vText)
	If ((viPosition#0) & (viPosition#1) & (viPosition#viLength))  //delimiter must exist and can't be the first or last character
		vText1:=Substring:C12(vText; 1; viPosition-1)
		vText2:=Substring:C12(vText; viPosition+1; (viLength-viPosition))
		//Alert(vText1)
		//Alert(vText2)
		viIndex:=Num:C11(vText1)
		viInterval:=Num:C11(vText2)
		viEnd:=12
		While (viIndex<=viEnd)
			//Alert(String(viIndex))
			APPEND TO ARRAY:C911(atCronMonth; String:C10(viIndex))
			viIndex:=viIndex+viInterval
		End while 
		DELETE FROM ARRAY:C228(atCronMonth; vi1)
	End if 
End for 

//==== vtCronWeekday ====

//parse comma separated values

ARRAY TEXT:C222(atCronWeekday; 0)
viDelimiter:=1
APPEND TO ARRAY:C911(atCronWeekday; "")
For (vi1; 1; Length:C16(vtCronWeekday))
	If (vtCronWeekday[[vi1]]=",")
		viDelimiter:=viDelimiter+1
		APPEND TO ARRAY:C911(atCronWeekday; "")
	Else 
		atCronWeekday{viDelimiter}:=atCronWeekday{viDelimiter}+vtCronWeekday[[vi1]]
	End if 
End for 

//parse range values x-y

vi2:=Size of array:C274(atCronWeekday)  //save current size of array
For (vi1; 1; vi2)
	vText:=atCronWeekday{vi1}
	viLength:=Length:C16(vText)
	viPosition:=Position:C15("-"; vText)
	If ((viPosition#0) & (viPosition#1) & (viPosition#viLength))  //delimiter must exist and can't be the first or last character
		vText1:=Substring:C12(vText; 1; viPosition-1)
		vText2:=Substring:C12(vText; viPosition+1; (viLength-viPosition))
		//Alert(vText1)
		//Alert(vText2)
		viIndex:=Num:C11(vText1)
		viEnd:=Num:C11(vText2)
		While (viIndex<=viEnd)
			//Alert(String(viIndex))
			APPEND TO ARRAY:C911(atCronWeekday; String:C10(viIndex))
			viIndex:=viIndex+1
		End while 
		DELETE FROM ARRAY:C228(atCronWeekday; vi1)
	End if 
End for 

//parse interval values x/y

vi2:=Size of array:C274(atCronWeekday)  //save current size of array
For (vi1; 1; vi2)
	vText:=atCronWeekday{vi1}
	viLength:=Length:C16(vText)
	viPosition:=Position:C15("/"; vText)
	If ((viPosition#0) & (viPosition#1) & (viPosition#viLength))  //delimiter must exist and can't be the first or last character
		vText1:=Substring:C12(vText; 1; viPosition-1)
		vText2:=Substring:C12(vText; viPosition+1; (viLength-viPosition))
		//Alert(vText1)
		//Alert(vText2)
		viIndex:=Num:C11(vText1)
		viInterval:=Num:C11(vText2)
		viEnd:=7
		While (viIndex<=viEnd)
			//Alert(String(viIndex))
			APPEND TO ARRAY:C911(atCronWeekday; String:C10(viIndex))
			viIndex:=viIndex+viInterval
		End while 
		DELETE FROM ARRAY:C228(atCronWeekday; vi1)
	End if 
End for 

//Convert 7 to 0 both 0 and 7 = Sunday
vi2:=Size of array:C274(atCronWeekday)  //save current size of array
For (vi1; 1; vi2)
	atCronWeekday{vi1}:=Replace string:C233(atCronWeekday{vi1}; "7"; "0")
End for 

//parse hash values x#y

vi2:=Size of array:C274(atCronWeekday)  //save current size of array
For (vi1; 1; vi2)
	vText:=atCronWeekday{vi1}
	viLength:=Length:C16(vText)
	viPosition:=Position:C15("#"; vText)
	If ((viPosition#0) & (viPosition#1) & (viPosition#viLength))  //delimiter must exist and can't be the first or last character
		vText1:=Substring:C12(vText; 1; viPosition-1)
		vText2:=Substring:C12(vText; viPosition+1; (viLength-viPosition))
		//Alert(vText1)
		//Alert(vText2)
		viIndex:=Num:C11(vText1)
		viNum:=Num:C11(vText2)
		
		ARRAY TEXT:C222(atDays; 0)
		viWeekday:=viIndex+1  //Need to add one to the cron week day for 4D Day Number
		//FOM - First of Month
		//EOM - End of Month
		FOM:=Current date:C33-Day of:C23(Current date:C33)+1
		EOM:=(Add to date:C393(Current date:C33; 0; 1; 0))-(Day of:C23(Add to date:C393(Current date:C33; 0; 1; 0)))
		NumDays:=EOM-FOM+1  //Number of days in the month
		
		TheDay:=FOM
		For (viDayNum; 1; NumDays)
			If (Day number:C114(TheDay)=viWeekday)
				APPEND TO ARRAY:C911(atDays; String:C10(Day of:C23(TheDay)))
			End if 
			TheDay:=TheDay+1  //Increment the date
		End for 
		viMax:=Size of array:C274(atDays)
		If ((viNum>=1) & (viNum<=viMax))
			APPEND TO ARRAY:C911(atCronDay; atDays{viNum})  //Adds a date to the list of valid days of the month
		End if 
		atCronWeekday{vi1}:="*"
		
		//Delete element (atCronWeekday;vi1)
		
	End if 
End for 

//parse last values xL

vi2:=Size of array:C274(atCronWeekday)  //save current size of array
For (vi1; 1; vi2)
	vText:=atCronWeekday{vi1}
	viLength:=Length:C16(vText)
	viPosition:=Position:C15("L"; vText)
	If ((viPosition#0) & (viPosition#1) & (viPosition=viLength) & (viLength=2))  //delimiter must exist and can't be the first and is the last character
		vText1:=Substring:C12(vText; 1; viPosition-1)
		viIndex:=Num:C11(vText1)
		
		ARRAY TEXT:C222(atDays; 0)
		viWeekday:=viIndex+1  //Need to add one to the cron week day for 4D Day Number
		//FOM - First of Month
		//EOM - End of Month
		FOM:=Current date:C33-Day of:C23(Current date:C33)+1
		EOM:=(Add to date:C393(Current date:C33; 0; 1; 0))-(Day of:C23(Add to date:C393(Current date:C33; 0; 1; 0)))
		NumDays:=EOM-FOM+1  //Number of days in the month
		
		TheDay:=FOM
		For (viDayNum; 1; NumDays)
			If (Day number:C114(TheDay)=viWeekday)
				APPEND TO ARRAY:C911(atDays; String:C10(Day of:C23(TheDay)))
			End if 
			TheDay:=TheDay+1  //Increment the date
		End for 
		viMax:=Size of array:C274(atDays)
		APPEND TO ARRAY:C911(atCronDay; atDays{viMax})  //Adds a date to the list of valid days of the month
		atCronWeekday{vi1}:="*"
		
		//Delete element (atCronWeekday;vi1)
		
	End if 
End for 



//==== vtCronYear ====

//parse comma separated values

ARRAY TEXT:C222(atCronYear; 0)
viDelimiter:=1
APPEND TO ARRAY:C911(atCronYear; "")
For (vi1; 1; Length:C16(vtCronYear))
	If (vtCronYear[[vi1]]=",")
		viDelimiter:=viDelimiter+1
		APPEND TO ARRAY:C911(atCronYear; "")
	Else 
		atCronYear{viDelimiter}:=atCronYear{viDelimiter}+vtCronYear[[vi1]]
	End if 
End for 

//parse range values x-y

vi2:=Size of array:C274(atCronYear)  //save current size of array
For (vi1; 1; vi2)
	vText:=atCronYear{vi1}
	viLength:=Length:C16(vText)
	viPosition:=Position:C15("-"; vText)
	If ((viPosition#0) & (viPosition#1) & (viPosition#viLength))  //delimiter must exist and can't be the first or last character
		vText1:=Substring:C12(vText; 1; viPosition-1)
		vText2:=Substring:C12(vText; viPosition+1; (viLength-viPosition))
		//Alert(vText1)
		//Alert(vText2)
		viIndex:=Num:C11(vText1)
		viEnd:=Num:C11(vText2)
		While (viIndex<=viEnd)
			//Alert(String(viIndex))
			APPEND TO ARRAY:C911(atCronYear; String:C10(viIndex))
			viIndex:=viIndex+1
		End while 
		DELETE FROM ARRAY:C228(atCronYear; vi1)
	End if 
End for 

//parse interval values x/y

vi2:=Size of array:C274(atCronYear)  //save current size of array
For (vi1; 1; vi2)
	vText:=atCronYear{vi1}
	viLength:=Length:C16(vText)
	viPosition:=Position:C15("/"; vText)
	If ((viPosition#0) & (viPosition#1) & (viPosition#viLength))  //delimiter must exist and can't be the first or last character
		vText1:=Substring:C12(vText; 1; viPosition-1)
		vText2:=Substring:C12(vText; viPosition+1; (viLength-viPosition))
		//Alert(vText1)
		//Alert(vText2)
		viIndex:=Num:C11(vText1)
		viInterval:=Num:C11(vText2)
		viEnd:=2099  //Wikipedia lists 2099 as the upper limit can be adjusted later
		While (viIndex<=viEnd)
			//Alert(String(viIndex))
			APPEND TO ARRAY:C911(atCronYear; String:C10(viIndex))
			viIndex:=viIndex+viInterval
		End while 
		DELETE FROM ARRAY:C228(atCronYear; vi1)
	End if 
End for 

//End Parse Multiple Values

vtCronMinuteAll:=""
For (vi1; 1; Size of array:C274(atCronMinute))
	vtCronMinuteAll:=vtCronMinuteAll+","+atCronMinute{vi1}
End for 

vtCronHourAll:=""
For (vi1; 1; Size of array:C274(atCronHour))
	vtCronHourAll:=vtCronHourAll+","+atCronHour{vi1}
End for 

vtCronDayAll:=""
For (vi1; 1; Size of array:C274(atCronDay))
	vtCronDayAll:=vtCronDayAll+","+atCronDay{vi1}
End for 

vtCronMonthAll:=""
For (vi1; 1; Size of array:C274(atCronMonth))
	vtCronMonthAll:=vtCronMonthAll+","+atCronMonth{vi1}
End for 

vtCronWeekdayAll:=""
For (vi1; 1; Size of array:C274(atCronWeekday))
	vtCronWeekdayAll:=vtCronWeekdayAll+","+atCronWeekday{vi1}
End for 

vtCronYearAll:=""
For (vi1; 1; Size of array:C274(atCronYear))
	vtCronYearAll:=vtCronYearAll+","+atCronYear{vi1}
End for 

If (True:C214)
	vText1:=""
	vText1:=vText1+"Cron Minute "+vtCronMinute+" "+vtCronMinuteAll+"\r"
	vText1:=vText1+"Cron Hour "+vtCronHour+" "+vtCronHourAll+"\r"
	vText1:=vText1+"Cron Day "+vtCronDay+" "+vtCronDayAll+"\r"
	vText1:=vText1+"Cron Month "+vtCronMonth+" "+vtCronMonthAll+"\r"
	vText1:=vText1+"Cron Weekday "+vtCronWeekday+" "+vtCronWeekdayAll+"\r"
	vText1:=vText1+"Cron Year "+vtCronYear+" "+vtCronYearAll+"\r"
	//Alert(vText1)
End if 

//viMinute
//viHour
//viDay
//viMonth
//viWeekday
//viYear

If (vtCronMinute="*")
	viNextMinute:=viMinute
Else 
	viNextMinute:=Num:C11(atCronMinute{1})
	For (x; 1; Size of array:C274(atCronMinute))
		//Alert("atCronMinute{x} = "+atCronMinute{x}+" viMinute = "+String(viMinute))
		If (Num:C11(atCronMinute{x})>=viMinute)
			viNextMinute:=Num:C11(atCronMinute{x})
			x:=Size of array:C274(atCronMinute)
		End if 
	End for 
End if 
//Alert("viNextMinute ="+ String(viNextMinute))

If (vtCronHour="*")
	viNextHour:=viHour
Else 
	viNextHour:=Num:C11(atCronHour{1})
	For (x; 1; Size of array:C274(atCronHour))
		If (Num:C11(atCronHour{x})>=viHour)
			viNextHour:=Num:C11(atCronHour{x})
			x:=Size of array:C274(atCronHour)
		End if 
	End for 
End if 
//Alert("viNextHour ="+ String(viNextHour))

If (vtCronDay="*")
	viNextDay:=viDay
Else 
	viNextDay:=Num:C11(atCronDay{1})
	For (x; 1; Size of array:C274(atCronDay))
		If (Num:C11(atCronDay{x})>=viDay)
			viNextDay:=Num:C11(atCronDay{x})
			x:=Size of array:C274(atCronDay)
		End if 
	End for 
End if 
//Alert("viNextDay ="+ String(viNextDay))

If (vtCronMonth="*")
	viNextMonth:=viMonth
Else 
	viNextMonth:=Num:C11(atCronMonth{1})
	For (x; 1; Size of array:C274(atCronMonth))
		If (Num:C11(atCronMonth{x})>=viMonth)
			viNextMonth:=Num:C11(atCronMonth{x})
			x:=Size of array:C274(atCronMonth)
		End if 
	End for 
End if 
//Alert("viNextMonth ="+ String(viNextMonth))

If (vtCronWeekday="*")
	viNextWeekday:=viWeekday
Else 
	viNextWeekday:=Num:C11(atCronWeekday{1})
	For (x; 1; Size of array:C274(atCronWeekday))
		If (Num:C11(atCronWeekday{x})>=viWeekday)
			viNextWeekday:=Num:C11(atCronWeekday{x})
			x:=Size of array:C274(atCronWeekday)
		End if 
	End for 
End if 
//Alert("viNextWeekday ="+ String(viNextWeekday))

If (vtCronYear="*")
	viNextYear:=viYear
Else 
	viNextYear:=Num:C11(atCronYear{1})
	For (x; 1; Size of array:C274(atCronYear))
		If (Num:C11(atCronYear{x})>=viYear)
			viNextYear:=Num:C11(atCronYear{x})
			x:=Size of array:C274(atCronYear)
		End if 
	End for 
End if 
//Alert("viNextYear ="+ String(viNextYear))

vtmyDate:=""
vtmyTime:=""
vtDate:=String:C10(viNextMonth)+"/"+String:C10(viNextDay)+"/"+String:C10(viNextYear)
vtmyTime:=String:C10(viNextHour)+":"+String:C10(viNextMinute)
//vtmyTime:=atCronHour{1}+":"+atCronMinute{1}+":00"
vdDate:=Date:C102(vtDate)
vhmyTime:=Time:C179(vtmyTime)
[TallyMaster:60]realName3:18:=(String:C10(vdDate; 7)+" - "+String:C10(vhmyTime; 2))
//Alert([TallyMaster]RealName3)//Alert("Next Start Time "+(String(vdDate;7)+" - "+String(vhmyTime;2)))
vdt:=(vdDate-!1990-01-01!)*86400+vhmyTime  //Alert("DTNextStart "+String(vdt))
[TallyMaster:60]dtNextStart:10:=vdt
[TallyMaster:60]dateRevision:32:=vdDate

SAVE RECORD:C53([TallyMaster:60])
UNLOAD RECORD:C212([TallyMaster:60])
CLOSE WINDOW:C154
