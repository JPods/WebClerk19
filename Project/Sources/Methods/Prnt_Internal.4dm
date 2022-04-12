//%attributes = {"publishedWeb":true}
//Procedure: Prnt_Internal
//October 25, 1995
C_LONGINT:C283($1)  //report key; file number
READ ONLY:C145([DefaultQQQ:15])
QUERY:C277([DefaultQQQ:15]; [DefaultQQQ:15]PrimeDefault:176=1)
Case of 
	: ($1=100)
		rptLead(100)
		InitContactArra(0)
		ServiceArrayInit(0)
	: ($1=101)
		rptLead(101)
		InitContactArra(0)
		ServiceArrayInit(0)
		
		
	: ($1=103)
		prntJobSummary
		//: ($1=104)
		//WO_PrntSheet
	: (($1=141) | ($1=142))
		prntStatement($1)
	: ($1=10)
		Ltr_MultLtr
		//: (($1=11)|($1=12))
		//ALERT("Set for wide paper.")
		//prntShipEnvel ($2;$1)
	: ($1=200)
		ALL RECORDS:C47([Employee:19])
		RptEmpCommis(True:C214)  //do std commissions
	: ($1=201)
		ALL RECORDS:C47([Rep:8])
		RptRepCommis(True:C214)  //do std commissions
	: ($1=202)
		ALL RECORDS:C47([Employee:19])
		RptEmpCommis(False:C215)  //do Bulk commissions
	: ($1=203)
		ALL RECORDS:C47([Rep:8])
		RptRepCommis(False:C215)  //do Bulk commissions
End case 
UNLOAD RECORD:C212([DefaultQQQ:15])