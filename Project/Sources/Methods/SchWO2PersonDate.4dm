//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 05/26/06, 09:13:38
// ----------------------------------------------------
// Method: SchWO2PersonDate
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1)
C_LONGINT:C283($2; $3; $4)
C_DATE:C307($5)
C_TIME:C306($6)
C_REAL:C285($7)
$theError:=0
If ($1="name ID@")
	$theError:=1
End if 
If ($2<0)  //(Record number([WOTemplate])//schWOTypeNum<2)
	$theError:=$theError+1
End if 
If ($3<0)  //(Record number([Customer])<0)
	$theError:=$theError+1
End if 
If (($4<1) & ($4>5))  //Column
	$theError:=$theError+1
End if 
If ($5=!00-00-00!)  //Date
	$theError:=$theError+1
End if 
If ($6=?00:00:00?)  //Time
	$theError:=$theError+1
End if 
If (Count parameters:C259>6)
	$theDuration:=$7
Else 
	If (currentDuration>0)
		$theDuration:=currentDuration
	Else 
		$theDuration:=2
	End if 
End if 
$cntRec:=Size of array:C274(aItemLines)
If ($cntRec<1)
	$theError:=$theError+1
End if 
If ($theError>0)
	ALERT:C41("Existing Customer, WorkOrder, Items and Employee required: "+String:C10($theError))
Else 
	CONFIRM:C162("Post New Order/WorkOrder for selected customer?")
	If (OK=1)
		$booPass:=allowAlerts_boo
		allowAlerts_boo:=False:C215
		CREATE RECORD:C68([Order:3])
		myCycle:=3
		NxPvOrders
		If (<>aMfg>1)
			[Order:3]mfrID:52:=<>aMfg{<>aMfg}
		End if 
		allowAlerts_boo:=$booPass
		//
		For ($incRec; 1; $cntRec)
			GOTO RECORD:C242([Item:4]; aLsSrRec{aItemLines{$incRec}})
			If (Records in selection:C76([Item:4])=1)
				pPartNum:=[Item:4]itemNum:1
				pDescript:=[Item:4]description:7
				pUnitCost:=[Item:4]costAverage:13
			End if 
			OrdLnAdd((Size of array:C274(aoLineAction)+1); 1; True:C214)
		End for 
		//
		//QUERY([WOTemplate];[WOTemplate]TypeWO=<>aWoTypes{schWOTypeNum})
		CREATE RECORD:C68([WorkOrder:66])
		[WorkOrder:66]idNum:29:=CounterNew(->[WorkOrder:66])
		WO_FillArrays(-8)
		TaskIDAssign(->[Order:3]idNumTask:85)
		[WorkOrder:66]idNumTask:22:=[Order:3]idNumTask:85
		[WorkOrder:66]activity:7:=<>aWoTypes{schWOTypeNum}
		[WorkOrder:66]actionBy:8:=$1
		[WorkOrder:66]durationPlanned:10:=$theDuration
		[WorkOrder:66]dtAction:5:=DateTime_DTTo($5; $6)
		SAVE RECORD:C53([WorkOrder:66])
		booAccept:=True:C214
		vMod:=True:C214
		acceptOrders
		Sched_Reset($4)
	End if 
End if 