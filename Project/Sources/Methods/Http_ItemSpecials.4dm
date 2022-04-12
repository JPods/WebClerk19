//%attributes = {"publishedWeb":true}

//   // Modified by: Bill James (2015-12-16T00:00:00: qqqWords TestThis)
// 
// 
//   // ----------------------------------------------------
//   // User name (OS): Bill James
//   // Date and time: 2015-12-16T00:00:00, 01:11:17
//   // ----------------------------------------------------
//   // Method: Http_ItemSpecials
//   // Description
//   // Modified: 12/16/15
//   // Structure: CEv13_131005
//   // 
//   //
//   // Parameters
//   // ----------------------------------------------------
// 
// 
// 
//   //Keep for History until 2006
// 
// 
// 
// 
//   //KeyModifierCurrent 
// READ ONLY([Item])
// READ ONLY([ItemSpec])
// READ ONLY([ItemXRef])
// C_LONGINT($w;$h;$t;$1)
// C_TEXT($cat;$ser;$val)
// C_POINTER($2)
// C_DATE($dateBeg;$dateEnd)
// C_TEXT(itemDiscounts)
// itemDiscounts:=""
// $itemType:=WCapi_GetParameter("itemType";"")
// $ItemsProfile1:=WCapi_GetParameter("ItemsProfile1";"")
// $ItemsProfile2:=WCapi_GetParameter("ItemsProfile2";"")
// $ItemsProfile3:=WCapi_GetParameter("ItemsProfile3";"")
// $ItemsProfile4:=WCapi_GetParameter("ItemsProfile4";"")
// $keyWord:=WCapi_GetParameter("keyWord";"")
// $jitPageList:=WCapi_GetParameter("jitPageList";"")
// $jitPageOne:=WCapi_GetParameter("jitPageOne";"")
// $jitSkip:=WCapi_GetParameter("jitSkip";"")
//   //
// $jitTarget:=WCapi_GetParameter("target";"")
// If ($jitTarget#"")
// $nextTarget:="&target="+$jitTarget
// $jitTarget:=" target="+Char(34)+$jitTarget+Char(34)
// Else 
// $jitTarget:=""
// $nextTarget:=""
// End if 
// 
// Case of 
// : (lang="fr")
// $suffix:="_fr"
// : (lang="de")
// $suffix:="_de"
// Else 
// lang:="us"
// $suffix:=""
// End case 
// vlBeenHere:=DateTime_Enter 
// C_REAL(vValueBonus)
// vValueBonus:=[EventLog]ValueBonus
// If ([EventLog]eventID#0)
// SAVE RECORD([EventLog])
// End if 
//   //
// $testCnt:=0
// C_LONGINT($testCnt;$DTitem)
// If ($itemType#"")
// If ($testCnt=0)
// QUERY([Item];[Item]typeID=$itemType+"@";*)
// Else 
// QUERY([Item]; & [Item]typeID=$itemType+"@";*)
// End if 
// $testCnt:=$testCnt+1
// End if 
// If ($keyWord#"")
// C_LONGINT($p;$cycleCnt)
// C_TEXT($testWord)
// $cycleCnt:=$testCnt
// Repeat 
// $p:=Position("; ";$keyWord)
// If ($p>0)
// $testWord:=Substring($keyWord;1;$p-1)
// $keyWord:=Substring($keyWord;$p+2)
// Else 
// $testWord:=$keyWord
// End if 
// Case of 
// : ($cycleCnt=0)
// QUERY([Item];=$testWord+"@";*)
// : ($testWord="")
// Else 
// QUERY([Item]; & =$testWord+"@";*)
// End case 
// $cycleCnt:=1
// Until ($p=0)
// $testCnt:=$testCnt+1
// End if 
// If ($ItemsProfile1#"")
// If ($testCnt=0)
// QUERY([Item];[Item]Profile1=$ItemsProfile1+"@";*)
// Else 
// QUERY([Item]; & [Item]Profile1=$ItemsProfile1+"@";*)
// End if 
// $testCnt:=$testCnt+1
// End if 
// If ($ItemsProfile2#"")
// If ($testCnt=0)
// QUERY([Item];[Item]Profile2=$ItemsProfile2+"@";*)
// Else 
// QUERY([Item]; & [Item]Profile2=$ItemsProfile2+"@";*)
// End if 
// $testCnt:=$testCnt+1
// End if 
// If ($ItemsProfile3#"")
// If ($testCnt=0)
// QUERY([Item];[Item]Profile3=$ItemsProfile3+"@";*)
// Else 
// QUERY([Item]; & [Item]Profile3=$ItemsProfile3+"@";*)
// End if 
// $testCnt:=$testCnt+1
// End if 
// If ($ItemsProfile4#"")
// If ($testCnt=0)
// QUERY([Item];[Item]Profile4=$ItemsProfile4+"@";*)
// Else 
// QUERY([Item]; & [Item]Profile4=$ItemsProfile4+"@";*)
// End if 
// $testCnt:=$testCnt+1
// End if 
// If ($testCnt>0)
// QUERY([Item]; & [Item]BonusValue>0;*)
// QUERY([Item]; & [Item]Retired=False;*)
// QUERY([Item]; & [Item]Publish>0;*)
// QUERY([Item]; & [Item]Publish<=viEndUserSecurityLevel)
// End if 
//   //
// $num:=Records in selection([Item])
// 
// If ($num><>viMaxShow)
//   //REDUCE SELECTION([Item];<>viMaxShow)
//   //Else 
// ARRAY LONGINT($aItemRecs;0)
// ARRAY LONGINT($aTheList;0)
// C_LONGINT($seqNum;$i;$w)
// $seqNum:=Num($jitSkip)
// Case of 
// : (($num<=100) | ($seqNum<=60))
// $i:=10
// : ($seqNum+60>$num)
// $i:=$num-100
// : ($seqNum>60)
// $i:=$seqNum-50
// Else 
// $i:=$seqNum
// End case 
// 
// While (($num>$i) & (Size of array($aTheList)<10))
// $w:=Size of array($aTheList)+1
// INSERT IN ARRAY($aTheList;$w;1)
// $aTheList{$w}:=$i
// $i:=$i+10
// End while 
// If ($i>=($seqNum+90))
// $w:=Size of array($aTheList)+1
// INSERT IN ARRAY($aTheList;$w;1)
// $aTheList{$w}:=$i
// End if 
//   //C_TEXT(vChoiceText)
// vText8:=""
// For ($i;1;Size of array($aTheList))
// If ($seqNum=$aTheList{$i})
// vText8:=vText8+String($aTheList{$i}\10)+" - "
// Else 
// vText8:=vText8+"<a href="+Char(34)+"/item_Narrow?"+$nextTarget+"&jitskip="+String($aTheList{$i})
// If ($jitPageOne#"")
// vText8:=vText8+"&jitPageOne="+$jitPageOne
// End if 
// If ($jitPageList#"")
// vText8:=vText8+"&jitPageList="+$jitPageList
// End if 
// If ($itemType#"")
// vText8:=vText8+"&itemType="+$itemType
// End if 
// If ($ItemsProfile1#"")
// vText8:=vText8+"&ItemsProfile1="+$ItemsProfile1
// End if 
// If ($ItemsProfile2#"")
// vText8:=vText8+"&ItemsProfile2="+$ItemsProfile2
// End if 
// If ($ItemsProfile3#"")
// vText8:=vText8+"&ItemsProfile3="+$ItemsProfile3
// End if 
// If ($ItemsProfile4#"")
// vText8:=vText8+"&ItemsProfile4="+$ItemsProfile4
// End if 
// If ($keyWord#"")
// vText8:=vText8+"&keyWord="+$keyWord
// End if 
// If (<>doeventID)
// vText8:=vText8+"jitUser="+String(vleventID)
// End if 
// Case of 
// : (($aTheList{1}>10) & ($i=1))
// vText8:=vText8+Char(34)+$jitTarget+">"+"Previous 10 </a> -  "
// : (($i=Size of array($aTheList)) & ($aTheList{$i}<$num))
// vText8:=vText8+Char(34)+$jitTarget+">"+"Next 10 </a>"
// Else 
// vText8:=vText8+Char(34)+$jitTarget+">"+String($aTheList{$i}\10)+"</a> - "
// End case 
// End if 
// End for 
// SELECTION RANGE TO ARRAY($seqNum;$seqNum+10;[Item];$aItemRecs)
// CREATE EMPTY SET([Item];"Current")
// For ($i;1;10)
// GOTO RECORD([Item];$aItemRecs{$i})
// ADD TO SET([Item];"Current")
// End for 
// USE SET("Current")
// CLEAR SET("Current")
// End if 
//   //
// C_LONGINT(vlBeenHere)
// vlBeenHere:=DateTime_Enter 
// $theTarget:=""
// Case of 
// : ($num>1)
// $err:=WC_PageSendWithTags ($1;WC_DoPage ("ItemListBonus.html";$jitPageList);0)
// 
// : ($num=1)
// Http_ItemRelated ($1;"text/html")
// If ([Item]UseQtyPriceBrks>0)
// Http_ItemPriceBreaks 
// End if 
// vText8:=""
// $err:=WC_PageSendWithTags ($1;WC_DoPage ("ItemsOne"+[Item]WebPage+".html";$jitPageOne);0)
// Else 
//   // Send no records found
// vResponse:="No Item found"
// $err:=WC_PageSendWithTags ($1;WC_DoPage ("Error"+$suffix+".html";"");0)
// End case 
// itemDiscounts:=""
// REDUCE SELECTION([Item];0)
// REDUCE SELECTION([ItemSpec];0)
// REDUCE SELECTION([ItemXRef];0)
// REDUCE SELECTION([TechNote];0)
// REDUCE SELECTION([Forum];0)
// REDUCE SELECTION([TallySummary];0)
// REDUCE SELECTION([TallyResult];0)
// REDUCE SELECTION([WOTemplate];0)
// REDUCE SELECTION([TallyMaster];0)
// READ WRITE([Item])
// READ WRITE([ItemSpec])
// READ WRITE([ItemXRef])
// vItemRelated:=""