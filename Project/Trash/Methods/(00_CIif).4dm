//%attributes = {}

vdDateBeg:=Date:C102(Request:C163("Begin date"; String:C10(Current date:C33-365)))
vdDateEnd:=Date:C102(Request:C163("End date"; String:C10(Current date:C33)))
vi1:=(vdDateBeg-!1990-01-01!)*86400
vi2:=(((vdDateEnd+1)-!1990-01-01!)*86400)
READ ONLY:C145([DInventory:36])
READ ONLY:C145([Item:4])
QUERY:C277([DInventory:36]; [DInventory:36]dtCreated:15>=vi1; *)
QUERY:C277([DInventory:36];  & ; [DInventory:36]dtCreated:15<=vi2)
ORDER BY:C49([DInventory:36]; [DInventory:36]itemNum:1)
vi8:=Records in selection:C76([DInventory:36])
vi7:=0
FIRST RECORD:C50([DInventory:36])
vi5:=0
vr1:=0
vr2:=0
vr3:=0
vr4:=0
vText1:="ItemNum"+Char:C90(9)+"description"\
+Char:C90(9)+"onHand"\
+Char:C90(9)+"cost"+Char:C90(9)+"priceA"\
+Char:C90(9)+"transactions"\
+Char:C90(9)+"+SO"+Char:C90(9)+"-SO"\
+Char:C90(9)+"+PO"+Char:C90(9)+"-PO"+Char:C90(13)
vText2:=""
QUERY:C277([Item:4]; [Item:4]itemNum:1=[DInventory:36]itemNum:1)
vText2:=[DInventory:36]itemNum:1
Repeat 
	If (Records in selection:C76([Item:4])=0)
		vText1:=vText1+vText2\
			+Char:C90(9)+"No Item"\
			+Char:C90(9)+String:C10(0)\
			+Char:C90(9)+String:C10(0)\
			+Char:C90(9)+String:C10(0)\
			+Char:C90(9)+String:C10(vi5)\
			+Char:C90(9)+String:C10(vr1)\
			+Char:C90(9)+String:C10(vr2)\
			+Char:C90(9)+String:C10(vr3)\
			+Char:C90(9)+String:C10(vr14)+Char:C90(13)
		NEXT RECORD:C51([DInventory:36])
		vi7:=vi7+1
	Else 
		While ([Item:4]itemNum:1=[DInventory:36]itemNum:1)
			vi7:=vi7+1
			vi5:=vi5+1
			If ([DInventory:36]qtyOnSO:3>0)
				vr1:=vr1+[DInventory:36]qtyOnSO:3
			Else 
				vr2:=vr2+[DInventory:36]qtyOnSO:3
			End if 
			// 
			If ([DInventory:36]qtyOnPo:4>0)
				vr3:=vr3+[DInventory:36]qtyOnPo:4
			Else 
				vr4:=vr4+[DInventory:36]qtyOnPo:4
			End if 
			NEXT RECORD:C51([DInventory:36])
		End while 
		
		vText1:=vText1+[Item:4]itemNum:1\
			+Char:C90(9)+[Item:4]description:7\
			+Char:C90(9)+String:C10([Item:4]qtyOnHand:14)\
			+Char:C90(9)+String:C10([Item:4]costAverage:13)\
			+Char:C90(9)+String:C10([Item:4]priceA:2)\
			+Char:C90(9)+String:C10(vi5)\
			+Char:C90(9)+String:C10(vr1)\
			+Char:C90(9)+String:C10(vr2)\
			+Char:C90(9)+String:C10(vr3)\
			+Char:C90(9)+String:C10(vr14)+Char:C90(13)
	End if 
	vi5:=0
	vr1:=0
	vr2:=0
	vr3:=0
	vr4:=0
	QUERY:C277([Item:4]; [Item:4]itemNum:1=[DInventory:36]itemNum:1)
	modul
Until (vi7>=vi8)
vi4:=Create document:C266("")
If (OK=1)
	CLOSE DOCUMENT:C267(vi4)
	TEXT TO DOCUMENT:C1237(document; vText1)
End if 