//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-08-31T00:00:00, 10:51:49
// ----------------------------------------------------
// Method: WC_MimeBuild
// Description
// Modified: 08/31/17
// 
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($mimeList)

$mimeList:=$mimeList+"suffix"+"\t"+"mime"+"\r"  //  First row of a text block must contain the name for the name value pairs
$mimeList:=$mimeList+"au"+"\t"+"audio/basic"+"\r"
$mimeList:=$mimeList+"class"+"\t"+"application"+"\r"
$mimeList:=$mimeList+"css"+"\t"+"text/css"+"\r"
$mimeList:=$mimeList+"doc"+"\t"+"application/msword"+"\r"
$mimeList:=$mimeList+"gif"+"\t"+"image/gif"+"\r"
$mimeList:=$mimeList+"hqx"+"\t"+"application/mac-binhex40"+"\r"
$mimeList:=$mimeList+"htm"+"\t"+"text/html; charset=utf-8"+"\r"
$mimeList:=$mimeList+"html"+"\t"+"text/html; charset=utf-8"+"\r"
$mimeList:=$mimeList+"ico"+"\t"+"image/vnd"+"\r"
$mimeList:=$mimeList+"jpeg"+"\t"+"image/jpeg"+"\r"
$mimeList:=$mimeList+"jpg"+"\t"+"image/jpeg"+"\r"
$mimeList:=$mimeList+"js"+"\t"+"application/javascript"+"\r"
$mimeList:=$mimeList+"json"+"\t"+"application/json"+"\r"
$mimeList:=$mimeList+"mid"+"\t"+"audio/midi"+"\r"
$mimeList:=$mimeList+"midi"+"\t"+"audio/midi"+"\r"
$mimeList:=$mimeList+"moov"+"\t"+"video/quicktime"+"\r"
$mimeList:=$mimeList+"mov"+"\t"+"video/quicktime"+"\r"
$mimeList:=$mimeList+"mp3"+"\t"+"audio/mpeg"+"\r"
$mimeList:=$mimeList+"mp4"+"\t"+"video/quicktime"+"\r"
$mimeList:=$mimeList+"pdf"+"\t"+"application/pdf"+"\r"
$mimeList:=$mimeList+"pict"+"\t"+"image/pict"+"\r"
$mimeList:=$mimeList+"pjpg"+"\t"+"image/jpeg"+"\r"
$mimeList:=$mimeList+"png"+"\t"+"image/png"+"\r"
$mimeList:=$mimeList+"ppt"+"\t"+"application/vnd.ms-powerpoint"+"\r"
$mimeList:=$mimeList+"shtm"+"\t"+"text/html; charset=utf-8"+"\r"
$mimeList:=$mimeList+"shtml"+"\t"+"text/html; charset=utf-8"+"\r"
$mimeList:=$mimeList+"sit"+"\t"+"application/x-stuffit"+"\r"
$mimeList:=$mimeList+"svg"+"\t"+"image/svg+xml"+"\r"
$mimeList:=$mimeList+"svgz"+"\t"+"image/svg+xml"+"\r"
$mimeList:=$mimeList+"swf"+"\t"+"application/x-shockwave-flash"+"\r"
$mimeList:=$mimeList+"text"+"\t"+"text/plain"+"\r"
$mimeList:=$mimeList+"txt"+"\t"+"text/plain"+"\r"
$mimeList:=$mimeList+"wav"+"\t"+"audio/wav"+"\r"
$mimeList:=$mimeList+"wc"+"\t"+"text/html; charset=utf-8"+"\r"
$mimeList:=$mimeList+"xls"+"\t"+"application/vnd.ms-excel"+"\r"
$mimeList:=$mimeList+"xml"+"\t"+"text/xml"+"\r"
$mimeList:=$mimeList+"zip"+"\t"+"application/zip"+"\r"
// ### bj ### 20190805_0733
$mimeList:=$mimeList+"html"+"\t"+"text/html; charset=utf-8"+"\r"

$0:=jsonTextBlockTojason($mimeList)