//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/16/12, 18:21:44
// ----------------------------------------------------
// Method: WCErrorPageReturn
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (Not:C34(allowAlerts_boo))
	If (Size of array:C274(aParameterName)>0)
		C_LONGINT:C283($foundPage; $foundError)
		$foundPage:=Find in array:C230(aParameterName; "jitPageOne")
		If ($foundPage>0)
			$foundError:=Find in array:C230(aParameterName; "jitPageError")
			If ($foundError>0)
				aParameterValue{$foundPage}:=aParameterValue{$foundError}
			End if 
		End if 
		$foundPage:=Find in array:C230(aParameterName; "jitPageReturn")
		If ($foundPage>0)
			$foundError:=Find in array:C230(aParameterName; "jitPageError")
			If ($foundError>0)
				aParameterValue{$foundPage}:=aParameterValue{$foundError}
			End if 
		End if 
	End if 
End if 
