//%attributes = {}
//var myPath; cells_t; fieldName_t; working_t; titles_t; itemsExtra_t; itemsMissing_t : Text
//var lines_c : Collection
//var cells_c; missingDec_c : Collection
//var missingJan_c; working_c; titles_c : Collection
//var doc; working_o; line_o; sel_o; rec_o : Object
//var count; countMissing : Integer
////var dtSync : cs.cDateTime  // define a DT for records in this import
////dtSync:=cs.cDateTime.new(Current date; ?00:00:05?)
//// path /Users/williamjames/Downloads/CopperfieldUpdate_2023-01-17.txt
//var dtSync : Integer
//working_c:=New collection
//missingDec_c:=New collection
//missingJan_c:=New collection
//dtSync:=222

//myPath:=Get text from pasteboard
//myPath:="/Users/williamjames/Downloads/CopperfieldUpdate2_2023-01-17.txt"
//If (myPath#"")
//doc:=File(myPath)
//If (doc.exists)
//working_t:=doc.getText()
//lines_c:=Split string(working_t; "\r")
//CONFIRM("Line count is: "+String(lines_c.length-1))
//If (OK=0)
//return 
//Else 
//titles_t:=lines_c[0]
//titles_c:=Split string(titles_t; "\t")
//lines_c:=lines_c.remove(0; 1)
//For each (cells_t; lines_c)
//cells_c:=Split string(cells_t; "\t")
//line_o:=New object()
//count:=0
//For each (fieldName_t; titles_c)
//If (fieldName_t="Price")
//line_o[fieldName_t]:=Num(cells_c[count])
//Else 
//line_o[fieldName_t]:=cells_c[count]
//End if 
//count:=count+1
//End for each 
//working_c.push(line_o)

////  update prices
//If (line_o["Inventory ID"]#Null)
//rec_o:=ds.Item.query("itemNum = :1"; line_o["Inventory ID"]+"-CCS").first()
//If (rec_o=Null)
//missingDec_c.push(line_o["Inventory ID"])
//Else 

//rec_o.dtLastSync:=111
//rec_o.costMSC:=line_o.Price
//rec_o.costAverage:=rec_o.costMSC
//rec_o.costLastInShip:=rec_o.costMSC

//rec_o.priceA:=line_o.costMSC*2
//rec_o.priceB:=line_o.costMSC*2
//rec_o.priceC:=line_o.costMSC*2
//rec_o.priceD:=line_o.costMSC*2
//rec_o.dateLastCost:=Current date
//rec_o.save()
//End if 
//End if 
//End for each 
//End if 
//End if 
//End if 


//SET TEXT TO PASTEBOARD("Missing: "+String(missingDec_c.length)+"\r"+missingDec_c.join("\r"))
//CONFIRM("Paste from clipboard the "+String(missingDec_c.length)+" missing parts that were in the Dec spreadsheet: ")


//sel_o:=ds.Item.query("vendorID = :1 && dtLastSync != :2"; "Copperfield"; 111)

//For each (rec_o; sel_o)
//missingJan_c.push(Replace string(rec_o.itemNum; "-CCS"; ""))
//End for each 
//SET TEXT TO PASTEBOARD("Missing: "+String(missingJan_c.length)+"\r"+missingJan_c.join("\r"))
//CONFIRM("Paste from clipboard the "+String(missingJan_c.length)+" extra parts that were NOT in the Dec spreadsheet: ")
