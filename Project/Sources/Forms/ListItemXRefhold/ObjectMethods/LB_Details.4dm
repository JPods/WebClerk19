var $event_o : Object
var $eventCode_i : Integer
$eventCode_i:=Form event code:C388
$event_o:=FORM Event:C1606
Case of 
	: ($eventCode_i=On Load:K2:1)
		var $obSetup; $columnSet_o : Object
		var $obRec : Object
		$obRec:=ds:C1482.FC.query("purpose = QuickQuoteColumns").first()
		If ($obRec=Null:C1517)
			// HOWTO: make default columns in list box
			
			vtFieldList:="itemNum,description,priceA,qtyOnHand,qtyOnPo,costMSC,class,id"
			$obSetup:=New object:C1471("listboxName"; "_LB_Item_"; "tableName"; "Item"; "fieldList"; vtFieldList; "priority"; "textBlock")
			//$columnSet_o:=LBX_DraftFromFieldString($obSetup)
			
			$obSetup.columns:=$columnSet_o
			$obRec:=ds:C1482.FC.new()
			
			$obRec.purpose:="QuickQuoteColumns"
			$obRec.data:=New object:C1471("listboxSetup"; $obSetup)
			
			$result_o:=$obRec.save()
		Else 
			$obSetup:=$obRec.data.listboxSetup
		End if 
		//LBX_ColumnBuild($obSetup)
		
	: ($eventCode_i=On Double Clicked:K2:5)
		var $obPassable : Object
		$obPassable:=New object:C1471("tableName"; "Item"; "form"; "Input"; "tableForm"; "Item_Input"; "id"; Form:C1466.ItemCurrent.id)
		$viProcess:=New process:C317("Process_ByID"; 0; "Item - "+String:C10(Count tasks:C335); $obPassable)
End case 

