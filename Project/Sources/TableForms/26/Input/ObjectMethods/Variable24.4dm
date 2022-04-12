C_LONGINT:C283(bPayApply)
C_LONGINT:C283(bPayApply; $recNum)
C_BOOLEAN:C305($doBeep; $doSearch)
$doBeep:=False:C215
$doSearch:=False:C215
If (Locked:C147([Invoice:26]))
	ALERT:C41("Invoice is Locked.  You must have Read/Write privileges.")
Else 
	vMod:=calcInvoice(True:C214)
	acceptInvoice
	If (Size of array:C274(aPayShow)>0)
		If ((aPayShow>0) & (aPayShow<=(Size of array:C274(aPayShow))))
			If (aPayShow{aPayShow}=0)
				$doBeep:=True:C214
			Else 
				GOTO SELECTED RECORD:C245([Payment:28]; aPayShow)
				LOAD RECORD:C52([Payment:28])
				If (Locked:C147([Payment:28]))
					jAlertMessage(10004)
				Else 
					$recNum:=Record number:C243([Payment:28])
					GOTO RECORD:C242([Payment:28]; $recNum)
					PayApplyIvc(True:C214)
					$doSearch:=True:C214
				End if 
			End if 
			$doBeep:=True:C214
		End if 
	Else 
		$doSearch:=True:C214
		$doBeep:=True:C214
	End if 
	If ($doBeep)
		BEEP:C151
	End if 
	If ($doSearch)
		Pay_InvoiceSrch
		PayLoadShow(Records in selection:C76([Payment:28]))
	End if 
End if 
