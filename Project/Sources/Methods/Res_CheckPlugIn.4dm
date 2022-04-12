//%attributes = {"publishedWeb":true}
//Method: Res_CheckPlugIn
C_TEXT:C284($1; $2)
C_BOOLEAN:C305($0)
//TRACE
ARRAY LONGINT:C221($thePluginRef; 0)
ARRAY TEXT:C222($thePluginName; 0)
RESOURCE LIST:C500("4BNX"; $thePluginRef; $thePluginName)
C_LONGINT:C283($w)
$w:=Find in array:C230($thePluginName; $1)
$0:=($w>-1)