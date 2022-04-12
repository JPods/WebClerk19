//%attributes = {"publishedWeb":true}
If (False:C215)
	TCStrong_prf_v142_PictBundle
	//02/03/03.prf
	//code changes to replace PictBundle plugin
End if 

//C_POINTER($1;$2)
//C_LONGINT($i;$k;$fileNum)
//C_PICTURE($picBund)
//$k:=Count fields($1->)
//$fileNum:=Table($1)
//$picBund:=CreateBundle
//For ($i;1;$k)
//Case of 
//: (Type(Field($fileNum;$k)->)=0)//String
//PutBdlString ($picBund;Field($fileNum;$k)->)
//: (Type(Field($fileNum;$k)->)=1)//Real
//PutBdlReal ($picBund;Field($fileNum;$k)->)
//: (Type(Field($fileNum;$k)->)=2)// Text
//PutBdlText ($picBund;Field($fileNum;$k)->)
//: (Type(Field($fileNum;$k)->)=3)//Pict
//PutBdlPict ($picBund;Field($fileNum;$k)->)
//: (Type(Field($fileNum;$k)->)=4)//Date
//PutBdlDate ($picBund;Field($fileNum;$k)->)
////5
//: (Type(Field($fileNum;$k)->)=6)//Boolean
//PutBdlShort ($picBund;Num(Field($fileNum;$k)->))
////7
//: (Type(Field($fileNum;$k)->)=8)//Integer
//PutBdlShort ($picBund;Field($fileNum;$k)->)
//: (Type(Field($fileNum;$k)->)=9)//Longint
//PutBdlLong ($picBund;Field($fileNum;$k)->)
////10
//: (Type(Field($fileNum;$k)->)=11)//Time
//PutBdlLong ($picBund;Field($fileNum;$k)->*1)
//End case 
//End for 
//SetBdlPos ($picBund;0)
//$2->:=$picBund