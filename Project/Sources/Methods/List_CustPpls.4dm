//%attributes = {"publishedWeb":true}
//Procedure: List_CustPpls
C_LONGINT:C283($1; $i; $k; $w)
C_TEXT:C284($2)
KeyModifierCurrent
$doCustomer:=False:C215
$doPop:=False:C215
Case of 
	: ((vhere>2) & (Record number:C243([Proposal:42])#-1))
		PUSH RECORD:C176([Proposal:42])
		$doPop:=True:C214
	: ($2="")
		QUERY:C277([ProposalLine:43]; [ProposalLine:43]customerID:42=[Customer:2]customerID:1)
	: ((CmdKey=1) & ($2#""))  //get all ref to this item
		QUERY:C277([ProposalLine:43]; [ProposalLine:43]customerID:42=[Customer:2]customerID:1; *)
		QUERY:C277([ProposalLine:43];  & [ProposalLine:43]itemNum:2=$2)
	Else 
		QUERY:C277([ProposalLine:43];  & [ProposalLine:43]itemNum:2=$2)
		$doCustomer:=True:C214
		If (ptCurTable=(->[Proposal:42]))
			PUSH RECORD:C176([Proposal:42])
		End if 
End case 
//moved Aug 10, 04
// -- AL_SetHeaders($1; 1; 8; "T"; "Item Number"; "Description"; "Qty"; "Unit Cost"; "Disc"; "Days"; "")
// -- AL_SetHeaders($1; 9; 8; ""; ""; ""; ""; "Date"; "Doc"; "Customer"; "")
// -- AL_SetWidths($1; 1; 8; 10; 50; 54; 48; 48; 20; <>wAlDate; 3)
// -- AL_SetWidths($1; 9; 8; 3; 3; 3; 3; 3; <>wAlDate; 58; 200; 30)
If ($k>1)
	// -- AL_SetSort($1; 2; -11)  //sorted before it is filled
End if 
// -- AL_SetColOpts($1; 1; 0; 1; 0; 0)  //$columnCnt;0)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
//// -- AL_SetRowColor ($1;0;"Black";0;"white";0)
//  --  CHOPPED  AL_UpdateArrays($1; -2)
//
List_RaySize(0)
$k:=Records in selection:C76([ProposalLine:43])

SELECTION TO ARRAY:C260([ProposalLine:43]idNumProposal:1; aLsSrRec; [ProposalLine:43]itemNum:2; aLsItemNum; [ProposalLine:43]description:4; aLsItemDesc; [ProposalLine:43]qty:3; aLsQtyOH; [ProposalLine:43]unitPrice:15; aLsQtySO; [ProposalLine:43]discount:17; aLsQtyPO; [ProposalLine:43]dateExpected:41; aLsDate)

C_LONGINT:C283($i; $k)
$k:=Size of array:C274(aLsItemNum)
ARRAY REAL:C219(aLsPrice; $k)
ARRAY REAL:C219(aLsCost; $k)
ARRAY REAL:C219(aLsMargin; $k)
ARRAY TEXT:C222(aLsText1; $k)
ARRAY TEXT:C222(aLsText2; $k)
ARRAY LONGINT:C221(aLsSrRec; $k)  //Record number([Item])
ARRAY TEXT:C222(aLsDocType; $k)
ARRAY LONGINT:C221(aLsLeadTime; $k)
ARRAY REAL:C219(aLsDiscount; $k)  //Discount
ARRAY REAL:C219(aLsDiscountPrice; $k)  //Discounted Price
For ($i; 1; $k)
	If ($doCustomer)
		If (aLsSrRec{$i}#[Proposal:42]idNum:5)
			QUERY:C277([Proposal:42]; [Proposal:42]idNum:5=aLsSrRec{$i})
		End if 
		aLsText2{$i}:=[Proposal:42]bill2Company:57
	End if 
	If (aLsDate{$i}=!00-00-00!)
		aLsDate{$i}:=!1901-01-01!
	End if 
	aLsText1{$i}:=String:C10(aLsSrRec{$i})
	aLsSrRec{$i}:=-1  //Record number([Item])
	aLsDocType{$i}:="ppl"
	aLsLeadTime{$i}:=Current date:C33-aLsDate{$i}
	aLsDiscount{$i}:=0
	aLsDiscountPrice{$i}:=0
End for   //use "h" to trigger a search
Case of 
	: (((ptCurTable=(->[Proposal:42])) & ($doCustomer)) | ($doPop))
		POP RECORD:C177([Proposal:42])
	: ((ptCurTable#(->[Proposal:42])) | (vHere<2))
		UNLOAD RECORD:C212([Proposal:42])
End case 
