var $name : Text
$name:=Request:C163("Name this saved action.")
var $oTest : Object
If (($name#"") & (OK=1))
	
	$oTest:=ds:C1482.TallyMaster.query(\
		"purpose = :1 AND tableName = :2 AND name = :3"; \
		"SavedQuery"; \
		Form:C1466.dataClassName; \
		$name)
	If ($oTest.length>0)
		CONFIRM:C162("Overwrite existing?")
		If (OK=1)
			$oTest.obGeneral.entsSaved:=Form:C1466.LB_Use.ents
			$oTest.save()
		End if 
	Else 
		// save a query so it can be reused
		$oTest:=ds:C1482.TallyMaster.new()
		$oTest.purpose:="SavedQuery"
		$oTest.name:=$name
		$oTest.tableName:=Form:C1466.dataClassName
		$oTest.obGeneral:=Init_obGeneral
		$oTest.obGeneral.entsSaved:=Form:C1466.LB_Use.ents
		$oTest.obGeneral.uses:=1
		$oTest.obGeneral.lastUsed:=Current date:C33
		$oTest.save()
	End if 
	// clumsy should add but for now, reload all the saved queries
	$oTest:=ds:C1482.TallyMaster.query(\
		"purpose = :1 AND tableName = :2"; \
		"SavedQuery"; \
		Form:C1466.dataClassName)
	Form:C1466.LB_SavedAction.setSource($oTest; Is collection:K8:32)
End if 