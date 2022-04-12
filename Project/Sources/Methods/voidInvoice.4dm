//%attributes = {"publishedWeb":true}
//Procedure: voidInvoice
//October 25, 1995
C_LONGINT:C283($i; $k)
//ON EVENT CALL("jotcCmdQAction")
If (allowAlerts_boo)
	CONFIRM:C162("Do you SERIOUSLY want to Void Invoice Record(s) and reset the Order(s).")
Else 
	OK:=1
End if 
If (OK=1)
	jpwSignoff("Control"; ->[Invoice:26]packedBy:30; " VOID Invoices"; ->myOK)
	If (myOk=1)
		If (vHere>1)
			curRecNum:=Selected record number:C246([Invoice:26])
			CREATE SET:C116([Invoice:26]; "Current")
			voidCurInvoice
			IvcLnFillRays  //vLineCnt set if no orde
			//  --  CHOPPED  AL_UpdateArrays(eIvcList; Size of array(aiLineAction))
			USE SET:C118("Current")
			CLEAR SET:C117("Current")
			If (booSorted)
				jCancelButton
			Else 
				GOTO SELECTED RECORD:C245([Invoice:26]; curRecNum)
			End if 
		Else 
			If (Records in set:C195("userSet")>0)
				USE SET:C118("UserSet")
				$k:=Records in selection:C76([Invoice:26])
				//ThermoInitExit ("Voiding Records";$k;True)
				$viProgressID:=Progress New
				
				FIRST RECORD:C50([Invoice:26])
				For ($i; 1; $k)
					//Thermo_Update ($i)
					ProgressUpdate($viProgressID; $i; $k; "Voiding Records")
					If (<>ThermoAbort)
						$i:=$k
					Else 
						voidCurInvoice
					End if 
					NEXT RECORD:C51([Invoice:26])
				End for 
				//Thermo_Close 
				Progress QUIT($viProgressID)
				
			Else 
				ALERT:C41("There must be records HIGHLIGHTED to identify the ones to be VOIDED.")
			End if 
		End if 
	End if 
End if 
//ON EVENT CALL("")