//%attributes = {"publishedWeb":true}
//Method: Html_URLSupportPage
//   //
// 
// If ((curTableNum#58) | (curTableNum#73) | (curTableNum#80) | (curTableNum#19))
// ALERT("Applies to TechNotes, TallyResults, Forums, Employees")
// Else 
// CONFIRM("Draft Tech Page?")
// If (OK=1)
// 
// ARRAY TEXT(aiLoText2;1)
//   //myDocName:=""
//   //$myOK:=EI_CreateDoc (->myDocName;->myDoc;"")
//   //If ($myOK=1)
// $makeSearch:="SkipSearch"
// $theFont:=""  //<FONT FACE="+"\""+"Arial"+"\""+" SIZE="+"\""+"1"+"\""+">"
// $endFont:=""  //</FONT>"
// C_Longint($theBreaks)
// $theBreaks:=Num(Request("Enter number of columns.";"5"))
//   //    
// C_Longint($incRay;cntRay)
// cntRay:=Size of array(aFieldLns)
// 
// If (curTableNum=73)
// QUERY([TallyResult];[TallyResult]Publish>0)
// ARRAY TEXT($aTallyPurposes;0)
// HTML_Distinct (->[TallyResult]Purpose;-3;->[TechNote]Publish;$makeSearch;->aText1)
// COPY ARRAY(aText1;$aTallyPurposes)
// End if 
// For ($incRay;1;cntRay)
// Case of 
// : (curTableNum=58)  //TechNote
// QUERY([TechNote];[TechNote]Publish>0)
// Case of 
// : (theFldNum{aFieldLns{$incRay}}=2)
// $w:=Size of array(aiLoText2)+1
// INSERT IN ARRAY(aiLoText2;$w;1)
// HTML_Distinct (->[TechNote]Name;-3;->[TechNote]Publish;$makeSearch;->aText1)
// aiLoText2{$w}:=$theFont+"TechNote Names: "+$endFont+Html_UrlFill (->aText1;"/Tech_List?Title=";$theBreaks)
// : (theFldNum{aFieldLns{$incRay}}=6)
// $w:=Size of array(aiLoText2)+1
// INSERT IN ARRAY(aiLoText2;$w;1)
// HTML_Distinct (->[TechNote]Subject;-3;->[TechNote]Publish;$makeSearch;->aText1)
// aiLoText2{$w}:=$theFont+"TechNote Subjects: "+$endFont+Html_UrlFill (->aText1;"/Tech_List?subject=";$theBreaks)
// : (theFldNum{aFieldLns{$incRay}}=10)
// $w:=Size of array(aiLoText2)+1
// INSERT IN ARRAY(aiLoText2;$w;1)
// HTML_Distinct (->[TechNote]Author;-3;->[TechNote]Publish;$makeSearch;->aText1)
// aiLoText2{$w}:=$theFont+"TechNote Authors: "+$endFont+Html_UrlFill (->aText1;"/Tech_List?author=";$theBreaks)
// End case 
// : (curTableNum=80)  //Forum
// QUERY([Forum];[Forum]Publish>0)
// Case of 
// : (theFldNum{aFieldLns{$incRay}}=1)
// $w:=Size of array(aiLoText2)+1
// INSERT IN ARRAY(aiLoText2;$w;1)
// HTML_Distinct (->[Forum]Subject;-3;->[Forum]Publish;$makeSearch;->aText1)
// aiLoText2{$w}:=$theFont+"Forum Subjects: "+$endFont+Html_UrlFill (->aText1;"/Forum_List?subject=";$theBreaks)
// : (theFldNum{aFieldLns{$incRay}}=2)
// $w:=Size of array(aiLoText2)+1
// INSERT IN ARRAY(aiLoText2;$w;1)
// HTML_Distinct (->[Forum]Topic;-3;->[Forum]Publish;$makeSearch;->aText1)
// aiLoText2{$w}:=$theFont+"Forum Topics: "+$endFont+Html_UrlFill (->aText1;"/Forum_List?topic=";$theBreaks)
// : (theFldNum{aFieldLns{$incRay}}=11)
// $w:=Size of array(aiLoText2)+1
// INSERT IN ARRAY(aiLoText2;$w;1)
// HTML_Distinct (->[Forum]Purpose;-3;->[Forum]Publish;$makeSearch;->aText1)
// aiLoText2{$w}:=$theFont+"Forum Purpose: "+$endFont+Html_UrlFill (->aText1;"/Forum_List?purpose=";$theBreaks)
// End case 
// : (curTableNum=73)  //TallyResults
// Case of 
// : (theFldNum{aFieldLns{$incRay}}=17)
// $k:=Size of array($aTallyPurposes)
// For ($i;1;$k)
// QUERY([TallyResult];[TallyResult]Publish>0;*)
// QUERY([TallyResult]; & [TallyResult]Purpose=$aTallyPurposes{$i})
// $w:=Size of array(aiLoText2)+1
// INSERT IN ARRAY(aiLoText2;$w;1)
// HTML_Distinct (->[TallyResult]Profile1;-3;->[TallyResult]Publish;$makeSearch;->aText1)
// aiLoText2{$w}:=$theFont+"Who: "+$aTallyPurposes{$i}+$endFont+Html_UrlFill (->aText1;"/Library?purpose="+$aTallyPurposes{$i}+"?Who=";$theBreaks)
// End for 
// : (theFldNum{aFieldLns{$incRay}}=18)
// $k:=Size of array($aTallyPurposes)
// For ($i;1;$k)
// QUERY([TallyResult];[TallyResult]Publish>0;*)
// QUERY([TallyResult]; & [TallyResult]Purpose=$aTallyPurposes{$i})
// $w:=Size of array(aiLoText2)+1
// INSERT IN ARRAY(aiLoText2;$w;1)
// HTML_Distinct (->[TallyResult]Profile2;-3;->[TallyResult]Publish;$makeSearch;->aText1)
// aiLoText2{$w}:=$theFont+"Topic: "+$aTallyPurposes{$i}+$endFont+Html_UrlFill (->aText1;"/Library?purpose="+$aTallyPurposes{$i}+"?topic=";$theBreaks)
// End for 
// : (theFldNum{aFieldLns{$incRay}}=19)
// $k:=Size of array($aTallyPurposes)
// For ($i;1;$k)
// QUERY([TallyResult];[TallyResult]Publish>0;*)
// QUERY([TallyResult]; & [TallyResult]Purpose=$aTallyPurposes{$i})
// $w:=Size of array(aiLoText2)+1
// INSERT IN ARRAY(aiLoText2;$w;1)
// HTML_Distinct (->[TallyResult]Profile3;-3;->[TallyResult]Publish;$makeSearch;->aText1)
// aiLoText2{$w}:=$theFont+"Subject: "+$aTallyPurposes{$i}+$endFont+Html_UrlFill (->aText1;"/Library?purpose="+$aTallyPurposes{$i}+"?subject=";$theBreaks)
// End for 
// End case 
// End case 
// End for 
//   //     
// Case of 
// : (curTableNum=58)
// CONFIRM("Do TechNote Keywords?")
// If (OK=1)
// Srch_FullDia (Table(curTableNum))
// $makeSearch:="SkipSearch"
// $w:=Size of array(aiLoText2)+1
// INSERT IN ARRAY(aiLoText2;$w;1)
// HTML_Distinct (->;-3;->[TechNote]Publish;$makeSearch;->aText1)
// aiLoText2{$w}:=$theFont+"TechNote Keywords: "+$endFont+Html_UrlFill (->aText1;"/Tech_List?keyword=";$theBreaks)
// End if 
// 
// End case 
//   //   
// $selectText:=""
// $k:=Size of array(aiLoText2)
// For ($i;1;$k)
// $selectText:=$selectText+aiLoText2{$i}+"\r"+"<p>"
// End for 
// 
// Case of 
// : (is4DWriteUser=3)
// //**WR INSERT TEXT (eLetterArea;$selectText)
// Else 
// vTextSummary:=$selectText+"\r"+"\r"+vTextSummary
//   //SET TEXT TO CLIPBOARD($selectList)
// End case 
// End if 
// ARRAY TEXT(aiLoText2;0)
// End if 