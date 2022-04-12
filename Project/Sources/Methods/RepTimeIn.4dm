//%attributes = {}
//// ----------------------------------------------------
//// User name (OS): williamjames
//// Date and time: 12/28/11, 08:57:06
//// ----------------------------------------------------
//// Method: Method: RepTimeIn
//// Description
//// 
////
//// Parameters
//// ----------------------------------------------------


//If (False)
//myDoc:=Open document("")
//If (OK=1)
//CLOSE DOCUMENT(myDoc)
//$myPathIn:=HFS_ParentName(document)
//ARRAY TEXT($aListDocuments; 0)
//DOCUMENT LIST($myPathIn; $aListDocuments)
//End if 
//$k:=Size of array($aListDocuments)
//$theDocuments:=""
//For ($i; 1; $k)
//$theDocuments:=$theDocuments+$aListDocuments{$i}+"\r"
//End for 
//SET TEXT TO PASTEBOARD($theDocuments)
//End if 
//$myPathOut:=Storage.folder.jitF
////If there is not a data exchange folder create one
//C_TEXT($myPathOut; $myPathIn; $myPathCompleted; $myPathOut)
//C_LONGINT($result)
//$myPathOut:=Storage.folder.jitF+"RepTimeFromWebClerk"+Folder separator
//$result:=Test path name($myPathOut)
//If ($result#0)
//CREATE FOLDER($myPathOut)
//End if 
//$myPathIn:=Storage.folder.jitF+"RepTime2WebClerk"+Folder separator
//$result:=Test path name($myPathIn)
//If ($result#0)
//CREATE FOLDER($myPathIn)
//End if 
//$myPathCompleted:=Storage.folder.jitF+"RepTime2WebClerk"+Folder separator+"Completed"+Folder separator
//$result:=Test path name($myPathCompleted)
//If ($result#0)
//CREATE FOLDER($myPathCompleted)
//End if 
//$myPathCompleted:=Storage.folder.jitF+"RepTime2WebClerk"+Folder separator+"Completed"+Folder separator+Date_strYyyymmdd(Current date)+Replace string(Time string(Current time); ":"; "")+Folder separator
//$result:=Test path name($myPathCompleted)
//If ($result#0)
//CREATE FOLDER($myPathCompleted)
//End if 
////
//$myPathRejected:=Storage.folder.jitF+"RepTime2WebClerk"+Folder separator+"Rejected"+Folder separator
//$result:=Test path name($myPathRejected)
//If ($result#0)
//CREATE FOLDER($myPathRejected)
//End if 

//If (False)
//ARRAY TEXT($aFolderDocuments; 0)
////

//ARRAY TEXT($aListDocuments; 0)
//ARRAY TEXT($aInDocuments; 0)
//ARRAY TEXT($aOutDocuments; 0)
//ARRAY TEXT($aInScripts; 0)
//ARRAY TEXT($aOutScripts; 0)
//ARRAY TEXT($aRecordScript; 0)
//ARRAY LONGINT($aTallyRecordNum; 0)

//DOCUMENT LIST($myPathIn; $aFolderDocuments)
//QUERY([TallyMaster]; [TallyMaster]purpose="RepTimeOut")
//SELECTION TO ARRAY([TallyMaster]name; $aListDocuments; [TallyMaster]profile1; $aInDocuments; [TallyMaster]profile2; $aOutDocuments; [TallyMaster]build; $aOutScripts; [TallyMaster]after; $aInScripts; [TallyMaster]script; $aRecordScript; [TallyMaster]; $aTallyRecordNum)
//$k:=Size of array($aFolderDocuments)
//ARRAY LONGINT($aTallyRecordNum; Size of array($aListDocuments))
//For ($i; 1; $k)
//$w:=Find in array($aListDocuments; $aFolderDocuments{$i})
//If ($w<0)
//APPEND TO ARRAY($aListDocuments; $aFolderDocuments{$i})
//APPEND TO ARRAY($aInDocuments; "in")
//APPEND TO ARRAY($aOutDocuments; "")
//APPEND TO ARRAY($aInScripts; "")
//APPEND TO ARRAY($aOutScripts; "")
//APPEND TO ARRAY($aRecordScript; "")
//APPEND TO ARRAY($aTallyRecordNum; -1)
//Else 
//$aInDocuments{$w}:="in"
//End if 
//End for 

