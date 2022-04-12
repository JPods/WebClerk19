//%attributes = {"publishedWeb":true}

// 
// If (False)
//   //Method: Copss
//   //Date: 03/11/03
//   //Who: Bill
//   //Description: 
// End if 
// 
// C_TEXT($tempFold;$workText;$labelText;$b18Name)
// TRACE
// $tempFold:=Get_FolderName ("Select folder for setting loading items.")
// If ($tempFold#"")
// $err:=HFS_CatToArray ($tempFold;"aText1")
// If ($err=0)
// C_Longint($i;$k;$p;$w;$pCR;$pStartClip;$cntTabs;$wProgram;$wWt;$totalCnt)
// $k:=Size of array(aText1)
// $totalCnt:=0
// For ($i;1;$k)
// $p:=Position(".txt";aText1{$i})
// If ($p>0)
// myDoc:=Open document($tempFold+aText1{$i})
// If (OK=1)
// RECEIVE PACKET(myDoc;$workText;"\r")
// RECEIVE PACKET(myDoc;$b18Name;"\t")
// RECEIVE PACKET(myDoc;$workText;1000)
// CLOSE DOCUMENT(myDoc)
// $pStartClip:=Position("!GENERIC";$workText)
// $p:=Position("INST NAME";$workText)
// If ($p>0)
// $workText:=Substring($workText;$p)
// $p:=Position("!GENERIC";$workText)
// If ($p>0)
// $workText:=Substring($workText;1;$p-1)
// ARRAY TEXT($aCats;0)
// Repeat 
// $p:=Position("\t";$workText)
// $w:=Size of array($aCats)+1
// INSERT IN ARRAY($aCats;$w;1)
// If ($p>0)
// $labelText:=Substring($workText;1;$p-1)
// $workText:=Substring($workText;$p+1)
// $pCR:=Position("\r";$labelText)
// If ($pCR>0)
// $labelText:=Substring($workText;$p+1)
// End if 
// Else 
// $labelText:=$workText
// $workText:=""
// $pCR:=Position("\r";$labelText)
// If ($pCR>0)
// $labelText:=Substring($labelText;1;$pCR-1)  //does not account for CR in labels
// End if 
// End if 
// $aCats{$w}:=Replace string($labelText;Char(34);"")
// Until ($p=0)
// myDoc:=Open document($tempFold+aText1{$i})
// If (OK=1)
// $wProgram:=Find in array($aCats;"Program@")
// $wWt:=Find in array($aCats;"Unit_wt@")
// $wModel:=Find in array($aCats;"Model_Num@")
// $descriptSeed:=HFS_ShortName (document)
// $descriptSeed:=Replace string($descriptSeed;".txt";"")
// RECEIVE PACKET(myDoc;$workText;$pStartClip)
// RECEIVE PACKET(myDoc;$workText;"\r")
// $k:=Size of array($aCats)
// ARRAY TEXT($valueText;$k)
// $cntTabs:=$k-1
// Repeat 
// For ($incTabs;1;$cntTabs)
// RECEIVE PACKET(myDoc;$valueText{$incTabs};"\t")
// End for 
// RECEIVE PACKET(myDoc;$valueText{$k};"\r")
// 
// If ((OK=1) & ($valueText{$wModel}#"") & ($valueText{$wModel}#"!@"))
//   // $valueText{1}:=Replace string($valueText{1};Char(10);"")
// QUERY([Item];[Item]ItemNum=$valueText{$wModel})
// If (Records in selection([Item])=0)
// CREATE RECORD([Item])
// [Item]ItemNum:=$valueText{$wModel}
// Else 
// jdeleteAllSubRe (->[Item]KeySub)
// End if 
// QUERY([Word];[Word]TableNum=4;*)
// QUERY([Word]; & [Word]RelatedAlpha=$valueText{1})
// If (Records in selection([Word])>0)
// DELETE SELECTION([Word])
// End if 
// If ($totalCnt=424)
// TRACE
// End if 
// $totalCnt:=$totalCnt+1
// MESSAGE(String($totalCnt))
// [Item]Description:=$descriptSeed
// For ($incProgram;1;$k)
// If (($aCats{$incProgram}#"Unit_Wt@") & ($incProgram#1) & ($aCats{$incProgram}#"Model_Num@"))
// [Item]Description:=[Item]Description+", "+$valueText{$incProgram}
// CREATE SUBRECORD([Item]KeySub)
// :=$valueText{$incProgram}
// :=$aCats{$incProgram}
// :=+
// End if 
// End for 
// [Item]Class:=$b18Name
// [Item]typeID:=$descriptSeed
// If ($wProgram>2)
// [Item]Profile1:=$valueText{2}
// If ($wProgram>3)
// [Item]Profile2:=$valueText{3}
// If ($wProgram>4)
// [Item]Profile3:=$valueText{4}
// If ($wProgram>5)
// [Item]Profile4:=$valueText{5}
// End if 
// End if 
// End if 
// End if 
// SAVE RECORD([Item])
// Else 
// OK:=0
// End if 
// Until (OK=0)
// CLOSE DOCUMENT(myDoc)
// End if 
// End if 
// End if 
// End if 
// End if 
// End for 
// End if 
// End if 
// 
// REDRAW WINDOW