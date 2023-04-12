//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 03/14/21, 00:21:11
// ----------------------------------------------------
// Method: CloneProposal
// Description
// 
//
// Parameters
// ----------------------------------------------------

//CLEAR SET("PpLineCur")
//CREATE EMPTY SET([ProposalLine];"PpLineCur")
// ### bj ### 20200218_0113 so clone can be called from the wcc
$obClone:=New object:C1471
$obClone.cloneType:=[Proposal:42]status:2
$obClone.parent:=[Proposal:42]idNum:5
PpLnInitRays
QUERY:C277([ProposalLine:43]; [ProposalLine:43]idNumProposal:1=[Proposal:42]idNum:5)
PpLnFillRays(Records in selection:C76([ProposalLine:43]))
REDUCE SELECTION:C351([ProposalLine:43]; 0)
DUPLICATE RECORD:C225([Proposal:42])
[Proposal:42]idNum:5:=CounterNew(->[Proposal:42])

CREATE RECORD:C68([Task:140])
[Task:140]obRelate:17:=New object:C1471
[Task:140]obRelate:17.Proposal:=[Proposal:42]idNum:5
SAVE RECORD:C53([Task:140])
[Proposal:42]idNumTask:70:=[Task:140]idNum:4
newProp:=True:C214

//If ((returnTable="Customer") & (ReturnValue#"") & (ReturnValue#[Proposal]customerID))
//QUERY([Customer]; [Customer]customerID=ReturnValue)
If (Records in selection:C76([Customer:2])=1)
	ProposalLoadCus
End if 
//End if 

// ### bj ### 20200609_2214
[Proposal:42]obGeneral:93:=New object:C1471
[Proposal:42]obGeneral:93.clone:=$obClone
[Proposal:42]dateDocument:3:=Current date:C33
[Proposal:42]salesNameID:9:=Current user:C182
[Proposal:42]dateNeeded:4:=Current date:C33+<>tcNeedDelay
[Proposal:42]inquiryCode:6:=""
[Proposal:42]status:2:="Open"
[Proposal:42]complete:56:=False:C215
srPp:=[Proposal:42]idNum:5
ARRAY LONGINT:C221(aPpOgRec; 0)
REDUCE SELECTION:C351([ProposalLine:43]; 0)
For ($i; 1; Size of array:C274(aPLineAction))
	aPDateExp{$i}:=!00-00-00!
	aPLineAction{$i}:=-3
	aPUniqueID{$i}:=-3
	PpLnExtend($i)
End for 
<>aReps:=Find in array:C230(<>aReps; [Proposal:42]repID:7)
If (<>aReps>0)
	If (<>tcUpdateCommFromMaster)
		CM_ChangeRateByNameID(->[Proposal:42]repID:7; -><>aReps; ->[Rep:8]; ->vComRep; -><>aRepRate; <>tcSaleMar; ->aPExtPrice; ->aPExtCost; ->aPRepRate; ->aPRepComm; ->[Proposal:42]repCommission:8; ->aPQtyOrder; ->aPLineAction)
	End if 
End if 
<>aComNameID:=Find in array:C230(<>aComNameID; [Proposal:42]salesNameID:9)
If (<>aComNameID>0)
	If (<>tcUpdateCommFromMaster)
		CM_ChangeRateByNameID(->[Proposal:42]salesNameID:9; -><>aComNameID; ->[Employee:19]; ->vComSales; -><>aEmpRate; <>tcSaleMar; ->aPExtPrice; ->aPExtCost; ->aPSalesRate; ->aPSaleComm; ->[Proposal:42]salesCommission:10; ->aPQtyOrder; ->aPLineAction)
	End if 
End if 
vLineMod:=True:C214
FontSrchLabels(1)
REDUCE SELECTION:C351([ProposalLine:43]; 0)