//End if 
//C_TEXT($myTextVar)
//C_TIME(myDoc)
//C_TEXT($xml_Struct_Ref)
//CREATE RECORD([TallyResult])

//[TallyResult]dtCreated:=DateTime_Enter
//$resetbEDIPass:=allowAlerts_boo
//allowAlerts_boo:=False



////if(find in array($aListDocuments;"export_category.xml")>0)
////
////if(find in array($aListDocuments;"export_custcontact.xml")>0)
////if(find in array($aListDocuments;"export_custnumber.xml")>0)
////if(find in array($aListDocuments;"export_custsales.xml")>0)
////if(find in array($aListDocuments;"export_division.xml")>0)
////if(find in array($aListDocuments;"export_globaloptions.xml")>0)
////
////if(find in array($aListDocuments;"export_ordercode.xml")>0)

////if(find in array($aListDocuments;"export_sales.xml")>0)
////if(find in array($aListDocuments;"export_seasonalname.xml")>0)
////if(find in array($aListDocuments;"export_shipvia.xml")>0)
////if(find in array($aListDocuments;"export_terms.xml")>0)
////if(find in array($aListDocuments;"export_territory.xml")>0)
////if(find in array($aListDocuments;"export_territoryname.xml")>0)
////if(find in array($aListDocuments;"export_users.xml")>0)
//$doIn:=True
//allowAlerts_boo:=False

//C_LONGINT($myOK)
//$myDocName:=$myPathIn+"export_mfct.xml"
//If (Test path name($myDocName)=1)
//$myOK:=UTLoadDoc2Array($myDocName; ->aText1)
//If ($myOK=1)
//UTWorkingTextFromArray(->vText1; ->aText1; 14000)
//C_LONGINT($foundTagBegin; $foundTagEnd)
//$tagName:="<Manufacturer>"
//$tagNameEnd:="</Manufacturer>"
//$tagLength:=Length($tagName)
//$foundTagBegin:=Position($tagName; vText1)
//While ((Size of array(aText1)>0) | ($foundTagBegin>0))
//UTWorkingTextFromArray(->vText1; ->aText1; 14000)
//vText1:=Substring(vText1; $foundTagBegin+$tagLength)
//$foundTagEnd:=Position($tagNameEnd; vText1)
//$workingText:=Substring(vText1; 1; $foundTagEnd-1)
//XMLParseTags($workingText)
//If (Size of array(aXMLTag)>0)
//$doItem:=False
//$foundelement:=Find in array(aXMLTag; "Mfg4Letter")
//If ($foundelement>0)

//QUERY([Customer]; [Customer]customerID=aXMLValue{$foundelement})
//If (Records in selection([Customer])=0)
//CREATE RECORD([Customer])
//[Customer]customerID:=aXMLValue{$foundelement}
//DBCustomer_init
//End if 
//If (False)  //do in the 
//XMLFillFieldValue("FullName"; ->[ManufacturerTerm]company)
//XMLFillFieldValue("Mfg4Letter"; ->[ManufacturerTerm]customerID)
//[ManufacturerTerm]terms:=[Customer]terms
//SAVE RECORD([ManufacturerTerm])
//End if 
//UtFillIfTargetIsEmpty(->[Customer]adSource; "RepTime")
//UtFillIfTargetIsEmpty(->[Customer]prospect; "Mfr")
//UtFillIfTargetIsEmpty(->[Customer]prospect; "Mfr")
////
//XMLFillFieldValue("FullName"; ->[Customer]company)
//XMLFillFieldValue("Mfg4Letter"; ->[Customer]customerID)
//XMLFillFieldValue("Address1"; ->[Customer]address1)
//XMLFillFieldValue("Address2"; ->[Customer]address2)
//XMLFillFieldValue("City"; ->[Customer]city)
//XMLFillFieldValue("StateProv"; ->[Customer]state)
//XMLFillFieldValue("ZipPostal"; ->[Customer]zip)
//XMLFillFieldValue("Phone"; ->[Customer]phone)

