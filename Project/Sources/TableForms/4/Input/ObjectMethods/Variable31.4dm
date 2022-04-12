KeyModifierCurrent
If (OptKey=0)
	[Item:4]priceA:2:=Margin2Price(vRM1; [Item:4]costAverage:13)
Else 
	If (Is new record:C668([Item:4]))
		[Item:4]costAverage:13:=Margin2Cost(vRM1; [Item:4]priceA:2)
		[Item:4]costLastInShip:47:=[Item:4]costAverage:13
	End if 
End if 