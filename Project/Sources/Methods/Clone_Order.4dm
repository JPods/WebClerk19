//%attributes = {"publishedWeb":true}
var $1 : Object
If ($1.obGeneral=Null:C1517)
	$1.obGeneral:=New object:C1471("clonedFrom"; $1.idNum)
End if 
// ### bj ### 20200412_1957
If ([Order:3]salesNameID:10="Clone@")
	[Order:3]salesNameID:10:="FromClone"
End if 
srSO:=[Order:3]idNum:2
newOrd:=True:C214
If ((returnTable="Customer") & (ReturnValue#"") & (ReturnValue#[Order:3]customerID:1))
	QUERY:C277([Customer:2]; [Customer:2]customerID:1=ReturnValue)
	If (Records in selection:C76([Customer:2])=1)
		LoadCustOrder
	End if 
End if 
// ### bj ### 20200609_2214
[Order:3]obGeneral:147:=New object:C1471
[Order:3]obGeneral:147.clone:=$obClone
// ### bj ### 20200609_2214

TaskIDAssign(->[Order:3]idNumTask:85)

[Order:3]dateDocument:4:=Current date:C33
[Order:3]takenBy:36:=Current user:C182
[Order:3]dateNeeded:5:=Current date:C33+<>tcNeedDelay
[Order:3]dateDocument:4:=Current date:C33
[Order:3]dateInvoiceComp:6:=!00-00-00!
[Order:3]complete:83:=0
[Order:3]timesPrinted:39:=0
[Order:3]dateCancel:53:=Current date:C33+<>tcCancelBy
[Order:3]amountBackLog:54:=[Order:3]total:27
[Order:3]dtProdRelease:56:=DateTime_Enter
[Order:3]dtProdCompl:57:=0
jDateTimeRecov([Order:3]dtProdRelease:56; ->releaseDate; ->releaseTime)
jDateTimeRecov([Order:3]dtProdCompl:57; ->complDate; ->complTime)
[Order:3]timeOrdered:58:=Current time:C178
[Order:3]profile6:105:=[Order:3]status:59
[Order:3]status:59:="Cloned"
//        [Order]Comment:=""
If ([Order:3]currency:69#<>tcMONEYCHAR)
	
End if 

<>aReps:=Find in array:C230(<>aReps; [Order:3]repID:8)
If (<>aReps>0)
	If (<>tcUpdateCommFromMaster)
		CM_ChangeRateByNameID(->[Order:3]repID:8; -><>aReps; ->[Rep:8]; ->vComRep; -><>aRepRate; <>tcSaleMar; ->aOExtPrice; ->aOExtCost; ->aORepRate; ->aORepComm; ->[Order:3]repCommission:9; ->aOQtyOrder; ->aoLineAction)
	End if 
End if 
<>aComNameID:=Find in array:C230(<>aComNameID; [Order:3]salesNameID:10)
If (<>aComNameID>0)
	If (<>tcUpdateCommFromMaster)
		CM_ChangeRateByNameID(->[Order:3]salesNameID:10; -><>aComNameID; ->[Employee:19]; ->vComSales; -><>aEmpRate; <>tcSaleMar; ->aOExtPrice; ->aOExtCost; ->aOSalesRate; ->aOSaleComm; ->[Order:3]salesCommission:11; ->aOQtyOrder; ->aoLineAction)
	End if 
End if 
// ### bj ### 20200412_1909 clone on web
If (allowAlerts_boo)
	CONFIRM:C162("Update item prices?"; "Update"; "No Change")
Else 
	OK:=1
End if 
OrdLnReCalc(OK)
//
vLineMod:=True:C214
FontSrchLabels(1)
REDUCE SELECTION:C351([Invoice:26]; 0)
REDUCE SELECTION:C351([Payment:28]; 0)
If (eOrdList>0)
	//  --  CHOPPED  AL_UpdateArrays(eOrdList; Size of array(aoLineAction))
End if 