//%attributes = {}

// Modified by: Bill James (2021-12-05T06:00:00Z)
// Method: SplashNew
// Description 
// Parameters
// ----------------------------------------------------

If (Not:C34(Application type:C494=4D Server:K5:6))  //  
	C_OBJECT:C1216($obWindows)
	If (Count parameters:C259=0)
		
		$obWindows:=WindowCountToShow
		var $int : Integer
		$int:=New process:C317("SplashNew"; 0; "Sales"; $obWindows)
	Else 
		$obWindows:=$1
		$form_t:="Splash"
		$win_l:=Open form window:C675($form_t; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)
		DIALOG:C40($form_t)
	End if 
End if 