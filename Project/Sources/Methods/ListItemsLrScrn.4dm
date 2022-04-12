//%attributes = {"publishedWeb":true}
If (False:C215)
	//Date: 02/27/02
	//Who: Dan Bentson, Arkware
	//Description: Passing SalesType
	VERSION_960
End if 
//TRACE
<>vItemNumCreate:=""
C_POINTER:C301($1)
C_TEXT:C284($2)
C_BOOLEAN:C305($doItem)
//C_Longint($doReplace;$3)
//$doReplace:=0
C_TEXT:C284($typeSaleSel)
$typeSaleSel:=""

// 02/27/02 - assign saletype
C_LONGINT:C283($updateList)
Case of 
	: ($1=(->[Order:3]))
		$typeSaleSel:=[Order:3]typeSale:22
		$updateList:=eItemOrd
	: ($1=(->[Invoice:26]))
		$typeSaleSel:=[Invoice:26]typeSale:49
		$updateList:=eItemInv
	: ($1=(->[Proposal:42]))
		$typeSaleSel:=[Proposal:42]typeSale:20
		$updateList:=eItemPp
	: ($1=(->[PO:39]))
		$updateList:=eItemPo
End case 

If (pPartNum#"")
	$doItem:=True:C214
	KeyModifierCurrent
	If (pPartNum="*")
		Case of 
			: ($1=(->[Order:3]))
				If (Size of array:C274(aoLineAction)>0)
					pPartNum:=aOItemNum{aoLineAction}
					$2:=pPartNum
				End if 
			: ($1=(->[Invoice:26]))
				If (Size of array:C274(aiLineAction)>0)
					pPartNum:=aiItemNum{aiLineAction}
					$2:=pPartNum
				End if 
			: ($1=(->[PO:39]))
				If (Size of array:C274(aPOLineAction)>0)
					pPartNum:=aPoItemNum{aPOLineAction}
					$2:=pPartNum
				End if 
			: ($1=(->[Proposal:42]))
				If (Size of array:C274(aPLineAction)>0)
					pPartNum:=aPItemNum{aPLineAction}
					$2:=pPartNum
				End if 
		End case 
	End if 
	//case of
	//: ((CmdKey=1)&(OptKey=1))
	//
	//Case of 
	//: ($1=([Order]))
	//aOItemNum{aoLineAction}:=pPartNum
	//: ($1=([Invoice]))
	//aiItemNum{aiLineAction}:=pPartNum
	//: ($1=([PO]))
	//aPoItemNum{aPOLineAction}:=pPartNum
	//: ($1=([Proposal]))
	//aPItemNum{aPLineAction}:=pPartNum
	//End case 
	//$doItem:=False
	Case of 
		: (OptKey=1)
			QUERY:C277([Item:4]; [Item:4]itemNum:1=($2))
			If (Records in selection:C76([Item:4])=1)
				//MODIFY RECORD([Item])
				ProcessTableOpen(Table:C252(->[Item:4])*-1)
			Else 
				REDUCE SELECTION:C351([Item:4]; 0)
				vPartNum:=$2
				//ADD RECORD([Item])
				C_TEXT:C284(<>vItemNumCreate)
				<>vItemNumCreate:=$2
				Process_AddRecord("Item")
			End if 
		: (CmdKey=1)
			TRACE:C157
			QUERY:C277([Item:4]; [Item:4]itemNum:1=($2))
		Else 
			Item_SrSeq($2)
	End case 
	Case of 
		: ($doItem=False:C215)
		: (Records in selection:C76([Item:4])=0)
			QUERY:C277([Item:4]; [Item:4]retired:64=True:C214; *)
			QUERY:C277([Item:4];  & [Item:4]itemNum:1=($2))
			If (Records in selection:C76([Item:4])=0)
				BEEP:C151
				BEEP:C151
				CONFIRM:C162("Item "+pPartNum+" does not exist."+"\r"+"OK creates item record?"+"\r"+"Opt OK for temp item.")
				REDUCE SELECTION:C351([Item:4]; 0)
				KeyModifierCurrent
				Case of 
					: ((OK=1) & (OptKey=1))
						listItemsFill($1; False:C215)
					: (OK=1)
						vPartNum:=$2
						<>vItemNumCreate:=$2
						//ADD RECORD([Item])
						Process_AddRecord("Item")
						//listItemsFill ($1;False)
					Else 
						HIGHLIGHT TEXT:C210(pPartNum; 1; 35)
				End case 
			Else 
				ALERT:C41("Retired Item, hold ShiftKey down to Enter.")
			End if 
		: (Records in selection:C76([Item:4])=1)
			listItemsFill($1; False:C215)  //;$doReplace)
		Else 
			viRecordsInSelection:=Records in selection:C76([Item:4])
			List_FillOpts(viRecordsInSelection; vUseBase; $typeSaleSel)
			BEEP:C151
			HIGHLIGHT TEXT:C210(pPartNum; 1; 15)
			doSearch:=1000
			bMultiSr:=0
			If (eItemList>0)
				// //  --  CHOPPED  AL_UpdateArrays (eItemList;Size of array(aItemSrRec))
			End if 
	End case 
	UNLOAD RECORD:C212([Item:4])
	
	If ($updateList>0)
		//  --  CHOPPED  AL_UpdateArrays($updateList; -2)
	End if 
End if 