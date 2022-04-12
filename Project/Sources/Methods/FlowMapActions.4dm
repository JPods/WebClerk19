//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-23T00:00:00, 10:51:08
// ----------------------------------------------------
// Method: FlowMapActions
// Description
// Modified: 08/23/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (True:C214)
		// clip off a subsequent actions
		// keep to extract anything that might be needed.
	: (b1=1)
		jrptService  //show open service records
		
	: (b2=1)  //Add Show Lead
		Process_AddRecord("Lead")
		
	: (b3=1)  //Customers
		Process_AddRecord("Customer")
		
	: (b4=1)  //Add Proposal
		Process_AddRecord("Proposal")
		
	: (b5=1)  //Open Proposal
		QUERY:C277([Proposal:42]; [Proposal:42]complete:56=False:C215)
		DB_ShowCurrentSelection(->[Proposal:42]; ""; 1; "")
		
	: (b6=1)  //Add Order
		Process_AddRecord("Order")
		
	: (b7=1)  //Open Order
		<>ptCurTable:=ptCurTable
		<>prcControl:=1
		<>processAlt:=New process:C317("OrdProcessing"; <>tcPrsMemory; String:C10(Count user processes:C343)+"-Orders")
		
	: (b8=1)  //Ship Window
		ShipWindow
		
		
	: (b9=1)  //Open Invoice
		QUERY:C277([Invoice:26]; [Invoice:26]balanceDue:44#0)
		DB_ShowCurrentSelection(->[Invoice:26]; ""; 1; "")
		
	: (b10=1)  //Performance
		<>ptCurTable:=ptCurTable
		<>prcControl:=1
		<>processAlt:=New process:C317("Rpt_SalesCompar"; <>tcPrsMemory; String:C10(Count user processes:C343)+"-Evaluation")
		
	: (b11=1)  //Production -- BOM Forecasting
		FC_LaunchWin
		
		//<>processAlt:=New process("OrdProcessing";<>tcPrsMemory;String
		//(Count user processes)+"-"+Filename(<>ptCurFile))
		//  Dept_Production 
	: (b12=1)  //Payments
		<>ptCurTable:=ptCurTable
		<>prcControl:=1
		<>processAlt:=New process:C317("PayApply"; <>tcPrsMemory; String:C10(Count user processes:C343)+"-ApplyPay")
		
	: (b13=1)  //Customers Past Due
		<>ptCurTable:=ptCurTable
		<>prcControl:=1
		<>processAlt:=New process:C317("RptPastDue"; <>tcPrsMemory; String:C10(Count user processes:C343)+"-PastDue")
		
	: (b14=1)
		<>ptCurTable:=ptCurTable
		<>prcControl:=1
		<>processAlt:=New process:C317("showReports"; <>tcPrsMemory; String:C10(Count user processes:C343)+"-"+Table name:C256(<>ptCurTable))
		
	: (b15=1)  //Admin
		showAccts
		If (False:C215)
			<>ptCurTable:=ptCurTable
			<>prcControl:=1
			<>processAlt:=New process:C317("TallyEOM"; <>tcPrsMemory; String:C10(Count user processes:C343)+"-"+Table name:C256(<>ptCurTable))
		End if 
		//          Dept_Admin 
	: (b17=1)
		Prs_PrcssAdd
		
	: (b19=1)
		Process_Running
	: (False:C215)  //_b20=1)
		<>ptCurTable:=ptCurTable
		<>prcControl:=1
		<>processAlt:=New process:C317("jAbout"; <>tcPrsMemory; String:C10(Count user processes:C343)+"-"+Table name:C256(<>ptCurTable))
		
	: (b21=1)  //Scheduler
		Tm_SchdSetter
		
	: (b22=1)  //add po
		Process_AddRecord("PO")
		
	: (b23=1)  //Inship
		<>ptCurTable:=ptCurTable
		<>prcControl:=1
		<>processAlt:=New process:C317("Try_AddInShips"; <>tcPrsMemory; String:C10(Count user processes:C343)+"-Inship")
		
		
		
End case 