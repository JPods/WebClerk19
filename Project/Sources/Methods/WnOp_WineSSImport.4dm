//%attributes = {"publishedWeb":true}
//If (False)
////Method: WnOp_WineSSImport
////Date: 07/01/02
////Who: Bill
////Description: 4 header rows
////Add three columns
////  1.  Winery Name
////  2.  WineryID
////  3.  Terminator
//End if 

//C_LONGINT(bImport; $myOK)
//BEEP
//ON ERR CALL("jOECNoAction")
//CLOSE DOCUMENT(myDoc)
//ON ERR CALL("")
//C_DATE($beginDate; $endDate)

//TRACE
//myDocName:=""
//$myOK:=EI_OpenDoc(->myDocName; ->myDoc; "Wine data to Import"; ""; Storage.folder.jitExportsF)
//If ($myOK=1)
//ARRAY TEXT($aValues; 50)
//// ARRAY TEXT($aName;50)
//C_LONGINT($i)
//C_TEXT($skipText)
////
//ARRAY TEXT($aLabels; 39)
//$aLabels{1}:="TTTNumber"
//$aLabels{2}:="TTTDescription"
//$aLabels{3}:="Vintage"
//$aLabels{4}:="Prime Drinking"
//$aLabels{5}:="Region"
//$aLabels{6}:="Appellation"
//$aLabels{7}:="Classification"
//$aLabels{8}:="Color"
//$aLabels{9}:="Grapes/blend"
//$aLabels{10}:="alcohol"
//$aLabels{11}:="size"
//$aLabels{12}:="TTTBottleWt"
//$aLabels{13}:="TTTBottles/case"
//$aLabels{14}:="TTTCaseWt"
//$aLabels{15}:="TTTEAN"
//$aLabels{16}:="TTTUPC"
//$aLabels{17}:="TTTBottleSuggestedRetail"
//$aLabels{18}:="TTTCaseSuggestedRetail"
//$aLabels{19}:="TTTBottleTypicalWholesale"
//$aLabels{20}:="TTTCaseTypicalWholesale"
//$aLabels{21}:="TTTWineryComment"
//$aLabels{22}:="TTTTastingNotes"
//$aLabels{23}:="TTTWineMakerComment"
//$aLabels{24}:="TTTReviews"
//$aLabels{25}:="TTTAwards"
//$aLabels{26}:="TTTblank"
//$aLabels{27}:="Dry/Sweet"
//$aLabels{28}:="Light/Full"
//$aLabels{29}:="Direct/Complex"
//$aLabels{30}:="Delicate/"
//$aLabels{31}:="Soft"
//$aLabels{32}:="Tannin"
//$aLabels{33}:="Oakiness"
//$aLabels{34}:="TTTempty"
//$aLabels{35}:="TTTURL to picture"
//$aLabels{36}:="TTTURL to site"
//$aLabels{37}:="Winery"
//$aLabels{38}:="MfgID"
//$aLabels{39}:="Terminator"
////
//Repeat 
//RECEIVE PACKET(myDoc; $skipText; "\r")  //1st Line, Instructions
//If (Character code($skipText)=10)
//$skipText:=Substring($skipText; 2)
//End if 
//Until ($skipText="Example@")
//$i:=0
//Repeat 
//$i:=$i+1
//MESSAGE(String($i))
//RECEIVE PACKET(myDoc; $aValues{1}; "\t")  //Number   
//RECEIVE PACKET(myDoc; $aValues{2}; "\t")  //Description, 4;7
//RECEIVE PACKET(myDoc; $aValues{3}; "\t")  //Year  4;35 
//If (($aValues{2}="") & ($aValues{3}=""))
//OK:=0
//End if 
//If (OK=1)
//RECEIVE PACKET(myDoc; $aValues{4}; "\t")  //Prime Drinking 
//RECEIVE PACKET(myDoc; $aValues{5}; "\t")  //Region  4;36
//RECEIVE PACKET(myDoc; $aValues{6}; "\t")  //Appellation  4;37
//RECEIVE PACKET(myDoc; $aValues{7}; "\t")  //Classification  31;8
//RECEIVE PACKET(myDoc; $aValues{8}; "\t")  //Color  4;38
//RECEIVE PACKET(myDoc; $aValues{9}; "\t")  //Grapes/blend  31;6
//RECEIVE PACKET(myDoc; $aValues{10}; "\t")  //%alcohol  31;25
//RECEIVE PACKET(myDoc; $aValues{11}; "\t")  //size  31;24
//RECEIVE PACKET(myDoc; $aValues{12}; "\t")  //BottleWt  4;8
//RECEIVE PACKET(myDoc; $aValues{13}; "\t")  //Bottles/case   4;84
//RECEIVE PACKET(myDoc; $aValues{14}; "\t")  //CaseWt  4;83
//RECEIVE PACKET(myDoc; $aValues{15}; "\t")  //EAN  4;82
//$aValues{15}:=Replace string($aValues{15}; "-"; "")
//RECEIVE PACKET(myDoc; $aValues{16}; "\t")  //UPC  4;34
//$aValues{16}:=Replace string($aValues{16}; "-"; "")
//RECEIVE PACKET(myDoc; $aValues{17}; "\t")  //BottleSuggestedRetail  4;2
//RECEIVE PACKET(myDoc; $aValues{18}; "\t")  //CaseSuggestedRetail 
//RECEIVE PACKET(myDoc; $aValues{19}; "\t")  //BottleTypicalWholesale  4;3
//RECEIVE PACKET(myDoc; $aValues{20}; "\t")  //CaseTypicalWholesale 
//RECEIVE PACKET(myDoc; $aValues{21}; "\t")  //WineryComment  31;15
//RECEIVE PACKET(myDoc; $aValues{22}; "\t")  //TastingNotes  31;2
//RECEIVE PACKET(myDoc; $aValues{23}; "\t")  //WineMakerComment  31;16
//RECEIVE PACKET(myDoc; $aValues{24}; "\t")  //Reviews  31;17
//RECEIVE PACKET(myDoc; $aValues{25}; "\t")  //Awards  31;18
//RECEIVE PACKET(myDoc; $aValues{26}; "\t")  //blank
//RECEIVE PACKET(myDoc; $aValues{27}; "\t")  //Dry/Sweet  31;22
//RECEIVE PACKET(myDoc; $aValues{28}; "\t")  //Light/Full   31;23
//RECEIVE PACKET(myDoc; $aValues{29}; "\t")  //Direct/Complex  31;30
//RECEIVE PACKET(myDoc; $aValues{30}; "\t")  //Delicate/   31;31
//RECEIVE PACKET(myDoc; $aValues{31}; "\t")  //Soft  31;32
//RECEIVE PACKET(myDoc; $aValues{32}; "\t")  //Tannin  31;33
//RECEIVE PACKET(myDoc; $aValues{33}; "\t")  //Oakiness  31;34   
//RECEIVE PACKET(myDoc; $aValues{34}; "\t")  //empty
//RECEIVE PACKET(myDoc; $aValues{35}; "\t")  //URL to picture
//RECEIVE PACKET(myDoc; $aValues{36}; "\t")  //URL to site 4;61
//RECEIVE PACKET(myDoc; $aValues{37}; "\t")  //Winery 31;
//RECEIVE PACKET(myDoc; $aValues{38}; "\t")  //MfgID 4;53
//RECEIVE PACKET(myDoc; $aValues{39}; "\r")  //Terminator


