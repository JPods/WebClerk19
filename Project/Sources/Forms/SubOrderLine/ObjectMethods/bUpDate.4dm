If ([Order:3]orderNum:2<10)
	QUERY:C277([Order:3]; [Order:3]orderNum:2=3016)
End if 
var OrderLineDisplayed_o : Object
OrderLineDisplayed_o:=ds:C1482.OrderLine.query("orderNum = :1 "; [Order:3]orderNum:2)
Form:C1466.OrderLineDisplayed:=OrderLineDisplayed_o
CALL SUBFORM CONTAINER:C1086(-255)
