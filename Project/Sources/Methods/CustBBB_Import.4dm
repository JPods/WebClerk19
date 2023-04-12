//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 03/15/07, 13:23:00
// ----------------------------------------------------
// Method: CustBBB_Import
// Description
// 
//
// Parameters
// ----------------------------------------------------


//CLOSE DOCUMENT(myDoc)


CONFIRM:C162("Import BBB Items")
If (OK=1)
	myDoc:=Open document:C264("")
	If (OK=1)
		vi9:=DateTime_DTTo
		vi5:=1
		ARRAY TEXT:C222(aText1; 19)
		Repeat 
			RECEIVE PACKET:C104(myDoc; aText1{1}; "\t")  //SKU
			vi5:=OK
			RECEIVE PACKET:C104(myDoc; aText1{2}; "\t")  //DESCRIPTION
			RECEIVE PACKET:C104(myDoc; aText1{3}; "\t")  //COMPANY
			RECEIVE PACKET:C104(myDoc; aText1{4}; "\t")  //TITLE
			RECEIVE PACKET:C104(myDoc; aText1{5}; "\t")  //PRICE
			RECEIVE PACKET:C104(myDoc; aText1{6}; "\t")  //TAXABLE
			RECEIVE PACKET:C104(myDoc; aText1{7}; "\t")  //CANEMAIL
			RECEIVE PACKET:C104(myDoc; aText1{8}; "\t")  //CANSHIP
			RECEIVE PACKET:C104(myDoc; aText1{9}; "\t")  //VISIBLE
			RECEIVE PACKET:C104(myDoc; aText1{10}; "\t")  //OWNER
			RECEIVE PACKET:C104(myDoc; aText1{11}; "\t")  //WEIGHT
			RECEIVE PACKET:C104(myDoc; aText1{12}; "\t")  //QUANTITY
			RECEIVE PACKET:C104(myDoc; aText1{13}; "\t")  //TAG_LINE
			RECEIVE PACKET:C104(myDoc; aText1{14}; "\t")  //OTHER_INFO
			RECEIVE PACKET:C104(myDoc; aText1{15}; "\t")  //LONG_DESCRIPTION
			RECEIVE PACKET:C104(myDoc; aText1{16}; "\t")  //PICTURE
			RECEIVE PACKET:C104(myDoc; aText1{17}; "\t")  //BIG_PICTURE
			RECEIVE PACKET:C104(myDoc; aText1{18}; "\t")  //SECTIONS
			RECEIVE PACKET:C104(myDoc; aText1{19}; "\r")  //HEADER39
			//$cntRay:=19
			//C_TEXT($testText)
			//$testText:=""
			//For ($rayInc;1;$cntRay)
			//$testText:=$testText+aText1{$rayInc}+"\t"
			//End for 
			//SET TEXT TO CLIPBOARD($testText)
			If (vi5=1)
				aText1{1}:=TxtStripLineFeed(aText1{1})
				If (Length:C16(aText1{1})>2)
					QUERY:C277([Item:4]; [Item:4]itemNum:1=aText1{1})
					If (Records in selection:C76([Item:4])=0)
						CREATE RECORD:C68([Item:4])
						[Item:4]itemNum:1:=aText1{1}
						//[Item]Specification:=True
						//CREATE RECORD([ItemSpec])
						//
						//
						//[ItemSpec]ItemNum:=[Item]ItemNum
					End if 
					//zzz:=aText1{1}//SKU
					[Item:4]description:7:=aText1{2}  //DESCRIPTION
					[Item:4]mfrID:53:=aText1{3}  //COMPANY
					[Item:4]profile1:35:=aText1{4}  //TITLE
					[Item:4]priceA:2:=Num:C11(aText1{5})  //PRICE
					[Item:4]priceB:3:=Num:C11(aText1{5})  //PRICE
					[Item:4]priceC:4:=Num:C11(aText1{5})  //PRICE
					[Item:4]priceD:5:=Num:C11(aText1{5})  //PRICE
					[Item:4]taxID:17:=aText1{6}  //TAXABLE
					//zzz:=aText1{7}//CANEMAIL
					//zzz:=aText1{8}//CANSHIP
					//zzz:=aText1{9}//VISIBLE
					//zzz:=aText1{10}//OWNER
					[Item:4]weightAverage:8:=Num:C11(aText1{11})  //WEIGHT
					[Item:4]qtySaleDefault:15:=Num:C11(aText1{12})  //QUANTITY
					[Item:4]profile2:36:=aText1{13}  //TAG_LINE
					[Item:4]profile3:37:=aText1{14}  //OTHER_INFO
					[Item:4]descriptionDetail:66:=aText1{15}  //LONG_DESCRIPTION
					[Item:4]imagePathTn:114:=aText1{16}  //TN_PICTURE
					[Item:4]imagePath:104:=aText1{17}  //BIG_PICTURE
					[Item:4]profile4:38:=aText1{18}  //SECTIONS
					//zzz:=aText1{19}//HEADER39
					
					
					[Item:4]dtItemDate:33:=vi9
					SAVE RECORD:C53([Item:4])
					//SAVE RECORD([ItemSpec])
				End if 
			End if 
		Until (vi5=0)
		CLOSE DOCUMENT:C267(myDoc)
	End if 
