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
		
	: ($eventCode_i=On Clicked:K2:4)
		If (_LB_Item_.cur#Null:C1517)  // if unselecting a line
			LB_FieldList.ents:=_LB_Item_.setRecord(_LB_Item_.cur).orderBy("name")
			var vItemPict : Picture
			vItemPict:=action_setImage(_LB_Item_.cur.imagePath)
			//vItemPict:=_LB_Item_.setImage(_LB_Item_.cur.imagePath)
		End if 
		
	: ($eventCode_i=On Begin Drag Over:K2:44)
		dragFrom:="_LB_Item_"
		
	: ($eventCode_i=On Drop:K2:12)
		Query_PlanFromLines
		
		//{
		//"queryInSelection" : false,
		//"queryString" : "itemNum = :1 or itemNum = :2 or itemNum = :3", 
		//"queryParams" : {
		//"queryPlan" : true,
		//"queryPath" : true,
		//"parameters" : [
		//"", 
		//"", 
		//""
		//]
		//}
		//}
		
		
	: ($eventCode_i=On Double Clicked:K2:5)
		var $obPassable : Object
		//$obPassable:=New object("tableName"; "Item"; "form"; "Input"; "tableForm"; "Item_Input"; "id"; Form.ItemCurrent.id)
		//$viProcess:=New process("Process_ByID"; 0; "Item - "+String(Count tasks); $obPassable)
End case 

