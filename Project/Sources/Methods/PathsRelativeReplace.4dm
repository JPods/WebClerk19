//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/14/18, 16:13:44
// ----------------------------------------------------
// Method: PathsRelativeReplace
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($0; $1; $working; $pathReplacement; $result)
$replaceWhat:="/,./,../"


C_TEXT:C284($techPath; $resourcePath; $theChapterFolder; $findImage)
$theChapterFolder:="Chap_"+String:C10([TechNote:58]Chapter:14; "000")
$techPath:="file:///"+<>jitHelpFolder+"technotes/"+$theChapterFolder+"/"
$result:=Tx_ReplaceURLstrings([TechNote:58]BodyText:23; "src=\""; "\""; $techPath; "/,./,../")


// FIXTHIS this changing of paths.
