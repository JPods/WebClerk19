//%attributes = {"publishedWeb":true}
//Procedure: Http_ServerSale
C_LONGINT:C283($1; $c; $doThis; <>vbSaleLevel)
C_TEXT:C284(vResponse)
$c:=$1
$suffix:=""
$doThis:=0
vResponse:=""
READ WRITE:C146([Customer:2])
//SET TEXT TO CLIPBOARD(vText11)
Case of 
	: (voState.url="/Sales_Contacts@")  //
		Http_Employees($c; ->vText11)
		$doThis:=1
		//
	: ((voState.url="/Sales_MfgOrder@") | (voState.url="/Sales_MfrOrder@"))  //Split an order              
		Http_MfgOrdSplit($c; ->vText11)
		$doThis:=1
		//
	: ((voState.url="/Sales_MfgPONums@") | (voState.url="/Sales_MfrPONums@"))  //post Proposal              
		//Http_MfgPONeed($c; ->vText11)
		//$doThis:=1
		
	: ((voState.url="/Sales_MfgSplitList@") | (voState.url="/Sales_MfrSplitList@"))  //post Proposal              
		Http_MfgSplitList($c; ->vText11)  //show split orders, option to print them
		$doThis:=1
		//
		//
	: (voState.url="/Sales_MyTasks@")  //post Proposal              
		//Http_MfgPONeed($c; ->vText11)
		//$doThis:=1
		//
End case 

vcustomerID:=""