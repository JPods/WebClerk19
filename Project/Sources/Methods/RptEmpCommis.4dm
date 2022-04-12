//%attributes = {"publishedWeb":true}
//Procedure: RptEmpCommis
C_BOOLEAN:C305($1)
MESSAGES OFF:C175
vi1:=1  //Commissions for Internal Sales
vdDateBeg:=Current date:C33
vdDateEnd:=Current date:C33
vComName:=""
If (<>tcSaleMar=1)
	v1:="Based on Sales"
Else 
	v1:="Based on Margin"
End if 
vDiaCom:="Report All Commissioned Employees unless one is selected below:"
QUERY:C277([Employee:19]; [Employee:19]salesGroup:8=True:C214)
SELECTION TO ARRAY:C260([Employee:19]nameID:1; <>aComNameID; [Employee:19]comRate:6; <>aCommRates)
COPY ARRAY:C226(<>aComNameID; aComNames)
jCenterWindow(218; 264; 1)
DIALOG:C40([Rep:8]; "DiaRptRepCom")
CLOSE WINDOW:C154
vDiaCom:=""
If (OK=1)
	QUERY:C277([Invoice:26]; [Invoice:26]datePaid:26>=vdDateBeg; *)
	QUERY:C277([Invoice:26];  & [Invoice:26]datePaid:26<=vdDateEnd; *)
	If (Length:C16(vComName)#0)
		QUERY:C277([Invoice:26];  & [Invoice:26]salesNameID:23=vComName; *)
	End if 
	QUERY:C277([Invoice:26])
	If (Records in selection:C76([Invoice:26])>0)  //check to see if there are no events          
		If ($1)  //std commissions
			ORDER BY:C49([Invoice:26]; [Invoice:26]salesNameID:23; [Invoice:26]company:7)
			FIRST RECORD:C50([Invoice:26])
			BREAK LEVEL:C302(1; 1)
			ACCUMULATE:C303(vShipAmt; vComAmount)  //;[Invoice]SalesName)          
			FORM SET OUTPUT:C54([Invoice:26]; "RptRepComm")
		Else   //bulk      commissions
			setChMfgs  //###wdj### why is this here?
			ORDER BY:C49([Invoice:26]; [Invoice:26]salesNameID:23; [Invoice:26]customerID:3; [Invoice:26]profile1:53)
			FIRST RECORD:C50([Invoice:26])
			BREAK LEVEL:C302(2; 1)
			ACCUMULATE:C303(vShipAmt; vSaleByMfg; vComAmount; pCommRep)  //;[Invoice]SalesName)         
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
SORT ARRAY:C229(<>aComNameID; >)
INSERT IN ARRAY:C227(<>aComNameID; 1; 1)
<>aComNameID{1}:="Sales ID"
<>aComNameID:=1
vComName:=""
vShipAmt:=0
vSalebyRep:=0
vComByRep:=0
vComRate:=0
vdDateBeg:=!00-00-00!
vdDateEnd:=!00-00-00!
vi1:=0
v1:=""
ARRAY TEXT:C222(aComNames; 0)
ARRAY REAL:C219(<>aCommRates; 0)
MESSAGES ON:C181
//

//C_BOOLEAN($1)
//MESSAGES OFF
//vi1:=1//Commissions for Internal Sales
//vdDateBeg:=Current date
//vdDateEnd:=Current date
//vComName:=""
//If (viSaleMar=1)
//v1:="Based on Sales"
//Else 
//v1:="Based on Margin"
//End if 
//vDiaCom:="Report All Commissioned Employees unless one is selected below:"
//SEARCH([Employee];[Employee]SalesGroup=True)
//SELECTION TO ARRAY([Employee]nameID;aComNameID;[Employee]ComRate
//;aComRate)
//COPY ARRAY(aComNameID;aComNames)
//jCenterWindow (218;264;1)
//DIALOG([Rep];"DiaRptRepCom")
//CLOSE WINDOW
//vDiaCom:=""
//If (OK=1)
//SEARCH BY INDEX([Invoice]DatePaidvReportBeg;vdDateEnd)
//If (Length(vComName)#0)
//SEARCH SELECTION([Invoice];[Invoice]salesNameID=vComName)
//End if 
//If (Records in selection([Invoice])>0)//check to see if there are no
// events     
//If ($1)
//SORT SELECTION([Invoice];[Invoice]SalesName;[Invoice]Company)
//FIRST RECORD([Invoice])
//BREAK LEVEL(1;1)
//ACCUMULATE(vShipAmt;vComAmount)//;[Invoice]SalesName)          
//OUTPUT LAYOUT([Invoice];"RptRepComm")
//Else 
//SORT SELECTION([Invoice];[Invoice]SalesName;[Invoice]Company;
//[Invoice]Profile)
//FIRST RECORD([Invoice])
//BREAK LEVEL(2;2)
//ACCUMULATE(vShipAmt;vComAmount)//;[Invoice]SalesName)          
//SEARCH([Customer];[Customer]MfrLocationID<-1999999)
//MfgArrayInit (Records in selection([Customer]))
//OUTPUT LAYOUT([Invoice];"RptBulkComm")
//End if 
//PRINT SELECTION([Invoice])//prints the report
//OUTPUT LAYOUT(ptCurFile;"o"+Filename(ptCurFile)+"_"+ScreenSize)
//Else 
//ALERT("No invoices between "+String(vdDateBeg)+" and "+String
//(vdDateEnd)+".")
//End if 
//End if 
//vText1:=""
//MfgArrayInit (0)
//SORT ARRAY(aComNameID;>)
//INSERT ELEMENT(aComNameID;1;1)
//aComNameID{1}:="Sales ID"
//aComNameID:=1
//vComName:=""
//vShipAmt:=0
//vSalebyRep:=0
//vComByRep:=0
//vComRate:=0
//vdDateBeg:=!00/00/00!
//vdDateEnd:=!00/00/00!
//vi1:=0
//v1:=""
//array TEXT(aComNames;0)
//ARRAY REAL(aComRate;0)
//MESSAGES ON