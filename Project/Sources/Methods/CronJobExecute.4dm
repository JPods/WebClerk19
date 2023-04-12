//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/08/12, 19:17:59
// ----------------------------------------------------
// Method: CronJobExecute
// Description
// 
//
// Parameters
// ----------------------------------------------------


//Script:   CronJob Execute 20110920
//Author:   James W. Medlen
//Comment:  Run Scheduled scripts 
//Created:  09/01/11
//Modified: 09/23/11
//Notes:    * matches all values, if either day or weekday match the expression matches TRUE
//Notes:matches - for a range / for an interval and L for last day of the month
//Notes:match # and L for Weekday, Third Friday, Last Friday of the month,...
//Notes:Weekdays are Unix Cron format 0-6 Sunday-Saturday 7 = Sunday

C_TEXT:C284(vtMinute; vtHour; vtDay; vtMonth; vtWeekday,vtYear)
C_TEXT:C284(vtCronMinute; vtCronHour; vtCronDay; vtCronMonth; vtCronWeekday,vtCronYear)
C_LONGINT:C283(viMinute; viHour; viDay; viMonth; viWeekday; viYear; viIndex,viEnd; viInterval)
C_LONGINT:C283($0)
C_TEXT:C284($packedVariables)

$0:=0

vtMinute:=""
vtHour:=""
vtDayOfMonth:=""
vtMonth:=""
vtDayOfWeek:=""
vtYear:=""
vtCronMinute:=""
vtCronHour:=""
vtCronDay:=""
vtCronMonth:=""
vtCronWeekday:=""
vtCronYear:=""
vTab:=Char:C90(9)

ARRAY TEXT:C222(atDayOfWeek; 7)
atDayOfWeek{0}:="Sunday"
atDayOfWeek{1}:="Monday"
atDayOfWeek{2}:="Tuesday"
atDayOfWeek{3}:="Wednesday"
atDayOfWeek{4}:="Thursday"
atDayOfWeek{5}:="Friday"
atDayOfWeek{6}:="Saturday"
atDayOfWeek{7}:="Sunday"

viMinute:=((Current time:C178\60)%60)
viHour:=(Current time:C178\3600)
viDay:=(Day of:C23(Current date:C33))
viMonth:=(Month of:C24(Current date:C33))
viWeekday:=(Day number:C114(Current date:C33)-1)  //Unix Cron weekdays (0-6) Sunday-Saturday (7 also = Sunday), 4D (1-7) Sunday-Saturday
viYear:=Year of:C25(Current date:C33)

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
//Alert(vText1)

//vText:="*"+vTab+"*"+vTab+"*"+vTab+"*"+vTab+"*"
//vText:="*"+vTab+"*"+vTab+"1"+vTab+"9"+vTab+"*"
//vText:=Request("Enter Cron Date Time * * * * *")


vtCronMinute:=""
vtCronHour:=""
vtCronDay:=""
vtCronMonth:=""
vtCronWeekday:=""
vtCronYear:=""

//ItemNum is 35 Character Alpha
vText:=[CronJob:82]cronString:28
//Alert(vText)

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
				
			: (viPointer=5)  //Unix Cron weekdays (0-6) Sunday-Saturday (7 also = Sunday), 4D (1-7) Sunday-Saturday
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
		ALERT:C41("atCronDay{vi1} = "+atCronDay{vi1}+" vtLastDay = "+vtLastDay)
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
C_DATE:C307(EOM; FOM)
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
		NumDays:=EOM-FOM  //Number of days in the month
		NumDays:=NumDays+1
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
C_DATE:C307(EOM; FOM)
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
		NumDays:=EOM-FOM  //Number of days in the month
		NumDays:=NumDays+1
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


vText1:=""
vText1:=vText1+"Cron Minute "+vtCronMinute+"\r"
vText1:=vText1+"Cron Hour "+vtCronHour+"\r"
vText1:=vText1+"Cron Day "+vtCronDay+"\r"
vText1:=vText1+"Cron Month "+vtCronMonth+"\r"
vText1:=vText1+"Cron Weekday "+vtCronWeekday+"\r"
vText1:=vText1+"Cron Year "+vtCronYear+"\r"
//Alert(vText1)


//==== Test Date Time ====

If ((Find in array:C230(atCronMinute; vtMinute)>0) | (vtCronMinute="*"))
	If ((Find in array:C230(atCronHour; vtHour)>0) | (vtCronHour="*"))
		If ((Find in array:C230(atCronDay; vtDay)>0) | (vtCronDay="*") | (Find in array:C230(atCronWeekday; vtWeekday)>0))
			If ((Find in array:C230(atCronMonth; vtMonth)>0) | (vtCronMonth="*"))
				If ((Find in array:C230(atCronWeekday; vtWeekday)>0) | (vtCronWeekday="*") | (Find in array:C230(atCronDay; vtDay)>0))
					If ((Find in array:C230(atCronYear; vtYear)>0) | (vtCronYear="*"))
						//Alert("Cron time matches current time")
						//$childProcess:=New process("ExecuteTextInNewProcess";<>tcPrsMemory;String(Count user processes)+"-"+[CronJob]EventName;[CronJob]Script;[CronJob]ScriptAfter;$packedvariables)  //;$1)
						// ### jwm ### 20161207_0947 removed process count from name
						//$childProcess:=New process("ExecuteTextInNewProcess";<>tcPrsMemory;[CronJob]EventName;[CronJob]Script;[CronJob]ScriptAfter;$packedvariables)  //;$1)
						C_TEXT:C284($myMessage)
						$myMessage:="CronJob: "+[CronJob:82]eventName:15+": "+[CronJob:82]machineName:22+": "+[CronJob:82]nameID:10+": "+String:C10(Current time:C178)+": "+String:C10(Current date:C33)
						If (<>VIDEBUGMODE>=2)
							ConsoleLog($myMessage)
						End if 
						// Alert($myMessage)
						//New process ( method ; stack {; name {; param {; param2 ; ... ; paramN}}}{; *} ) -> Function result
						// ### jwm ### 20161208_1702 ProcessTableQuery Parameters: $1 ProcessID, $2 Script, $3 WindowTitle $4 Table Number $5 displayTrue
						
						$childProcess:=New process:C317("ProcessTableQuery"; <>tcPrsMemory; [CronJob:82]eventName:15; Current process:C322; [CronJob:82]script:11; [CronJob:82]eventName:15; [CronJob:82]tableNum:33; [CronJob:82]displayRecords:17; [CronJob:82]multipleThread:16)
						
						$0:=1
					Else 
						//Alert("years do not match")
					End if 
				Else 
					//Alert("weekdays do not match")
				End if 
			Else 
				//Alert("months do not match")
			End if 
		Else 
			//Alert("days do not match")
		End if 
	Else 
		//Alert("hours do not match")
	End if 
Else 
	//Alert("minutes do not match")
End if 