//SAVE RECORD([Customer])

//MFG_AssignCode
//Else 
//[TallyResult]textBlk1:=[TallyResult]textBlk1+"Manufacturer tag found: "+"\r"
//End if 
//End if 
//$foundTagBegin:=Position($tagName; vText1)
//End while 
//End if 
//CLOSE DOCUMENT(myDoc)
//MOVE DOCUMENT($myDocName; $myPathCompleted+"export_mfct.xml")
//End if 

//$myDocName:=$myPathIn+"export_cust.xml"
//If (Test path name($myDocName)=1)
//C_LONGINT($myOK)
//$myOK:=UTLoadDoc2Array($myDocName; ->aText1)
//If ($myOK=1)
//UTWorkingTextFromArray(->vText1; ->aText1; 14000)
//C_LONGINT($foundTagBegin; $foundTagEnd)
//$tagName:="<Customer>"
//$tagNameEnd:="</Customer>"
//$tagLength:=Length($tagName)
//$foundTagBegin:=Position($tagName; vText1)
//While ((Size of array(aText1)>0) | ($foundTagBegin>0))
//UTWorkingTextFromArray(->vText1; ->aText1; 14000)
//vText1:=Substring(vText1; $foundTagBegin+$tagLength)
//$foundTagEnd:=Position($tagNameEnd; vText1)
//$workingText:=Substring(vText1; 1; $foundTagEnd-1)
//XMLParseTags($workingText)
//If (Size of array(aXMLTag)>0)
//$foundelement:=Find in array(aXMLTag; "customerID")
//If ($foundelement>0)
//QUERY([Customer]; [Customer]customerID=aXMLValue{$foundelement})
//If (Records in selection([Customer])=0)
//CREATE RECORD([Customer])
//[Customer]customerID:=aXMLValue{$foundelement}
//DBCustomer_init
//End if 
//XMLFillFieldValue("CustomerName"; ->[Customer]company)
//XMLFillFieldValue("Address1"; ->[Customer]address1)
//XMLFillFieldValue("Address2"; ->[Customer]address2)
//XMLFillFieldValue("City"; ->[Customer]city)
//XMLFillFieldValue("StateProv"; ->[Customer]state)
//XMLFillFieldValue("ZipPostal"; ->[Customer]zip)
//XMLFillFieldValue("PrimaryPhone"; ->[Customer]phone)
//XMLFillFieldValue("ShipEmail"; ->[Customer]email)
//XMLFillFieldValue("BillEmail"; ->[Customer]profile1)
//XMLFillFieldValue("ShipPhone"; ->[Customer]phoneCell)
//XMLFillFieldValue("ShipFAX"; ->[Customer]fax)
//XMLFillFieldValue("ShipEmail"; ->[Customer]email)
//XMLFillFieldValue("BillEmail"; ->[Customer]profile1)
//XMLFillFieldValue("BillPhone"; ->[Customer]profile2)
//XMLFillFieldValue("BillFax"; ->[Customer]profile3)
//XMLFillFieldValue("SalesmanName"; ->[Customer]repID)
//XMLFillFieldValue("SalesmanName"; ->[Customer]salesNameID)
//XMLFillFieldValue("TermList"; ->[Customer]terms)
////
//UtFillIfTargetIsEmpty(->[Customer]phone; [Customer]phoneCell)
//UtFillIfTargetIsEmpty(->[Customer]email; [Customer]profile1)
//UtFillIfTargetIsEmpty(->[Customer]typeSale; "Wholesale")
//UtFillIfTargetIsEmpty(->[Customer]terms; "Same")
//UtFillIfTargetIsEmpty(->[Customer]prospect; "Mfr")
//UtFillIfTargetIsEmpty(->[Customer]dateOpened; "01/01/11")
//UtFillIfTargetIsEmpty(->[Customer]adSource; "Legacy")
//[Customer]dateLastUpdated:=Current date

