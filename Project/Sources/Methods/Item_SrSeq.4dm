//%attributes = {"publishedWeb":true}
//aText1{1}:="ItemNum Only"
//aText1{2}:="ItemNum then Barcode"
//aText1{3}:="ItemNum then Mfg Num"
//aText1{4}:="Item Num then Barcode then Mfg Num"
//aText1{5}:="Item Num then Mfg Num then Barcode"
////
//aText1{6}:="Barcode Only"
//aText1{7}:="Barcode then ItemNum"
//aText1{8}:="Barcode then Mfg Num"
//aText1{9}:="Barcode then ItemNum then Mfg Num"
//aText1{10}:="Barcode then Mfg Num then ItemNum"
////
//aText1{11}:="Mfg Num Only"
//aText1{12}:="Mfg Num then ItemNum"
//aText1{13}:="Mfg Num then Barcode"
//aText1{14}:="Mfg Num then ItemNum then Barcode"
//aText1{15}:="Mfg Num then Barcode then ItemNum"//
//
//aText1{16}:="ItemNum then VendorNum"
//aText1{17}:="ItemNum then VendorNum then Barcode"
//aText1{18}:="VendorNum then ItemNum"
//aText1{19}:="VendorNum then ItemNum then Barcode"
C_TEXT:C284($1)
If (<>keywordItemQuery=1)
	KeyWordByAlpha(Table:C252(->[Item:4]); $1; True:C214)
Else 
	// check if item is retired and ItemXRef replacement exists
	C_BOOLEAN:C305($vbSearch)
	$vbSearch:=True:C214
	
	QUERY BY FORMULA:C48([ItemXRef:22]; (\
		([Item:4]itemNum:1=[ItemXRef:22]ItemNumMaster:1)\
		 & ([ItemXRef:22]ItemNumMaster:1=$1)\
		 & ([ItemXRef:22]Relationship:27="Replacement")\
		 & ([Item:4]retired:64=True:C214)))
	
	If (Records in selection:C76([ItemXRef:22])>0)
		ARRAY TEXT:C222($atItemNums; 0)
		
		DISTINCT VALUES:C339([ItemXRef:22]ItemNumXRef:2; $atItemNums)
		QUERY WITH ARRAY:C644([Item:4]itemNum:1; $atItemNums)
		
		If (Records in selection:C76([Item:4])>0)
			$vbSearch:=False:C215  // skip standard search replacement Xref found
			C_TEXT:C284($vtReplacements)
			$vtReplacements:=""
			FIRST RECORD:C50([Item:4])
			$vi2:=Records in selection:C76([Item:4])
			For ($vi1; 1; $vi2)
				$vtReplacements:=$vtReplacements+"\r"+[Item:4]itemNum:1+" - "+Substring:C12([Item:4]description:7; 1; 32)+"..."
				If ($vi1<$vi2)
					NEXT RECORD:C51([Item:4])
				End if 
			End for 
			ALERT:C41("ERROR: "+$1+" IS RETIRED. \r\rRecomended Replacement(s):"+$vtReplacements)
		Else 
			ALERT:C41($1+" is Retired, No Recomennded Replacement")
		End if 
	End if 
	
	If ($vbSearch=True:C214)
		If (ShftKey=0)
			Item_SrRetireNot($1)
		Else 
			Item_SrRetire($1)
		End if 
	End if 
	
	
	If (<>tcSrItemDoXRefs)  //did the user request XRef searching in defaults?
		//search ItemXrefs for the entered item number, set-up any pricepoint info if ther
		pXRfPricePt:=""
		pXRfDescrp:=""
		If (Records in selection:C76([Item:4])=0)
			QUERY:C277([ItemXRef:22]; [ItemXRef:22]ItemNumXRef:2=$1)
			
			// ### jwm ### 20150914_1500 relate all XRefs 
			If (Records in selection:C76([ItemXRef:22])>0)
				ARRAY TEXT:C222($atItemNums; 0)
				DISTINCT VALUES:C339([ItemXRef:22]ItemNumMaster:1; $atItemNums)
				QUERY WITH ARRAY:C644([Item:4]itemNum:1; $atItemNums)
				If (ShftKey=0)
					QUERY SELECTION:C341([Item:4]; [Item:4]retired:64=False:C215)
				End if 
			End if 
			
			If (False:C215)
				If (Records in selection:C76([ItemXRef:22])=1)
					pXRfPricePt:=[ItemXRef:22]TypeSale:18
					pXRfDescrp:=[ItemXRef:22]DescriptionXRef:3
					QUERY:C277([Item:4]; [Item:4]itemNum:1=[ItemXRef:22]ItemNumMaster:1)
				End if 
			End if 
			
			
		End if 
	End if 
	
End if 