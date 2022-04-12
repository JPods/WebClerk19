//%attributes = {}



// 4D_25Invoice - 2022-01-15
C_OBJECT:C1216($1; $2; $DnDsource)
C_TEXT:C284($PrimaryKey)
C_COLLECTION:C1488($dragCollection)

$event:=$1
$selection:=$2

Case of 
	: ($event.code=On Begin Drag Over:K2:44)
		$nbOfLines:=$selection.length
		Case of 
			: ($nbOfLines<1)
				//Nothing to do
			Else 
				$icon:=Util25_Get_DragNDropIcon($nbOfLines)
				SET DRAG ICON:C1272($icon)
				$collection:=$selection.toCollection("ID")  //We have to go through an array because .toCollection creates a non-shared collection
				$dragCollection:=New shared collection:C1527
				Use ($dragCollection)
					For each ($id; $collection)
						$dragCollection.push($id.ID)
					End for each 
				End use 
				$dragThings:=New shared object:C1526
				Use ($dragThings)
					$dragThings.sourceDataClass:=Form:C1466.dataClassName
					$dragThings.sourceSelField:="ID"
				End use 
				Use (Storage:C1525)
					Storage:C1525.DnDdataClassInfo:=$dragThings
					Storage:C1525.DnDcollection:=$dragCollection
					//storage.DnDproperty:="ID"
				End use 
				
		End case 
		
	: ($event.code=On Drag Over:K2:13)
		
		
	: ($event.code=On Drop:K2:12)
		$DnDsource:=Storage:C1525.DnDdataClassInfo
		If ($DnDsource#Null:C1517)
			$source:=Storage:C1525.DnDdataClassInfo.sourceDataClass
			If ($source=Form:C1466.dataClassName)
				//Drop inside the same class, we do nothing
			Else 
				$PrimaryKey:=Storage:C1525.DnDdataClassInfo.sourceSelField
				$collection:=Storage:C1525.DnDcollection
				If (($source#"") & ($collection.length>0))
					$dataSource:=ds:C1482[$source]
					$selection2use:=$dataSource.query($PrimaryKey+" in :1"; $collection)
					Form:C1466.displayedSelection:=Util25_PropagateSelection($selection2Use; $source; Form:C1466.dataClassName)
					If (FORM Get current page:C276=2)
						Form:C1466.currentPage:=1
						FORM GOTO PAGE:C247(Form:C1466.currentPage)
					End if 
					Util25_UpdateSelection("_LB_1")
					Util25_UpdateOnContext
				End if 
				Use (Storage:C1525)
					Storage:C1525.DnDdataClassInfo:=New shared object:C1526
					Storage:C1525.DnDcollection:=New shared collection:C1527
					//storage.DnDproperty:="ID"
				End use 
			End if 
		End if 
End case 