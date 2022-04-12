//%attributes = {"publishedWeb":true}
C_TEXT:C284(vComName)
C_LONGINT:C283(<>tcSaleMar)
C_BOOLEAN:C305($1)
MESSAGES OFF:C175
vi1:=0  //Commissions for External Reps
vdDateBeg:=Current date:C33
vdDateEnd:=Current date:C33

vComName:=""
vDiaCom:="The report will be prepared for All Reps unless you select one Rep below:"
If (<>tcSaleMar=1)
	v1:="Based on Sales"
Else 
	v1:="Based on Margin"
End if 
SELECTION TO ARRAY:C260([Rep:8]RepID:1; aComNames)
jCenterWindow(218; 264; 1)
DIALOG:C40([Rep:8]; "DiaRptRepCom")
CLOSE WINDOW:C154
vDiaCom:=""
If (OK=1)
	QUERY:C277([Invoice:26]; [Invoice:26]datePaid:26>=vdDateBeg; *)
	QUERY:C277([Invoice:26];  & [Invoice:26]datePaid:26<=vdDateEnd; *)
	If (Length:C16(vComName)#0)
		QUERY:C277([Invoice:26];  & [Invoice:26]repID:22=vComName; *)
	End if 
	QUERY:C277([Invoice:26])
	If (Records in selection:C76([Invoice:26])>0)  //check to see if there are no events          
		If ($1)  //std commissions
			ORDER BY:C49([Invoice:26]; [Invoice:26]repID:22; [Invoice:26]company:7)
			FIRST RECORD:C50([Invoice:26])
			BREAK LEVEL:C302(1; 1)
			ACCUMULATE:C303(vShipAmt; vComAmount)  //;[Invoice]SalesName)          
			FORM SET OUTPUT:C54([Invoice:26]; "RptRepComm")
		Else   //bulk  commissions
			setChMfgs  //###wdj### why is this here?
			ORDER BY:C49([Invoice:26]; [Invoice:26]repID:22; [Invoice:26]customerID:3; [Invoice:26]profile1:53)
			FIRST RECORD:C50([Invoice:26])
			BREAK LEVEL:C302(2; 1)
			ACCUMULATE:C303(vShipAmt; vComAmount; vSaleByMfg)  //;[Invoice]SalesName)    
			FORM SET OUTPUT:C54([Invoice:26]; "RptBulkComm")
		End if 
		PRINT SELECTION:C60([Invoice:26])  //prints the report
	Else 
		ALERT:C41("No invoices between "+String:C10(vdDateBeg)+" and "+String:C10(vdDateEnd)+".")
	End if 
End if 
FORM SET OUTPUT:C54([Invoice:26]; "oInvoices_9")
vText1:=""
//MfgArrayInit (0)
vComName:=""
vShipAmt:=0
vSalebyRep:=0
vComByRep:=0
vComRate:=0
vdDateBeg:=!00-00-00!
vdDateEnd:=!00-00-00!
v1:=""
ARRAY TEXT:C222(aComNames; 0)
MESSAGES ON:C181