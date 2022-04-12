Case of 
	: (Outside call:C328)
		Prs_OutsideCall
	: ((Before:C29) | (booPreNext))
		viRecordsInSelection:=0
		ARRAY LONGINT:C221(aRayLines; 0)
		bNewRec:=0
		jsetBefore(->[Control:1])
		SET WINDOW TITLE:C213("Apply Payments")
		//Pict_InputLo (->[Control];1;7)//get PICT resc 21006
		//
		Pay_ApplyBefore
		vCurr:=""
		vrCurrValue:=0
		viRecordsInSelection:=0
		viLoR1:=0
		viLoR2:=0
		viLoR3:=0
		C_TEXT:C284(sAltCo)
		C_TEXT:C284(sAltAcct)
		C_TEXT:C284(sAltPhone)
		C_TEXT:C284(sAltZip)
		C_TEXT:C284(sAltDivision)
		sAltCo:=""
		sAltAcct:=""
		sAltPhone:=""
		sAltZip:=""
		sAltDivision:=""
		//  should we care -- //  CHOPPED DivD_SetFieldColor(->sAltDivision; 0)
		//  should we care -- //  CHOPPED DivD_SetFieldColor(->sAltAcct; 0)
		OBJECT SET ENTERABLE:C238(sAltCo; False:C215)
		OBJECT SET ENTERABLE:C238(sAltAcct; False:C215)
		OBJECT SET ENTERABLE:C238(sAltPhone; False:C215)
		OBJECT SET ENTERABLE:C238(sAltZip; False:C215)
		iLoReal9:=0  //pallet wt
		Before_New(ptCurTable)  //last thing to do  // ### jwm ### 20170731_1538
	Else 
		//If (booDuringDo)
		If (ptCurTable#(->[Control:1]))
			jsetDuringIncl(->[Control:1])
			SET WINDOW TITLE:C213("Apply Payments")
			Pict_InputLo(->[Control:1]; 1; 7)  //get PICT resc 21006
		End if 
		C_BOOLEAN:C305($CalcBal; $ReCalc)
		C_LONGINT:C283($w)
		If (doSearch>0)
			C_BOOLEAN:C305($ReCalc; $upDateInvRa; $upDatePayRa)
			Case of 
				: ((doSearch=21) | (doSearch=22))  //click on pay window
					If (doSearch=22)
						$ReCalc:=PayDiaLoadPay
						$ReCalc:=True:C214
					Else 
						$ReCalc:=PayDiaLoadPay
					End if 
					//  should we care -- //  CHOPPED DivD_SetFieldColor(->srDivision; Num(srDivision))
					//  should we care -- //  CHOPPED DivD_SetFieldColor(->srAcct; Num(srDivision))
				: (doSearch=20)  //click on invoice window
					viLoR1:=0
					$cntRay:=Size of array:C274(aInvSelRec)
					C_LONGINT:C283($incRay; $cntRay)
					For ($incRay; 1; $cntRay)
						viLoR1:=viLoR1+aUnPaid{aInvSelRec{$incRay}}
					End for 
					doSearch:=20
					$ReCalc:=PayDiaLoadInv
					//  should we care -- //  CHOPPED DivD_SetFieldColor(->srDivision; Num(srDivision))
					//  should we care -- //  CHOPPED DivD_SetFieldColor(->srAcct; Num(srDivision))
					If ([Invoice:26]currency:62#"")
						vCurr:=[Invoice:26]currency:62
						vrCurrValue:=Round:C94([Invoice:26]exchangeRate:61*[Invoice:26]balanceDue:44; <>tcDecimalTt)
					Else 
						vCurr:=""
						vrCurrValue:=1
					End if 
				: (doSearch=1)  //change customer        
					$ReCalc:=PayChangeCust
					//  should we care -- //  CHOPPED DivD_SetFieldColor(->srDivision; Num(srDivision))
					//  should we care -- //  CHOPPED DivD_SetFieldColor(->srAcct; Num(srDivision))
					pTotal:=0
					pPayment:=0
					pDiff:=0
					<>aLastRecNum{2}:=Record number:C243([Customer:2])
				: (doSearch=11)  //(b11=1)|(b13=1))//Pay Invoice                
					$ReCalc:=PayPayInvoice
					bCredit:=0
					$ReCalc:=True:C214
				: (doSearch=12)
					Pay_LoopMulti
					$ReCalc:=True:C214
				: (doSearch=14)
					$ReCalc:=True:C214
				: (b12=1)  //Credit Invoice
				: (b14=1)
					//        $ReCalc:=PayDiaPayChange 
				: (b23=1)
				: (b24=1)
				: (b25=1)
				: (b26=1)
				: (b28=1)
					$ReCalc:=True:C214
			End case 
			C_LONGINT:C283($theLine)
			If ($ReCalc)
				PayReCalcCust
				$upDateInvRa:=True:C214
				$upDatePayRa:=True:C214
			End if 
			If ($upDateInvRa)
				ARRAY LONGINT:C221(aInvSelRec; 0)
				//  CHOPPED  $error:=AL_GetSelect(eIvc2Pay; aInvSelRec)
				aInvoices:=aInvSelRec{Num:C11(Size of array:C274(aInvSelRec)>0)}  //used in credit invoice, possibly others
				//  CHOPPED  AL_GetScroll(eIvc2Pay; viVert; viHorz)
				//  --  CHOPPED  AL_UpdateArrays(eIvc2Pay; -2)
				// -- AL_SetSelect(eIvc2Pay; aInvSelRec)
				// -- AL_SetScroll(eIvc2Pay; viVert; viHorz)
			End if 
			If ($upDatePayRa)
				$theLine:=aPayInvs
				//  CHOPPED  AL_GetScroll(ePay2App; viVert; viHorz)
				//  --  CHOPPED  AL_UpdateArrays(ePay2App; -2)
				// -- AL_SetLine(ePay2App; $theLine)
				// -- AL_SetScroll(ePay2App; viVert; viHorz)
			End if 
			PaymentLoadRecs
			doSearch:=0
			viLoR2:=[Payment:28]amountAvailable:19
			viLoR3:=viLoR1-viLoR2
		End if 
		//Else 
		booDuringDo:=True:C214
		//End if 
End case 