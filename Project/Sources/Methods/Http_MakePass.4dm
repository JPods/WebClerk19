//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: Http_MakePass
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_LONGINT:C283($i; $k; $theDT)
C_BOOLEAN:C305($goDo)
C_TEXT:C284($userName; $passWord)

$goDo:=True:C214
$doLength:=0
If (Count parameters:C259=1)
	$doThis:=$1
Else 
	$doThis:=True:C214
End if 
If ($doThis)
	ALERT:C41("Select for Customers")
	Srch_FullDia(->[Customer:2])
	$goDo:=(myOK=1)
	ALERT:C41("Select Leads")
	Srch_FullDia(->[zzzLead:48])
End if 
$doThis:=True:C214
If ($goDo)
	$k:=Records in selection:C76([Customer:2])
	If ($k=1)
		OK:=1
		$doThis:=False:C215
	Else 
		CONFIRM:C162("Create Remote Users and Passwords for "+String:C10($k)+" Customer records.")
	End if 
	If (OK=1)
		If (($doThis) & (allowAlerts_boo))
			$doLength:=Num:C11(Request:C163("Create random password with length of:"; "6"))
		End if 
		If (OK=1)
			$theDT:=DateTime_Enter
			If ($doThis)
				//ThermoInitExit (("Making Passwords:  "+Table name(->[Customer]));$k;True)
				$viProgressID:=Progress New
				
			End if 
			FIRST RECORD:C50([Customer:2])
			For ($i; 1; $k)
				If ($doThis)
					//Thermo_Update ($i)
					ProgressUpdate($viProgressID; $i; $k; "Making Passwords: "+Table name:C256(->[Customer:2]))
				End if 
				
				RemoteUser_Create((->[Customer:2]); [Customer:2]customerID:1; [Customer:2]zip:8; 1)
				
			End for 
			If ($doThis)
				//Thermo_Close 
				Progress QUIT($viProgressID)
			End if 
		End if 
		//
	End if 
	If (myOK=1)
		myOK:=0
		$k:=Records in selection:C76([zzzLead:48])
		If ($k=1)
			$doThis:=False:C215
		Else 
			CONFIRM:C162("Create Remote Users and Passwords for "+String:C10($k)+" Leads records.")
		End if 
		If (OK=1)
			$theDT:=DateTime_Enter
			If ($doThis)
				//ThermoInitExit (("Making Passwords:  "+Table name(->[Lead]));$k;True)
				$viProgressID:=Progress New
				
			End if 
			FIRST RECORD:C50([zzzLead:48])
			For ($i; 1; $k)
				If ($doThis)
					//Thermo_Update ($i)
					ProgressUpdate($viProgressID; $i; $k; "Making Passwords:  "+Table name:C256(->[zzzLead:48]))
				End if 
				
				RemoteUser_Create((->[zzzLead:48]); String:C10([zzzLead:48]idNum:32); [zzzLead:48]zip:10; 1)
				
				
			End for 
			If ($doThis)
				//Thermo_Close 
				Progress QUIT($viProgressID)
			End if 
		End if 
	End if 
	//
End if 
