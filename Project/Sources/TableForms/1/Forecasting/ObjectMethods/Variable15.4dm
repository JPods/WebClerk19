C_LONGINT:C283($myOK)
$myOK:=FC_ByOrder(1; 1)
If ($myOK=1)
	FC_FillQtyDescription
	
	If (Size of array:C274(aFCItem)<=<>alpArrayMax)
		//  --  CHOPPED  AL_UpdateArrays(eForeCast; -2)
	Else 
		doSearch:=0
		ALERT:C41("Arrays are too large to display."+"Run Date Item or Export.")
	End if 
	viRecordsInSelection:=Size of array:C274(aFCItem)
End if 
viRecordsInSelection:=Size of array:C274(aFCItem)

UNLOAD RECORD:C212([Order:3])
UNLOAD RECORD:C212([POLine:40])
UNLOAD RECORD:C212([WorkOrder:66])
UNLOAD RECORD:C212([ProposalLine:43])
UNLOAD RECORD:C212([Item:4])

//KeyModifierCurrent 
//CONFIRM("This will take a while.")
//TRACE
//If (OK=1)
//Case of 
//: (OptKey=1)
//Srch_FullDia (->[Order])
//Else 
//QUERY([Order];[Order]CompleteID<2;*)
//End case 
//Case of 
//: (OptKey=1)
//Srch_FullDia (->[PrpLine])
//Else 
//QUERY([PrpLine];[PrpLine]Complete=False;*)
//QUERY([PrpLine];&[PrpLine]Use=True)
//End case 
//Case of 
//: (OptKey=1)
//Srch_FullDia (->[POLine])
//Else 
//QUERY([POLine];[POLine]QtyBackLogged#0)
//End case 
//Case of 
//: (OptKey=1)
//Srch_FullDia (->[WorkOrder])
//Else 
//QUERY([WorkOrder];[WorkOrder]DTCompleted=0)
//End case 
//FC_FillArrays (1;1;0)//include POs and WOs; expand BOM; by Ord
//End if 