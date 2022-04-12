//%attributes = {"publishedWeb":true}
//C_LONGINT($i; $k; $w; $fileNum; $fieldNum; $loopCnt)
//C_TEXT($theData; $theHeader)

//// MustFixQQQZZZ: Bill James (2022-01-31T06:00:00Z)
//// UPdate to current QuickBooks


//myDoc:=Open document("")
//If (OK=1)
//vCount:=0
//$loopCnt:=0
//$estRecs:=Get_FileLogSize(document)
////ThermoInitExit ("Testing record count";$estRecs;True)
//$viProgressID:=Progress New

//TRACE
//Repeat 
//vCount:=vCount+50
//RECEIVE PACKET(myDoc; $theData; "\t")
//If (Character code($theData)=10)
//$theData:=Substring($theData; 2)
//End if 
////Thermo_Update (vCount)
//ProgressUpdate($viProgressID; vCount; $estRecs; "Testing record count")

//If (<>ThermoAbort)
//OK:=0
//End if 
//Case of 
//: (OK=0)
//: ($theData[[1]]="!")
//RECEIVE PACKET(myDoc; $theHeader; "\r")
//OK:=0
//Case of 
//: ($theData="!CUST")
//$theHeader:="!CUST"+"\t"+$theHeader
//TextToArray($theHeader; ->aText8; "\t")
//sumDoc:=Open document(Storage.folder.jitPrefPath+"QuickBooksCUST.txt")
//: ($theData="!INVITEM")
//$theHeader:="!INVITEM"+"\t"+$theHeader
//TextToArray($theHeader; ->aText8; "\t")
//sumDoc:=Open document(Storage.folder.jitPrefPath+"QuickBooksINVITEM.txt")
//: ($theData="!VEND")
//$theHeader:="!VEND"+"\t"+$theHeader
//TextToArray($theHeader; ->aText8; "\t")
//sumDoc:=Open document(Storage.folder.jitPrefPath+"QuickBooksVEND.txt")
//: ($theData="!VTYPE")
//$theHeader:="!VTYPE"+"\t"+$theHeader
//TextToArray($theHeader; ->aText8; "\t")
//sumDoc:=Open document(Storage.folder.jitPrefPath+"QuickBooksVTYPE.txt")
////
////
//: ($theData="!ACCNT")
//$theHeader:="!ACCNT"+"\t"+$theHeader
//TextToArray($theHeader; ->aText8; "\t")
//sumDoc:=Open document(Storage.folder.jitPrefPath+"QuickBooksACCNT.txt")
//: ($theData="!CTYPE")
//$theHeader:="!CTYPE"+"\t"+$theHeader
//TextToArray($theHeader; ->aText8; "\t")
//sumDoc:=Open document(Storage.folder.jitPrefPath+"QuickBooksCType.txt")
//: ($theData="!TERMS")
//$theHeader:="!TERMS"+"\t"+$theHeader
//TextToArray($theHeader; ->aText8; "\t")
//sumDoc:=Open document(Storage.folder.jitPrefPath+"QuickBooksTERMS.txt")
//: ($theData="!CTYPE")
//$theHeader:="!CTYPE"+"\t"+$theHeader
//TextToArray($theHeader; ->aText8; "\t")
//sumDoc:=Open document(Storage.folder.jitPrefPath+"QuickBooksCTYPE.txt")
//: ($theData="!EMP")
//$theHeader:="!EMP"+"\t"+$theHeader
//TextToArray($theHeader; ->aText8; "\t")
//sumDoc:=Open document(Storage.folder.jitPrefPath+"QuickBooksEMP.txt")
//: ($theData="!PAYMETH")
//$theHeader:="!PAYMETH"+"\t"+$theHeader
//TextToArray($theHeader; ->aText8; "\t")
//sumDoc:=Open document(Storage.folder.jitPrefPath+"QuickBooksPAYMETH.txt")
//: ($theData="!PAYMETH")
//$theHeader:="!PAYMETH"+"\t"+$theHeader
//TextToArray($theHeader; ->aText8; "\t")
//sumDoc:=Open document(Storage.folder.jitPrefPath+"QuickBooksINVMEMO.txt")
//End case 
//If (OK=1)
//<>vEoF:=Get document size(document)+1  // ### jwm ### 20160714_1147 is plus 1 needed ?
//RECEIVE PACKET(sumDoc; $thePairs; <>vEoF)
//CLOSE DOCUMENT(sumDoc)
//OK:=TxtXMLGetPairs($thePairs)
//End if 
//Else 
//Case of 
//: ($theData="ACCNT@")
//RECEIVE PACKET(myDoc; $theData; "\r")
//If (OK=1)
//TextToArray("ACCNT"+"\t"+$theData; ->aText8; "\t")
//$k:=Size of array(aXMLReceived)
//If ($k=Size of array(aText8))
//CREATE RECORD([GLAccount])

