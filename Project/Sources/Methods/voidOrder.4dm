//%attributes = {"publishedWeb":true}
//Procedure: voidOrder
//October 25, 1995
C_LONGINT:C283($i; $k)
CONFIRM:C162("Do you SERIOUSLY want to Void Order Records and their Invoices.")
If (OK=1)
	jpwSignoff("Control"; ->[Order:3]takenBy:36; " VOID Orders"; ->myOK)
	If (myOk=1)
		If (vHere>1)
			CREATE SET:C116([Order:3]; "Current")
			curRecNum:=Selected record number:C246([Order:3])
			voidCurOrder
			OrdLnFillRays
			//  --  CHOPPED  AL_UpdateArrays(eOrdList; Size of array(aoLineAction))
			USE SET:C118("Current")
			CLEAR SET:C117("Current")
			If (booSorted)
				jCancelButton
			Else 
				GOTO SELECTED RECORD:C245([Order:3]; curRecNum)
			End if 
		Else 
			If (Records in set:C195("userSet")>0)
				USE SET:C118("UserSet")
				FIRST RECORD:C50([Order:3])
				$k:=Records in selection:C76([Order:3])
				$viProgressID:=Progress New
				
				For ($i; 1; $k)
					//Thermo_Update ($i)
					ProgressUpdate($viProgressID; $i; $k; "Voiding Order")
					
					If (<>ThermoAbort)
						$i:=$k
					Else 
						voidCurOrder
					End if 
					NEXT RECORD:C51([Order:3])
				End for 
				Progress QUIT($viProgressID)
				
			Else 
				ALERT:C41("There must be records HIGHLIGHTED to identify the ones to be VOIDED.")
			End if 
		End if 
	End if 
End if 