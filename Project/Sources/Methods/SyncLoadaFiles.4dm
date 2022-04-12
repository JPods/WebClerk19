//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $2; $k)
vi1:=$1
ptCurTable:=Table:C252($2)
jaFilesInitial(False:C215; False:C215)
$k:=Get last field number:C255(ptCurTable)
ARRAY TEXT:C222(aText1; $k)
ARRAY TEXT:C222(aText2; $k)
ARRAY TEXT:C222(aText3; $k)
ARRAY TEXT:C222(aSyncChoose; $k)