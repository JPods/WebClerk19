//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/23/11, 20:58:35
// ----------------------------------------------------
// Method: OrdLnExtend
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20170411_1113 added protection for EDI

C_BOOLEAN:C305(<>onErrWeb)  // to keep dialog from opening of undefined item
If (<>onErrWeb)
	ON ERR CALL:C155("OEC_Web")  // try to turn off all alerts ???? look at creating a log of alerts
End if 

C_LONGINT:C283($1; $unitPrec; $totalPrec)
If ((Shift down:C543) & (allowAlerts_boo))  // ### jwm ### 20170411_1113 added protection for EDI
	CONFIRM:C162(String:C10($1))
	If (OK=1)
		CONFIRM:C162(String:C10(Size of array:C274(aOQtyOrder)))
		If (OK=1)
			ALERT:C41(aOItemNum{$1})
		End if 
	End if 
End if 

If (Size of array:C274(aoUniqueID)>0)
	If (($1>0) & ($1<=Size of array:C274(aOQtyOrder)) & ($1<=Size of array:C274(aoLineAction)))
		Case of 
			: ((<>tcMONEYCHAR#strCurrency) & ([Order:3]currency:69#"") & ([Order:3]exchangeRate:68#1) & ([Order:3]exchangeRate:68#0))
				$thePrec:=viExDisPrec
			: ((<>tcMONEYCHAR=strCurrency) | ([Order:3]currency:69="") | ([Order:3]exchangeRate:68=1) | ([Order:3]exchangeRate:68=0) | (<>tcMONEYCHAR=""))
				$thePrec:=<>tcDecimalTt
			: (<>tcMONEYCHAR#strCurrency)
				$thePrec:=viExDisPrec  //viExConPrec
			Else 
				$thePrec:=<>tcDecimalTt
		End case 
		If (aoLineAction{$1}=10)
			aoLineAction{$1}:=-3000
		End if 
		If (aoUniqueID{$1}>0)  // don't make this negative
			Case of 
				: (aoLineAction{$1}=-2000)  // packing window CHANGE
					// no Change
				: (aoLineAction{$1}=10)  // packing window NO CHANGE
					// no Change
					// Modified by: William James (2014-10-16T00:00:00 Subrecord eliminated)
					// even if nothing has changed, the order terms, type sale and other could have 
					aoLineAction{$1}:=-3000  // why if nothing has changed
				Else 
					aoLineAction{$1}:=-3000  // why if nothing has changed
			End case 
		End if 
		//
		//06/22/98
		//aOQtyBL{$1}:=(aOQtyOrder{$1}-aOQtyShip{$1})*Num(aOLnCmplt{$1}="")
		//TRACE
		
		Case of 
			: (aoLineAction{$1}=10)  // no change, do nothing
				
			: (aoLineAction{$1}=-3)  // New Line
				aOQtyBL{$1}:=aOQtyOrder{$1}-aOQtyShip{$1}
				aOLnCmplt{$1}:=""
				pUse:=0
				
				If ((Shift down:C543) & (allowAlerts_boo))  // ### jwm ### 20170411_1113 added protection for EDI
					ALERT:C41(String:C10(Size of array:C274(aOQtyOrder))+"; "+aOItemNum{$1})
				End if 
				
			: (False:C215)
			: (aOQtyOrder{$1}=aOQtyShip{$1})
				aOQtyBL{$1}:=0
				aOLnCmplt{$1}:="x"
				pUse:=1
			: ((aOQtyOrder{$1}#aOQtyShip{$1}) & (aOLnCmplt{$1}=""))
				aOLnCmplt{$1}:=""
				aOQtyBL{$1}:=aOQtyOrder{$1}-aOQtyShip{$1}
			: ((aOQtyOrder{$1}#aOQtyShip{$1}) & (aOLnCmplt{$1}#""))  //if it is compl
				aOLnCmplt{$1}:="x"
				aOQtyCanceled{$1}:=aOQtyBL{$1}
				aOQtyBL{$1}:=0
			Else 
				aOQtyBL{$1}:=aOQtyOrder{$1}-aOQtyShip{$1}
				aOLnCmplt{$1}:=Num:C11(aOQtyBL{$1}=0)*"x"
		End case 
		
		If (False:C215)
			Case of 
					// : ((aOQtyBL{$1}+aOQtyShip{$1}+aOQtyCanceled{$1})#aOQtyOrder{$1})
					
				: (aOLnCmplt{$1}#"")  //if it is compl
					aOLnCmplt{$1}:="x"
					aOQtyCanceled{$1}:=aOQtyOrder{$1}-aOQtyShip{$1}
					aOQtyBL{$1}:=0
				: (((aOQtyOrder{$1}-aOQtyShip{$1})=aOQtyCanceled{$1}) & (aOQtyBL{$1}=0) & (aOLnCmplt{$1}#""))
					// Modified by: William James BUG_To_Hunt #31
					// do nothing
				: (aoLineAction{$1}=-3)
					aOQtyBL{$1}:=aOQtyOrder{$1}-aOQtyShip{$1}
					aOLnCmplt{$1}:=""
					aOQtyCanceled{$1}:=0
				: (((aOQtyOrder{$1}-aOQtyShip{$1})-aOQtyCanceled{$1}-aOQtyBL{$1}=0) & (aOLnCmplt{$1}=""))  // adding to an orderline that was cancelled
					aOQtyCanceled{$1}:=0
					aOQtyBL{$1}:=aOQtyOrder{$1}-aOQtyShip{$1}
				: (aOQtyOrder{$1}=aOQtyShip{$1})
					aOQtyBL{$1}:=0
					aOLnCmplt{$1}:="x"
					aOQtyCanceled{$1}:=0
				: ((aOQtyOrder{$1}#aOQtyShip{$1}) & (aOLnCmplt{$1}=""))
					aOLnCmplt{$1}:=""
					aOQtyBL{$1}:=aOQtyOrder{$1}-aOQtyShip{$1}
					aOQtyCanceled{$1}:=0
				: ((aOQtyOrder{$1}#aOQtyShip{$1}) & (aOLnCmplt{$1}#""))  //if it is compl
					aOLnCmplt{$1}:="x"
					aOQtyCanceled{$1}:=aOQtyBL{$1}
					aOQtyBL{$1}:=0
				Else 
					aOQtyBL{$1}:=aOQtyOrder{$1}-aOQtyShip{$1}
					aOLnCmplt{$1}:=Num:C11(aOQtyBL{$1}=0)*"x"
					aOQtyCanceled{$1}:=0
			End case 
		End if 
		pUse:=Num:C11(aOLnCmplt{$1}#"")
		//
		If (aoLineAction{$1}#10)  // 10 notes there are no changes to orderline
			
			pQtyBL:=aOQtyBL{$1}
			Case of 
				: (aOQtyShip{$1}=0)
					aoDateShipped{$1}:=!00-00-00!
				: ((aOQtyBL{$1}=0) & ((aoDateShipped{$1}=!00-00-00!) | (aoDateShipped{$1}=!1901-01-01!)))
					aoDateShipped{$1}:=Current date:C33
			End case 
			If ($thePrec><>tcDecimalUP)
				$discntPrc:=DiscountApply(aOUnitPrice{$1}; aODiscnt{$1}; $thePrec)
			Else 
				$discntPrc:=DiscountApply(aOUnitPrice{$1}; aODiscnt{$1}; <>tcDecimalUP)
			End if 
			aODscntUP{$1}:=Round:C94($discntPrc; <>tcDecimalUP+4)
			If (aoLineAction{$1}=-3)
				PriceBelowMargi(->aODscntUP{$1}; ->aOUnitCost{$1}; ->aOItemNum{$1})
			End if 
			//
			$unitMeasBy:=1
			If (aOUnitMeas{$1}#"")
				If (aOUnitMeas{$1}[[1]]="*")
					C_REAL:C285($unitMeasBy)
					$unitMeasBy:=Item_PricePer(->aOUnitMeas{$1})
				End if 
			End if 
			//
			If (aOLnCmplt{$1}="")
				aOExtWt{$1}:=aOUnitWt{$1}*aOQtyOrder{$1}/$unitMeasBy
				aOExtPrice{$1}:=Round:C94(aOQtyOrder{$1}/$unitMeasBy*$discntPrc; $thePrec)
				aOExtCost{$1}:=Round:C94((aOQtyOrder{$1}*aOUnitCost{$1}/$unitMeasBy); $thePrec)
				aOBackLog{$1}:=Round:C94(aOQtyBL{$1}*$discntPrc/$unitMeasBy; $thePrec)  //unit of measure
			Else 
				aOExtWt{$1}:=aOUnitWt{$1}*aOQtyShip{$1}/$unitMeasBy
				aOExtPrice{$1}:=Round:C94(aOQtyShip{$1}/$unitMeasBy*$discntPrc; $thePrec)
				aOExtCost{$1}:=Round:C94((aOQtyShip{$1}*aOUnitCost{$1}/$unitMeasBy); $thePrec)
				aOBackLog{$1}:=0
			End if 
			//
			pExtPrice:=aOExtPrice{$1}
			//
			TaxCalcLine(->[Order:3]taxJuris:43; [Order:3]taxExemptid:122; aOTaxable{$1}; aOExtPrice{$1}; aOExtCost{$1}; $1; $thePrec; ->aOSaleTax{$1}; ->aOTaxCost{$1})
			
			If (aOLnCmplt{$1}="")
				CM_LineCalc(<>tcSaleMar; $1; ->aOExtPrice; ->aOExtCost; ->aOSalesRate; ->aOSaleComm; ->aOQtyOrder)
				CM_LineCalc(<>tcSaleMar; $1; ->aOExtPrice; ->aOExtCost; ->aORepRate; ->aORepComm; ->aOQtyOrder)
			Else 
				CM_LineCalc(<>tcSaleMar; $1; ->aOExtPrice; ->aOExtCost; ->aOSalesRate; ->aOSaleComm; ->aOQtyShip)
				CM_LineCalc(<>tcSaleMar; $1; ->aOExtPrice; ->aOExtCost; ->aORepRate; ->aORepComm; ->aOQtyShip)
			End if 
			vMod:=True:C214
			vLineMod:=True:C214
			vLineReCalc:=False:C215
		End if 
	End if 
End if 
