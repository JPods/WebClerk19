//%attributes = {"publishedWeb":true}
//C_LONGINT($1;$2;$i;$k)
//C_TEXT($3;$4;$theSummary;$0)
//ARRAY TEXT(aText1;0)
//DISTINCT VALUES(File($1;$2);aText1)
//$theSummary:=""
//$k:=Size of array(aText1)
//For ($i;1;$k)
//$theSummary:=$theSummary+$3+aText1{vi1}+$4
//End for 
//$0:=$theSummary
//CopyTEXT ($theSummary)