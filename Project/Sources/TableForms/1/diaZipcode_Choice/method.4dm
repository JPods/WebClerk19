If (False:C215)
	//Date: 03/20/02
	//Who: Peter Fleming, Arkware
	//Description: Form method
	VERSION_960
End if 

Case of 
	: (Before:C29)
		C_LONGINT:C283(eZipChoice)
		C_LONGINT:C283($i; $PreferredCity)
		
		Zip_DefineAL(eZipChoice)
		
		$PreferredCity:=0
		For ($i; 1; Size of array:C274(aZipCity))
			If (aZipCity{$i}=aZipPrefCity{$i})
				$PreferredCity:=$i
				aZipCity:=$i
			End if 
		End for 
		If ($PreferredCity>0)
			// -- AL_SetLine(eZipChoice; $PreferredCity)
			// -- AL_SetRowStyle(eZipChoice; $PreferredCity; 1; "")
		End if 
		
	: (Outside call:C328)
		Prs_OutsideCall
	Else 
		
End case 