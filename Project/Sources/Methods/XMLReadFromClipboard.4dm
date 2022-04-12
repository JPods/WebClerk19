//%attributes = {"publishedWeb":true}
//XMLReadFromClipboard
C_LONGINT:C283($i; $k)
$workingText:=Get text from pasteboard:C524
XMLArrayManagement(0)
XMLParseTags($workingText)
//  --  CHOPPED  AL_UpdateArrays(eHttpEdit; -2)