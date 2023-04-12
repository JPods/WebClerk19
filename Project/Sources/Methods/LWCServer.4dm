//%attributes = {"publishedWeb":true}
//127.0.0.1/LWC_AddItemToOrder?TableName=Customers&ItemNum=ZZZWindow&ProcessNum=0&Quantity=23



//Method: Http_ServerPay
C_LONGINT:C283($1; $3; $c; $doThis; <>vbSaleLevel)
C_TEXT:C284(vResponse)
C_POINTER:C301($2)
READ ONLY:C145([Employee:19])
READ ONLY:C145([Rep:8])
$c:=$1
$suffix:=""
$doThis:=0
$sendPage:=True:C214
vResponse:="Access to this command is not available."
$doPage:="Error.html"

//TRACE
C_LONGINT:C283($p; $p2; $findInArray)
C_TEXT:C284($incomingAddress)
$findInArray:=Find in array:C230(aHeaderNameIn; "Host")
If ($findInArray>0)
	If ((aHeaderValueIn{$findInArray}="localhost@") | (aHeaderValueIn{$findInArray}="127.0.0.1@"))
		$notFinished:=True:C214
		$tableName:=WCapi_GetParameter("TableName"; "")
		$theRecordNum:=Num:C11(WCapi_GetParameter("RecordNum"; ""))
		$tableNum:=STR_GetTableNumber($tableName)
		If ($tableNum>0)
			$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
			$theScript:=WCapi_GetParameter("jitScript"; "")
			If ($jitPageOne#"")
				$doPage:=$jitPageOne
			End if 
			theText:=""
			//TRACE
			Case of 
				: (voState.url="/LWC_Display@")  //Utilities
					If ($theScript#"")
						QUERY:C277([TallyResult:73]; [TallyResult:73]name:1=$theScript; *)
						QUERY:C277([TallyResult:73];  & [TallyResult:73]purpose:2="LWCScript")
						If (Records in selection:C76([TallyResult:73])=1)
							theText:=[TallyResult:73]textBlk2:6
							REDUCE SELECTION:C351([TallyResult:73]; 0)
						End if 
					End if 
					Case of 
						: ($theRecordNum=-11)
							USE SET:C118("?curSelSet")
						: ($theRecordNum>-1)
							GOTO RECORD:C242(Table:C252($tableNum)->; $theRecordNum)
							ptCurTable:=Table:C252($tableNum)
							//RelatedRelease 
							RelateOnWeb($1; Table:C252($tableNum); True:C214)
					End case 
					
				: (voState.url="/LWC_ServeMilgard@")
					$doPage:="index_mil.html"
					pvProcessNum:=WCapi_GetParameter("ProcessNum"; "")
					
				: (voState.url="/LWC_AddItemToProcess@")
					//Required, this is the process that currently holds the open order that you want to add the item to
					$prsNum:=WCapi_GetParameter("ProcessNum"; "")
					//Required, this is the ItemNum that will be searched for, and put into memory
					$itemNum:=WCapi_GetParameter("ItemNum"; "")
					//Not required, this will be set to [Item]LIComment
					$LIComment:=WCapi_GetParameter("LIComment"; "")
					If ($LIComment="")
						$LIComment:=WCapi_GetParameter("DescriptionDetail"; "")
					End if 
					$Description:=WCapi_GetParameter("Description"; "")
					
					C_TEXT:C284(<>vtMore; <>vtDescription)
					<>vtMore:=$LIComment
					<>vtDescription:=$Description
					C_REAL:C285(<>vrPrice)
					<>vrPrice:=Num:C11(WCapi_GetParameter("ItemPrice"; ""))
					C_REAL:C285(<>vrCost)
					<>vrCost:=Num:C11(WCapi_GetParameter("ItemCost"; ""))
					$itemQty:=Num:C11(WCapi_GetParameter("Quantity"; ""))
					QUERY:C277([Item:4]; [Item:4]itemNum:1=$itemNum)
					If (Records in selection:C76([Item:4])=1)
						ARRAY LONGINT:C221(<>aItemLines; 1)
						ARRAY LONGINT:C221(<>aLsSrRec; 1)
						<>aLsSrRec{1}:=Record number:C243([Item:4])
						<>aItemLines{1}:=1
						<>rQQAddQty:=$itemQty
						UNLOAD RECORD:C212([Item:4])
						QQItemAdd(Num:C11($prsNum); False:C215)
					Else 
						vResponse:="Item does not exist."
					End if 
			End case 
		End if 
	End if 
End if 
If ($sendPage)
	$err:=WC_PageSendWithTags($c; WC_DoPage($doPage; ""); 0)
End if 
theText:=""