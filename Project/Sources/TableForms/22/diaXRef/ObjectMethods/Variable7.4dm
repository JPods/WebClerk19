KeyModifierCurrent
READ ONLY:C145([Item:4])
READ WRITE:C146([ItemXRef:22])
CREATE RECORD:C68([ItemXRef:22])

QUERY:C277([Item:4]; [Item:4]itemNum:1=vPartNum)
Case of 
	: (OptKey=1)
		v2:=[Item:4]vendorItemNum:40
		v5:=[Item:4]vendorID:45
		If (Record number:C243([Vendor:38])>-1)
			PUSH RECORD:C176([Vendor:38])
			$doPop:=True:C214
		End if 
		QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=v5)
		v4:=[Vendor:38]company:2
		If ($doPop)
			POP RECORD:C177([Vendor:38])
		Else 
			UNLOAD RECORD:C212([Vendor:38])
		End if 
		vR1:=[Item:4]costLastInShip:47
		vi1:=[Item:4]leadTimePo:55
	: (CmdKey=1)
		v2:=[Item:4]mfrItemNum:39
		v5:=[Item:4]mfrID:53
		vR1:=[Item:4]costAverage:13
		If (Record number:C243([Customer:2])>-1)
			PUSH RECORD:C176([Customer:2])
			$doPop:=True:C214
		End if 
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=v5)
		v4:=[Customer:2]company:2
		If ($doPop)
			POP RECORD:C177([Customer:2])
		Else 
			UNLOAD RECORD:C212([Customer:2])
		End if 
		vi1:=[Item:4]leadTimePo:55
	Else 
		vi1:=[Item:4]leadTimeSales:12
		If (v2="")
			v2:=vPartNum
		End if 
End case 
[ItemXRef:22]itemNumMaster:1:=vPartNum
[ItemXRef:22]itemNumXRef:2:=v2
[ItemXRef:22]descriptionXRef:3:=vPartDesc
v6:=""
vText1:=""
v7:=[Item:4]type:26
v1:=vPartDesc
UNLOAD RECORD:C212([Item:4])
READ WRITE:C146([Item:4])
XRef_Var2Rec
SAVE RECORD:C53([ItemXRef:22])
READ ONLY:C145([ItemXRef:22])
XRef_Rec2Ray(-1)
UNLOAD RECORD:C212([ItemXRef:22])
aXRefRec:=Size of array:C274(aXRefRec)
//  --  CHOPPED  AL_UpdateArrays(eXRefList; -2)
ARRAY LONGINT:C221(aItemLines; 1)
aItemLines{1}:=Size of array:C274(aXRefRec)
// -- AL_SetScroll(eXRefList; viVert; viHorz)
// -- AL_SetSelect(eXRefList; aItemLines)
vMod:=False:C215