//SAVE RECORD([Customer])
////
//$newContact:=False
//If ([Customer]contactShipTo>0)
//QUERY([Contact]; [Contact]idNum=[Customer]contactShipTo)
//If (Records in selection([Contact])=0)
//$newContact:=True
//End if 
//Else 
//$newContact:=True
//End if 
//If ($newContact)
//CREATE RECORD([Contact])

//Contact_FillFrom(->[Customer])
//[Customer]contactShipTo:=[Contact]idNum
//End if 
//XMLFillFieldValue("ShipEmail"; ->[Contact]email)
//XMLFillFieldValue("ShipPhone"; ->[Contact]phone)
//XMLFillFieldValue("ShipFax"; ->[Contact]fax)
//SAVE RECORD([Contact])
////
//If ([Customer]contactBillTo>0)
//QUERY([Contact]; [Contact]idNum=[Customer]contactBillTo)
//If (Records in selection([Contact])=1)
//$doContact:=True
//End if 
//Else 
//$doContact:=True
//End if 
//If ($newContact)
//CREATE RECORD([Contact])

//Contact_FillFrom(->[Customer])
//[Customer]contactBillTo:=[Contact]idNum
//End if 
//XMLFillFieldValue("BillCustomerName"; ->[Contact]company)
//XMLFillFieldValue("BillAddress1"; ->[Contact]address1)
//XMLFillFieldValue("BillAddress2"; ->[Contact]address2)
//XMLFillFieldValue("BillCity"; ->[Contact]city)
//XMLFillFieldValue("BillStateProv"; ->[Contact]state)
//XMLFillFieldValue("BillZipPostal"; ->[Contact]zip)
//XMLFillFieldValue("BillPhone"; ->[Contact]phone)
//XMLFillFieldValue("BillFax"; ->[Contact]fax)
//XMLFillFieldValue("BillEmail"; ->[Contact]email)
//SAVE RECORD([Contact])
////

//End if 
//End if 
//$foundTagBegin:=Position($tagName; vText1)
//End while 
//End if 
//CLOSE DOCUMENT(myDoc)
//MOVE DOCUMENT($myDocName; $myPathCompleted+"export_cust.xml")
//End if 

//$myDocName:=$myPathIn+"export_cat.xml"
//If (Test path name($myDocName)=1)
//C_LONGINT($myOK)
//$myOK:=UTLoadDoc2Array($myDocName; ->aText1)
//If ($myOK=1)
//UTWorkingTextFromArray(->vText1; ->aText1; 14000)
//C_LONGINT($foundTagBegin; $foundTagEnd)
//$tagName:="<Item>"
//$tagNameEnd:="</Item>"
//$tagLength:=Length($tagName)
//$foundTagBegin:=Position($tagName; vText1)
//While ((Size of array(aText1)>0) | ($foundTagBegin>0))
//UTWorkingTextFromArray(->vText1; ->aText1; 14000)
//vText1:=Substring(vText1; $foundTagBegin+$tagLength)
//$foundTagEnd:=Position($tagNameEnd; vText1)
//$workingText:=Substring(vText1; 1; $foundTagEnd-1)
//XMLParseTags($workingText)
//If (Size of array(aXMLTag)>0)
//$doItem:=False
//$foundelement:=Find in array(aXMLTag; "ItemNum")
//If ($foundelement>0)
//$mfrItemNum:=aXMLValue{$foundelement}
//$foundelement:=Find in array(aXMLTag; "MfctName")
//If ($foundelement>0)
//$mfrName:=aXMLValue{$foundelement}
//QUERY([ManufacturerTerm]; [ManufacturerTerm]company=$mfrName)
//If (Records in selection([ManufacturerTerm])=1)
//$doItem:=True
//Else 
//[TallyResult]textBlk1:=[TallyResult]textBlk1+$mfrItemNum+" MfrNF "+$mfrName+"\r"
//End if 
//Else 
//[TallyResult]textBlk1:=[TallyResult]textBlk1+"Manufacturer tag found: "+"\r"
//End if 
//Else 
//[TallyResult]textBlk1:=[TallyResult]textBlk1+"ItemNum tag not found"+"\r"
//End if 
//$doItem:=True
//C_TEXT($myCompanyID)
//If (([ManufacturerTerm]customerID="") | ($mfrName#[ManufacturerTerm]company))
//Repeat 
//$myCompanyID:=Request("Enter Mfr Company Name for: "; $mfrName)
//QUERY([ManufacturerTerm]; [ManufacturerTerm]customerID=$myCompanyID)

