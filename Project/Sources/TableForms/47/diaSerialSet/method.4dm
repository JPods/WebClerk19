Case of 
	: (Before:C29)
		vi1:=1
		vi2:=0
		viRecordsInSelection:=0
		vsnSrNum:=""
		If (myOK=15)
			OBJECT SET ENTERABLE:C238(vSnItmAlpha; True:C214)
			OBJECT SET ENABLED:C1123(b2; False:C215)
		End if 
		C_LONGINT:C283($error; $w)
		SR_ALDefine(eListSrNums)
	: (Outside call:C328)
		Prs_OutsideCall
	Else 
		If (Size of array:C274(aSrRecSel)>0)
			OBJECT SET ENABLED:C1123(bAcceptB; True:C214)
		Else 
			OBJECT SET ENABLED:C1123(bAcceptB; False:C215)
		End if 
End case 