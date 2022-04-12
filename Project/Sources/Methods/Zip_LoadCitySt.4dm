//%attributes = {"publishedWeb":true}
If (False:C215)
	//Date: 03/20/02
	//Who: Peter Fleming, Arkware
	//Description: Disabled old zip plugin, added new method Zip_LoadCitySt_New
	VERSION_960
End if 

C_POINTER:C301($1; $2; $3; $4; $cityPtr; $statePtr; $zipPtr; $countryPtr)
C_LONGINT:C283(kCase)

$cityPtr:=$1
$statePtr:=$2
$zipPtr:=$3
$countryPtr:=$4
If (False:C215)
	If (<>allowZip)
		kCase:=1  //1 Returns Mixed Case City & County Info, 0 Returns ALL CAPS
		C_TEXT:C284(zipCity; zipZip; zipCountry; zipState)
		zipCity:=""
		zipState:=""
		zipZip:=$3->
		zipCounty:=""
		//City;State;Zip;Country; kCase
		
		// ZipQuest(zipZip;zipState;zipCity;zipCounty;kCase)
		
		If (Length:C16(zipCity)>0)
			$1->:=zipCity
			$2->:=zipState
			//  $4:=zipCountry
		Else 
			BEEP:C151
		End if 
	End if 
End if 

Zip_LoadCitySt_New($zipPtr; $cityPtr; $statePtr; True:C214)