//Until (($mfrName=[ManufacturerTerm]company) | ($myCompanyID="giveup@"))
//End if 

//If (($doItem) & ($myCompanyID#"giveup@"))
//$itemNum:=$mfrItemNum+"_"+[ManufacturerTerm]customerID
//QUERY([Item]; [Item]itemNum=$itemNum)
//If (Records in selection([Item])=0)
//CREATE RECORD([Item])
//[Item]itemNum:=$itemNum
//Item_New(0; $itemNum; ""; 1; 1)
//End if 
//XMLFillFieldValue("MfctName"; ->[Item]mfrName)
//XMLFillFieldValue("ItemNum"; ->[Item]mfrItemNum)
//XMLFillFieldValue("Description"; ->[Item]description)
//XMLFillFieldValue("Minimum"; ->[Item]qtySaleDefault)
//XMLFillFieldValue("UnitPrice"; ->[Item]priceD)
//XMLFillFieldValue("ProductCode"; ->[Item]barCode)
////
//[Item]description:=Parse_UnWanted([Item]description)
//[Item]mfrID:=[ManufacturerTerm]customerID
//[Item]mfrName:=[ManufacturerTerm]company  //put the Mfr Name into the Item
////
//[Item]vendorItemNum:=[Item]mfrID+[Item]mfrItemNum
//UtFillIfTargetIsEmpty(->[Item]vendorID; [Item]mfrID)

//[Item]dtReviewed:=DateTime_Enter(Current date)

//UtFillIfTargetIsEmpty(->[Item]publish; "1")
////
//[Item]location:=[ManufacturerTerm]locationid
//[Item]qtyBundleSell:=[Item]qtySaleDefault

//UtFillIfTargetIsEmpty(->[Item]notTracked; "t")
//UtFillIfTargetIsEmpty(->[Item]tallyByType; "t")
////*Complete_Costs_DPrice  (script)
//UtFillIfTargetIsEmpty(->[Item]costAverage; String(Round([Item]priceD; 2)))
//UtFillIfTargetIsEmpty(->[Item]costLastInShip; String(Round([Item]priceD; 2)))
//UtFillIfTargetIsEmpty(->[Item]costMSC; String(Round([Item]priceD; 2)))
//UtFillIfTargetIsEmpty(->[Item]dateLastCost; String(Current date))
//[Item]priceD:=Round([Item]priceD; 2)
//UtFillIfTargetIsEmpty(->[Item]priceA; String([Item]priceD))
//UtFillIfTargetIsEmpty(->[Item]priceB; String([Item]priceD))
//UtFillIfTargetIsEmpty(->[Item]priceC; String([Item]priceD))
////

////
//SAVE RECORD([Item])
//Else 
////log the problem
//End if 
//End if 
//$foundTagBegin:=Position($tagName; vText1)
//End while 
//End if 
//CLOSE DOCUMENT(myDoc)
//MOVE DOCUMENT($myDocName; $myPathCompleted+"export_cat.xml")
//End if 