//For ($i; 1; $k)

//SAVE RECORD([GLAccount])
//End for 
//End if 
//End if 
//: ($theData="INVITEM@")
//RECEIVE PACKET(myDoc; $theData; "\r")
//If (OK=1)
//TextToArray("INVITEM"+"\t"+$theData; ->aText8; "\t")
//$k:=Size of array(aXMLReceived)
//If ($k=Size of array(aText8))
//$w:=Find in array(aXMLReceived; "REFNUM")
//If ($w>0)
//QUERY([Item]; [Item]itemNum=aText8{$w})
//If (Records in selection([Item])=0)
//CREATE RECORD([Item])
//End if 
//Else 

//End if 
//For ($i; 1; $k)

//SAVE RECORD([Item])
//End for 
//End if 
//End if 
//: ($theData="CTYPE@")
////!CTYPE	NAME	REFNUM	TIMESTAMP            
//RECEIVE PACKET(myDoc; $theData; "\t")
//CREATE RECORD([AdSource])

//RECEIVE PACKET(myDoc; $theData; "\t")
//[AdSource]adCode:=$theData
//SAVE RECORD([AdSource])
//RECEIVE PACKET(myDoc; $theData; "\r")
//: ($theData="CUST@")

//SAVE RECORD([Customer])
//: ($theData="TERMS@")
////TERMS	1% 10 Net 30	5	0	30	1	10	0                    
//CREATE RECORD([Term])
//RECEIVE PACKET(myDoc; $theData; "\t")  //Descrpt
//[Term]description:=$theData  //1% 10 Net 30
//RECEIVE PACKET(myDoc; $theData; "\t")  //Code
//[Term]termID:=$theData
//RECEIVE PACKET(myDoc; $theData; "\t")  //skip
//RECEIVE PACKET(myDoc; $theData; "\t")
//[Term]dueDays:=Num($theData)
//RECEIVE PACKET(myDoc; $theData; "\t")
//[Term]discountRate:=Num($theData)
//RECEIVE PACKET(myDoc; $theData; "\r")
//[Term]discountDays:=Num($theData)
//SAVE RECORD([Term])
//: ($theData="VEND@")
////!VEND	NAME	REFNUM	TIMESTAMP	PRINTAS	ADDR1	ADDR2	ADDR3	ADDR4
////	ADDR5	VTYPE	CONT1	PHONE1	PHONE2	FAXNUM	NOTE	taxID	LIMIT	TERMS	NOTEPAD

//RECEIVE PACKET(myDoc; $theData; "\t")
//RECEIVE PACKET(myDoc; $theData; "\t")
//QUERY([Vendor]; [Vendor]vendorID=$theData)


//// Modified by: Bill James (2017-05-01T00:00:00)


