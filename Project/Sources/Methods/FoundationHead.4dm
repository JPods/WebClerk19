//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-05-03T00:00:00, 10:01:18
// ----------------------------------------------------
// Method: FoundationHead
// Description
// Modified: 05/03/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($headText; $0)
$headText:=""


$headText:="<!doctype html>"+"\r"

$headText:=$headText+"<html class"+Txt_Quoted("no-js")+" lang="+Txt_Quoted("en")+">"+"\r"

$headText:=$headText+"<head>"+"\r"
$headText:=$headText+"<title>"+Storage:C1525.default.company+" | "+<>aTableNames{curTableNum}+"</title>"+"\r"
$headText:=$headText+"<link rel"+Txt_Quoted("stylesheet")+" href="+Txt_Quoted("css/foundation.css")+"/>"+"\r"
$headText:=$headText+"<link rel"+Txt_Quoted("stylesheet")+" href="+Txt_Quoted("css/foundation-datepicker.css")+"/>"+"\r"
$headText:=$headText+"<link rel"+Txt_Quoted("stylesheet")+" href="+Txt_Quoted("css/webclerk.css")+"/>"+"\r"
$headText:=$headText+"<script src"+Txt_Quoted("js/vendor/jquery.js")+"></script>"+"\r"
$headText:=$headText+"<script src"+Txt_Quoted("js/vendor/modernizr.js")+"></script>"+"\r"
$headText:=$headText+"<script src"+Txt_Quoted("js/foundation-datepicker.js")+"></script>"+"\r"+"\r"

$headText:=$headText+"<meta charset"+Txt_Quoted("utf-8")+"/>"+"\r"
$headText:=$headText+"<meta name"+Txt_Quoted("viewport")+" content"+Txt_Quoted("width=device-width, initial-Scale=1")+"/>"+"\r"

C_TEXT:C284($returnText)
$returnText:=HTMLMetaTags

$headText:=$headText+$returnText+"\r"
$headText:=$headText+"</head>"+"\r"

// SET TEXT TO PASTEBOARD($headText)

$0:=$headText





