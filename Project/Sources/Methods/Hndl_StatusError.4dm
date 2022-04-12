//%attributes = {}



// 4D_25Invoice - 2022-01-15
C_OBJECT:C1216($status)

$status:=$1

If ($status.success)
	$ok:=True:C214
Else 
	$ok:=False:C215
	If ($status.status=dk status serious error:K85:22)
		ALERT:C41(Util25_Get_LocalizedMessage("followingProblem"; $status.statusText))
	Else 
		ALERT:C41(Util25_Get_LocalizedMessage("RecordIs"; $status.statusText; $status.lockKindText))
	End if 
End if 

$0:=$ok

//dk status locked, dk status stamp has changed, dk status success, dk status wrong permission