//%attributes = {"publishedWeb":true}

If (False:C215)
	//Method: FCByOrder
	Version_0602
End if 
C_LONGINT:C283($0; $1; $2; $doConfirm; $doOption)
C_BOOLEAN:C305($bAccountForQtyOnHand)
C_LONGINT:C283($k; $i; $w; $iBom; $cntBom)
If (Count parameters:C259>0)
	$doConfirm:=$1  //1 requires confirm dialog
	$doOption:=$2
Else 
	$doConfirm:=0
	$doOption:=0
End if 
jCenterWindow(292; 180; 1)
DIALOG:C40([Control:1]; "ForecastingChoices")
CLOSE WINDOW:C154
$0:=OK
If (OK=1)
	FC_FillRay(0)
	ARRAY TEXT:C222(aBOMQtyLookupItemNum; 0)
	ARRAY REAL:C219(aBOMQtyLookupQtyOnHand; 0)
	doQuickQuote:=1
	
	$bAccountForQtyOnHand:=(b61=1)
	doQuickQuote:=1
	If (b62=1)
		
		// Modified by: William James (2014-01-17T00:00:00)
		
		QUERY:C277([OrderLine:49]; [OrderLine:49]qtyBackLogged:8#0; *)
		QUERY:C277([OrderLine:49];  & ; [OrderLine:49]itemNum:4#"")  // ### jwm ### 20180417_2347
		
	Else 
		If (b60=0)
			REDUCE SELECTION:C351([OrderLine:49]; 0)
			Srch_FullDia(->[OrderLine:49])
		End if 
	End if 
	If (b63=1)
		QUERY:C277([ProposalLine:43]; [ProposalLine:43]complete:35=False:C215; *)
		QUERY:C277([ProposalLine:43];  & [ProposalLine:43]calculateLine:20=True:C214; *)
		QUERY:C277([ProposalLine:43];  & [ProposalLine:43]probability:9#0; *)
		QUERY:C277([ProposalLine:43];  & [ProposalLine:43]itemNum:2#"")  // ### jwm ### 20180417_2350
	Else 
		If (b60=0)
			REDUCE SELECTION:C351([ProposalLine:43]; 0)
			Srch_FullDia(->[ProposalLine:43])
		End if 
	End if 
	If (b64=1)
		QUERY:C277([QQQPOLine:40]; [QQQPOLine:40]qtyBackLogged:5#0; *)
		QUERY:C277([QQQPOLine:40];  & ; [QQQPOLine:40]itemNum:2#"")  // ### jwm ### 20180417_2350
	Else 
		If (b60=0)
			REDUCE SELECTION:C351([QQQPOLine:40]; 0)
			Srch_FullDia(->[QQQPOLine:40])
		End if 
	End if 
	If (b65=1)
		QUERY:C277([WorkOrder:66]; [WorkOrder:66]DTCompleted:6=0; *)
		QUERY:C277([WorkOrder:66];  & ; [WorkOrder:66]ItemNum:12#"")  // ### jwm ### 20180417_2350
		// ### bj ### 20181205_1433
		REDUCE SELECTION:C351([WorkOrder:66]; 0)  // remove after testing what happens with allowing WO
		
	Else 
		If (b60=0)
			REDUCE SELECTION:C351([WorkOrder:66]; 0)
			Srch_FullDia(->[WorkOrder:66])
		End if 
	End if 
	doQuickQuote:=0
	If ($bAccountForQtyOnHand)  //check for QOH to process
		FC_FillArrays(1; 1; 0; $bAccountForQtyOnHand; ->aBOMQtyLookupItemNum; ->aBOMQtyLookupQtyOnHand)  //include POs and WOs; expand BOM; by OrdLn
	Else 
		FC_FillArrays(1; 1; 0)  //include POs and WOs; expand BOM; by Ord
	End if 
	UNLOAD RECORD:C212([Order:3])
	UNLOAD RECORD:C212([OrderLine:49])
	UNLOAD RECORD:C212([QQQPOLine:40])
	UNLOAD RECORD:C212([WorkOrder:66])
	UNLOAD RECORD:C212([ProposalLine:43])
	UNLOAD RECORD:C212([Item:4])
	
	
End if 