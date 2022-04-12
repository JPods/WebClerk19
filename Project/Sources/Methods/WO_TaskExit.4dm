//%attributes = {}
C_LONGINT:C283($col; $row)
//If (<>aNameID>1)
//  CHOPPED  AL_GetCurrCell(eWOTasks; $col; $row)
READ WRITE:C146([WorkOrderTask:67])
GOTO RECORD:C242([WorkOrderTask:67]; aWoTaskRecNum{$row})
//WO_FillArrays (-4;$row)
[WorkOrderTask:67]actionBy:7:=aWOTaskActionBy{$row}


SAVE RECORD:C53([WorkOrderTask:67])
UNLOAD RECORD:C212([WorkOrderTask:67])
//READ ONLY([WorkOrderTask])
//  --  CHOPPED  AL_UpdateArrays(eWOTasks; -2)
//End if 