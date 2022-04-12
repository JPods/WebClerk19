//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $2)  // out in;$cntFiles;$3;$typeThis)
If (($2>0) & ($2<Get last table number:C254))
	$ptFile:=Table:C252($2)
	If ($1=1)
		//send out of data base
		vi2:=Records in selection:C76($ptFile->)
		vi1:=0
		SET CHANNEL:C77(10; Table name:C256($2)+"-EI")
		For (vi1; 1; vi2)
			SEND RECORD:C78($ptFile->)
			NEXT RECORD:C51($ptFile->)
		End for 
		SET CHANNEL:C77(11)
	Else 
		//load into data file
		SET CHANNEL:C77(10; Table name:C256($2)+"-EI")
		RECEIVE RECORD:C79($ptFile->)
		While (OK=1)
			SAVE RECORD:C53($ptFile->)
			RECEIVE RECORD:C79($ptFile->)
		End while 
		SET CHANNEL:C77(11)
	End if 
Else 
	ALERT:C41("File does not exist")
End if 
//EI_SendRecvRecs(1;1)
//C_POINTER($4)
//C_POINTER($ptFile;$ptField)
//C_BOOLEAN($doSearch)
//If ((Count parameters>2)&(Count parameters=4))
//$doSearch:=True
//$typeThis:=Type(Field($2;$3))
//Case of 
//: ($typeThis=0)|$typeThis=2))
//$ptField:=$4
//: ($typeThis=1)|$typeThis=8)|$typeThis=9))
//$ptField:=Num($4)
//: $typeThis=4)
//$ptField:=Date($4)
//: $typeThis=11)
//$ptField:=Time($4)
//End case 
//End if 
QUERY:C277([QQQTaxJurisdiction:14]; [QQQTaxJurisdiction:14]TaxJurisdiction:1=[Order:3]taxJuris:43)
vText7:=[QQQTaxJurisdiction:14]TaxPayGLAcct:4
UNLOAD RECORD:C212([QQQTaxJurisdiction:14])