//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 06/19/19, 17:12:10
// ----------------------------------------------------
// Method: emailZeroBounce
// Description
// Use the ZeroBounce.com file xxxx_Final_all_results.csv
//
// Parameters
// ----------------------------------------------------

C_TIME:C306($vhDocRef)
C_TEXT:C284($1; $documentPath; $vtBatch; $recordMessage; $badEmailBase)
C_TEXT:C284($vtCSVTag)
C_LONGINT:C283($incRay; $cntRay)
C_LONGINT:C283($viStatusElement)
C_LONGINT:C283($vieMailElement)
C_BLOB:C604($vxBlob)


$badEmailBase:=Date_strYyyymmdd(Current date:C33)+": [["
$recordMessage:=""
C_LONGINT:C283($incRay; $cntRay; $incRec; $cntRec)

$vtBatch:=""
KeyModifierCurrent
If (OptKey=1)
	$vtBatch:=Get text from pasteboard:C524
Else 
	If (Count parameters:C259=0)
		$documentPath:=""
		$vhDocRef:=Open document:C264($documentPath; Read mode:K24:5)  // open document read only
		If (OK=1)
			$documentPath:=document
			CLOSE DOCUMENT:C267($vhDocRef)  // We don't need to keep it open
		End if 
	Else 
		$documentPath:=$1
		If (Test path name:C476($documentPath)#1)
			OK:=0
			ALERT:C41("Invalid Path: "+$documentPath)
			$documentPath:=""
		End if 
	End if 
	If (OK=1)
		DOCUMENT TO BLOB:C525($documentPath; $vxBlob)  // Load the document
		$vtBatch:=BLOB to text:C555($vxBlob; UTF8 text without length:K22:17)
	End if 
End if 

If ($vtBatch#"")
	ConsoleLog("ZeroBounce file size: "+String:C10(Length:C16($vtBatch)))
	$vtBatch:=Replace string:C233($vtBatch; Storage:C1525.char.crlf; "\r")
	$vtBatch:=Replace string:C233($vtBatch; "\n"; "\r")
	// convert to CSV to tabs
	$vtBatch:=Replace string:C233($vtBatch; "\""+","+"\""; "\t")
	$vtBatch:=Replace string:C233($vtBatch; "\""+"\t"+"\""; "\t")
	$vtBatch:=Replace string:C233($vtBatch; "\""; "")
	
	ARRAY TEXT:C222($aTextAddresses; 0)
	TextToArray($vtBatch; ->$aTextAddresses; "\r")
	
	C_LONGINT:C283($incEmail; $ctnEmail)
	$ctnEmail:=Size of array:C274($aTextAddresses)
	vi1:=0
	vi2:=Size of array:C274($aTextAddresses)
	C_LONGINT:C283(vi1; vi2)
	
	CREATE EMPTY SET:C140([Customer:2]; "valid")
	CREATE EMPTY SET:C140([Customer:2]; "unkown")
	CREATE EMPTY SET:C140([Customer:2]; "catch-all")
	CREATE EMPTY SET:C140([Customer:2]; "invalid")
	CREATE EMPTY SET:C140([Customer:2]; "abuse")
	For (vi1; 1; vi2)
		ARRAY TEXT:C222($aTOneAddress; 0)
		TextToArray($aTextAddresses{vi1}; ->$aTOneAddress; "\t"; True:C214)
		If (Size of array:C274($aTOneAddress)>1)
			
			QUERY:C277([Customer:2]; [Customer:2]email:81=$aTOneAddress{1})
			vi4:=Records in selection:C76([Customer:2])
			ConsoleLog($aTOneAddress{1}+" record count: "+String:C10(vi4))
			FIRST RECORD:C50([Customer:2])
			vi3:=0
			For (vi3; 1; vi4)
				[Customer:2]emailStatus:138:=$aTOneAddress{4}
				Case of 
					: ([Customer:2]emailStatus:138="valid")
						// zzzqqq jDateTimeStamp(->[Customer:2]comment:15; "Email tested: "+[Customer:2]emailStatus:138)
						ADD TO SET:C119([Customer:2]; "valid")
					: ([Customer:2]emailStatus:138="unknown")
						// zzzqqq jDateTimeStamp(->[Customer:2]comment:15; "Email tested: "+[Customer:2]emailStatus:138)
						ADD TO SET:C119([Customer:2]; "unkown")
					: ([Customer:2]emailStatus:138="catch-all")
						// zzzqqq jDateTimeStamp(->[Customer:2]comment:15; "Email tested: "+[Customer:2]emailStatus:138)
						ADD TO SET:C119([Customer:2]; "catch-all")
					: ([Customer:2]emailStatus:138="invalid")
						// zzzqqq jDateTimeStamp(->[Customer:2]comment:15; "Email failed: "+[Customer:2]emailStatus:138+": "+[Customer:2]email:81)
						[Customer:2]email:81:=""
						ADD TO SET:C119([Customer:2]; "invalid")
						
					: (([Customer:2]emailStatus:138="spamtrap") | ([Customer:2]emailStatus:138="abuse") | ([Customer:2]emailStatus:138="do_not_mail"))
						// zzzqqq jDateTimeStamp(->[Customer:2]comment:15; "Email failed: "+[Customer:2]emailStatus:138+": "+[Customer:2]email:81)
						[Customer:2]email:81:=""
						// look at creating a call report to contact the customer and update
						ADD TO SET:C119([Customer:2]; "abuse")
						
					Else 
						// zzzqqq jDateTimeStamp(->[Customer:2]comment:15; "Email not a known catagory: "+[Customer:2]emailStatus:138+": "+[Customer:2]email:81)
						[Customer:2]email:81:=""
						
				End case 
				
				SAVE RECORD:C53([Customer:2])
				NEXT RECORD:C51([Customer:2])
			End for 
		End if 
		
		
	End for 
	USE SET:C118("valid")
	ProcessTableOpen(Table:C252(->[Customer:2]); ""; "valid")
	USE SET:C118("unknown")
	ProcessTableOpen(Table:C252(->[Customer:2]); ""; "unknown")
	USE SET:C118("catch-all")
	ProcessTableOpen(Table:C252(->[Customer:2]); ""; "catch-all")
	USE SET:C118("invalid")
	ProcessTableOpen(Table:C252(->[Customer:2]); ""; "invalid")
	USE SET:C118("abuse")
	ProcessTableOpen(Table:C252(->[Customer:2]); ""; "abuse")
	REDUCE SELECTION:C351([Customer:2]; 0)
End if 
