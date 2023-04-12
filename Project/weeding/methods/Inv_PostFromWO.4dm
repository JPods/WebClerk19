//%attributes = {"publishedWeb":true}
//Inv_PostFromWO
//TRACE
CONFIRM:C162("Process Invoices from WorkOrders?")
If (OK=1)
	If (Count parameters:C259=1)
		$fixedInvoice:=$1
	End if 
	C_LONGINT:C283($i; $k; $fixedInvoice; $1)
	C_BOOLEAN:C305($doOrder; $doInvoice)
	C_TEXT:C284($CustID)
	READ WRITE:C146([OrderLine:49])
	READ WRITE:C146([InvoiceLine:54])
	ORDER BY:C49([WorkOrder:66]; [WorkOrder:66]customerID:28)
	FIRST RECORD:C50([WorkOrder:66])
	$CustID:=[WorkOrder:66]customerID:28
	$k:=Records in selection:C76([WorkOrder:66])
	CREATE EMPTY SET:C140([Invoice:26]; "NewInvoices")
	CREATE EMPTY SET:C140([WorkOrder:66]; "SkipOrders")
	CREATE EMPTY SET:C140([WorkOrder:66]; "ProcOrders")
	READ WRITE:C146([WorkOrder:66])
	//ThermoInitExit ("Invoice WorkOrders";$k;True)
	$viProgressID:=Progress New
	
	//TRACE
	For ($i; 1; $k)
		//Thermo_Update ($i)
		ProgressUpdate($viProgressID; $i; $k; "Invoice WorkOrders")
		If (<>ThermoAbort)
			$i:=$k
		End if 
		$doInvoice:=False:C215  //February 1, 2000
		$doNewInvoice:=False:C215
		$doOrder:=False:C215
		LOAD RECORD:C52([WorkOrder:66])
		If ((Locked:C147([WorkOrder:66])) | ([WorkOrder:66]action:33="Billed@"))
			ADD TO SET:C119([WorkOrder:66]; "SkipOrders")
		Else 
			Case of 
				: ($fixedInvoice#0)
					If ([Invoice:26]idNum:2#$fixedInvoice)
						QUERY:C277([Invoice:26]; [Invoice:26]idNum:2=$fixedInvoice)
					End if 
					If (Records in selection:C76([Invoice:26])=0)
						CONFIRM:C162("Create New Invoice?")
						If (OK=1)
							$doNewInvoice:=True:C214
						End if 
					Else 
						If ([WorkOrder:66]customerID:28=[Invoice:26]customerID:3)
							$doInvoice:=True:C214
						End if 
					End if 
				: ([WorkOrder:66]billInstructions:46="")
					QUERY:C277([Invoice:26]; [Invoice:26]customerID:3=[WorkOrder:66]customerID:28; *)
					QUERY:C277([Invoice:26];  & [Invoice:26]dateShipped:4=Current date:C33)
					If (Records in selection:C76([Invoice:26])=1)
						LOAD RECORD:C52([Invoice:26])
						If (Not:C34(Locked:C147([Invoice:26])))
							$doInvoice:=True:C214
						End if 
					Else 
						$doNewInvoice:=True:C214
					End if 
				Else 
					$doNewInvoice:=True:C214
			End case 
			If ($doNewInvoice)
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=[WorkOrder:66]customerID:28)
				$doInvoice:=True:C214
				CREATE RECORD:C68([Invoice:26])
				Ivc_Initiate
				If ($fixedInvoice#0)
					$fixedInvoice:=[Invoice:26]idNum:2
				End if 
			End if 
			If (($doInvoice) & ([Invoice:26]customerID:3=[WorkOrder:66]customerID:28))
				
				IvcLnFillRays  //vLineCnt set if no order
				pPartNum:=[WorkOrder:66]itemNum:12
				pDescript:=[WorkOrder:66]itemDescript:34
				[WorkOrder:66]action:33:="Billed-"+Date_strYrMmDd
				[WorkOrder:66]idNumInvoice:1:=[Invoice:26]idNum:2
				[WorkOrder:66]dtRequested:31:=DateTime_DTTo
				[WorkOrder:66]comment:17:=String:C10(Current date:C33)+": "+Current user:C182+"; Invoiced"+"\r"+[WorkOrder:66]comment:17
				SAVE RECORD:C53([WorkOrder:66])
				QUERY:C277([Item:4]; [Item:4]itemNum:1=pPartNum)
				
				IvcLnAdd((Size of array:C274(aiLineAction)+1); 1; False:C215)
				If ($doOrder)
					C_LONGINT:C283($incSub; $cntSub)
					$cntSub:=Records in selection:C76([OrderLine:49])
					FIRST RECORD:C50([OrderLine:49])
					For ($incSub; 1; $cntSub)
						If ([OrderLine:49]location:22=[WorkOrder:66]idNum:29)
							aiUnitPrice{aiLineAction}:=[OrderLine:49]unitPrice:9
							aiDiscnt{aiLineAction}:=[OrderLine:49]discount:10
							aiQtyRemain{aiLineAction}:=0  //maintain as original, zero for new
							aiQtyShip{aiLineAction}:=[OrderLine:49]qtyBackLogged:8
							[OrderLine:49]qtyShipped:7:=[OrderLine:49]qty:6
							[OrderLine:49]qtyBackLogged:8:=0
							$incSub:=$cntSub
						End if 
						NEXT RECORD:C51([OrderLine:49])
					End for 
					//calc Order BackLog and open status
					
					If ([Order:3]idNum:2>0)
						SAVE RECORD:C53([Order:3])
					Else 
						[EventLog:75]areYouHuman:36:="zeroOrder"
						EventLogsMessage("Trying to save a zero Order Inv_PostFromWO.")
					End if 
				Else 
					aiQtyOrder{aiLineAction}:=[WorkOrder:66]qtyOrdered:13
					aiQtyShip{aiLineAction}:=[WorkOrder:66]qtyOrdered:13
					aiQtyRemain{aiLineAction}:=0
					aiUnitPrice{aiLineAction}:=[WorkOrder:66]woPrice:47
					aiDiscnt{aiLineAction}:=0
					aiProdBy{aiLineAction}:=String:C10([WorkOrder:66]idNum:29)
					aiShipOrdSt{aiLineAction}:="WOLink"+aiProdBy{aiLineAction}
					aiLocation{aiLineAction}:=[WorkOrder:66]idNum:29
					aiSerialNm{aiLineAction}:=[WorkOrder:66]processCodes:24
					aiProfile1{aiLineAction}:=[WorkOrder:66]processCodes:24
					aiLnComment{aiLineAction}:=[WorkOrder:66]actionByApproved:48+\
						("; "*Num:C11([WorkOrder:66]actionByApproved:48#""))+\
						QX_FindActiveText([WorkOrder:66]description:3; ">"; "<")
					aiProdBy{aiLineAction}:=[WorkOrder:66]actionByApproved:48
					aiAltItem{aiLineAction}:=[WorkOrder:66]mfrItemNum:42
					//If ([WorkOrder]RemoteUserName#"")
					//QUERY([RemoteUser];[RemoteUser]UserName=[WorkOrders
					//]RemoteUserName)
					//aiLnComment{aiLineAction}:=[RemoteUser]UserName+", "+
					//[RemoteUser]customerID+"\r"
					//UNLOAD RECORD([RemoteUser])
					//End if 
				End if 
				IvcLnExtend(aiLineAction)
				vMod:=calcInvoice(vMod)
				[Invoice:26]producedBy:65:=Current user:C182
				If (([WorkOrder:66]shipInstructions:45#"") | ([Invoice:26]shipInstruct:40#""))
					[Invoice:26]shipInstruct:40:=[Invoice:26]shipInstruct:40+(Num:C11([Invoice:26]shipInstruct:40#"")*"\r")+String:C10([WorkOrder:66]idNum:29; "0000-0000")+":  "+[WorkOrder:66]shipInstructions:45
				End if 
				acceptInvoice(True:C214)
				ADD TO SET:C119([Invoice:26]; "NewInvoices")
				ADD TO SET:C119([WorkOrder:66]; "ProcOrders")
			End if 
		End if 
		NEXT RECORD:C51([WorkOrder:66])
		If ($doInvoice=False:C215)
			ADD TO SET:C119([WorkOrder:66]; "SkipOrders")
		End if 
	End for 
	//Thermo_Close 
	Progress QUIT($viProgressID)
	READ ONLY:C145([WorkOrder:66])
	If (Records in set:C195("NewInvoices")>0)
		USE SET:C118("NewInvoices")
		CLEAR SET:C117("NewInvoices")
		DB_ShowCurrentSelection(->[Invoice:26]; ""; 1; "New Invoices")
	End if 
	If (Records in set:C195("SkipOrders")>1)
		USE SET:C118("SkipOrders")
		CLEAR SET:C117("SkipOrders")
		DB_ShowCurrentSelection(->[WorkOrder:66]; ""; 1; "Skipped")
	End if 
	If (Records in set:C195("ProcOrders")>1)
		USE SET:C118("ProcOrders")
		CLEAR SET:C117("ProcOrders")
		DB_ShowCurrentSelection(->[WorkOrder:66]; ""; 1; "Processed")
	End if 
End if 
READ ONLY:C145([OrderLine:49])
READ ONLY:C145([InvoiceLine:54])