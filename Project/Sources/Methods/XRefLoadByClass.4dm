//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2015-12-16T00:00:00 Convert_2_v14)
// 
// If (False)
//   // Method: Method: XRefLoadByClass
// Version_0501 
//   //Date: 01/05/05
//   //Who: Bill
//   //Description: 
// End if 
// 
// 
// If (Count parameters=1)
// $filePath:=$1
// Else 
// $filePath:=""
// End if 
// 
// CLOSE DOCUMENT(myDoc)
// TRACE
// myDoc:=Open document($filePath)
// If (OK=1)
// C_TEXT($workingText)
// RECEIVE PACKET(myDoc;$workingText;<>vEoF)
// If (OK=1)
// CLOSE DOCUMENT(myDoc)
// XMLParseTags ($workingText)
//   //
// vText1:=$workingText
// $theMfgID:=WCapi_GetParameter(->vText1;"MfgID";"")
// If ($theMfgID="")
// $theMfgID:=WCapi_GetParameter(->vText1;"mfrID";"")
// End if 
// If ($theMfgID="")
// $theMfgID:=Request("Enter Manufacturer's ID")
// End if 
// vText1:=""
// $specText:=""
//   //
// $k:=Size of array(aXMLValue)
// array TEXT($aItemList;0)
// For ($i;$k;1;-1)
// Case of 
// : (aXMLTag{$i}="ItemNum")
// INSERT IN ARRAY($aItemList;1;1)
// $aItemList{1}:=aXMLValue{$i}+("-"*Num($theMfgID#""))+$theMfgID
// XMLArrayManagement (-1;$i;1)
// : (aXMLTag{$i}="meta@")
// XMLArrayManagement (-1;$i;1)
// : ((aXMLTag{$i}="lnComment@") | (aXMLTag{$i}="Comment@") | (aXMLTag{$i}="Specification@"))
// $specText:=$specText+"\r"+aXMLValue{$i}
// XMLArrayManagement (-1;$i;1)
// End case 
// End for 
// 
// 
//   //
// CREATE SET([Item];"Current")
// $k:=Size of array($aItemList)
// For ($i;1;$k)
// QUERY([Item];[Item]ItemNum=$aItemList{$i})
// If (Records in selection([Item])=0)
// CREATE RECORD([Item])
// [Item]ItemNum:=$aItemList{$i}
// [Item]Description:="Missing built by XRef"
// End if 
// [Item]mfrID:=$theMfgID
// [Item]Publish:=1
// [Item]QtySaleDefault:=1
// [Item]LIComment:=$specText
// SAVE RECORD([Item])
// ADD TO SET([Item];"Current")
//   //
// C_TEXT($curItemNum)
//   //
//   //Procedure: BOM_AddChildren
// C_LONGINT($i;$k;$curRecNum)
// C_TEXT($curItemNum)
// C_TEXT($curItemDesc)
// $curRecNum:=Record number([Item])
// $curItemNum:=[Item]ItemNum
// $curItemDesc:=[Item]Description
// $cntXRef:=Size of array(aXMLValue)
// If ($cntXRef>0)
// ALL SUBRECORDS([Item]RelatedDetails)
// $doRelated:=True
// $cntSubRec:=Records in sub_selection([Item]RelatedDetails)
// FIRST SUBRECORD([Item]RelatedDetails)
// For ($incSubRec;1;$cntSubRec)
// If (=22)
// $doRelated:=False
// End if 
// NEXT SUBRECORD([Item]RelatedDetails)
// End for 
// If ($doRelated)
// CREATE SUBRECORD([Item]RelatedDetails)
// :=22
// 
// SAVE RECORD([Item])
// End if 
// End if 
// For ($incXRef;1;$cntXRef)
// $itemNumMfg:=aXMLValue{$incXRef}+("-"*Num($theMfgID#""))+$theMfgID
// 
// $tagRelationship:=""
// $tagRelationship:=WCapi_GetParameter(->aXMLTag{$incXRef};"Relationship";"")
// If ($tagRelationship="")
// $tagRelationship:=aXMLTag{$incXRef}
// End if 
//   //        
// QUERY([Item];[Item]ItemNum=$itemNumMfg)
// If (Records in selection([Item])=0)
// CREATE RECORD([Item])
// [Item]ItemNum:=$itemNumMfg
// [Item]Description:="Missing built by XRef"
// [Item]Publish:=1
// [Item]DTSync:=DateTime_Enter 
// [Item]DTReviewed:=0
// [Item]mfrID:=$theMfgID
// [Item]MfrItemNum:=aXMLValue{$incXRef}
// SAVE RECORD([Item])
// End if 
//   //
// QUERY([ItemXRef];[ItemXRef]ItemNumMaster=$curItemNum;*)
// QUERY([ItemXRef]; & [ItemXRef]ItemNumXRef=$itemNumMfg;*)
// QUERY([ItemXRef]; & [ItemXRef]Relationship=$tagRelationship)
// Case of 
// : (Records in selection([ItemXRef])>1)
// DELETE SELECTION([ItemXRef])
// CREATE RECORD([ItemXRef])
// 
// : (Records in selection([ItemXRef])=1)
// Else 
// CREATE RECORD([ItemXRef])
// 
// End case 
// XRefItem_Fill ($curItemNum;$curItemDesc)
// [ItemXRef]Relationship:=$tagRelationship
// SAVE RECORD([ItemXRef])
// End for 
// QUERY([ItemXRef];[ItemXRef]ItemNumMaster=$curItemNum)
// ORDER BY([ItemXRef];[ItemXRef]Relationship;[ItemXRef]ItemNumXRef)
// $cntXRef:=Records in selection([ItemXRef])
// FIRST RECORD([ItemXRef])
// For ($incXRef;1;$cntXRef)
// [ItemXRef]Sequence:=$incXRef
// SAVE RECORD([ItemXRef])
// NEXT RECORD([ItemXRef])
// End for 
// End for 
// USE SET("Current")
// CLEAR SET("Current")
// End if 
// End if 
// 