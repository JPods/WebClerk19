C_LONGINT:C283($w)
$w:=Find in array:C230(aInvoices; vi1)
If ($w>0)
	viVert:=$w
	// -- AL_SetScroll(eIvc2Pay; viVert; viHorz)
	// -- AL_SetLine(eIvc2Pay; $w)
Else 
	QUERY:C277([Invoice:26]; [Invoice:26]idNum:2=VI1)
	If (Records in selection:C76([Invoice:26])>0)
		//CREATE SET([Invoice];"Current")
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Invoice:26]customerID:3)
		srAcct:=[Invoice:26]customerID:3
		//SEARCH([Invoice];[Invoice]customerID=srAcct;*)
		//SEARCH([Invoice];&[Invoice]BalanceDue#0)
		//CREATE SET([Invoice];"Temp")
		//UNION("Current";"Temp";"Current")
		//USE SET("Current")
		//CLEAR SET("Current")
		//CLEAR SET("Temp")
		QUERY:C277([Payment:28]; [Payment:28]customerID:4=srAcct; *)
		QUERY:C277([Payment:28];  & [Payment:28]amountAvailable:19#0)
		//  //  CHOPPED FillPayArrays(Records in selection([Payment]); 0; 0; ePay2App)
		//  //  CHOPPED FillInvArrays(Records in selection([Invoice]); 0; 0; eIvc2Pay)
		$w:=Find in array:C230(aInvoices; vi1)
		If ($w>0)
			viVert:=$w
			// -- AL_SetScroll(eIvc2Pay; viVert; viHorz)
			// -- AL_SetLine(eIvc2Pay; $w)
		End if 
		v1:=""
		v2:=""
		v3:=""
		v4:=""
		pTotal:=0
		pPayment:=0
		pDiff:=0
		<>aLastRecNum{2}:=Record number:C243([Customer:2])
		srCustomer:=[Customer:2]company:2
		srPhone:=[Customer:2]phone:13
		srAcct:=[Customer:2]customerID:1
		srZip:=[Customer:2]zip:8
		srDivision:=String:C10(Cust_GetDivision)
		//  should we care -- //  CHOPPED DivD_SetFieldColor(->srDivision; Num(srDivision))
		//  should we care -- //  CHOPPED DivD_SetFieldColor(->srAcct; Num(srDivision))
	Else 
		BEEP:C151
		BEEP:C151
	End if 
End if 
HIGHLIGHT TEXT:C210(vi1; 1; 20)