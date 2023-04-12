//%attributes = {}
C_OBJECT:C1216(item0_o; item1_o; item2_o; item3_o; item4_o; update_o; json_o; line_o)
C_LONGINT:C283(1Found; 2Found; 3Found; 4Found; countLines)
C_REAL:C285(costAverage)

C_COLLECTION:C1488(cLines; cHeader; cFields)

myDoc:=Open document:C264(""; Read mode:K24:5)
If (OK=1)
	CLOSE DOCUMENT:C267(myDoc)
	
	vText11:=Document to text:C1236(document)
	
	json_o:=New object:C1471("date"; Current date:C33; "file"; document; "outPut"; ""; "json"; ""; "lines"; New collection:C1472)
	
	C_TEXT:C284(path)
	path:=HFS_GetParent(document)
	path:=path+"ItemReworked-"+String:C10(Tickcount:C458)+".txt"
	myDoc:=Create document:C266(path)
	CLOSE DOCUMENT:C267(myDoc)
	
	json_o.outPut:=document
	
	// HOWTO:File Create
	
	//$new:=Folder(Storage.folder.jitF).file("act/ItemReworked-"+String(Tickcount)+".txt").create()
	vText7:=""
	vText6:=""
	vText4:=""
	vText5:=""
	vText10:="itemNum"+Storage:C1525.char.tab+"itemNumVendor"+Storage:C1525.char.tab+"itemNumMfr"+\
		Storage:C1525.char.tab+"Description"+Storage:C1525.char.tab+"priceA"+Storage:C1525.char.tab+"costAverage"+Storage:C1525.char.tab+\
		"costMSC"+Storage:C1525.char.tab+\
		"costDelta"+Storage:C1525.char.tab+\
		"itemListed"+Storage:C1525.char.tab+\
		"itemNum-COP"+Storage:C1525.char.tab+\
		"itemNumVendor-COP"+Storage:C1525.char.tab+\
		"itemNumMfr"+Storage:C1525.char.tab+\
		"upDated"+Char:C90(13)
	
	cLines:=Split string:C1554(vText11; Char:C90(13))
	countLines:=0
	For each (vText1; cLines)
		countLines:=countLines+1
		If (countLines=1)
			cHeader:=Split string:C1554(vText1; Storage:C1525.char.tab)
		Else 
			upDated_t:=""
			cFields:=Split string:C1554(vText1; Storage:C1525.char.tab)
			line_o:=New object:C1471
			countHead:=0
			For each (vText7; cHeader)
				line_o[vText7]:=cFields[countHead]
				countHead:=countHead+1
			End for each 
			json_o.lines.push(line_o)
			
			If (cFields[0]="COP@")
				vText4:=Substring:C12(cFields[0]; 4)
			Else 
				vText4:=cFields[0]
			End if 
			vText4:=vText4+"@"
			If (cFields[1]="COP@")
				vText5:=Substring:C12(cFields[1]; 4)
			Else 
				vText5:=cFields[1]
			End if 
			0Found:=0
			1Found:=0
			2Found:=0
			3Found:=0
			4Found:=0
			
			VBOOLEAN1:=False:C215
			update_o:=Null:C1517
			
			item0_o:=ds:C1482.Item.query("itemNum = :1"; cFields[0])
			If (item0_o#Null:C1517)
				0Found:=item0_o.length
				If (0Found>0)
					VBOOLEAN1:=True:C214
					update_o:=item1_o.first()
					upDated_t:="itemNum="+cFields[0]
				End if 
			End if 
			item1_o:=ds:C1482.Item.query("itemNum = :1"; vText4)
			If (item1_o#Null:C1517)
				1Found:=item1_o.length
				If ((1Found>0) & (VBOOLEAN1=False:C215))
					VBOOLEAN1:=True:C214
					update_o:=item1_o.first()
					upDated_t:="itemNum="+vText4
				End if 
			End if 
			item2_o:=ds:C1482.Item.query("vendorItemNum = :1"; vText5)
			If (item2_o#Null:C1517)
				2Found:=item2_o.length
				If ((2Found>0) & (VBOOLEAN1=False:C215))
					VBOOLEAN1:=True:C214
					update_o:=item2_o.first()
					upDated_t:="vendorItemNum="+vText5
				End if 
			End if 
			
			item3_o:=ds:C1482.Item.query("mfrItemNum = :1"; cFields[2])
			If (item3_o#Null:C1517)
				3Found:=item3_o.length
				If ((3Found>0) & (VBOOLEAN1=False:C215))
					VBOOLEAN1:=True:C214
					update_o:=item3_o.first()
					upDated_t:="itemNumMfr="+cFields[2]
				End if 
			End if 
			item4_o:=ds:C1482.Item.query("itemNum = :1"; cFields[3])
			If (item4_o#Null:C1517)
				4Found:=item4_o.length
				If ((4Found>0) & (VBOOLEAN1=False:C215))
					VBOOLEAN1:=True:C214
					update_o:=item4_o.first()
					upDated_t:="itemNum="+cFields[3]
				End if 
			End if 
			
			
			If (update_o=Null:C1517)
				
				upDated_t:="NewByMfr"
				update_o:=ds:C1482.Item.query("itemNum = :1"; cFields[3]).first()
				If (update_o=Null:C1517)
					update_o:=ds:C1482.Item.new()
					update_o.itemNum:=cFields[3]
				Else 
					upDated_t:="ByMfr_NotNew"
				End if 
				update_o.vendorItemNum:=cFields[1]
				update_o.mfrItemNum:=cFields[2]
				
				If (update_o.obCost=Null:C1517)
					update_o.obCost:=New object:C1471("update"; New collection:C1472)
				End if 
				update_o.obCost.update.push(New object:C1471("date"; Current date:C33; "newItem"; "added"))
				If (cFields[4][[1]]=Storage:C1525.char.quote)
					cFields[4]:=Substring:C12(cFields[4]; 2)
					If (cFields[4][[Length:C16(cFields[4])]]=Storage:C1525.char.quote)
						cFields[4]:=Substring:C12(cFields[4]; 1; Length:C16(cFields[4])-1)
					End if 
					cFields[4]:=Replace string:C233(cFields[4]; 2*Storage:C1525.char.quote; Storage:C1525.char.quote)
				End if 
				
				update_o.description:=cFields[4]
				update_o.costAverage:=Num:C11(cFields[6])
				update_o.costMSC:=update_o.costAverage
				update_o.priceA:=Num:C11(cFields[5])
				update_o.dateLastCost:=Current date:C33
				update_o.profile6:="add_"+upDated_t
				update_o.save()
				
			Else 
				If (update_o.obCost=Null:C1517)
					update_o.obCost:=New object:C1471("update"; New collection:C1472)
				End if 
				update_o.obCost.update.push(New object:C1471("date"; Current date:C33; "description"; update_o.description; "updatedBy"; upDated_t; "oldCost"; update_o.costAverage; "newCost"; Num:C11(cFields[6])))
				If (cFields[4][[1]]=Storage:C1525.char.quote)
					cFields[4]:=Substring:C12(cFields[4]; 2)
					If (cFields[4][[Length:C16(cFields[4])]]=Storage:C1525.char.quote)
						cFields[4]:=Substring:C12(cFields[4]; 1; Length:C16(cFields[4])-1)
					End if 
					cFields[4]:=Replace string:C233(cFields[4]; 2*Storage:C1525.char.quote; Storage:C1525.char.quote)
				End if 
				update_o.description:=cFields[4]
				update_o.costAverage:=Num:C11(cFields[6])
				update_o.costMSC:=update_o.costAverage
				update_o.priceA:=Num:C11(cFields[5])
				update_o.dateLastCost:=Current date:C33
				update_o.profile6:="ud_"+upDated_t
				update_o.save()
				
			End if 
			
			
			
			
			vText10:=vText10+vText1+\
				Storage:C1525.char.tab+String:C10(Num:C11(cFields[3])-costAverage)+\
				Storage:C1525.char.tab+(String:C10(0Found))+Storage:C1525.char.tab+(String:C10(1Found))+\
				Storage:C1525.char.tab+(String:C10(2Found))+Storage:C1525.char.tab+(String:C10(3Found))+\
				Storage:C1525.char.tab+(String:C10(4Found))+Storage:C1525.char.tab+upDated_t+\
				Storage:C1525.char.cr
		End if 
	End for each 
	
	SET TEXT TO PASTEBOARD:C523(vText10)
	vText14:=JSON Stringify:C1217(json_o)
	SET TEXT TO PASTEBOARD:C523(vText14)
	
	
	TEXT TO DOCUMENT:C1237(path; vText10)
	
End if 