//%attributes = {"publishedWeb":true}
vText1:="--MeyerMfg"
vi2:=Records in selection:C76([Item:4])
FIRST RECORD:C50([Item:4])
For (vi1; 1; vi2)
	[Item:4]itemNum:1:=Replace string:C233([Item:4]itemNum:1; vText1; "")
	[Item:4]itemNum:1:=[Item:4]itemNum:1+"_"+[Item:4]mfrid:53
	SAVE RECORD:C53([Item:4])
	NEXT RECORD:C51([Item:4])
End for 


// vText1:=", unit of 1000 bags"
vi2:=Records in selection:C76([Item:4])
FIRST RECORD:C50([Item:4])
For (vi1; 1; vi2)
	[Item:4]priceA:2:=Round:C94([Item:4]costAverage:13*2.1; 2)
	[Item:4]priceB:3:=Round:C94([Item:4]costAverage:13*1.9; 2)
	[Item:4]priceC:4:=Round:C94([Item:4]costAverage:13*1.7; 2)
	[Item:4]priceD:5:=Round:C94([Item:4]costAverage:13*1.5; 2)
	SAVE RECORD:C53([Item:4])
	NEXT RECORD:C51([Item:4])
End for 
UNLOAD RECORD:C212([Item:4])