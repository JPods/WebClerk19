//%attributes = {}
If (False:C215)
	Version_0602
	TM_FillSchSetArray
End if 
C_LONGINT:C283($1; $k)

$k:=Records in selection:C76([WorkOrder:66])
WO_FillArrays($k)
REDUCE SELECTION:C351([WorkOrder:66]; 0)
//
WO_FillArrays(-7)  //sort the array
ARRAY LONGINT:C221(aWoStepLns; $k)
For ($i; 1; $k)
	aWoStepLns{$i}:=$i
End for 



Case of 
	: ($1=1)  //b21
		Tm_Wo2Time(->aTimeSlotBeg1; ->aTimeSlotEnd1; ->aTimeSlotType1; ->aTimeSlotWhat1; ->aTimeSlotAction1; ->aTimeSlotWORec1; eTimeList1; ->vText1; vDate1)
	: ($1=2)  //b22
		Tm_Wo2Time(->aTimeSlotBeg2; ->aTimeSlotEnd2; ->aTimeSlotType2; ->aTimeSlotWhat2; ->aTimeSlotAction2; ->aTimeSlotWORec2; eTimeList2; ->vText2; vDate2)
	: ($1=3)  //b23
		Tm_Wo2Time(->aTimeSlotBeg3; ->aTimeSlotEnd3; ->aTimeSlotType3; ->aTimeSlotWhat3; ->aTimeSlotAction3; ->aTimeSlotWORec3; eTimeList3; ->vText3; vDate3)
	: ($1=4)  //b24
		Tm_Wo2Time(->aTimeSlotBeg4; ->aTimeSlotEnd4; ->aTimeSlotType4; ->aTimeSlotWhat4; ->aTimeSlotAction4; ->aTimeSlotWORec4; eTimeList4; ->vText4; vDate4)
	: ($1=5)  //b25
		Tm_Wo2Time(->aTimeSlotBeg5; ->aTimeSlotEnd5; ->aTimeSlotType5; ->aTimeSlotWhat5; ->aTimeSlotAction5; ->aTimeSlotWORec5; eTimeList5; ->vText5; vDate5)
End case 
//