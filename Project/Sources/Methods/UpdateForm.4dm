//%attributes = {}



// 4D_25Invoice - 2022-01-15
C_OBJECT:C1216($currentEntity; $1; $2)

//We will set the Window Title according to the actual content and context
//...as well as Buttons
//...or the Selection

$this:=$1
$params:=$2

If ($this.currentPage=Null:C1517)
	$this.currentPage:=FORM Get current page:C276
End if 
If ($this.selectedSubset=Null:C1517)
	$subset:=New object:C1471
Else 
	$subset:=$this.selectedSubset
End if 
Case of 
	: (Bool:C1537($params.useSelection))
		$selection:=$params.selection2Use
		
	: ($this.displayedSelection=Null:C1517)
		$selection:=$subset
	Else 
		$selection:=$this.displayedSelection
End case 

If ($this.clickedEntity=Null:C1517)
	$currentEntity:=New object:C1471
Else 
	$currentEntity:=$this.clickedEntity
End if 

Case of 
	: ($this.currentPage=1)
		Util25_SetWindowTitle($this; Current form window:C827)
		
	: ($this.currentPage=2)
		Util25_SetWindowTitle($this; Current form window:C827)
		
End case 
//We have to disable buttons depending on the current status
Util25_HandleButtons($this)

If ($this.clickedEntity#Null:C1517)  //Specific for each DataClass
	Case of 
		: ($this.dataClassName="Invoices")  //Specific for Invoices
			$proforma:=Not:C34(OB Is empty:C1297($this.clickedEntity))
			If ($proforma)
				$proforma:=$this.clickedEntity.ProForma
			End if 
			OBJECT SET VISIBLE:C603(*; "@_PROF_@"; $proforma)
			
	End case 
End if 