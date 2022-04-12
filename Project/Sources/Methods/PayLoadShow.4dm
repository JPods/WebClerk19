//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1)

OBJECT SET FORMAT:C236(aPayShow; "###,##0.00")
ARRAY REAL:C219(aPayShow; 0)
ARRAY REAL:C219($aPayOrig; 0)
If ($1>0)
	SELECTION TO ARRAY:C260([Payment:28]amountAvailable:19; aPayShow; [Payment:28]amount:1; $aPayOrig)
End if 
aPayShow:=Num:C11(Size of array:C274(aPayShow)>0)
C_LONGINT:C283($i; $k)
$k:=Size of array:C274($aPayOrig)
C_REAL:C285($collected)
If (Record number:C243([Order:3])>-1)
	For ($i; 1; $k)
		$collected:=$collected+$aPayOrig{$i}
	End for 
	[Order:3]balanceDueEstimated:107:=[Order:3]total:27-$collected
End if 

