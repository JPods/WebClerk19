//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-04-30T00:00:00, 23:20:17
// ----------------------------------------------------
// Method: tinyMCE_cleanCR
// Description
// Modified: 04/30/17
// 
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($0)
C_TEXT:C284($1)

$1:=Replace string:C233($1; Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40); Char:C90(Carriage return:K15:38))
$1:=Replace string:C233($1; Char:C90(Line feed:K15:40); Char:C90(Carriage return:K15:38))
$1:=Replace string:C233($1; Char:C90(NUL ASCII code:K15:1); ""; *)
$1:=Replace string:C233($1; Char:C90(65534); ""; *)
$1:=Replace string:C233($1; Char:C90(65535); ""; *)
$1:=Replace string:C233($1; Char:C90(8232); Char:C90(Carriage return:K15:38); *)  //'LINE SEPARATOR' (U+2028) / 0x2028 / 
$1:=Replace string:C233($1; Char:C90(8233); Char:C90(Carriage return:K15:38); *)  //'PARAGRAPH SEPARATOR' (U+2029) / 0x2029 / 
$0:=Replace string:C233($1; Char:C90(Carriage return:K15:38); "\\r\\n")