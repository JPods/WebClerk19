//%attributes = {}
If (False:C215)
	Version_0508
	//PaymentFillVariables
End if 
C_LONGINT:C283($i; $k)
ARRAY REAL:C219($aPayAmount; 0)
ARRAY REAL:C219($aPayTendered; 0)
ARRAY REAL:C219($aPayChange; 0)
SELECTION TO ARRAY:C260([Payment:28]Amount:1; $aPayAmount; [Payment:28]Tendered:44; $aPayTendered; [Payment:28]Change:45; $aPayChange)
pPayAmount:=0
pPayTendered:=0
pPayChange:=0
$k:=Size of array:C274($aPayAmount)
For ($i; 1; $k)
	pPayAmount:=pPayAmount+$aPayAmount{$i}
	pPayTendered:=pPayTendered+$aPayTendered{$i}
	pPayChange:=pPayChange+$aPayChange{$i}
End for 
