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
	
	
	//PPP 19-FORCED
	//If (([AdSource]dateCalcBegin=!00-00-00!) | ([AdSource]dateCalcEnd=!00-00-00!))
	//QUERY([(zzzLead)]; [(zzzLead)]adSource=[AdSource]marketEffort)
	//Else 
	//QUERY([(zzzLead)]; [(zzzLead)]adSource=[AdSource]marketEffort; *)
	//QUERY([(zzzLead)];  & [(zzzLead)]dateEntered>=[AdSource]dateCalcBegin; *)
	//QUERY([(zzzLead)];  & [(zzzLead)]dateEntered<=[AdSource]dateCalcEnd)
	//End if 
	//[AdSource]numLeadAct:=Records in selection([(zzzLead)])
	$k:=[AdSource:35]numCustAct:16+[AdSource:35]numLeadAct:18
	If ($k>0)
		[AdSource:35]costRespAct:20:=[AdSource:35]costAct:22/$k
	Else 
		[AdSource:35]costRespAct:20:=[AdSource:35]costAct:22
	End if 
	//PPP 19-FORCED
	//QUERY([TallyChange]; [TallyChange]complete=False; *)
	//QUERY([TallyChange];  & [TallyChange]idKey=[AdSource]marketEffort; *)
	//QUERY([TallyChange];  & [TallyChange]idAlpha=Table(->[AdSource]); *)
	//If ([AdSource]dateCalcEnd#!00-00-00!)
	//C_LONGINT($beforeDT)
	//$beforeDT:=DateTime_DTTo([AdSource]dateCalcEnd; ?23:59:59?)
	//QUERY([TallyChange];  & [TallyChange]dtCreated<=$beforeDT; *)
	//End if 
	//QUERY([TallyChange])
	TallyCalc
	[AdSource:35]dateofCalc:4:=Current date:C33
	SAVE RECORD:C53([AdSource:35])
Else 
	jAlertMessage(10004)
End if 