Case of 
	: (Form event code:C388=On Load:K2:1)
		Form:C1466.LB_SavedAction:=cs:C1710.listboxK.new("LB_SavedAction")
		var $o; $o1 : Object
		$o:=ds:C1482.TallyMaster.query(\
			"purpose = :1 AND tableName = :2"; "SavedQuery"; Form:C1466.dataClassName)
		var $cnt : Integer
		$cnt:=0
		For each ($o1; $o)
			If ($o1.name="")
				$cnt:=$cnt+1
				$o1.name:="Test"+String:C10($cnt)
				$o1.save()
			End if 
		End for each 
		Form:C1466.LB_SavedAction.setSource($o; Is object:K8:27)
		OBJECT SET ENABLED:C1123(*; "bSave_o"; False:C215)
		OBJECT SET ENABLED:C1123(*; "bNew_o"; False:C215)
	: (Form event code:C388=On Clicked:K2:4)
		If (Form:C1466.LB_SavedAction.cur#Null:C1517)
			If (Form:C1466.LB_SavedAction.cur.obGeneral#Null:C1517)
				If (Form:C1466.LB_SavedAction.cur.obGeneral.entsSaved#Null:C1517)
					$o1:=Form:C1466.LB_SavedAction.cur.obGeneral.entsSaved
					Form:C1466.LB_Use.ents:=Form:C1466.LB_SavedAction.cur.obGeneral.entsSaved
				End if 
			End if 
		End if 
End case 