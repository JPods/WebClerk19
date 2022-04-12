//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-05-29T00:00:00, 09:06:41
// ----------------------------------------------------
// Method: OrderLineDuplicateClean
// Description
// Modified: 05/29/15
// Structure: CEv13_131005
// 
// Delete duplicated lines
// Parameters
// ----------------------------------------------------

C_LONGINT:C283(vi1; vi2; vi3)

If (vHere>1)
	Case of 
		: (ptCurTable=(->[Order:3]))
			vi2:=Size of array:C274(aRayLines)
			If (vi2>0)
				CONFIRM:C162("Delete "+String:C10(vi2)+" lines.")
				If (OK=1)
					CONFIRM:C162("There is no undo, delete "+String:C10(vi2)+" lines.")
					If (OK=1)
						READ WRITE:C146([OrderLine:49])
						vi3:=0
						For (vi1; 1; vi2)
							QUERY:C277([OrderLine:49]; [OrderLine:49]idNum:50=aoUniqueID{aRayLines{vi1}})
							If (Records in selection:C76([OrderLine:49])=1)
								If (Not:C34(Locked:C147([OrderLine:49])))
									DELETE RECORD:C58([OrderLine:49])
								Else 
									vi3:=vi3+1
								End if 
							End if 
						End for 
						If (vi3>0)
							ALERT:C41("There were "+String:C10(vi3)+" locked records that could not be deleted.")
						End if 
						OrdLnFillRays
						vMod:=calcOrder(True:C214)
						If (eOrdList#0)
							//  --  CHOPPED  AL_UpdateArrays(eOrdList; -2)
						End if 
					End if 
				End if 
			End if 
			
		: (ptCurTable=(->[Invoice:26]))
			vi2:=Size of array:C274(aRayLines)
			If (vi2>0)
				CONFIRM:C162("Delete "+String:C10(vi2)+" lines.")
				If (OK=1)
					CONFIRM:C162("There is no undo, delete "+String:C10(vi2)+" lines.")
					If (OK=1)
						READ WRITE:C146([InvoiceLine:54])
						vi3:=0
						For (vi1; 1; vi2)
							QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]idNum:47=aiUniqueID{aRayLines{vi1}})
							If (Records in selection:C76([InvoiceLine:54])=1)
								If (Not:C34(Locked:C147([InvoiceLine:54])))
									DELETE RECORD:C58([InvoiceLine:54])
								Else 
									vi3:=vi3+1
								End if 
							End if 
						End for 
						If (vi3>0)
							ALERT:C41("There were "+String:C10(vi3)+" locked records that could not be deleted.")
						End if 
						IvcLnFillRays
						vMod:=calcInvoice(True:C214)
						If (eOrdList#0)
							//  --  CHOPPED  AL_UpdateArrays(eIvcList; -2)
						End if 
					End if 
				End if 
			End if 
			
	End case 
End if 