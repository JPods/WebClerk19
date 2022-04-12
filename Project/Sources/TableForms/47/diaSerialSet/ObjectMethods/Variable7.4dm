OK:=1
C_LONGINT:C283($i; $k; $w)
C_BOOLEAN:C305($doSrInc)
If (vi1<2)
	$k:=1
	$doSrInc:=False:C215
Else 
	If (vi1>50)
		CONFIRM:C162("Do you truely wish to create "+String:C10(vi1)+" new Serial Numbers.")
	End if 
	$k:=vi1
	$doSrInc:=True:C214
End if 
If (OK=1)
	C_TEXT:C284($testNum)
	For ($i; 1; $k)
		If (vsnSrNum="tbd@")
			$w:=-1
			$testNum:=vsnSrNum
		Else 
			If ($doSrInc)
				$testNum:=vsnSrNum+String:C10(vi2+$i)
			Else 
				$testNum:=vsnSrNum
			End if 
			$w:=Find in array:C230(aSrNum; $testNum)
			If ($w=-1)
				QUERY:C277([ItemSerial:47]; [ItemSerial:47]itemNum:1=vsnItmAlpha; *)
				QUERY:C277([ItemSerial:47];  & [ItemSerial:47]serialNum:4=$testNum)
				If (Records in selection:C76([ItemSerial:47])=0)
					$w:=-1
				End if 
			End if 
		End if 
		If ($w=-1)
			$w:=Size of array:C274(aSrAvail)+1
			Srl_FillRay(-3; $w; 1)
			aSrAvail{$w}:=""
			aSrOnFP{$w}:=False:C215
			aSrNum{$w}:=$testNum
			aSrDateIn{$w}:=Current date:C33
			aSrExpire{$w}:=!00-00-00!
			aSrLife{$w}:=0
			aSrRecNum{$w}:=-3
			aSrSaleID{$w}:=0
			aSrPoID{$w}:=0
			aSrRecID{$w}:=0
		Else 
			jAlertMessage(12006)
		End if 
	End for 
	//  --  CHOPPED  AL_UpdateArrays(eListSrNums; -2)
End if 