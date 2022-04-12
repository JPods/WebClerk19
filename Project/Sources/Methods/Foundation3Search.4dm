//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-05-03T00:00:00, 11:17:00
// ----------------------------------------------------
// Method: Foundation3Search
// Description
// Modified: 05/03/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($returnText; $0)
$returnText:=$returnText+"<div class="+Txt_Quoted("row")+">"+"\r"
$returnText:=$returnText+"<div class="+Txt_Quoted("panel")+">"+"\r"
$returnText:=$returnText+"<div class="+Txt_Quoted("row")+">"+"\r"
$returnText:=$returnText+"<div class="+Txt_Quoted("medium-4 columns")+">"+"\r"
// $returnText:=$returnText+"<p>Track Packages by PO Number</p>"+"\r"
$returnText:=$returnText+"<div class="+Txt_Quoted("row collapse")+">"+"\r"
$returnText:=$returnText+"<div class="+Txt_Quoted("medium-8 columns")+">"+"\r"
$returnText:=$returnText+"<input type="+Txt_Quoted("text")+" placeholder="+Txt_Quoted("Packages By Track#")+">"+"\r"
$returnText:=$returnText+"</div>"+"\r"
$returnText:=$returnText+"<div class="+Txt_Quoted("medium-4 columns")+">"+"\r"
$returnText:=$returnText+"<a href="+Txt_Quoted("#")+" class="+Txt_Quoted("alert button postfix expand")+">"+"Search"+"</a>"+"\r"
$returnText:=$returnText+"</div>"+"\r"
$returnText:=$returnText+"</div>"+"\r"
$returnText:=$returnText+"</div>"+"\r"
$returnText:=$returnText+"<div class="+Txt_Quoted("medium-4 columns")+">"+"\r"
// $returnText:=$returnText+"<p>Search Orders by PO Number</p>"+"\r"
$returnText:=$returnText+"<div class="+Txt_Quoted("row collapse")+">"+"\r"
$returnText:=$returnText+"<div class="+Txt_Quoted("medium-8 columns")+">"+"\r"
$returnText:=$returnText+"<input type="+Txt_Quoted("text")+" placeholder="+Txt_Quoted("Orders By PO#")+">"+"\r"
$returnText:=$returnText+"</div>"+"\r"
$returnText:=$returnText+"<div class="+Txt_Quoted("medium-4 columns")+">"+"\r"
$returnText:=$returnText+"<a href="+Txt_Quoted("#")+" class="+Txt_Quoted("alert button postfix expand")+">"+"Search"+"</a>"+"\r"
$returnText:=$returnText+"</div>"+"\r"
$returnText:=$returnText+"</div>"+"\r"
$returnText:=$returnText+"</div>"+"\r"
$returnText:=$returnText+"<div class="+Txt_Quoted("medium-4 columns")+">"+"\r"
// $returnText:=$returnText+"<p>Search Invoices by PO Number</p>"+"\r"
$returnText:=$returnText+"<div class="+Txt_Quoted("row collapse")+">"+"\r"
$returnText:=$returnText+"<div class="+Txt_Quoted("medium-8 columns")+">"+"\r"
$returnText:=$returnText+"<input type="+Txt_Quoted("text")+" placeholder="+Txt_Quoted("Invoices by PO#")+">"+"\r"
$returnText:=$returnText+"</div>"+"\r"
$returnText:=$returnText+"<div class="+Txt_Quoted("medium-4 columns")+">"+"\r"
$returnText:=$returnText+"<a href="+Txt_Quoted("#")+" class="+Txt_Quoted("alert button postfix expand")+">"+"Search"+"</a>"+"\r"
$returnText:=$returnText+"</div>"+"\r"
$returnText:=$returnText+"</div>"+"\r"
$returnText:=$returnText+"</div>"+"\r"
$returnText:=$returnText+"</div>"+"\r"
$returnText:=$returnText+"</div>"+"\r"
$returnText:=$returnText+"</div>"+"\r"

//  SET TEXT TO PASTEBOARD($returnText)

$0:=$returnText