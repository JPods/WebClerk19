//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/25/21, 23:08:03
// ----------------------------------------------------
// Method: WCapiTask_Gantt
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (voState=Null:C1517)
	voState:=New object:C1471
End if 
If (voState.request=Null:C1517)
	voState.request:=New object:C1471
End if 
If (voState.request.parameters=Null:C1517)
	voState.request.parameters:=New object:C1471
End if 

C_OBJECT:C1216($voSelGantt; $voRecGantt)
C_OBJECT:C1216($voChartToSend)
C_DATE:C307(vdDateBegin; vdDateEnd)

$voSelGantt:=ds:C1482.FC.query("purpose = Gantt")
If ($voSelGantt=Null:C1517)
	Response:="Error: No FC record exists for Gantt"
Else 
	$voRecGantt:=$voSelGantt.first()
	$voChartToSend:=$voRecGantt.obGeneral.gantt
	vdDateBegin:=Date:C102(WCapi_GetParameter("dateBegin"))
	vdDateEnd:=Date:C102(WCapi_GetParameter("dateEnd"))
	If (vdDateBegin=!00-00-00!)
		vdDateBegin:=Current date:C33
	End if 
	If (vdDateEnd=!00-00-00!)
		vdDateEnd:=Current date:C33
	End if 
	If (vdDateEnd<vdDateBegin)
		vdDateEnd:=vdDateBegin
	End if 
	voState.request.parameters.dateBegin:=vdDateBegin
	voState.request.parameters.dateEnd:=vdDateEnd
	
	// chartStart:"2020-03-02 00:00", 
	// chartEnd: "2020-03-04 00:00",
	$voChartToSend.chartStart:=Date_yyyy_mm_dd_hh_mm(vdDateBegin)
	$voChartToSend.chartEnd:=Date_yyyy_mm_dd_hh_mm(vdDateEnd+1)
	
	//$voChartToSend.rows:=Gantt_Rows(vdDateBegin; vdDateEnd)
	vResponse:=JSON Stringify:C1217($voChartToSend)
End if 

