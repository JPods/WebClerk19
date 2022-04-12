//%attributes = {"publishedWeb":true}
//C_PICTURE(myBundle)
//$cntRec:=Records in selection($1)
//$cntFld:=Count fields($1)
//C_LONGINT($cntRec;$cntFld;$incRec;$incFld;$fileNum)
//$fileNum:=File($1)
//FIRST RECORD($1)
//For ($incRec;1;$cntRec)
//PutBdlLong (myBundle;$fileNum)
//PutBdlLong (myBundle;$cntRec)
//For ($incFld;1;$cntFld)
//Case of 
//: (Type(Field($fileNum;$incFld))=0)
//PutBdlString (myBundle;Field($fileNum;$incFld))
//: (Type(Field($fileNum;$incFld))=2)//String; Text
//$0:=$1
//: ((Type($1)=1)|(Type($1)=8)|(Type($1)=9))//Real; Integer;
// Longint
//$0:=String($1)
//: (Type($1)=4)//Date
//$0:=String($1)
//: (Type($1)=11)//Time
//$0:=String($1)
//: (Type($1)=6)//Boolean
//$0:=String(Num($1))
//End case //