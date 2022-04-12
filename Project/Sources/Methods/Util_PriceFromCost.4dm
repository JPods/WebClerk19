//%attributes = {"publishedWeb":true}
ALL RECORDS:C47([Item:4])
vi2:=Records in selection:C76([Item:4])
FIRST RECORD:C50([Item:4])
For (vi1; 1; vi2)
	[Item:4]priceA:2:=Round:C94([Item:4]costAverage:13*1.9; 2)
	SAVE RECORD:C53([Item:4])
	NEXT RECORD:C51([Item:4])
End for 
UNLOAD RECORD:C212([Item:4])
