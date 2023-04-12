


OBJECT SET SUBFORM:C1138(*; process_o.sf.list.nameSF; "ListItem")

_LB_Item:=cs:C1710.listboxK.new("_LB_Item_"; "Item")
_LB_Item.setSource(ds:C1482.Item.all().toCollection())
