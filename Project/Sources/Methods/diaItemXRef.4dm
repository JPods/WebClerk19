//%attributes = {"publishedWeb":true}
C_POINTER:C301($1; $2)
C_TEXT:C284($3)
C_REAL:C285($4)
C_BOOLEAN:C305($tempMod)
MESSAGES OFF:C175
KeyModifierCurrent
vPartNum:=$1->
If (vPartNum="")
	vPartNum:=Request:C163("Enter Item Number.")
	vPartNum:=vPartNum*(OK=1)
End if 
If (vPartNum#"")
	vPartDesc:=$2->
	If (optKey=0)
		QUERY:C277([ItemXRef:22]; [ItemXRef:22]ItemNumMaster:1=vPartNum; *)
		QUERY:C277([ItemXRef:22];  & [ItemXRef:22]XRefLinked:17>=0)
		vR5:=0
	Else 
		QUERY:C277([ItemXRef:22]; [ItemXRef:22]ItemNumMaster:1=vPartNum; *)
		QUERY:C277([ItemXRef:22];  & [ItemXRef:22]XRefLinked:17=0)
		vR5:=1
	End if 
	XR_FillArrays(Records in selection:C76([ItemXRef:22]))
	MESSAGES ON:C181
	v1:=""
	v2:=""
	vText:=""
	v4:=""
	v5:=""
	v6:=""
	v7:=""
	vi1:=0
	vR1:=0
	vR2:=0
	vR4:=$4
	vR3:=0
	vText1:=""
	$tempMod:=vMod
	vDiaCom:="X-Ref: "+vPartNum+$3
	jCenterWindow(454; 400; 1)
	DIALOG:C40([ItemXRef:22]; "diaXRef")
	CLOSE WINDOW:C154
	vMod:=$tempMod
	Case of 
		: ((myOK=1) & (aXRefRec>0))  //Cancel no action
			Case of 
				: (ptCurTable=(->[PO:39]))
					aPOVndrAlph{aPOLineAction}:=aXItemNum{aXRefRec}
					If (aPOQtyRcvd{aPOLineAction}=0)
						aPOUnitCost{aPOLineAction}:=aXCost{aXRefRec}
						PoLnExtend(aPOLineAction)
					End if 
				: (ptCurTable=(->[Order:3]))
					aOAltItem{aoLineAction}:=aXItemNum{aXRefRec}
				: (ptCurTable=(->[Invoice:26]))
					aiAltItem{aiLineAction}:=aXItemNum{aXRefRec}
				: (ptCurTable=(->[Proposal:42]))
					aPAltItem{aPLineAction}:=aXItemNum{aXRefRec}
			End case 
		: ((myOK=2) & (Size of array:C274(aItemLines)>0))  //Cancel no action
			$k:=Size of array:C274(aItemLines)
			$curLeadQty:=pQtyOrd
			For ($i; 1; $k)
				pPartNum:=aXItemNum{aItemLines{$i}}
				QUERY:C277([Item:4]; [Item:4]itemNum:1=pPartNum)
				[Item:4]qtySaleDefault:15:=$curLeadQty*aXQtyLoc{aItemLines{$i}}
				listItemsFill(ptCurTable; True:C214)
			End for 
			
			
			
	End case 
	
	UNLOAD RECORD:C212([ItemXRef:22])
	vDiaCom:=""
	XR_FillArrays(0)
	v1:=""
	v2:=""
	vText1:=""
	v4:=""
	v5:=""
	v6:=""
	v7:=""
	vi1:=0
	vR1:=0
	vR2:=0
	vR3:=0
	vPartNum:=""
	vPartDesc:=""
End if 