If (False:C215)
	//Date: 02/27/02
	//Who: Bill James, JIT
	//Description:
	
	//Date: 04/17/02
	//Who: Janani, Arkware
	//Description: Modified so that the update button will update the vDate8 field to 
	VERSION_960
End if 

//[Item]DTItemDate:=DateTime_Enter (Current date;Current time)
//jDateTimeRecov ([Item]DTItemDate;->vDate1;->vTime1)
//[Item]obSync:=DateTime_Enter(Current date; Current time)
//vDate8:=jDateTimeRDate([Item]obSync)