//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/08/10, 14:28:10
// ----------------------------------------------------
// Method: TallyEndOfYr
// Description
// 
//
// Parameters
// ----------------------------------------------------

var $entDefault : Object
$entDefault:=ds:C1482.Default.query("primeDefault = 1").first()
$doChange:=UserInPassWordGroup("OnlyTally")
If (Not:C34($doChange))
	ALERT:C41("Access Denied")
	CANCEL:C270
Else 
	If (($entDefault.endOfYearDay<1) | ($entDefault.endOfYearDay>31) | ($entDefault.endofYearMon<1) | ($entDefault.endofYearMon>12))
		ALERT:C41("Cancel This,"+"\r"+"GoTo File menu >> Show Defaults"+"\r"+"Set End of Year")
	Else 
		$endOfYearMon:=$entDefault.endofYearMon
		$endOfYearDay:=$entDefault.endOfYearDay
		$yearOfEnd:=Year of:C25(Current date:C33)
		$yearMax:=$yearOfEnd+2
		$monOfCurrent:=Month of:C24(Current date:C33)
		//If ($monOfCurrent<3)
		//$yearOfEnd:=$yearOfEnd-1
		//End if 
		$yearOfEnd:=Num:C11(Request:C163("Tally Year ending in "; String:C10($yearOfEnd)))
		If ((OK=1) & ($yearOfEnd>2000) & ($yearOfEnd<$yearMax))
			$cyEnd:=Date_CvrtYyMmDd(Substring:C12(String:C10($yearOfEnd); 3; 2)+String:C10($endOfYearMon; "00")+String:C10($endOfYearDay; "00"))
			$cyBegin:=Date_CvrtYyMmDd(Substring:C12(String:C10(Year of:C25($cyEnd)-1); 3; 2)+String:C10($endOfYearMon; "00")+String:C10($endOfYearDay; "00"))+1
			CONFIRM:C162("Process End Of Year "+String:C10($cyBegin; 1)+" thru "+String:C10($cyEnd; 1))
			If (OK=1)
				READ ONLY:C145([Invoice:26])
				ALL RECORDS:C47([Customer:2])
				$k:=Records in selection:C76([Customer:2])
				
				C_DATE:C307($lyBegin; $lyEnd; $cyBegin; $cyEnd)
				//test the user privelege        
				//ThermoInitExit ("Processing EOY Customers";$k;True)
				$viProgressID:=Progress New
				
				$doItems:=True:C214
				$myOK:=1
				For ($i; 1; $k)
					//Thermo_Update ($i)
					ProgressUpdate($viProgressID; $i; $k; "Processing EOY Customers")
					
					If (<>ThermoAbort)
						$i:=$k
					End if 
					QUERY:C277([Invoice:26]; [Invoice:26]customerID:3=[Customer:2]customerID:1; *)
					QUERY:C277([Invoice:26];  & <>ptInvoiceDateFld->>=$cyBegin; *)
					QUERY:C277([Invoice:26];  & <>ptInvoiceDateFld-><=$cyEnd)
					[Customer:2]salesLastYr:48:=Sum:C1([Invoice:26]amount:14)
					//
					QUERY:C277([Invoice:26]; [Invoice:26]customerID:3=[Customer:2]customerID:1; *)
					QUERY:C277([Invoice:26];  & <>ptInvoiceDateFld->>$cyEnd)
					[Customer:2]salesYTD:47:=Sum:C1([Invoice:26]amount:14)
					[Customer:2]costsYTD:75:=Sum:C1([Invoice:26]totalCost:37)
					//
					SAVE RECORD:C53([Customer:2])
					NEXT RECORD:C51([Customer:2])
				End for 
				//Thermo_Close 
				Progress QUIT($viProgressID)
				
				
				READ WRITE:C146([Invoice:26])
				C_LONGINT:C283($i; $k; $myOK)
			End if 
		End if 
	End if 
End if 

