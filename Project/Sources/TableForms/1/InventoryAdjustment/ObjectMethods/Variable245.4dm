//C_LONGINT($currentProcess;$windowNum;$frontMostWindow;$windowProcessNum)
//$currentProcess:=Current process
//$windowNum:=Current form window
//$frontMostWindow:=Frontmost window(*)
//$windowProcessNum:=Window process($frontMostWindow)

// ### jwm ### 20160616_0957 changed shortcut key to F5

BOM_QtyChange(aLsItemNum{aItemLines{1}}; aItemLines{1}; aLsQtySO{aItemLines{1}}; aLsCost{aItemLines{1}})  //;vr4)
OBJECT SET ENABLED:C1123(b5; False:C215)
//BRING TO FRONT($windowProcessNum)
HIGHLIGHT TEXT:C210(srItem; 1; Length:C16(srItem)+1)  // ### jwm ### 20160622_0857