//REDUCE SELECTION([Item]; 0)
//REDUCE SELECTION([ItemSpec]; 0)
////
//vPartNum:=""
//If (Length($aValues{1})>3)  //ignor number and only if WineOps Item is referenced
//vText1:=$aValues{1}
//vText1:=Parse_UnWanted(vText1)
//$aValues{1}:=vText1
//QUERY([Item]; [Item]itemNum=vText1)
//If (vPartNum="")
//vPartNum:=vText1
//End if 
//End if 
//If ((Records in selection([Item])=0) & ($aValues{16}#""))  //UPC
//vText1:=$aValues{16}
//vText1:=Parse_UnWanted(vText1)
//$aValues{16}:=vText1
//QUERY([Item]; [Item]itemNum=vText1; *)
//QUERY([Item];  | [Item]barCode=vText1)
//If (vPartNum="")
//vPartNum:=vText1
//End if 
//End if 
//If ((Records in selection([Item])=0) & ($aValues{15}#""))  //EAN
//vText1:=$aValues{15}
//vText1:=Parse_UnWanted(vText1)
//$aValues{15}:=vText1
//QUERY([Item]; [Item]itemNum=vText1; *)
//QUERY([Item];  | [Item]ean=vText1)
//If (vPartNum="")
//vPartNum:=vText1
//End if 
//End if 
//If (Records in selection([Item])=0)
//CREATE RECORD([Item])
//Item_New(1; ""; "Wine"; 1; 1; 1; "")
//End if 
//QUERY([ItemSpec]; [ItemSpec]itemNum=$aValues{15})  //
//If (Records in selection([ItemSpec])=0)
//CREATE RECORD([ItemSpec])