End if 


If (False:C215)
	ARRAY TEXT:C222(aText1; 19)
	FIRST RECORD:C50([Item:4])
	vi2:=Records in selection:C76([Item:4])
	For (vi1; 1; vi2)
		aText1{1}:=[Item:4]itemNum:1
		aText1{2}:=[Item:4]description:7
		aText1{3}:=[Item:4]mfrID:53
		aText1{4}:=[Item:4]profile1:35
		aText1{5}:=String:C10([Item:4]priceA:2)
		aText1{5}:=String:C10([Item:4]priceB:3)
		aText1{5}:=String:C10([Item:4]priceC:4)
		aText1{5}:=String:C10([Item:4]priceD:5)
		aText1{6}:=[Item:4]taxID:17
		aText1{11}:=String:C10([Item:4]weightAverage:8)
		aText1{12}:=String:C10([Item:4]qtySaleDefault:15)
		aText1{13}:=[Item:4]profile2:36
		aText1{14}:=[Item:4]profile3:37
		aText1{15}:=[Item:4]descriptionDetail:66
		aText1{16}:=[Item:4]imagePathTn:114
		aText1{17}:=[Item:4]imagePath:104
		aText1{18}:=[Item:4]profile4:38
		vi9:=[Item:4]dtItemDate:33
		PUSH RECORD:C176([Item:4])
		aText1{1}:=TxtStripLineFeed(aText1{1})
		QUERY:C277([Item:4]; [Item:4]itemNum:1=aText1{1})
		If (Records in selection:C76=1)
			[Item:4]description:7:=aText1{2}  //DESCRIPTION
			[Item:4]mfrID:53:=aText1{3}  //COMPANY
			[Item:4]profile1:35:=aText1{4}  //TITLE
			[Item:4]priceA:2:=Num:C11(aText1{5})  //PRICE
			[Item:4]priceB:3:=Num:C11(aText1{5})  //PRICE
			[Item:4]priceC:4:=Num:C11(aText1{5})  //PRICE
			[Item:4]priceD:5:=Num:C11(aText1{5})  //PRICE
			[Item:4]taxID:17:=aText1{6}  //TAXABLE
			//zzz:=aText1{7}//CANEMAIL
			//zzz:=aText1{8}//CANSHIP
			//zzz:=aText1{9}//VISIBLE
			//zzz:=aText1{10}//OWNER
			[Item:4]weightAverage:8:=Num:C11(aText1{11})  //WEIGHT
			[Item:4]qtySaleDefault:15:=Num:C11(aText1{12})  //QUANTITY
			[Item:4]profile2:36:=aText1{13}  //TAG_LINE
			[Item:4]profile3:37:=aText1{14}  //OTHER_INFO
			[Item:4]descriptionDetail:66:=aText1{15}  //LONG_DESCRIPTION
			[Item:4]imagePathTn:114:=aText1{16}  //TN_PICTURE
			[Item:4]imagePath:104:=aText1{17}  //BIG_PICTURE
			[Item:4]profile4:38:=aText1{18}  //SECTIONS
			//zzz:=aText1{19}//HEADER39
			
			
			[Item:4]dtItemDate:33:=vi9
			SAVE RECORD:C53([Item:4])
			POP RECORD:C177([Item:4])
			[Item:4]description:7:="Delete"
			SAVE RECORD:C53([Item:4])
		Else 
			POP RECORD:C177([Item:4])
			[Item:4]profile6:94:="LeadChar"
			SAVE RECORD:C53([Item:4])
		End if 
		NEXT RECORD:C51([Item:4])
		
	End for 
End if 