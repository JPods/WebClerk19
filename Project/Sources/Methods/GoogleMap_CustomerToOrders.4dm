//%attributes = {}
#DECLARE($voOneLine : Object)->$result : Object
TRACE:C157
ARRAY TEXT:C222($atLine; 0)
C_TEXT:C284($tableName)
$result:=$voOneLine
C_OBJECT:C1216($veSelectionRelated; $veRecordRelated)
C_OBJECT:C1216($veSelectionCustomers; $veRecordCustomers)
$veSelectionCustomers:=ds:C1482.Customer.all()
For each ($veRecordCustomers; $veSelectionCustomers)
	For ($vi1; 1; 3)
		Case of 
			: ($vi1=1)
				$tableName:="Order"
			: ($vi1=2)
				$tableName:="Invoice"
			: ($vi1=3)
				$tableName:="Proposal"
		End case 
		$veSelectionRelated:=ds:C1482[$tableName].query("customerID = :1"; $veRecordCustomers.customerID)
		ConsoleMessage($tableName+": "+String:C10($veSelectionRelated.length)+": "+$veRecordCustomers.lat+": "+$veRecordCustomers.lng)
		For each ($veRecordRelated; $veSelectionRelated)
			$veRecordRelated.lat:=$veRecordCustomers.lat
			$veRecordRelated.lng:=$veRecordCustomers.lng
			$veRecordRelated.save()
		End for each 
	End for 
End for each 
If (allowAlerts_boo)
	ALERT:C41("Complete")
End if 