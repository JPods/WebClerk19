Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Clicked:K2:4)
		If (Form:C1466.LB_SavedAction.cur#Null:C1517)
			CONFIRM:C162("Delete")
			If (OK=1)
				var $oTest : Object
				var $result : Object
				$result:=Form:C1466.LB_SavedAction.cur.drop()
				$oTest:=ds:C1482.TallyMaster.query(\
					"purpose = :1 AND tableName = :2"; \
					"SavedQuery"; \
					Form:C1466.dataClassName)
				Form:C1466.LB_SavedAction.setSource($oTest; Is collection:K8:32)
			End if 
		End if 
End case 