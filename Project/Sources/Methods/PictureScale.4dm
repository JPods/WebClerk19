//%attributes = {"publishedWeb":true}
C_REAL:C285($scale)
C_POINTER:C301($1)
Case of 
	: (<>aScale=Size of array:C274(<>aScale))
		$scale:=Num:C11(Request:C163("Enter the desired scale."; "1"))
		If ($scale>0)
			$1->:=$1->*$scale
		Else 
			jAlertMessage(10013)
		End if 
	: (<>aScale>1)
		$1->:=$1->*Num:C11(<>aScale{<>aScale})
End case 
<>aScale:=1