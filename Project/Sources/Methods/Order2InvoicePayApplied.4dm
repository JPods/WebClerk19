//%attributes = {}
//Order2InvoicePayApplied
allowAlerts_boo:=False:C215
vbForceShip:=True:C214
TRACE:C157
C_LONGINT:C283($ordNum)
LOAD RECORD:C52([Order:3])
If (Not:C34(Locked:C147([Order:3])))
	$ordNum:=[Order:3]orderNum:2
	rptOrd2Inv
	QUERY:C277([Invoice:26]; [Invoice:26]orderNum:1=$ordNum)
	QUERY:C277([Payment:28]; [Payment:28]orderNum:2=$ordNum)
	vHere:=2
	//PayApplyIvc (True)
	
	//$recNum:=Record number([Payment])
	//GOTO RECORD([Payment];$recNum)
	PayApplyIvc(True:C214)
	//$doSearch:=True
	
	
	vbForceShip:=False:C215
End if 
