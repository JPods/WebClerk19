//%attributes = {"publishedWeb":true}
C_LONGINT:C283(bCalcRespon; $k)
TRACE:C157
If (Not:C34(Locked:C147([AdSource:35])))
	//SEARCH([Customer];[Customer]AdSource=[AdSource]MarketEffort;*)
	//If (Not(([AdSource]DateCalcBegin=!00/00/00!)|([AdSource]DateCalcEnd
	//=!00/00/00!)))
	//SEARCH([Customer];&[Customer]DateOpened>=[AdSource]DateCalcBegin;*
	//)
	//SEARCH([Customer];&[Customer]DateOpened<=[AdSource]DateCalcEnd;*)
	//End if 
	//SEARCH([Customer])
	//[AdSource]NumCustAct:=Records in selection([Customer])
	If (([AdSource:35]dateCalcBegin:5=!00-00-00!) | ([AdSource:35]dateCalcEnd:6=!00-00-00!))
		QUERY:C277([zzzLead:48]; [zzzLead:48]adSource:27=[AdSource:35]marketEffort:2)
	Else 
		QUERY:C277([zzzLead:48]; [zzzLead:48]adSource:27=[AdSource:35]marketEffort:2; *)
		QUERY:C277([zzzLead:48];  & [zzzLead:48]dateEntered:21>=[AdSource:35]dateCalcBegin:5; *)
		QUERY:C277([zzzLead:48];  & [zzzLead:48]dateEntered:21<=[AdSource:35]dateCalcEnd:6)
	End if 
	[AdSource:35]numLeadAct:18:=Records in selection:C76([zzzLead:48])
	$k:=[AdSource:35]numCustAct:16+[AdSource:35]numLeadAct:18
	If ($k>0)
		[AdSource:35]costRespAct:20:=[AdSource:35]costAct:22/$k
	Else 
		[AdSource:35]costRespAct:20:=[AdSource:35]costAct:22
	End if 
	QUERY:C277([TallyChange:65]; [TallyChange:65]complete:6=False:C215; *)
	QUERY:C277([TallyChange:65];  & [TallyChange:65]alphaKey:3=[AdSource:35]marketEffort:2; *)
	QUERY:C277([TallyChange:65];  & [TallyChange:65]fileNum:1=Table:C252(->[AdSource:35]); *)
	If ([AdSource:35]dateCalcEnd:6#!00-00-00!)
		C_LONGINT:C283($beforeDT)
		$beforeDT:=DateTime_Enter([AdSource:35]dateCalcEnd:6; ?23:59:59?)
		QUERY:C277([TallyChange:65];  & [TallyChange:65]dtCreated:7<=$beforeDT; *)
	End if 
	QUERY:C277([TallyChange:65])
	TallyCalc
	[AdSource:35]dateofCalc:4:=Current date:C33
	SAVE RECORD:C53([AdSource:35])
Else 
	jAlertMessage(10004)
End if 