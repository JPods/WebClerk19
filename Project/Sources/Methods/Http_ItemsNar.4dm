//%attributes = {"publishedWeb":true}

//  // ----------------------------------------------------
//  // User name (OS): William James
//  // Date and time: 2014-01-11T00:00:00, 06:44:31
//  // ----------------------------------------------------
//  // Method: Http_ItemsNar
//  // Description
//  // Modified: 01/11/14
//  // Structure: CEv13_131005
//  // 
//  //
//  // Parameters
//  // ----------------------------------------------------
//  
//  
//  //KeyModifierCurrent 
//  READ ONLY([Item])
//  READ ONLY([ItemSpec])
//  READ ONLY([ItemXRef])
//  C_LONGINT($w; $h; $t; $1; vRecordCount)
//  C_TEXT($cat; $ser; $val)
//  C_LONGINT(vBeenHere; vlBeenHere)
//  C_POINTER($2)
//  C_TEXT($keyWords)
//  C_TEXT($3; $mfrID)
//  C_DATE(vTmpDateBeg; vTmpDateEnd)
//  //
//  $mfrID:=""
//  If (Count parameters=3)
//  $mfrID:=$3
//  End if 
//  
//  C_TEXT(itemDiscounts; pvKeyWords)
//  itemDiscounts:=""
//  //
//  C_TEXT(pvOrderNum; returnValue; returnTable; returnField)  // these are so items can be web added to order, invoices, etc...
//  pvOrderNum:=WCapi_GetParameter("OrderNum"; "")
//  returnValue:=WCapi_GetParameter("returnValue"; "")
//  returnTable:=WCapi_GetParameter("returnTable"; "")
//  returnField:=WCapi_GetParameter("returnField"; "")
//  //
//  $recID:=WCapi_GetParameter("RecordNum"; "")
//  $itemNum:=WCapi_GetParameter("itemNum"; "")
//  $itemLiteral:=WCapi_GetParameter("ItemLiteral"; "")
//  $itemDesc:=WCapi_GetParameter("Description"; "")
//  $mfrItem:=WCapi_GetParameter("mfrItemNum"; "")
//  If ($mfrItem="")
//  $mfrItem:=WCapi_GetParameter("mfgItemNum"; "")
//  End if 
//  If ($mfrID="")
//  $mfrID:=WCapi_GetParameter("mfrID"; "")
//  If ($mfrID="")
//  $mfrID:=WCapi_GetParameter("mfgID"; "")
//  End if 
//  End if 
//  $itemType:=WCapi_GetParameter("typeID"; "")
//  $ItemsProfile1:=WCapi_GetParameter("Profile1"; "")
//  $ItemsProfile2:=WCapi_GetParameter("Profile2"; "")
//  $ItemsProfile3:=WCapi_GetParameter("Profile3"; "")
//  $ItemsProfile4:=WCapi_GetParameter("Profile4"; "")
//  $ItemsProfile5:=WCapi_GetParameter("Profile5"; "")
//  $ItemsProfile6:=WCapi_GetParameter("Profile6"; "")
//  $indicator1:=Num(WCapi_GetParameter("Indicator1"; ""))
//  $indicator2:=Num(WCapi_GetParameter("Indicator2"; ""))
//  $indicator3:=Num(WCapi_GetParameter("Indicator3"; ""))
//  $indicator4:=Num(WCapi_GetParameter("Indicator4"; ""))
//  $itemClass:=WCapi_GetParameter("Class"; "")
//  $barcode:=WCapi_GetParameter("barcode"; "")
//  $vendID:=WCapi_GetParameter("VendorID"; "")
//  $vendItem:=WCapi_GetParameter("VendorItemNum"; "")
//  $keyWords:=WCapi_GetParameter("keyWord@"; "")
//  If ($keyWords="")
//  $keyWords:=WCapi_GetParameter("keyWords"; "")
//  End if 
//  pvKeyWords:=$keyWords
//  C_TEXT($keyPairs)
//  $p:=Position("KeyPairs"; $2->)
//  If ($p>0)
//  //TRACE
//  $keyPairs:=HttpKeyPairs($2)
//  $keyWords:=$keyWords+("; "*Num($keyWords#""))+$keyPairs
//  End if 
//  $theDate:=WCapi_GetParameter("itemDate"; "")
//  $jitPageList:=WCapi_GetParameter("jitPageList"; "")
//  $jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
//  $jitPageError:=WCapi_GetParameter("jitPageError"; "")
//  If ($jitPageError="")
//  $jitPageError:="Error.html"
//  End if 
//  
//  $jitSkip:=WCapi_GetParameter("jitSkip"; "")
//  $jitMaxShow:=Num(WCapi_GetParameter("jitMaxShow"; ""))
//  If ($jitMaxShow<=5)
//  $jitMaxShow:=<>viMaxShow
//  End if 
//  If ($jitMaxShow><>viMaxShow)
//  $jitWebShow:=$jitMaxShow
//  Else 
//  $jitWebShow:=<>viWebShow
//  End if 
//  //
//  pvTypeSale:=""
//  If (vWccSecurity>0)
//  pvTypeSale:=WCapi_GetParameter("jitTypeSale"; "")
//  vRelateLevel:=1
//  End if 
//  
//  $jitTarget:=WCapi_GetParameter("target"; "")
//  If ($jitTarget#"")
//  $nextTarget:="&target="+$jitTarget
//  $jitTarget:=" target="+Char(34)+$jitTarget+Char(34)
//  Else 
//  $jitTarget:=""
//  $nextTarget:=""
//  End if 
//  $suffix:=""
//  
//  vlBeenHere:=DateTime_DTTo
//  vBeenHere:=vlBeenHere
//  If ([EventLog]idNum#0)
//  SAVE RECORD([EventLog])
//  End if 
//  //
//  REDUCE SELECTION([Item]; 0)  // just to make sure 
//  $wildCard:="@"
//  $testCnt:=0
//  C_LONGINT($testCnt; $DTitem)
//  vURLQueryScript:=""
//  If ($recID#"")
//  GOTO RECORD([Item]; Num($recID))
//  If (([Item]retired=True) | ([Item]publish<0) | ([Item]publish>viEndUserSecurityLevel-<>vlSecurityBump))
//  REDUCE SELECTION([Item]; 0)
//  $testCnt:=0
//  End if 
//  Else 
//  If ($keyWords#"")
//  KeyWordByAlpha(Table(->[Item]); $keyWords; True)
//  End if 
//  CREATE SET([Item]; "current")
//  vURLQueryScript:=vURLQueryScript+"QUERY([Item];[Item]Publish>0;*)"+"\r"
//  $testCnt:=0
//  If ($itemNum#"")
//  If ($itemLiteral="false")
//  vURLQueryScript:=vURLQueryScript+"QUERY([Item];&[Item]ItemNum="+Txt_Quoted($itemNum+$wildCard)+";*)"+"\r"
//  Else 
//  vURLQueryScript:=vURLQueryScript+"QUERY([Item];&[Item]ItemNum="+Txt_Quoted($itemNum)+";*)"+"\r"
//  End if 
//  $testCnt:=$testCnt+1
//  End if 
//  If ($theDate#"")
//  $testCnt:=txtDateFrom($theDate; 1; $testCnt; ->[Item]dtItemDate)
//  End if 
//  If ($itemDesc#"")
//  vURLQueryScript:=vURLQueryScript+"QUERY([Item];&[Item]Description="+Txt_Quoted($itemDesc+$wildCard)+";*)"+"\r"
//  $testCnt:=$testCnt+1
//  End if 
//  If ($itemClass#"")
//  //QUERY([Item];&[Item]Class=$itemClass;*)//keep literal for catalog tree
//  vURLQueryScript:=vURLQueryScript+"QUERY([Item];&[Item]Class="+Txt_Quoted($itemClass)+";*)"+"\r"
//  $testCnt:=$testCnt+1
//  End if 
//  If ($mfrID#"")
//  If ($mfrID="NotEmpty")
//  vURLQueryScript:=vURLQueryScript+"QUERY([Item];&[Item]mfrID="+Txt_Quoted("")+";*)"+"\r"
//  Else 
//  //QUERY([Item];&[Item]mfrID=$mfrID+"@";*)
//  vURLQueryScript:=vURLQueryScript+"QUERY([Item];&[Item]mfrID="+Txt_Quoted($mfrID+$wildCard)+";*)"+"\r"
//  End if 
//  $testCnt:=$testCnt+1
//  End if 
//  If ($mfrItem#"")
//  If ($itemLiteral="false")
//  //QUERY([Item];&[Item]MfrItemNum=$mfrItem+"@";*)
//  vURLQueryScript:=vURLQueryScript+"QUERY([Item];&[Item]MfrItemNum="+Txt_Quoted($mfrItem+$wildCard)+";*)"+"\r"
//  Else 
//  //QUERY([Item];&[Item]MfrItemNum=$mfrItem;*)
//  vURLQueryScript:=vURLQueryScript+"QUERY([Item];&[Item]MfrItemNum="+Txt_Quoted($mfrItem)+";*)"+"\r"
//  End if 
//  $testCnt:=$testCnt+1
//  End if 
//  If ($vendID#"")
//  //QUERY([Item];&[Item]VendorID=$vendID+"@";*)
//  If ($vendID="NotEmpty")
//  vURLQueryScript:=vURLQueryScript+"QUERY([Item];&[Item]VendorID#"+Txt_Quoted("")+";*)"+"\r"
//  Else 
//  vURLQueryScript:=vURLQueryScript+"QUERY([Item];&[Item]VendorID="+Txt_Quoted($vendID+$wildCard)+";*)"+"\r"
//  End if 
//  $testCnt:=$testCnt+1
//  End if 
//  If ($vendItem#"")
//  If ($itemLiteral="false")
//  //QUERY([Item];&[Item]VendorItemNum=$vendItem+"@";*)
//  vURLQueryScript:=vURLQueryScript+"QUERY([Item];&[Item]VendorItemNum="+Txt_Quoted($vendItem+$wildCard)+";*)"+"\r"
//  Else 
//  //QUERY([Item];&[Item]VendorItemNum=$vendItem;*)
//  vURLQueryScript:=vURLQueryScript+"QUERY([Item];&[Item]VendorItemNum="+Txt_Quoted($vendItem)+";*)"+"\r"
//  End if 
//  $testCnt:=$testCnt+1
//  End if 
//  If ($barcode#"")
//  //QUERY([Item];&[Item]BarCode=$barcode+"@";*)
//  vURLQueryScript:=vURLQueryScript+"QUERY([Item];&[Item]BarCode="+Txt_Quoted($barcode)+";*)"+"\r"
//  $testCnt:=$testCnt+1
//  End if 
//  If ($itemType#"")
//  //QUERY([Item];&[Item]typeID=$itemType+"@";*)
//  vURLQueryScript:=vURLQueryScript+"QUERY([Item];&[Item]typeID="+Txt_Quoted($itemType+$wildCard)+";*)"+"\r"
//  $testCnt:=$testCnt+1
//  End if 
//  If ($ItemsProfile1#"")
//  //QUERY([Item];&[Item]Profile1=$ItemsProfile1+"@";*)
//  vURLQueryScript:=vURLQueryScript+"QUERY([Item];&[Item]Profile1="+Txt_Quoted($ItemsProfile1+$wildCard)+";*)"+"\r"
//  $testCnt:=$testCnt+1
//  End if 
//  If ($ItemsProfile2#"")
//  //QUERY([Item];&[Item]Profile2=$ItemsProfile2+"@";*)
//  vURLQueryScript:=vURLQueryScript+"QUERY([Item];&[Item]Profile2="+Txt_Quoted($ItemsProfile2+$wildCard)+";*)"+"\r"
//  $testCnt:=$testCnt+1
//  End if 
//  If ($ItemsProfile3#"")
//  //QUERY([Item];&[Item]Profile3=$ItemsProfile3+"@";*)
//  vURLQueryScript:=vURLQueryScript+"QUERY([Item];&[Item]Profile3="+Txt_Quoted($ItemsProfile3+$wildCard)+";*)"+"\r"
//  $testCnt:=$testCnt+1
//  End if 
//  If ($ItemsProfile4#"")
//  //QUERY([Item];&[Item]Profile4=$ItemsProfile4+"@";*)
//  vURLQueryScript:=vURLQueryScript+"QUERY([Item];&[Item]Profile4="+Txt_Quoted($ItemsProfile4+$wildCard)+";*)"+"\r"
//  $testCnt:=$testCnt+1
//  End if 
//  If ($ItemsProfile5#"")
//  //QUERY([Item];&[Item]Profile5=$ItemsProfile5+"@";*)
//  vURLQueryScript:=vURLQueryScript+"QUERY([Item];&[Item]Profile5="+Txt_Quoted($ItemsProfile5+$wildCard)+";*)"+"\r"
//  $testCnt:=$testCnt+1
//  End if 
//  If ($ItemsProfile6#"")
//  //QUERY([Item];&[Item]Profile6=$ItemsProfile6+"@";*)
//  vURLQueryScript:=vURLQueryScript+"QUERY([Item];&[Item]Profile6="+Txt_Quoted($ItemsProfile6+$wildCard)+";*)"+"\r"
//  $testCnt:=$testCnt+1
//  End if 
//  If ($indicator1>0)
//  //QUERY([Item];&[Item]Indicator1=$indicator1;*)
//  $testCnt:=$testCnt+1
//  vURLQueryScript:=vURLQueryScript+"QUERY([Item];&[Item]Indicator1="+String($indicator1)+";*)"+"\r"
//  End if 
//  If ($indicator2>0)
//  //QUERY([Item];&[Item]Indicator2=$indicator2;*)
//  vURLQueryScript:=vURLQueryScript+"QUERY([Item];&[Item]Indicator2="+String($indicator2)+";*)"+"\r"
//  $testCnt:=$testCnt+1
//  End if 
//  If ($indicator3>0)
//  //QUERY([Item];&[Item]Indicator2=$indicator3;*)
//  vURLQueryScript:=vURLQueryScript+"QUERY([Item];&[Item]Indicator3="+String($indicator3)+";*)"+"\r"
//  $testCnt:=$testCnt+1
//  End if 
//  If ($indicator4>0)
//  //QUERY([Item];&[Item]Indicator2=$indicator4;*)
//  vURLQueryScript:=vURLQueryScript+"QUERY([Item];&[Item]Indicator4="+String($indicator4)+";*)"+"\r"
//  $testCnt:=$testCnt+1
//  End if 
//  If ($testCnt>0)  // skip if only published > 1 is called, no other criteria
//  If (<>vtcStrictInventory>0)
//  //QUERY([Item];&[Item]QtyAvailable>0;*)
//  vURLQueryScript:=vURLQueryScript+"QUERY([Item];&[Item]QtyAvailable>0;*)"+"\r"
//  End if 
//  //QUERY([Item];&[Item]Retired=False;*)
//  //QUERY([Item];&[Item]Publish<=viEndUserSecurityLevel-<>vlSecurityBump)
//  vURLQueryScript:=vURLQueryScript+"QUERY([Item];&[Item]Retired=False;*)"+"\r"
//  vURLQueryScript:=vURLQueryScript+"QUERY([Item];&[Item]Publish<="+String(viEndUserSecurityLevel-<>vlSecurityBump)+";*)"+"\r"
//  Else 
//  vURLQueryScript:=""
//  End if 
//  If (vURLQueryScript#"")
//  vURLQueryScript:=vURLQueryScript+"Query([Item])"
//  //SET TEXT TO CLIPBOARD(vURLQueryScript)
//  ExecuteText(0; vURLQueryScript)
//  
//  If (Records in set("current")>0)
//  CREATE SET([Item]; "queryresults")
//  
//  INTERSECTION("current"; "queryresults"; "current")
//  USE SET("current")
//  CLEAR SET("queryresults")
//  End if 
//  End if 
//  CLEAR SET("current")  // 
//  End if 
//  vText8:=""
//  $num:=Records in selection([Item])
//  vRecordCount:=$num
//  //
//  vURLSortScript:=""
//  vMoreChoices:=""
//  vText8:=""
//  MoreItems:=""
//  $mySort:=""
//  $p:=Position("_jitSort"; $2->)
//  If ($p>0)
//  $showLast:=0
//  $mySort:=Substring($2->; $p; 80)  //clip the sort command, get enough 
//  $p:=Position(<>endTag; $mySort)  //find the end
//  $mySort:=Substring($mySort; 1; $p+1)
//  $showLast:=Http_DoSort($mySort)
//  End if 
//  //
//  //
//  //TRACE
//  If ($num>$jitMaxShow)  //needs pieces
//  $maxClickList:=($jitWebShow*9)-1
//  If ($num>$maxClickList)
//  REDUCE SELECTION([Item]; $maxClickList)
//  $num:=$maxClickList
//  End if 
//  ARRAY TEXT($aItemNum; 0)
//  ARRAY LONGINT($aTheList; 0)
//  C_LONGINT($seqNum; $i; $w; $num; $incMax; $incSplit; $remain)
//  C_TEXT(vText8; $nextTarget)
//  // $num:=Records in selection([Item])
//  $seqNum:=Num($jitSkip)
//  $incMax:=(10*$jitWebShow)  //$jitWebShow
//  $incDo:=$num\$jitWebShow
//  If (Mod($num; $incMax)>0)
//  $incDo:=$incDo+1
//  End if 
//  $i:=$jitWebShow
//  While (Size of array($aTheList)<$incDo)  //$jitWebShow))//setup up to 9 elements    
//  $w:=Size of array($aTheList)+1
//  INSERT IN ARRAY($aTheList; $w; 1)
//  $aTheList{$w}:=$i
//  $i:=$i+$jitWebShow
//  End while 
//  $itemLiteral:="&ItemLiteral=False"*(Num(Position("ItemLiteral=False"; vText11)>0))
//  C_LONGINT($raySize)
//  $raySize:=Size of array($aTheList)-1
//  //TRACE
//  For ($i; 0; $raySize)
//  If ($seqNum=$aTheList{$i})
//  //
//  vText8:=vText8+String(($aTheList{$i}\$jitWebShow)+1)+"/"+String($jitWebShow)+" - "
//  Else 
//  vText8:=vText8+"<a href="+Char(34)+"/item_List?"+$itemLiteral+"&jitskip="+String($aTheList{$i})
//  If ($jitPageOne#"")
//  vText8:=vText8+"&jitPageOne="+$jitPageOne
//  End if 
//  If ($jitPageList#"")
//  vText8:=vText8+"&jitPageList="+$jitPageList
//  End if 
//  If ($itemType#"")
//  vText8:=vText8+"&typeID="+$itemType
//  End if 
//  If ($itemClass#"")
//  vText8:=vText8+"&Class="+$itemClass
//  End if 
//  If ($itemNum#"")
//  vText8:=vText8+"&itemNum="+$itemNum
//  End if 
//  If ($itemDesc#"")
//  vText8:=vText8+"&Description="+$itemDesc
//  End if 
//  If ($mfrItem#"")
//  vText8:=vText8+"&mfgItemNum="+$mfrItem
//  End if 
//  If ($mfrID#"")
//  vText8:=vText8+"&mfgID="+$mfrID
//  End if 
//  If ($ItemsProfile1#"")
//  vText8:=vText8+"&Profile1="+$ItemsProfile1
//  End if 
//  If ($ItemsProfile2#"")
//  vText8:=vText8+"&Profile2="+$ItemsProfile2
//  End if 
//  If ($ItemsProfile3#"")
//  vText8:=vText8+"&Profile3="+$ItemsProfile3
//  End if 
//  If ($ItemsProfile4#"")
//  vText8:=vText8+"&Profile4="+$ItemsProfile4
//  End if 
//  If ($ItemsProfile5#"")
//  vText8:=vText8+"&Profile5="+$ItemsProfile5
//  End if 
//  If ($ItemsProfile6#"")
//  vText8:=vText8+"&Profile6="+$ItemsProfile6
//  End if 
//  If ($indicator1>0)
//  vText8:=vText8+"&Indicator1="+String($indicator1)
//  End if 
//  If ($indicator2>0)
//  vText8:=vText8+"&Indicator2="+String($indicator2)
//  End if 
//  If ($indicator3>0)
//  vText8:=vText8+"&Indicator3="+String($indicator3)
//  End if 
//  If ($indicator4>0)
//  vText8:=vText8+"&Indicator4="+String($indicator4)
//  End if 
//  If ($barcode#"")
//  vText8:=vText8+"&barcode="+$barcode
//  End if 
//  If ($vendID#"")
//  vText8:=vText8+"&VendorID="+$vendID
//  End if 
//  If ($vendItem#"")
//  vText8:=vText8+"&VendorItemNum="+$vendItem
//  End if 
//  If ($keyWords#"")
//  vText8:=vText8+"&keyWord="+$keyWords
//  End if 
//  vText8:=vText8+"&sort="+$mySort
//  Case of 
//  : (($aTheList{1}>$jitWebShow) & ($i=1))
//  vText8:=vText8+Char(34)+$jitTarget+">"+"Previous "+String($jitWebShow)+" </a> -  "
//  : (($i=Size of array($aTheList)) & ($aTheList{$i}<$num))
//  vText8:=vText8+Char(34)+$jitTarget+">"+"Next "+String($jitWebShow)+" </a>"
//  Else 
//  vText8:=vText8+Char(34)+$jitTarget+">"+String(($aTheList{$i}\$jitWebShow)+1)+"/"+String($jitWebShow)+"</a> - "
//  End case 
//  End if 
//  End for 
//  If (($jitWebShow>0) & ((Records in selection([Item])-70)>$jitWebShow))
//  SELECTION RANGE TO ARRAY($seqNum+1; $seqNum+$jitWebShow; [Item]itemNum; $aItemNum)
//  QUERY WITH ARRAY([Item]itemNum; $aItemNum)
//  
//  End if 
//  //
//  If (False)
//  CREATE EMPTY SET([Item]; "Current")
//  C_LONGINT($cntSet)
//  $cntSet:=UtilReturnMinValue(Size of array($aItemNum); $jitWebShow)
//  For ($i; 1; $cntSet)
//  //GOTO RECORD([Item];$aItemNum{$i})
//  ADD TO SET([Item]; "Current")
//  End for 
//  USE SET("Current")
//  CLEAR SET("Current")
//  End if 
//  If (vURLSortScript#"")
//  ExecuteText(0; vURLSortScript)
//  End if 
//  End if 
//  //
//  
//  C_LONGINT(vlBeenHere)
//  vlBeenHere:=DateTime_DTTo
//  $theTarget:=""
//  itemDiscounts:=""
//  vItemKeys:=""
//  
//  
//  Case of 
//  : ($num>1)
//  $err:=WC_PageSendWithTags($1; WC_DoPage("ItemsList.html"; $jitPageList); 0)
//  [EventLog]tableName:=Table name(->[Item])
//  [EventLog]lastQueryScript:=vURLQueryScript
//  [EventLog]wccEmail:=vURLSortScript
//  If ([EventLog]idNum#0)
//  SAVE RECORD([EventLog])
//  End if 
//  ARRAY LONGINT($aRecNums; 0)
//  SELECTION TO ARRAY([Item]; $aRecNums)
//  VARIABLE TO BLOB($aRecNums; [EventLog]recordArray)
//  [EventLog]tableNumArray:=Table(->[Item])
//  If ([EventLog]idNum#0)
//  SAVE RECORD([EventLog])
//  End if 
//  : ($num=1)
//  // Http_ItemRelated ($1;"text/html")
//  // do this with page scripts
//  vText8:=""
//  $gotoPage:=""
//  If (($jitPageList#"") | ($jitPageOne#""))
//  C_TEXT($gotoPage)
//  $gotoPage:="&jitPageList="+$jitPageList+"&jitPageOne="+$jitPageOne
//  End if 
//  
//  // CodeDefect by: William James (2014-06-03T00:00:00 Subrecord eliminated)
//  //  zzzzz CheckThis Where is it used and why is it subrecords
//  // ### jwm ### 20171103_1333 the method Keyword combine is entirely commented out
//  //vItemKeys:=KeywordCombine (->[Item]KeySub;"=";"; ";35;1;$gotoPage)
//  
//  
//  If ([Item]useQtyPriceBrks>0)
//  Http_ItemPriceBreaks
//  End if 
//  
//  
//  ItemKeyPathVariables
//  If (([Item]reservation) & (<>vlPublishReservations<=viEndUserSecurityLevel))
//  Http_ItemReservationEach($1)
//  End if 
//  
//  $err:=WC_PageSendWithTags($1; WC_DoPage("ItemsOne"+[Item]webPage+".html"; $jitPageOne); 0)
//  
//  Else 
//  // Send no records found
//  vResponse:="No Item found at authority level "+String(viEndUserSecurityLevel)
//  $err:=WC_PageSendWithTags($1; WC_DoPage("Error.html"; $jitPageError); 0)
//  End case 
//  itemDiscounts:=""
//  vReservations:=""
//  vItemRelated:=""
//  vRecordCount:=0