//[ItemSpec]itemNum:=[Item]itemNum
//[Item]specification:=True
//End if 
////
//[Item]description:=$aValues{2}  //Description, 4;7
//[Item]profile1:=$aValues{3}  //Year  4;35
//[Item]dtItemDate:=DateTime_Enter(Date("01/01/"+[Item]profile1))
//[ItemSpec]profile4:=$aValues{4}  //Prime Drinking  31;8
//If (Length($aValues{4})>0)
//$pSep:=Position("-"; $aValues{4})
//If ($pSep>0)
//$beginDate:=Date("01/01/"+Substring($aValues{4}; 1; $pSep-1))
//$endDate:=Date("12/01/"+Substring($aValues{4}; $pSep+1))
//Else 
//$beginDate:=Date("01/01/"+$aValues{4})
//$endDate:=Date("12/01/"+Substring($aValues{4}; $pSep+1))
//End if 
//[Item]dtBestUseStart:=DateTime_Enter($beginDate)
//[Item]dtBestUseEnd:=DateTime_Enter($endDate)
//End if 
//[Item]profile2:=$aValues{5}  //Region  4;36
//[Item]profile3:=$aValues{6}  //Appellation  4;37
//[ItemSpec]profile3:=$aValues{7}  //Classification  31;8
//[Item]profile4:=$aValues{8}  //Color  4;38
//[ItemSpec]profile2:=$aValues{9}  //Grapes/blend  31;6
//[ItemSpec]profile21:=Num($aValues{10})  //%alcohol  31;25
//[ItemSpec]profile20:=Num($aValues{11})  //size  31;24
//[Item]weightAverage:=Num($aValues{12})  //BottleWt  4;8
//[Item]countBulk:=Num($aValues{13})  //Bottles/case   4;84
//[Item]weightBulk:=Num($aValues{14})  //CaseWt  4;83
//[Item]ean:=$aValues{15}  //EAN  4;82
//[Item]barCode:=$aValues{16}  //UPC  4;34
//[Item]priceA:=Num($aValues{17})  //SuggestedRetail  4;2
////Num($aValues{18})  //RetailCasePrice
//[Item]priceB:=Num($aValues{19})  //TypicalWholesale  4;3
////Num($aValues{20})    //WholesaleCasePrice
//[ItemSpec]profile11:=$aValues{21}  //WineryComment  31;15
//[ItemSpec]specification:=$aValues{22}  //TastingNotes  31;2
//[ItemSpec]profile12:=$aValues{23}  //WineMakerComment  31;16
//[ItemSpec]profile13:=$aValues{24}  //Reviews  31;17
//[ItemSpec]profile14:=$aValues{25}  //Awards  31;18
////$aValues{26}//empty

