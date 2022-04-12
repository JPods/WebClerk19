//%attributes = {"publishedWeb":true}
C_TEXT:C284($WandID)
C_TEXT:C284($StrIn; $ScanStr)
C_LONGINT:C283($index; $myOK)
C_BOOLEAN:C305($ItemFlag; $doEnd)
ARRAY TEXT:C222(aText1; 20)
Repeat 
	RECEIVE PACKET:C104(myDoc; $StrIn; "\r")
Until ((OK=0) | (Substring:C12($StrIn; 1; 5)="Lines"))
If (OK=1)
	RECEIVE PACKET:C104(myDoc; aText1{1}; "\t")
	RECEIVE PACKET:C104(myDoc; aText1{2}; "\t")
	RECEIVE PACKET:C104(myDoc; aText1{3}; "\t")
	RECEIVE PACKET:C104(myDoc; aText1{4}; "\t")
	RECEIVE PACKET:C104(myDoc; aText1{5}; "\t")
	RECEIVE PACKET:C104(myDoc; aText1{6}; "\t")
	RECEIVE PACKET:C104(myDoc; aText1{7}; "\t")
	RECEIVE PACKET:C104(myDoc; aText1{8}; "\t")
	RECEIVE PACKET:C104(myDoc; aText1{9}; "\t")
	RECEIVE PACKET:C104(myDoc; aText1{11}; "\t")
	RECEIVE PACKET:C104(myDoc; aText1{12}; "\t")
	RECEIVE PACKET:C104(myDoc; aText1{13}; "\t")
	RECEIVE PACKET:C104(myDoc; aText1{14}; "\t")
	RECEIVE PACKET:C104(myDoc; aText1{15}; "\t")
	RECEIVE PACKET:C104(myDoc; aText1{16}; "\t")
	RECEIVE PACKET:C104(myDoc; aText1{17}; "\t")
	RECEIVE PACKET:C104(myDoc; aText1{18}; "\t")
	RECEIVE PACKET:C104(myDoc; aText1{19}; "\t")
	RECEIVE PACKET:C104(myDoc; aText1{20}; "\r")
	If ((OK=1) & (Substring:C12(aText1{1}; 1; 9)#"End Lines"))
		Repeat 
			RECEIVE PACKET:C104(myDoc; aText1{1}; "\t")
			RECEIVE PACKET:C104(myDoc; aText1{2}; "\t")
			RECEIVE PACKET:C104(myDoc; aText1{3}; "\t")
			RECEIVE PACKET:C104(myDoc; aText1{4}; "\t")
			RECEIVE PACKET:C104(myDoc; aText1{5}; "\t")
			RECEIVE PACKET:C104(myDoc; aText1{6}; "\t")
			RECEIVE PACKET:C104(myDoc; aText1{7}; "\t")
			RECEIVE PACKET:C104(myDoc; aText1{8}; "\t")
			RECEIVE PACKET:C104(myDoc; aText1{9}; "\t")
			RECEIVE PACKET:C104(myDoc; aText1{11}; "\t")
			RECEIVE PACKET:C104(myDoc; aText1{12}; "\t")
			RECEIVE PACKET:C104(myDoc; aText1{13}; "\t")
			RECEIVE PACKET:C104(myDoc; aText1{14}; "\t")
			RECEIVE PACKET:C104(myDoc; aText1{15}; "\t")
			RECEIVE PACKET:C104(myDoc; aText1{16}; "\t")
			RECEIVE PACKET:C104(myDoc; aText1{17}; "\t")
			RECEIVE PACKET:C104(myDoc; aText1{18}; "\t")
			RECEIVE PACKET:C104(myDoc; aText1{19}; "\t")
			RECEIVE PACKET:C104(myDoc; aText1{20}; "\r")
			If ((OK=1) & (Substring:C12(aText1{1}; 1; 9)#"End Lines"))
				listItemsFill(ptCurTable; False:C215)
				Case of 
					: (ptCurTable=(->[Order:3]))
						aOItemNum{aoLineAction}:=aText1{1}
						aOAltItem{aoLineAction}:=(aOAltItem{aoLineAction}*Num:C11(aText1{2}=""))+(aText1{2}*Num:C11(aText1{2}#""))
						aOQtyOrder{aoLineAction}:=Num:C11(aText1{3})
						aODescpt{aoLineAction}:=aText1{4}
						aOUnitPrice{aoLineAction}:=Num:C11(aText1{5})
						aODiscnt{aoLineAction}:=Num:C11(aText1{6})
						//skip extended
						aOTaxable{aoLineAction}:="TR"  //((aText1{7}="True")|(aText1{7}="t")|(aText1{7}="1"))
						aOUnitCost{aoLineAction}:=Num:C11(aText1{8})
						aOUnitWt{aoLineAction}:=Num:C11(aText1{9})
						aOLocation{aoLineAction}:=-100
						//
						aOSalesRate{aoLineAction}:=Num:C11(aText1{10})
						aORepRate{aoLineAction}:=Num:C11(aText1{11})
						aODateReq{aoLineAction}:=Date:C102(aText1{12})
						aoDateShipOn{aoLineAction}:=Date:C102(aText1{13})
						aOUnitMeas{aoLineAction}:=aText1{14}
						aOPricePt{aoLineAction}:="*"
						aoProdBy{aoLineAction}:=aText1{15}
						aoLnComment{aoLineAction}:=aText1{16}
						aoProfile1{aoLineAction}:=aText1{17}
						aoProfile2{aoLineAction}:=aText1{18}
						aoProfile3{aoLineAction}:=aText1{19}
						OrdLnExtend(aoLineAction)
						//
					: (ptCurTable=(->[Invoice:26]))
						//IvcLnAdd ((Size of array(aiLineAction)+1);1;$2)
						BEEP:C151
					: (ptCurTable=(->[PO:39]))
						aPoItemNum{aPOLineAction}:=aText1{1}
						// aPoAltItem{aPOLineAction}:=(aPoAltItem{aPOLineAction}*Num(aText1{2}=""))+(aText1{2}*N
						aPOQtyOrder{aPOLineAction}:=Num:C11(aText1{3})
						aPoDescpt{aPOLineAction}:=aText1{4}
						aPoUnitCost{aPOLineAction}:=Num:C11(aText1{5})
						aPoDiscnt{aPOLineAction}:=Num:C11(aText1{6})
						//skip extended
						aPoTaxable{aPOLineAction}:="TR"  //((aText1{7}="True")|(aText1{7}="t")|(aText1{7}="1"))
						//  aPoUnitCost{aPOLineAction}:=Num(aText1{8})
						//aPoUnitWt{aPOLineAction}:=Num(aText1{9})
						//aPoLocation{aPOLineAction}:=-100
						//aPoSalesRate{aPOLineAction}:=Num(aText1{10})
						//aPoRepRate{aPOLineAction}:=Num(aText1{11})
						aPODateExp{aPOLineAction}:=Date:C102(aText1{12})
						//aPoDateProm{aPOLineAction}:=Date(aText1{13})
						aPoUnitMeas{aPOLineAction}:=aText1{14}
						//aPoPricePt{aPOLineAction}:="*"
						//aPoProdBy{aPOLineAction}:=aText1{15}
						aPoLComment{aPOLineAction}:=aText1{16}
						// aPoProfile1{aPOLineAction}:=aText1{17}
						// aPoProfile2{aPOLineAction}:=aText1{18}
						// aPoProfile3{aPOLineAction}:=aText1{19}
						PoLnExtend(aPOLineAction)
					: (ptCurTable=(->[Proposal:42]))
						aPItemNum{aPLineAction}:=aText1{1}
						aPAltItem{aPLineAction}:=(aPAltItem{aPLineAction}*Num:C11(aText1{2}=""))+(aText1{2}*Num:C11(aText1{2}#""))
						aPQtyOrder{aPLineAction}:=Num:C11(aText1{3})
						aPDescpt{aPLineAction}:=aText1{4}
						aPUnitPrice{aPLineAction}:=Num:C11(aText1{5})
						aPDiscnt{aPLineAction}:=Num:C11(aText1{6})
						//skip extended
						aPTaxable{aPLineAction}:=aText1{7}
						aPUnitCost{aPLineAction}:=Num:C11(aText1{8})
						aPUnitWt{aPLineAction}:=Num:C11(aText1{9})
						aPLocation{aPLineAction}:=-100
						//
						aPSalesRate{aPLineAction}:=Num:C11(aText1{10})
						aPRepRate{aPLineAction}:=Num:C11(aText1{11})
						//aPDateReq{aPLineAction}:=Date(aText1{12})
						// aPDateProm{aPLineAction}:=Date(aText1{13})
						aPUnitMeas{aPLineAction}:=aText1{14}
						aPPricePt{aPLineAction}:="*"
						aPProdBy{aoLineAction}:=aText1{15}
						aPLnComment{aoLineAction}:=aText1{16}
						aPProfile1{aoLineAction}:=aText1{17}
						aPProfile2{aoLineAction}:=aText1{18}
						aPProfile3{aoLineAction}:=aText1{19}
						PpLnExtend(aPLineAction)
						pUse:=1
				End case 
				vLineMod:=True:C214
			End if 
		Until (OK=0)
	End if 
End if 