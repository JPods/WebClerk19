//%attributes = {"publishedWeb":true}
C_TEXT:C284($1; $2)
$doAlert:=True:C214
If (Count parameters:C259>0)
	
	QUERY:C277([TallyMaster:60]; [TallyMaster:60]Purpose:3="SOAP@"; *)
	QUERY:C277([TallyMaster:60];  & [TallyMaster:60]Name:8=$1)
	If (Records in selection:C76([TallyMaster:60])=1)
		<>processAlt:=New process:C317("SoapProcess"; <>tcPrsMemory; "SoapProcess"; $1)
		$doAlert:=False:C215
	End if 
End if 
If ($doAlert)
	ALERT:C41("You must have a 'SOAP' compliant TallyMaster record.")
End if 