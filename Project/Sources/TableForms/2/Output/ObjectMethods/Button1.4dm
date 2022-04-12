If (False:C215)
	
	KeyModifierCurrent
	If ((OptKey=1) & (CmdKey=1))
		<>vWindowOverRide:=1
		REDUCE SELECTION:C351([QQQCustomer:2]; 1)
		LOAD RECORD:C52([QQQCustomer:2])
		
		MODIFY RECORD:C57([QQQCustomer:2])
	Else 
		
		Case of 
			: (<>vCountDeDup<5)
				CONFIRM:C162("DeDup All Records in this window to the UserSet Record")
			: (<>vCountDeDup=5)
				CONFIRM:C162("Skip DeDup Message")
				If (OK=1)
					<>vCountDeDup:=10
					OK:=1
				Else 
					CONFIRM:C162("DeDup All Records in this window to the UserSet Record")
					<>vCountDeDup:=-32000
				End if 
			Else 
				OK:=1
		End case 
		If (OK=1)
			<>vCountDeDup:=<>vCountDeDup+1
			
			ARRAY LONGINT:C221($aCustomerRecs; 0)
			SELECTION TO ARRAY:C260([QQQCustomer:2]; $aCustomerRecs)
			USE SET:C118("UserSet")
			$theKeyRecord:=Record number:C243([QQQCustomer:2])
			$w:=Find in array:C230($aCustomerRecs; $theKeyRecord)
			If ($w>0)
				DELETE FROM ARRAY:C228($aCustomerRecs; $w; 1)
			End if 
			$k:=Size of array:C274($aCustomerRecs)
			CREATE SET:C116([QQQCustomer:2]; "Current")
			For ($i; 1; $k)
				GOTO RECORD:C242([QQQCustomer:2]; $theKeyRecord)
				Dup_CustDetail(-1; $aCustomerRecs{$i}; $theKeyRecord)
			End for 
		End if 
		jCancelButton
		
	End if 
End if 