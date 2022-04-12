//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/14/12, 15:46:05
// ----------------------------------------------------
// Method: Comm_RateSet
// Description
// 
//
// Parameters
// ----------------------------------------------------


If (Size of array:C274(aMfgParts)=0)
	MfgItemRay
Else 
	If (aMfgParts{1}#("Com"+<>aMfg{<>aMfg}+"1"))
		MfgItemRay
	End if 
End if 
If (Size of array:C274(aMfgParts)>0)
	v4:=aMfgParts{1}
Else 
	v4:="Mfg Not Defined"
End if 
C_REAL:C285($commAble; $RepRate)
C_LONGINT:C283($w)
QUERY:C277([Item:4]; [Item:4]itemNum:1=v4)  //+"@")
Case of 
	: (Records in selection:C76([Item:4])>1)
		$commAble:=[Item:4]commissionA:29*0.01
	: (Records in selection:C76([Item:4])=1)
		$commAble:=[Item:4]commissionA:29*0.01
	Else 
		$commAble:=1
End case 
$w:=Find in array:C230(<>aCommNames; [Customer:2]repID:58)
If ($w>0)
	$RepRate:=Round:C94(<>aCommRates{$w}*$commAble*100; 4)
Else 
	$RepRate:=0
End if 
$w:=Find in array:C230(<>aCommNames; [Customer:2]salesNameID:59)
If ($w>0)
	vR2:=Round:C94(<>aCommRates{$w}*$commAble*100; 4)+$RepRate
Else 
	vR2:=$RepRate
End if 
If (vR2=0)
	vR4:=0
Else 
	vR4:=Round:C94($RepRate/vR2*100; 4)
End if 