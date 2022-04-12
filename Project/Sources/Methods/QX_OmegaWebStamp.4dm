//%attributes = {"publishedWeb":true}
$typeStamp:=""
$width:=0
Case of 
	: ($typeStamp="Ideal")
		Case of 
			: ($width<100)
				QUERY:C277([Item:4]; [Item:4]itemNum:1="jitTest")
			: ($width<200)
			: ($width<300)
			: ($width<400)
				
		End case 
	: ($typeStamp="handle")
		
		
	: ($typeStamp="Dater")
		
	: ($typeStamp="XStamp")
		
		
End case 
If (Records in selection:C76([Item:4])=1)
	
	
End if 