//TRACE
//TRACE
//CREATE RECORD([Vendor])
//[Vendor]vendorID:=String(CounterNew(->[Vendor]))
//$theData:=[Vendor]vendorID
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
//: ($theData="EMP@")
////!EMP	NAME	REFNUM	TIMESTAMP	INIT	ADDR1	ADDR2	ADDR3	ADDR4	ADDR5	SSNO	PHONE1	PHONE2
//RECEIVE PACKET(myDoc; vText1; "\t")
//CREATE RECORD([Employee])
//[Employee]nameID:=vText1
//ParseName(->vText1; ->[Employee]nameFirst; ->[Employee]nameLast)
//[Employee]active:=True
//RECEIVE PACKET(myDoc; $theData; "\t")  //Num
//[Employee]employeeAlphaNumber:=$theData
//RECEIVE PACKET(myDoc; $theData; "\t")  //TIMESTAMP
//RECEIVE PACKET(myDoc; $theData; "\t")  //initials
//RECEIVE PACKET(myDoc; $theData; "\t")  //name again ADDR1
//RECEIVE PACKET(myDoc; $theData; "\t")  //ADDR2
//[Employee]address1:=$theData
//RECEIVE PACKET(myDoc; vText1; "\t")  //ADDR3

//RECEIVE PACKET(myDoc; $theData; "\t")  //ADDR4
//RECEIVE PACKET(myDoc; $theData; "\t")  //ADDR5
//RECEIVE PACKET(myDoc; $theData; "\t")  //SSNo
//[Employee]employeeAlphaNumber:=$theData
//RECEIVE PACKET(myDoc; vText1; "\t")  //Phone1
//ParsePhone(vText1; ->[Employee]phone1; <>tcLocalArea)
//RECEIVE PACKET(myDoc; vText1; "\r")  //PHone2
//ParsePhone(vText1; ->[Employee]phone2; <>tcLocalArea)
//SAVE RECORD([Employee])
//: ($theData="!PAYMETH@")
//RECEIVE PACKET(myDoc; $theData; "\r")
//If (Records in table([DefaultAccount])=0)
//CREATE RECORD([DefaultAccount])

//Else 
//GOTO RECORD([DefaultAccount]; 0)
//End if 
//$i:=0
//$fileNum:=Table(->[DefaultAccount])
//$fieldNum:=Field(->[DefaultAccount])
//Repeat 
//RECEIVE PACKET(myDoc; $theData; "\t")
//RECEIVE PACKET(myDoc; $theData; "\t")

//Field($fileNum; ($fieldNum+$i))->:=$theData

//RECEIVE PACKET(myDoc; $theData; "\r")
//$i:=$i+2
//Until ((OK=0) | ($i>16) | ($theData[[1]]="1"))
//SAVE RECORD([DefaultAccount])
//: ($theData="INVMEMO@")
////!INVMEMO	NAME	REFNUM	TIMESTAMP     
//RECEIVE PACKET(myDoc; $theData; "\t")
//CREATE RECORD([OrderComment])

//[OrderComment]active:=True
//[OrderComment]approvedBy:=Current user
//[OrderComment]approvedOn:=Current date
//RECEIVE PACKET(myDoc; $theData; "\t")
//[OrderComment]comName:=Substring($theData; 1; 20)
//[OrderComment]comText:=$theData
//SAVE RECORD([OrderComment])
//RECEIVE PACKET(myDoc; $theData; "\r")
//Else   //($theData="BUD")
////: (($theData="!QBP")|($theData="!CUSTOMPI")|($theData=
////"!HOURLYPI"))
////: (($theData="!LOCALPI")|($theData="!ENDQBPEMP")
////|($theData="!SHIPMETH")|($theData="!OTHERNAME"))
//// : ($theData="VTYPE")
////: ($theData="HDR")
//RECEIVE PACKET(myDoc; $theData; "\r")
//End case 
//End case 
//Until (OK=0)
////Thermo_Close 
//Progress QUIT($viProgressID)

//CLOSE DOCUMENT(myDoc)
//End if 