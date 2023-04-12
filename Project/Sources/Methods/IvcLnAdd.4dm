//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-01-21T00:00:00, 11:46:34
// ----------------------------------------------------
// Method: IvcLnAdd
// Description
// Modified: 01/21/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($1; $2)  //start point, number of inserts)
C_BOOLEAN:C305($3)
C_LONGINT:C283($addCnt)
C_REAL:C285($d_rate)
If ((<>tcMONEYCHAR=strCurrency) | (<>tcMONEYCHAR="") | ([Invoice:26]exchangeRate:61=0))
	$d_rate:=1
	$thePrec:=<>tcDecimalUP
Else 
	$d_rate:=[Invoice:26]exchangeRate:61
	$thePrec:=viExDisPrec
End if 
$addCnt:=1
IvcLn_RaySize(1; $1; $2)
aiItemNum{$1}:=pPartNum
pQtyShip:=[Item:4]qtySaleDefault:15
If ((<>vbDoSrlNums) & ([Item:4]serialized:41))
	OrdSetPrice(->pUnitPrice; ->pDiscnt; pQtyShip; ->pComm)
	aiSerialRc{$1}:=CounterNew(->[DialingInfo:81])
	$addCnt:=Srl_IssueDialog($1; ->pPartNum; ->aiSerialRc{$1}; ->aiSerialNm{$1}; pQtyShip)  //search for serials 
	pQtyOrd:=$addCnt
	pQtyShip:=$addCnt
Else 
	aiSerialRc{$1}:=<>ciSRNotSerialized
	$addCnt:=1
End if 
aiLineAction:=$1
aiLineAction{$1}:=-3  // -1 from order and -3 for new
aiUniqueID{$1}:=-3
//vlineCnt:=vlineCnt+1




// Modified by: William James (2013-11-11T00:00:00)
// changed from [Invoice]OrderNum#1 in case there is some invoice with ordernum = 0
If (([Invoice:26]idNumOrder:1>10) & (viInvcLnCnt<=viOrdLnCnt))
	TRACE:C157
	viInvcLnCnt:=viOrdLnCnt+1
	viOrdLnCnt:=viOrdLnCnt+1
Else 
	//viInvcLnCnt:=viInvcLnCnt+1
	$inTest:=viInvcLnCnt
	C_LONGINT:C283($incRay; $cntRay; $lnTest)
	
	//  should always be zero
	$k:=Size of array:C274(aiOgLineNum)
	For ($i; 1; $k)
		$inTest:=MaxValueReturn($inTest; aiOgLineNum{$i}; 1)
	End for 
	
	$cntRay:=Size of array:C274(aiLineNum)
	For ($incRay; 1; $cntRay)
		$inTest:=MaxValueReturn($inTest; aiLineNum{$incRay})
	End for 
	viInvcLnCnt:=$inTest+1
	
