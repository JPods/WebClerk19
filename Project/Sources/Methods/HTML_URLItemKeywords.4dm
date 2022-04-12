//%attributes = {"publishedWeb":true}
// Modified by: Bill James (2015-12-16T00:00:00: qqqWords TestThis)

// 
// If (False)
//   //Method: HTML_URLItemKeywords
//   //Date: 07/07/02
//   //Who: Bill James
//   //Description: Change to java script compliant
// VERSION_960 
// End if 
//   //TRACE
// KeyModifierCurrent 
// If (CapKey=1)
// testDoc:=create document(Storage.folder.jitF+"test"+String(DateTime_Enter)+".txt")
// End if 
// C_Longint($err)
// C_TEXT($confirmStr;$docStr;$URLStr)
// If (Size of array(aFieldLns)=0)
// ALERT("Select the Profile, Manufacturer or Vendor field.")
// Else 
// $doThis:=True
// Case of 
// : (theFldNum{aFieldLns{1}}=45)  //VendorID
// $confirmStr:="Vendor ID"
// $docStr:="ViD"
// $URLStr:="VendorID"
// $ptField:=(->[Item]VendorID)
// : (theFldNum{aFieldLns{1}}=53)  //MfgId
// $confirmStr:="Manufacturer ID"
// $docStr:="MiD"
// $URLStr:="MfgID"
// $ptField:=(->[Item]mfrID)
// : (theFldNum{aFieldLns{1}}=26)  //typeID
// $confirmStr:="Type ID"
// $docStr:="TiD"
// $URLStr:="typeID"
// $ptField:=(->[Item]typeID)
// : (theFldNum{aFieldLns{1}}=35)  //Pro1
// $confirmStr:="Item Profile 1"
// $docStr:="P1"
// $URLStr:="Profile1"
// $ptField:=(->[Item]Profile1)
// : (theFldNum{aFieldLns{1}}=36)  //Pro2
// $confirmStr:="Item Profile 2"
// $docStr:="P2"
// $URLStr:="Profile2"
// $ptField:=(->[Item]Profile2)
// : (theFldNum{aFieldLns{1}}=37)  //Pro3
// $confirmStr:="Item Profile 3"
// $docStr:="P3"
// $URLStr:="Profile3"
// $ptField:=(->[Item]Profile3)
// : (theFldNum{aFieldLns{1}}=38)  //Pro4
// $confirmStr:="Item Profile 4"
// $docStr:="P4"
// $URLStr:="Profile4"
// $ptField:=(->[Item]Profile4)
// Else 
// $doThis:=False
// ALERT("You must select an Item Profile or MfgID or VendorID")
// End case 
// If ($doThis)
// CONFIRM("Make/Replace Keyword Pages by "+$confirmStr+"?")
// If (OK=1)
// 
// Case of 
// : (CmdKey=1)
// ARRAY TEXT($aBaseCat;1)
// $aBaseCat{1}:=Request("Update only "+$confirmStr+" with value: ";"")
// $catCount:=Num(OK=1)
// 
// 
// 
// 
// Else 
// C_TIME($testDoc)
// 
//   //
// <>userTag:=""
// QUERY([Item];$ptField->#"";*)
// QUERY([Item]; & [Item]Publish>0)
//   // ORDER BY([Item];$ptField->)  managed in array
// C_POINTER(ptField;$ptField)
// ptField:=$ptField
// ARRAY TEXT($aBaseCat;0)
// HTML_Distinct (ptField;1;->[Item]Publish;"SkipSearch";->aText4)  //subject
// COPY ARRAY(aText4;$aBaseCat)  //protect the original list]
// COPY ARRAY(aText4;aText5)
// $catCount:=Size of array($aBaseCat)
//   //
// $basePage:="It"+$docStr+".html"  //causes a duplicate .html
// If (HFS_Exists (<>WebFolder+$basePage)=1)
// $err:=HFS_Delete (<>WebFolder+$basePage)
// End if 
//   //  
// sumDoc:=create document(<>WebFolder+$basePage)
// If (OK=1)
//   //If ($doMoreSpecific)
//   ////some time extend the middle to an queried value//
//   //End if 
// For ($i;1;$catCount)
// aText4{$i}:="IT"+$docStr+aText4{$i}+".html"
// End for 
// SEND PACKET(sumDoc;HTML_jitTagMake (1;"-3";"ITheader.txt";"")+"\r")
// 
// vText5:=Html_UrlFill (->aText4;"";5;"";->aText5)
// 
// SEND PACKET(sumDoc;"<span class="+Txt_Quoted ("PageIndex")+">Page Index</span>"+"\r"+vText5+"\r"+"\r")
// SEND PACKET(sumDoc;HTML_jitTagMake (1;"-3";"ITfooter.txt";"")+"\r"+"\r")
// CLOSE DOCUMENT(sumDoc)
// App_SetSuffix (".html")
// End if 
// End case 
//   //
// C_TEXT($thisPage;$thisPagePath)
// C_LONGINT($pageInc;$pageCount;$catInc;$catCount)
// For ($catInc;1;$catCount)
// MESSAGE(String($catInc)+" of  "+String($catCount))
//   //
//   //
// QUERY([Item];$ptField->=$aBaseCat{$catInc};*)
// QUERY([Item]; & [Item]Publish>0)
// ARRAY TEXT(aText7;0)
// C_LONGINT($countitems;$incrementitems)
// $countitems:=Records in selection([Item])
// If ($countitems>0)
// For ($incrementitems;1;$countitems)
// 
//   // Modified by: William James (2013-06-21T00:00:00)  MustFix
// 
// 
// End for 
// HTML_Distinct (->;1;->[Item]Publish;"SkipSearch";->aText7)
// 
//   //
// 
// ARRAY TEXT($aLinks;0)
// ARRAY TEXT($aPageName;0)
// ARRAY TEXT($aPageRefs;0)
// C_TEXT($theRefs)
//   // TRACE
// $pageCnt:=0
// While (Size of array(aText7)>0)
// COPY ARRAY(aText7;atTableHTML)
// If (Size of array(aText7)>200)
// ARRAY TEXT(atTableHTML;200)
// DELETE FROM ARRAY(aText7;1;200)
// Else 
// ARRAY TEXT(aText7;0)
// End if 
// C_Longint($pageCnt;$0;$pageInc)
// $pageCnt:=$pageCnt+1
//   //
// $thisPage:="IT"+$docStr+$aBaseCat{$catInc}+(String($pageCnt)*(Num($pageCnt>1)))+".html"
// $thisPagePath:=<>WebFolder+$thisPage
// If (HFS_Exists ($thisPagePath)=1)
// $err:=HFS_Delete ($thisPagePath)
// End if 
//   //      
// INSERT IN ARRAY($aLinks;1;1)
// INSERT IN ARRAY($aPageName;1;1)
// INSERT IN ARRAY($aPageRefs;1;1)
// $aPageRefs{1}:="<a href="+Txt_Quoted ("/"+$thisPage)+">"+atTableHTML{1}+" to "+atTableHTML{Size of array(atTableHTML)}+"</a>"
// $aPageName{1}:=$thisPage
// 
//   //
// 
// 
// 
// $aLinks{1}:=Html_UrlFill (->atTableHTML;"/item_Narrow?"+$URLStr+"="+$aBaseCat{$catInc}+"&keyword=";6)
// End while 
//   //
// C_TEXT($theIndex)
// If ($pageCnt>1)
// ARRAY TEXT(aText8;$pageCnt)
// $backPage:=$pageCnt
// $cellCnt:=0
// $theIndex:="<table id="+Txt_Quoted ("myTable1")+" class="+Txt_Quoted ("tableStandard tablesorter")+">"
// Repeat   //build index backwards
// $theIndex:=$theIndex+"<tr>"
// $cellCnt:=0
// Repeat 
// $cellCnt:=$cellCnt+1
// $theIndex:=$theIndex+"<td>"+$aPageRefs{$backPage}+"</td>"
// $backPage:=$backPage-1
// Until (($backPage=0) | ($cellCnt=5))
// $theIndex:=$theIndex+"</tr>"
// Until ($backPage=0)
// $theIndex:=$theIndex+"</table>"
//   //COPY ARRAY($aPageRefs;aText8)
//   //$theIndex:=Html_UrlFill (->aText8;"";5)
// End if 
//   //   
// C_TEXT($pageName;$badPagetoClip)
// $badPagetoClip:=""
// For ($pageInc;1;$pageCnt)
// $pageName:=UtilClean2SafeChar ($aPageName{$pageInc})
// If ($pageName#$aPageName{$pageInc})
// $badPagetoClip:="Bad characters"+"\t"+$aPageName{$pageInc}+"\t"+$pageName+"\r"+$badPagetoClip
// End if 
// myDoc:=create document(<>WebFolder+$aPageName{$pageInc})
// If (OK=1)
// SEND PACKET(myDoc;"\r"+"\r"+HTML_jitTagMake (1;"-3";"ITheader.txt";"")+"\r")
// If ($pageCnt>1)
// SEND PACKET(myDoc;"<span class="+Txt_Quoted ("PageIndex")+">Page Index</span>"+"\r"+$theIndex+"\r"+"<span class="+Txt_Quoted ("PageIndex")+">Product Index, This Page<span>"+"\r"+"\r")
// End if 
// SEND PACKET(myDoc;"\r"+"\r"+$aLinks{$pageInc}+"\r"+"\r")
// SEND PACKET(myDoc;HTML_jitTagMake (1;"-3";"ITfooter.txt";""))
// CLOSE DOCUMENT(myDoc)
// $didPage:=True
// End if 
// App_SetSuffix ("html")
// End for 
// If ($badPagetoClip#"")
// ALERT("Errors on Clipboard")
// SET TEXT TO PASTEBOARD($badPagetoClip)
// End if 
// End if 
// 
// 
// End for 
// End if 
// End if 
// End if 
// If (CapKey=1)
// CLOSE DOCUMENT(testDoc)
// End if 
// REDRAW WINDOW