//$myDocName:=$myPathIn+"export_pricestructure.xml"
//If (Test path name($myDocName)=1)
//C_LONGINT($myOK)
//$myOK:=UTLoadDoc2Array($myDocName; ->aText1)
//If ($myOK=1)
//UTWorkingTextFromArray(->vText1; ->aText1; 14000)
//C_LONGINT($foundTagBegin; $foundTagEnd)
//$tagName:="<PriceStructure>"
//$tagNameEnd:="</PriceStructure>"
//$tagLength:=Length($tagName)
//$foundTagBegin:=Position($tagName; vText1)
//While ((Size of array(aText1)>0) | ($foundTagBegin>0))
//UTWorkingTextFromArray(->vText1; ->aText1; 14000)
//vText1:=Substring(vText1; $foundTagBegin+$tagLength)
//$foundTagEnd:=Position($tagNameEnd; vText1)
//$workingText:=Substring(vText1; 1; $foundTagEnd-1)
//XMLParseTags($workingText)
//If (Size of array(aXMLTag)>0)
//$doItem:=False
//$doItem:=True  //force everything to be processed
//$foundelement:=Find in array(aXMLTag; "ItemNum")
//If ($foundelement>0)
//$mfrItemNum:=aXMLValue{$foundelement}
//$foundelement:=Find in array(aXMLTag; "MfctName")
//If ($foundelement>0)
//$mfrName:=aXMLValue{$foundelement}
//QUERY([ManufacturerTerm]; [ManufacturerTerm]company=$mfrName)
//If (Records in selection([ManufacturerTerm])=1)

//Else 
//[TallyResult]textBlk1:=[TallyResult]textBlk1+"MfrRecNF: "+$mfrName+"\r"
//End if 
//Else 
//[TallyResult]textBlk1:=[TallyResult]textBlk1+"MfrCoNF: "+$mfrItemNum+"\r"
//End if 
//Else 
//[TallyResult]textBlk1:=[TallyResult]textBlk1+"ItemNumTagNF:"+"\r"
//End if 

//$doItem:=True
//C_TEXT($myCompanyID)
//If (([ManufacturerTerm]customerID="") | ($mfrName#[ManufacturerTerm]company))
//Repeat 
//$myCompanyID:=Request("Enter Mfr Company Name for: "; $mfrName)
//QUERY([ManufacturerTerm]; [ManufacturerTerm]customerID=$myCompanyID)

//Until (($mfrName=[ManufacturerTerm]company) | ($myCompanyID="giveup@"))
//End if 


//If (($doItem) & ($myCompanyID#"giveup@"))

//C_REAL($theMin; $theMax)
//CREATE RECORD([PriceMatrix])

//[PriceMatrix]typeSale:="Wholesale"
////
//XMLFillFieldValue("MfctName"; ->[PriceMatrix]nameID)
//XMLFillFieldValue("ItemNum"; ->[PriceMatrix]itemNum)
//If ([ManufacturerTerm]customerID#"")
//[PriceMatrix]itemNum:=[PriceMatrix]itemNum+"_"+[ManufacturerTerm]customerID
//[PriceMatrix]vendorID:=[ManufacturerTerm]customerID
//Else 
//[PriceMatrix]itemNum:=[PriceMatrix]itemNum+"_"+"ZZZ"
//[PriceMatrix]vendorID:="ZZZ"
//End if 
//XMLFillFieldValue("LowRange"; ->[PriceMatrix]quantityMin)
//XMLFillFieldValue("HighRange"; ->[PriceMatrix]quantityMax)
//XMLFillFieldValue("Price"; ->[PriceMatrix]price)
//SAVE RECORD([PriceMatrix])
////
//Else 
////log the problem
//End if 
//End if 
//$foundTagBegin:=Position($tagName; vText1)
//End while 
//End if 
//CLOSE DOCUMENT(myDoc)
//MOVE DOCUMENT($myDocName; $myPathCompleted+"export_pricestructure.xml")
//End if 



//$myDocName:=$myPathIn+"export_sizecolorstyle.xml"
//If (Test path name($myDocName)=1)
//C_LONGINT($myOK)
//$myOK:=UTLoadDoc2Array($myDocName; ->aText1)
//If ($myOK=1)
//UTWorkingTextFromArray(->vText1; ->aText1; 14000)
//C_LONGINT($foundTagBegin; $foundTagEnd)
//$tagName:="<PriceStructure>"
//$tagNameEnd:="</PriceStructure>"
//$tagLength:=Length($tagName)
//$foundTagBegin:=Position($tagName; vText1)
//While ((Size of array(aText1)>0) | ($foundTagBegin>0))
//UTWorkingTextFromArray(->vText1; ->aText1; 14000)
//vText1:=Substring(vText1; $foundTagBegin+$tagLength)
//$foundTagEnd:=Position($tagNameEnd; vText1)
//$workingText:=Substring(vText1; 1; $foundTagEnd-1)
//XMLParseTags($workingText)
//If (Size of array(aXMLTag)>0)
//$doItem:=False
//$doItem:=True  //force everything to be processed
//$foundelement:=Find in array(aXMLTag; "ItemNum")
//If ($foundelement>0)
//$mfrItemNum:=aXMLValue{$foundelement}
//$foundelement:=Find in array(aXMLTag; "MfctName")
//If ($foundelement>0)
//$mfrName:=aXMLValue{$foundelement}
//QUERY([ManufacturerTerm]; [ManufacturerTerm]company=$mfrName)
//If (Records in selection([ManufacturerTerm])=1)