End if 
aiLineNum{$1}:=viInvcLnCnt
pQtyOrd:=pQtyShip
aiPrintThis{$1}:=[Item:4]printNot:112
aiAltItem{$1}:=[Item:4]mfrItemNum:39
aiLocation{$1}:=[Item:4]location:9
aiUnitMeas{$1}:=[Item:4]unitOfMeasure:11
aiUnitCost{$1}:=[Item:4]costAverage:13*Num:C11([Item:4]type:26#"Bulk")*$d_rate
aiUnitWt{$1}:=[Item:4]weightAverage:8
aiQtyOpen{$1}:=[Item:4]qtyOnHand:14-[Item:4]qtyOnSalesOrder:16
Case of 
	: (([Item:4]taxID:17="NoTax") | ([Item:4]taxID:17="No Tax"))
		aiTaxable{$1}:="NoTax"  //|(Record number([Item])=-1))&doTax)
	: ([Item:4]taxID:17="")
		aiTaxable{$1}:="Tax"
	Else 
		aiTaxable{$1}:=[Item:4]taxID:17  //|(Record number([Item])=-1))&doTax)
End case 
If ([Item:4]useQtyPriceBrks:6>0)
	aiPQDIR{$1}:=Record number:C243([Item:4])  //record num if use price breaks
Else 
	aiPQDIR{$1}:=-1
End if 
aiItemNum{$1}:=pPartNum
//
aiQtyOrder{$1}:=0
If (([Item:4]qtySaleDefault:15>pQtyShip) & ($addCnt=1))
	// aiQtyRemain{$1}:=[Item]QtySaleDefault  //maintain as original, zero for new
	aiQtyShip{$1}:=[Item:4]qtySaleDefault:15
	pQtyShip:=[Item:4]qtySaleDefault:15
	BEEP:C151
Else 
	// aiQtyRemain{$1}:=pQtyShip  //maintain as original, zero for new
	aiQtyShip{$1}:=pQtyShip
End if 

If ([Item:4]type:26="carrier")
	pDescript:=String:C10(Current date:C33)+", "+[Item:4]description:7
End if 

// Modified by: William James (2014-02-08T00:00:00 Subrecord eliminated)


// Modified by: William James (2014-02-08T00:00:00 Subrecord eliminated)
aiQtyRemain{$1}:=0  // there is no remain

//C_LONGINT($prevUseBase)
Case of 
	: ((<>tcSrItemDoXRefs=True:C214) & (pXRfPricePt#""))
		//did the user request XRef searching in defaults?
		//AND did the located xref have an associated price point?
		//$prevUseBase:=vUseBase//preserve the old value for reverting.
		vUseBase:=SetPricePoint(pXRfPricePt)
		pDescript:=pXRfDescrp
		aiPricePt{$1}:=pPricePt
	: ([Invoice:26]typeSale:49#"")
		pPricePt:=[Invoice:26]typeSale:49
		vUseBase:=SetPricePoint(pPricePt)
		aiPricePt{$1}:=pPricePt
	Else 
		pPricePt:=<>tcPriceLvlA
		vUseBase:=SetPricePoint(pPricePt)
		aiPricePt{$1}:=pPricePt
End case 

OrdSetPrice(->pUnitPrice; ->pDiscnt; pQtyOrd; ->pComm; ->aiTaxable{$1})
//If ((<>tcSrItemDoXRefs=True)&(pPricePt#""))
//vUseBase:=$prevUseBase//revert to the old price point for this order
//End if 


pQtyBL:=0
//  aiQtyBL{$1}:=0
// Modified by: William James (2014-02-08T00:00:00 Subrecord eliminated)
aiQtyBL{$1}:=-pQtyShip


//
aiDescpt{$1}:=pDescript
pUnitPrice:=Round:C94(pUnitPrice*$d_rate; $thePrec)
aiUnitPrice{$1}:=pUnitPrice
aiDiscnt{$1}:=pDiscnt
aiSalesRate{$1}:=vComSales*pComm*0.01
aiRepRate{$1}:=vComRep*pComm*0.01

// Note the likely cross over between two types of line profiles
aiProfile1{$1}:=[Item:4]profile1:35
aiProfile2{$1}:=[Item:4]profile2:36
aiProfile3{$1}:=[Item:4]profile3:37
//
aiSeq{$1}:=MaxValueInArray(->aiSeq)+1
aiLnComment{$1}:=[Item:4]liComment:66
If (allowAlerts_boo)
	If (pQtyOrd>aiQtyOpen{$1})
		BEEP:C151  //PLAY("StockLevel")
	End if 
	ItemSetButtons((Size of array:C274(aiLineAction)>0); Not:C34([Invoice:26]jrnlComplete:48))
	If ([Item:4]linked:63)
		If ((Size of array:C274(aItemLines)#1) & (bAddItem=1))
			BEEP:C151
		Else 
			List_XRefLink(eItemInv; ->[Item:4]itemNum:1)
		End if 
	End if 
	If ([Item:4]alertMessage:52#"")
		ConsoleLog([Item:4]itemNum:1+"\r"+"\r"+[Item:4]alertMessage:52)
	End if 
End if 
If ($3)
	IvcLnExtend(aiLineAction)
End if 
UNLOAD RECORD:C212([Item:4])
UNLOAD RECORD:C212([ItemXRef:22])
UNLOAD RECORD:C212([ItemSpec:31])