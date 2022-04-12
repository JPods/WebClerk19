//%attributes = {}



// 4D_25Invoice - 2022-01-15
//This method sets the Window Title according to the content of the screen

C_OBJECT:C1216($1)
$this:=$1
$currentWindowRef:=$2

$display:=""

Case of 
	: ($this.currentPage=1)  //We display a List
		$display:=Util25_Get_LocalizedMessage("No_Record"; $this.dataClassName)
		$entitiesInSelection:=Num:C11($this.displayedSelection.length)  //We get the number of Records (Entities) in the Selection
		If ($entitiesInSelection>0)  //We have at least one entity
			$dataClass:=$this.displayedSelection.getDataClass().getInfo().name  //Another way for getting the DataClass Name from a selection
			$display:=String:C10($entitiesInSelection; "|Long")+" "+$dataClass+" / "+String:C10($this.entitiesInDataClass; "|Long")\
				+" ("+String:C10(Num:C11($this.selectedSubset.length); "|Long")+" "+Get localized string:C991("Selected")+")"
		End if 
		
	: ($this.currentPage=2)  //We display an Entity
		$display:=Choose:C955(Num:C11($this.clickedEntity.isNew()); "ID "+$this.clickedEntity.getKey(dk key as string:K85:16); Get localized string:C991("New_Record"))
		$display:=$this.dataClassName+" ("+$display+")"
		$display:="ID "+$this.clickedEntity.getKey(dk key as string:K85:16)
		$display:=$this.dataClassName+" ("+Get localized string:C991("A_Record")+" "+$display+")"
		SET WINDOW TITLE:C213($display; Form:C1466.windowRef)
		
End case 

SET WINDOW TITLE:C213($display; $currentWindowRef)