//Else 
//[TallyResult]textBlk1:=[TallyResult]textBlk1+"MfrRecNF: "+$mfrName+"\r"
//End if 
//Else 
//[TallyResult]textBlk1:=[TallyResult]textBlk1+"MfrCoNF: "+$mfrItemNum+"\r"
//End if 
//Else 
//[TallyResult]textBlk1:=[TallyResult]textBlk1+"ItemNumTagNF:"+"\r"
//End if 

//$doItem:=True
//C_TEXT($myCompanyID)
//If (([ManufacturerTerm]customerID="") | ($mfrName#[ManufacturerTerm]company))
//Repeat 
//$myCompanyID:=Request("Enter Mfr Company Name for: "; $mfrName)
//QUERY([ManufacturerTerm]; [ManufacturerTerm]customerID=$myCompanyID)

//Until (($mfrName=[ManufacturerTerm]company) | ($myCompanyID="giveup@"))
//End if 


//If (($doItem) & ($myCompanyID#"giveup@"))

//C_REAL($theMin; $theMax)
//CREATE RECORD([PriceMatrix])

//[PriceMatrix]typeSale:="Wholesale"
////
//XMLFillFieldValue("MfctName"; ->[PriceMatrix]nameID)
//XMLFillFieldValue("ItemNum"; ->[PriceMatrix]itemNum)
//If ([ManufacturerTerm]customerID#"")
//[PriceMatrix]itemNum:=[PriceMatrix]itemNum+"_"+[ManufacturerTerm]customerID
//[PriceMatrix]vendorID:=[ManufacturerTerm]customerID
//Else 
//[PriceMatrix]itemNum:=[PriceMatrix]itemNum+"_"+"ZZZ"
//[PriceMatrix]vendorID:="ZZZ"
//End if 
//XMLFillFieldValue("LowRange"; ->[PriceMatrix]quantityMin)
//XMLFillFieldValue("HighRange"; ->[PriceMatrix]quantityMax)
//XMLFillFieldValue("Price"; ->[PriceMatrix]price)
//SAVE RECORD([PriceMatrix])
////
//Else 
////log the problem
//End if 
//End if 
//$foundTagBegin:=Position($tagName; vText1)
//End while 
//End if 
//CLOSE DOCUMENT(myDoc)
//MOVE DOCUMENT($myDocName; $myPathCompleted+"export_pricestructure.xml")


//End if 


//If (False)
//vi2:=Records in selection([Customer])
//FIRST RECORD([Customer])
//For (vi1; 1; vi2)
//QUERY([Rep]; [Rep]repID=[Customer]customerID)
//If (Records in selection([Rep])=0)
//CREATE RECORD([Rep])
//[Rep]repID:=[Customer]customerID
//[Rep]company:=[Customer]company
//[Rep]email:=[Customer]email
//[Rep]nameFirst:=[Customer]nameFirst
//[Rep]nameLast:=[Customer]nameLast
//[Rep]phone:=[Customer]phone
//SAVE RECORD([Rep])
//QUERY([RemoteUser]; [RemoteUser]customerID=[Rep]repID; *)
//QUERY([RemoteUser];  & [RemoteUser]tableNum=Table(->[Rep]))
//If (Records in selection([RemoteUser])=0)
//RemoteUser_Create(->[Rep]; [Rep]repID; "111"; 5)
//End if 
//End if 
//NEXT RECORD([Customer])
//End for 
//End if 

