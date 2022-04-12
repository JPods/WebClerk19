//%attributes = {"publishedWeb":true}
If (False:C215)
	//Date: 03/20/02
	//Who: Dan Bentson, Arkware
	//Description: added check for blank zip
	
	//Date: 03/20/02
	//Who: Peter Fleming, Arkware
	//Description: New zipcode lookup method
	VERSION_960
End if 

C_POINTER:C301($1; $2; $3; $City; $State)
C_TEXT:C284($ZipCode)
C_BOOLEAN:C305($4; $showDialog)
C_LONGINT:C283($i; $PreferredCity)
$ZipCode:=Substring:C12($1->; 1; 5)
$City:=$2
$State:=$3
$showDialog:=False:C215
//TRACE
If (allowAlerts_boo)
	$showDialog:=$4
End if 
If ($zipCode#"")
	
	ALL RECORDS:C47([ZipCode:96])
	If (Records in selection:C76([ZipCode:96])>0)  //Do only if zipcode records have been imported 
		
		QUERY:C277([ZipCode:96]; [ZipCode:96]zipCode:1=$ZipCode)
		If (Records in selection:C76([ZipCode:96])>0)
			
			If (Records in selection:C76([ZipCode:96])=1)
				$City->:=CapFirst([ZipCode:96]cityName:2)
				$State->:=[ZipCode:96]stateAbbr:4
			Else 
				ORDER BY:C49([ZipCode:96]cityName:2)
				SELECTION TO ARRAY:C260([ZipCode:96]zipCode:1; aZipCode; [ZipCode:96]cityName:2; aZipCity; [ZipCode:96]stateAbbr:4; aZipState; [ZipCode:96]preferredCityName:3; aZipPrefCity)
				If ($showDialog)
					Open window:C153(129; 162; 525; 400; 4; "Cities for Zip Code "+$ZipCode)
					DIALOG:C40([Control:1]; "diaZipcode_Choice")
					If (myOK=1)
						$City->:=CapFirst(aZipCity{aZipCity})
						$State->:=aZipState{aZipCity}
					End if 
				Else 
					
					$PreferredCity:=0
					For ($i; 1; Size of array:C274(aZipCity))
						If (aZipCity{$i}=aZipPrefCity{$i})
							$PreferredCity:=$i
						End if 
					End for 
					If ($PreferredCity>0)
						$City->:=CapFirst(aZipCity{$PreferredCity})
						$State->:=aZipState{$PreferredCity}
					End if 
				End if 
				
			End if 
			
		Else 
			If ($showDialog)
				If (<>vAlertNoCity)
					ALERT:C41("No Zip Code record found for "+$ZipCode+".")
				End if 
			End if 
		End if 
	End if 
End if 