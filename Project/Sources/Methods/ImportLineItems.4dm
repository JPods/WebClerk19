//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/11/11, 12:11:01
// ----------------------------------------------------
// Method: ImportLineItems
// Description
// 
//
// Parameters
// ----------------------------------------------------




Case of 
	: (ptCurTable=(->[Order:3]))
		myDoc:=Open document:C264("")
		If (OK=1)
			StructureFields(Table:C252(->[OrderLine:49]))
			FieldRayNamesLines(->[OrderLine:49]; 1)
			RECEIVE PACKET:C104(myDoc; vText10; "\r")
			If (OK=1)
				TextToArray(vText10; ->aText9)
				Repeat 
					RECEIVE PACKET:C104(myDoc; vText10; "\r")
					If (OK=1)
						TextToArray(vText10; ->aText10)
						If (Size of array:C274(aText10)>0)
							pPartNum:=aText10{1}
							QUERY:C277([Item:4]; [Item:4]itemNum:1=pPartNum)
							vi9:=Find in array:C230(aText9; "QtyOrdered")
							If ((vi9>0) & (Size of array:C274(aText10)>=vi9))
								[Item:4]qtySaleDefault:15:=Num:C11(aText10{vi9})
							End if 
							OrdLnAdd((Size of array:C274(aoLineAction)+1); 1; False:C215)
							//aoLineAction is set to the current line
							//expand the following to any [OrderLine] field name
							vi9:=Size of array:C274(aText10)
							For (vi8; 1; vi9)
								vi7:=Find in array:C230(theFields; aText9{vi8})
								If (vi7>0)
									vi6:=Find in array:C230(aFieldNames; theFields{vi7})
									If (vi6>0)
										UtFillifNotEmpty(ptVar; aText10{vi8}; 1; vi6)
									End if 
								End if 
							End for 
							OrdLnExtend(aoLineAction)
						End if 
					End if 
				Until (OK=0)
				vMod:=calcOrder(True:C214)
			End if 
			FieldRayNamesLines(->[OrderLine:49]; 0)
		End if 
		If (eOrdList>0)
			//  --  CHOPPED  AL_UpdateArrays(eOrdList; -2)
		End if 
		
	: (ptCurTable=(->[Invoice:26]))
		myDoc:=Open document:C264("")
		If (OK=1)
			StructureFields(Table:C252(->[InvoiceLine:54]))
			FieldRayNamesLines(->[InvoiceLine:54]; 1)
			RECEIVE PACKET:C104(myDoc; vText10; "\r")
			If (OK=1)
				TextToArray(vText10; ->aText9)
				Repeat 
					RECEIVE PACKET:C104(myDoc; vText10; "\r")
					If (OK=1)
						TextToArray(vText10; ->aText10)
						If (Size of array:C274(aText10)>0)
							pPartNum:=aText10{1}
							QUERY:C277([Item:4]; [Item:4]itemNum:1=pPartNum)
							vi9:=Find in array:C230(aText9; "QtyShipped")
							If ((vi9>0) & (Size of array:C274(aText10)>=vi9))
								[Item:4]qtySaleDefault:15:=Num:C11(aText10{vi9})
							End if 
							IvcLnAdd((Size of array:C274(aiLineAction)+1); 1; False:C215)
							//aoLineAction is set to the current line
							//expand the following to any [OrderLine] field name
							vi9:=Size of array:C274(aText10)
							For (vi8; 1; vi9)
								vi7:=Find in array:C230(theFields; aText9{vi8})
								If (vi7>0)
									vi6:=Find in array:C230(aFieldNames; theFields{vi7})
									If (vi6>0)
										UtFillifNotEmpty(ptVar; aText10{vi8}; 1; vi6)
									End if 
								End if 
							End for 
							IvcLnExtend(aiLineAction)
						End if 
					End if 
				Until (OK=0)
				vMod:=calcInvoice(True:C214)
			End if 
			FieldRayNamesLines(->[InvoiceLine:54]; 0)
		End if 
		If (eIvcList>0)
			//  --  CHOPPED  AL_UpdateArrays(eIvcList; -2)
		End if 
		
	: (ptCurTable=(->[PO:39]))
		myDoc:=Open document:C264("")
		If (OK=1)
			StructureFields(Table:C252(->[POLine:40]))
			FieldRayNamesLines(->[POLine:40]; 1)
			RECEIVE PACKET:C104(myDoc; vText10; "\r")
			If (OK=1)
				TextToArray(vText10; ->aText9)
				Repeat 
					RECEIVE PACKET:C104(myDoc; vText10; "\r")
					If (OK=1)
						TextToArray(vText10; ->aText10)
						If (Size of array:C274(aText10)>0)
							pPartNum:=aText10{1}
							QUERY:C277([Item:4]; [Item:4]itemNum:1=pPartNum)
							vi9:=Find in array:C230(aText9; "QtyOrdered")
							If ((vi9>0) & (Size of array:C274(aText10)>=vi9))
								[Item:4]qtySaleDefault:15:=Num:C11(aText10{vi9})
							End if 
							POLnAdd((Size of array:C274(aPOLineAction)+1); 1; False:C215)
							//aoLineAction is set to the current line
							//expand the following to any [OrderLine] field name
							vi9:=Size of array:C274(aText10)
							For (vi8; 1; vi9)
								vi7:=Find in array:C230(theFields; aText9{vi8})
								If (vi7>0)
									vi6:=Find in array:C230(aFieldNames; theFields{vi7})
									If (vi6>0)
										UtFillifNotEmpty(ptVar; aText10{vi8}; 1; vi6)
									End if 
								End if 
							End for 
							PoLnExtend(aPOLineAction)
						End if 
					End if 
				Until (OK=0)
				vMod:=calcPO(True:C214)
			End if 
			FieldRayNamesLines(->[POLine:40]; 0)
		End if 
		If (ePOList>0)
			//  --  CHOPPED  AL_UpdateArrays(ePOList; -2)
		End if 
	: (ptCurTable=(->[Proposal:42]))
		myDoc:=Open document:C264("")
		If (OK=1)
			StructureFields(Table:C252(->[ProposalLine:43]))
			FieldRayNamesLines(->[ProposalLine:43]; 1)
			RECEIVE PACKET:C104(myDoc; vText10; "\r")
			If (OK=1)
				TextToArray(vText10; ->aText9)
				Repeat 
					RECEIVE PACKET:C104(myDoc; vText10; "\r")
					If (OK=1)
						TextToArray(vText10; ->aText10)
						If (Size of array:C274(aText10)>0)
							pPartNum:=aText10{1}
							QUERY:C277([Item:4]; [Item:4]itemNum:1=pPartNum)
							vi9:=Find in array:C230(aText9; "Qty")
							If ((vi9>0) & (Size of array:C274(aText10)>=vi9))
								[Item:4]qtySaleDefault:15:=Num:C11(aText10{vi9})
							End if 
							PpLnAdd((Size of array:C274(aPLineAction)+1); 1; False:C215)
							pUse:=1
							vi9:=Size of array:C274(aText10)
							For (vi8; 1; vi9)
								vi7:=Find in array:C230(theFields; aText9{vi8})
								If (vi7>0)
									vi6:=Find in array:C230(aFieldNames; theFields{vi7})
									If (vi6>0)
										UtFillifNotEmpty(ptVar; aText10{vi8}; 1; vi6)
									End if 
								End if 
							End for 
							PpLnExtend(aPLineAction)
						End if 
					End if 
				Until (OK=0)
				vMod:=calcProposal(True:C214)
			End if 
			FieldRayNamesLines(->[ProposalLine:43]; 0)
		End if 
		If (ePropList>0)
			//  --  CHOPPED  AL_UpdateArrays(ePropList; -2)
		End if 
End case 