//[Item]indicator1:=Num($aValues{27})  //Dry/Sweet  31;22
//[Item]indicator2:=Num($aValues{28})  //Light/Full   31;23
//[Item]indicator3:=Num($aValues{29})  //Direct/Complex  31;30
//[Item]indicator4:=Num($aValues{30})  //Delicate/   31;31
//[Item]indicator5:=Num($aValues{31})  //Soft  31;32
//[Item]indicator6:=Num($aValues{32})  //Tannin  31;33
//[Item]indicator7:=Num($aValues{33})  //Oakiness  31;34
////
//[ItemSpec]profile18:=Num($aValues{27})  //Dry/Sweet  31;22
//[ItemSpec]profile19:=Num($aValues{28})  //Light/Full   31;23
//[ItemSpec]profile30:=Num($aValues{29})  //Direct/Complex  31;30
//[ItemSpec]profile31:=Num($aValues{30})  //Delicate/   31;31
//[ItemSpec]profile32:=Num($aValues{31})  //Soft  31;32
//[ItemSpec]profile33:=Num($aValues{32})  //Tannin  31;33
//[ItemSpec]profile34:=Num($aValues{33})  //Oakiness  31;34
////$aValues{34}//empty
//[ItemSpec]docReference:=$aValues{35}  //URL  4;61
//[Item]path:=$aValues{36}  //URL to Winery 4;61
//[ItemSpec]profile1:=$aValues{37}  //WineryName
//[Item]mfrID:=$aValues{38}  //WineryID, assigned by WineOps


//C_LONGINT($k; $fieldtype)
//$k:=Get last field number(->[Item])
//For ($i; 1; $k)
//$fieldtype:=Type(Field(4; $i)->)
//If (($fieldtype=0) | ($fieldtype=24))
//Parse_UnWanted(Field(4; $i))
//End if 
//End for 
//$k:=Get last field number(->[ItemSpec])
//For ($i; 1; $k)
//$fieldtype:=Type(Field(31; $i)->)
//If (($fieldtype=0) | ($fieldtype=24))
//Parse_UnWanted(Field(31; $i))
//End if 
//End for 
//For ($i; 1; $k)
//If ($aLabels{$i}#"TTT@")
//CREATE RECORD([Word])

//[Word]tableNum:=Table(->[Item])
//[Word]alternate:=[Item]itemNum
//[Word]reference:=$aLabels{$i}
//[Word]wordOnly:=$aValues{$i}
//[Word]wordCombined:=$aValues{$i}+$aLabels{$i}
//SAVE RECORD([Word])
//End if 
//End for 
//SAVE RECORD([ItemSpec])
//SAVE RECORD([Item])
//End if 
//Until (OK=0)
//CLOSE DOCUMENT(myDoc)
//End if 
////
//REDRAW WINDOW

////If (False)
////RECEIVE PACKET(myDoc;$aValues{30};vTab)//DateReceived  4;33
////RECEIVE PACKET(myDoc;$aValues{31};vTab)//DateReviewed  4;87
////RECEIVE PACKET(myDoc;$aValues{32};vTab)//Winery  31;5
////RECEIVE PACKET(myDoc;$aValues{33};vTab)//Year  31;38
////RECEIVE PACKET(myDoc;$aValues{34};vTab)//Stars  4;88
////RECEIVE PACKET(myDoc;$aValues{35};vTab)//Buyer_Ratings 4;89
////RECEIVE PACKET(myDoc;$aValues{36};vTab)//RaterCount 4;90
////RECEIVE PACKET(myDoc;$aValues{37};vCR)//RetailerRating 4;91
////RECEIVE PACKET(myDoc;$aValues{38};vCR)//RatingValue 4;92
////RECEIVE PACKET(myDoc;$aValues{38};vCR)//WineOps_SKU
////End if 