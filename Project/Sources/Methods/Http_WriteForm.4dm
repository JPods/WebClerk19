//%attributes = {"publishedWeb":true}
//C_LONGINT($myOK;$w;$k;$lenStart;$lenMid;$lenEnd)
//C_TEXT(vText1;$sendText)
//C_TEXT($name;$startStr;$endStr;$midStr)
//$startStr:="!xjit="
//$midStr:=";"
//$endStr:="!"
//$myText:=""
//$lenStart:=Length($startStr)//p will already be at 1
//$lenMid:=Length($midStr)
//$lenEnd:=Length($endStr)+1//grabbing in the middle, must add 1
////
//myDocName:=""
//$myOK:=EI_OpenDoc (myDocName;sumDoc;"Select Form Template";""
//;Storage.folder.jitExportsF)//;jitQRsF
//If ($myOK=1)
//RECEIVE PACKET(sumDoc;vText1;32000)
//CLOSE DOCUMENT(sumDoc)
//myDocName:=""
//myDocName:=PutFileName ("Name the Form";<>aTableNames{<>aTableNames}+".html"
//)
//If (myDocName#"")
//myDoc:=create document(myDocName)
//If (OK=1)
//$w:=Position("!$startStr=";vText1)
//While ($w>0)
//SEND PACKET(myDoc;Substring(vText1;1;$w-1))
//vText1:=Substring(vText1;6)
//$name:=Substring(vText1;$w+8)
//SEND PACKET(myDoc;$sendText+<>aTableNames{<>aTableNames})
//End if 
//$w:=Position("!xjitForm";vText1)
//If ($w>0)
//$sendText:=Substring(vText1;1;$w-1)
//vText1:=Substring(vText1;$w+8)
//SEND PACKET(myDoc;$sendText+<>aTableNames{<>aTableNames})
//End if 
//$w:=Position("!xjitBegin";vText1)
//If ($w>0)
//$sendText:=Substring(vText1;1;$w-1)
//vText1:=Substring(vText1;$w+8)
//SEND PACKET(myDoc;$sendText+<>aTableNames{<>aTableNames})
//End if 
//
//
//
//
//
//
//End if 