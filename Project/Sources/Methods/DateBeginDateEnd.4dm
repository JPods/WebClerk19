//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/23/20, 23:20:56
// ----------------------------------------------------
// Method: DateBeginDateEnd
// Description
// 
//
// Parameters

C_OBJECT:C1216($1; $voPayload)
C_DATE:C307(vdDateBegin; vdDateEnd)
If (OB Is defined:C1231($1))
	$voPayload:=$1
End if 
vdDateBegin:=Current date:C33
vdDateEnd:=Current date:C33
If ($voPayload#Null:C1517)
	If ($voPayload.dateBegin#Null:C1517)
		If (OB Get type:C1230($voPayload; "dateBegin")=Is date:K8:7)
			vdDateBegin:=$voPayload.dateBegin
		Else 
			vdDateBegin:=Date:C102($voPayload.dateBegin)
		End if 
	Else 
		If ($voPayload.beginDate#Null:C1517)
			If (OB Get type:C1230($voPayload; "beginDate")=Is date:K8:7)
				vdDateBegin:=$voPayload.beginDate
			Else 
				vdDateBegin:=Date:C102($voPayload.beginDate)
			End if 
		End if 
	End if 
	If ($voPayload.dateEnd#Null:C1517)
		If (OB Get type:C1230($voPayload; "dateEnd")=Is date:K8:7)
			vdDateEnd:=$voPayload.dateEnd
		Else 
			vdDateEnd:=Date:C102($voPayload.dateEnd)
		End if 
	Else 
		If ($voPayload.endDate#Null:C1517)
			If (OB Get type:C1230($voPayload; "endDate")=Is date:K8:7)
				vdDateBegin:=$voPayload.endDate
			Else 
				vdDateBegin:=Date:C102($voPayload.endDate)
			End if 
		End if 
	End if 
End if 
If (vdDateEnd<vdDateBegin)
	vdDateEnd:=vdDateBegin
End if 
