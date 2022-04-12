//%attributes = {"publishedWeb":true}


// Modified by: Bill James (2015-12-16T00:00:00: qqqWords TestThis)


//Method: IE_ItemDiscounts
// 
// 
//   // Modified by: William James (2013-07-15T00:00:00)
// 
//   //  ?????  CLEAR THIS PROCEDURE   ?????  
// 
// 
//   //
//   //
// CLOSE DOCUMENT(myDoc)
//   //
// CONFIRM("Import PriceQty breaks, breaks across top, items down")
// If (OK=1)
// myDocName:=""
// $myOK:=EI_OpenDoc (->myDocName;->myDoc;"Open discount file";"";Storage.folder.jitExportsF)  //;jitQRsF
// If ($myOK=1)
// TRACE
// C_TEXT($theBlock)
// RECEIVE PACKET(mydoc;$theBlock;"\t")
// If (OK=1)
// $theCount:=Num($theBlock)
// If ($theCount>0)
// ARRAY REAL($aBreakPoints;$theCount)
// For ($i;1;$theCount)
// RECEIVE PACKET(mydoc;$theBlock;"\t")
// $aBreakPoints{$i}:=Num($theBlock)
// End for 
// RECEIVE PACKET(mydoc;$theBlock;"\r")  //terminator column
// End if 
// Repeat 
// RECEIVE PACKET(mydoc;$itemNum;"\t")
// If (OK=1)
// $itemNum:=Replace string($itemNum;Char(10);"")
// QUERY([Item];[Item]ItemNum=$itemNum)
// If (Records in selection([Item])=1)
// jdeleteAllSubRe (->[Item]PriceBreaks)
// $lastBreak:=0
// For ($i;1;$theCount)
// RECEIVE PACKET(mydoc;$theBlock;"\t")
// $Discnt:=Num($theBlock)
// If (($aBreakPoints{$i}>0) & ($Discnt>0))
// CREATE SUBRECORD([Item]PriceBreaks)
// If ($i=0)
// :=1
// Else 
// :=$aBreakPoints{$i-1}+1
// End if 
// :=$aBreakPoints{$i}
// :=$Discnt
// End if 
// $lastBreak:=$qty
// End for 
// RECEIVE PACKET(mydoc;$theBlock;"\r")  //terminator column
// SAVE RECORD([Item])
// Else 
// RECEIVE PACKET(mydoc;$theBlock;"\r")  //terminator column
// End if 
// End if 
// Until (OK=0)
// CLOSE DOCUMENT(myDoc)
// End if 
// End if 
// End if 
// 
// 