C_LONGINT:C283($i; $k; bDoSet)
If (Size of array:C274(aFCSelect)=0)
	ALERT:C41("Select records.")
Else 
	BEEP:C151  //PLAY("Sosumi")
	MESSAGES OFF:C175
	CREATE EMPTY SET:C140([Item:4]; "CurItem")
	CREATE EMPTY SET:C140([Order:3]; "CurSO")
	CREATE EMPTY SET:C140([PO:39]; "CurPO")
	CREATE EMPTY SET:C140([Proposal:42]; "CurPp")
	$k:=Size of array:C274(aFCSelect)
	For ($i; 1; $k)
		Case of 
			: (aFCTypeTran{aFCSelect{$i}}="SO")
				GOTO RECORD:C242([Order:3]; aFCRecNum{aFCSelect{$i}})
				ADD TO SET:C119([Order:3]; "CurSO")
			: (aFCTypeTran{aFCSelect{$i}}="PO")
				GOTO RECORD:C242([PO:39]; aFCRecNum{aFCSelect{$i}})
				ADD TO SET:C119([PO:39]; "CurPO")
			: (aFCTypeTran{aFCSelect{$i}}="L")
				GOTO RECORD:C242([Item:4]; aFCRecNum{aFCSelect{$i}})
				ADD TO SET:C119([Item:4]; "CurItem")
			: (aFCTypeTran{aFCSelect{$i}}="Pp")
				GOTO RECORD:C242([Proposal:42]; aFCRecNum{aFCSelect{$i}})
				ADD TO SET:C119([Proposal:42]; "CurPp")
		End case 
	End for 
	USE SET:C118("CurSO")
	CLEAR SET:C117("CurSO")
	USE SET:C118("CurPO")
	CLEAR SET:C117("CurPO")
	USE SET:C118("CurItem")
	CLEAR SET:C117("CurItem")
	USE SET:C118("CurPp")
	CLEAR SET:C117("CurPp")
	MESSAGES ON:C181
End if 