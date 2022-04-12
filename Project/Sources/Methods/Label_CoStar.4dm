//%attributes = {"publishedWeb":true}
//
////<>vi_CS_Error:=CS_Dimensions (<>vl_LabelHnd;<>vi_Height;<>vi_Width)// 
//// PRINT AREA SIZE 
////<>vi_CS_User:=CS_Print (<>vl_LabelHnd)//  PRINT DIALOG CALL 
//
//
////If ($err=0)
////
////$err:=CS_Page_SetUp (<>vl_LabelHnd)//  PAGE SETUP DIALOG CALL 
////$err:=CS_Dimensions (<>vl_LabelHnd;80;236)//handle, height, width
////$err:=CS_Page_SetUp (<>vl_LabelHnd)//
////
////End if 
////If ($err#0)
////ALERT("CoStar Printer cannot be used.")
////End if 
////
//$err:=CS_Select(<>vl_LabelHnd)//  PRINTER SELECTION 
//C_LONGINT(<>vl_LabelHnd;<>vl_thisLabe;<>viFontID;<>viFontSz;$i;$k)
//array TEXT(<>aFontList;0)
//$vi_Error:=Get_Font_List (<>aFontList)
//<>aFontList:=Find in array(<>aFontList;"Helvetica")
//<>viFontSz:=18
//jCenterWindow (228;76;1)
//DIALOG([Control];"Dia_FontSize")
//CLOSE WINDOW
//If (OK=1)
//<>viFontID:=Get_Font_ID (<>aFontList{<>aFontList})
//$err:=CS_Directional (<>vl_LabelHnd;0)
//$err:=CS_Continuous (<>vl_LabelHnd;0)//0 off, 1 on will print across the
// label boundry
//
//$err:=CS_Orientation (<>vl_LabelHnd;0)//0-Landscape, 1 portrait
//$err:=CS_Num_Copies (<>vl_LabelHnd;1)//number of copies
////
//FONT(CustAddress;<>viFontID)
//FONT SIZE(CustAddress;<>viFontSz)
////
//$err:=CS_Start_Print (<>vl_LabelHnd)
//$k:=Records in selection(ptCurFile->)
//FIRST RECORD(ptCurFile->)
//TRACE
//C_TEXT(CustAddress)
//For ($i;1;$k)
//PVars_AddressFull (ptCurFile;->CustAddress)
//$err:=CS_Create_Label (<>vl_LabelHnd;<>vl_thisLabe;CustAddress;<>viFontID
//;<>viFontSz;0)
//$err:=CS_Print_Label (<>vl_LabelHnd;<>vl_thisLabe)
//NEXT RECORD(ptCurFile->)
//End for 
//$err:=CS_Stop_Print (<>vl_LabelHnd)
////
//End if 
//CLEAR VARIABLE(CustAddress)
//array TEXT(<>aFontList;0)