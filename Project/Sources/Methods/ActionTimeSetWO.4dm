//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/28/20, 22:55:42
// ----------------------------------------------------
// Method: ActionTimeSetWO
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TIME:C306($1; $vTime)
$vTime:=$1
C_DATE:C307($vDate)
$k:=Size of array:C274(aWoStepLns)
C_LONGINT:C283($i; $k)
If ($k>0)
	For ($i; 1; $k)
		READ WRITE:C146([WorkOrder:66])
		GOTO RECORD:C242([WorkOrder:66]; aWoRecNum{aWoStepLns{$i}})
		$vDate:=[WorkOrder:66]actionDate:105
		[WorkOrder:66]actionTime:111:=$vTime
		[WorkOrder:66]dtAction:5:=DateTime_Enter([WorkOrder:66]actionDate:105; [WorkOrder:66]actionTime:111)
		SAVE RECORD:C53([WorkOrder:66])
		aWoTimeNd{aWoStepLns{$i}}:=vtWoPlan*1
	End for 
	//  --  CHOPPED  AL_UpdateArrays(eCntWos; -2)
	// -- AL_SetSelect(eCntWos; aWoStepLns)
	viALVert:=aWoStepLns{1}
	// -- AL_SetScroll(eCntWos; viALVert; viALHorz)
End if 