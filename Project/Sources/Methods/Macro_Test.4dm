//%attributes = {"invisible":true,"shared":true}
//Test method for macros
//This method will be called when you choose the "Macro test" macro
C_TEXT:C284($Txt_method; $Txt_highlighted)

//In $Txt_method, the full method content
GET MACRO PARAMETER:C997(1; $Txt_method)

//In $Txt_highlighted, the highlighted text of the method if any
GET MACRO PARAMETER:C997(2; $Txt_highlighted)

