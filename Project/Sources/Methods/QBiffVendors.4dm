//%attributes = {"publishedWeb":true}
//If (False)
////Method: QBiffVendors
//Version_0501
////Date: 01/05/05
////Who: Bill
////Description: 
//End if 
////
//// MustFixQQQZZZ: Bill James (2022-01-31T06:00:00Z)
//// must update to current QuickBooks
//CONFIRM("Import Vendor List from QuickBooks")
//If (OK=1)
//myDoc:=Open document("")
//If (OK=1)
////!VEND	NAME	REFNUM	TIMESTAMP	PRINTAS	ADDR1	ADDR2	ADDR3	ADDR4
////	ADDR5	VTYPE	CONT1	PHONE1	PHONE2	FAXNUM	NOTE	taxID	LIMIT	TERMS	NOTEPAD

//RECEIVE PACKET(myDoc; $theLine; "\r")
//If (OK=1)
//TextToArray($theLine; ->aText4; "\t")  //header row
//$sizeRay:=Size of array(aText4)
//C_LONGINT($sizeRay; $incRay)
//Repeat 
//RECEIVE PACKET(myDoc; $theLine; "\r")
//TextToArray($theLine; ->aText8; "\t")
//$theText:=""
//For ($incRay; 1; $sizeRay)
//$theText:=$theText+"<"+aText4{$incRay}+">"+aText8{$incRay}+"</"+aText4{$incRay}+">"+"\r"
//End for 
//[Vendor]comment:=$theText



//RECEIVE PACKET(myDoc; $theData; "\t")
//RECEIVE PACKET(myDoc; $theData; "\t")
//QUERY([Vendor]; [Vendor]vendorID=$theData)
//If (Records in selection([Vendor])>0)
//$theData:=String(CounterNew(->[Vendor]))
//End if 
//CREATE RECORD([Vendor])
//[Vendor]vendorID:=$theData
//RECEIVE PACKET(myDoc; $theData; "\t")  //TIMESTAMP
//RECEIVE PACKET(myDoc; $theData; "\t")  //PRINTAS
//RECEIVE PACKET(myDoc; $theData; "\t")  //ADDR1
//[Vendor]company:=$theData
//RECEIVE PACKET(myDoc; $theData; "\t")  //ADDR2
//If ($theData[[1]]=Char(34))
//[Vendor]address1:=Substring($theData; 2; (Length($theData)-1))
//Else 
//[Vendor]address1:=$theData
//End if 
//RECEIVE PACKET(myDoc; vText1; "\t")  //ADDR3
//ParseCityStZip(->vText1; ->[Vendor]city; ->[Vendor]state; ->[Vendor]zip)
//RECEIVE PACKET(myDoc; $theData; "\t")  //ADDR4
//[Vendor]division:=$theData
//RECEIVE PACKET(myDoc; $theData; "\t")  //ADDR5
//[Vendor]country:=$theData
//RECEIVE PACKET(myDoc; $theData; "\t")  //VTYPE
//[Vendor]profile1:=$theData
//RECEIVE PACKET(myDoc; $theData; "\t")  //CONT1
//[Vendor]attention:=$theData
//RECEIVE PACKET(myDoc; vText1; "\t")  //PHONE1
//ParsePhone(vText1; ->[Vendor]phone; <>tcLocalArea)
//RECEIVE PACKET(myDoc; $theData; "\t")  //PHONE2
//[Vendor]comment:=$theData
//RECEIVE PACKET(myDoc; vText1; "\t")  //PHONE1
//ParsePhone(vText1; ->[Vendor]fax; <>tcLocalArea)
//RECEIVE PACKET(myDoc; $theData; "\t")  //NOTE
//[Vendor]comment:=[Vendor]comment+("\r"*Num([Vendor]comment#""))+$theData
//RECEIVE PACKET(myDoc; $theData; "\t")  //taxID
//[Vendor]taxID:=$theData
//RECEIVE PACKET(myDoc; $theData; "\t")  ////LIMIT
//[Vendor]creditLimit:=Num($theData)
//RECEIVE PACKET(myDoc; $theData; "\t")  //TERMS
//[Vendor]terms:=$theData
//RECEIVE PACKET(myDoc; $theData; "\t")
//[Vendor]comment:=[Vendor]comment+("\r"*Num([Vendor]comment#""))+$theData  //NOTEPAD
//SAVE RECORD([Vendor])
//Until (OK=0)
//End if 
//End if 
//End if 
