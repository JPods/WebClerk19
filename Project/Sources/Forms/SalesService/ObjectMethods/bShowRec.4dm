If (Form:C1466.userRec_ob=Null:C1517)
	ALERT:C41("No record is selected")
Else 
	$tableName:=Form:C1466.userRec_ob.tableName
	$viRow:=$obEvent.row
	If (<>viDebugMode>410)
		ConsoleLog("In ListBox On Double Clicked")
		ConsoleLog("$obEvent.code: On Double Clicked, Form.userRec_ob: "+$tableName+", and id: "+Form:C1466.userRec_ob.id)
		ConsoleLog("Form.userRec_ob: "+$tableName+", and id: "+Form:C1466.userRec_ob.id)
	End if 
	
	Case of 
		: ($tableName="CallReport")
			$tableNum:=Table:C252(->[CallReport:34])
			$script:="Query([CallReport];[CallReport]id=\""+Form:C1466.userRec_ob.id+"\")"
			ProcessTableOpen($tableNum; $script; "CallReport: ")
			
		: ($tableName="Service")
			$tableNum:=Table:C252(->[Service:6])
			$script:="Query([Service];[Service]id=\""+Form:C1466.userRec_ob.id+"\")"
			ProcessTableOpen($tableNum; $script; "Service: ")
			
		: ($tableName="Customer")
			$tableNum:=Table:C252(->[Customer:2])
			$script:="Query([Customer];[Customer]id=\""+Form:C1466.userRec_ob.id+"\")"
			ProcessTableOpen($tableNum; $script; "Customer: ")
			
		: ($tableName="Contact")
			$tableNum:=Table:C252(->[Contact:13])
			$script:="Query([Contact];[Contact]id=\""+Form:C1466.userRec_ob.id+"\")"
			ProcessTableOpen($tableNum; $script; "Contact: ")
			
		: ($tableName="Order")
			$tableNum:=Table:C252(->[Order:3])
			$script:="Query([Order];[Order]id=\""+Form:C1466.userRec_ob.id+"\")"
			ProcessTableOpen($tableNum; $script; "Order: ")
			
		: ($tableName="Proposal")
			$tableNum:=Table:C252(->[Proposal:42])
			$script:="Query([Proposal];[Proposal]id=\""+Form:C1466.userRec_ob.id+"\")"
			ProcessTableOpen($tableNum; $script; "Proposal: ")
			
		: ($tableName="Invoice")
			$tableNum:=Table:C252(->[Invoice:26])
			$script:="Query([Invoice];[Invoice]id=\""+Form:C1466.userRec_ob.id+"\")"
			ProcessTableOpen($tableNum; $script; "Invoice: ")
			
		: ($tableName="Project")
			$tableNum:=Table:C252(->[Project:24])
			$script:="Query([Project];[Project]id=\""+Form:C1466.userRec_ob.id+"\")"
			ProcessTableOpen($tableNum; $script; "Project: ")
			
		: ($tableName="Workorder")
			$tableNum:=Table:C252(->[WorkOrder:66])
			$script:="Query([WorkOrder];[WorkOrder]id=\""+Form:C1466.userRec_ob.id+"\")"
			ProcessTableOpen($tableNum; $script; "Workorder: ")
			
	End case 
End if 