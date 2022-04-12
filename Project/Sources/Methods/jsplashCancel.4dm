//%attributes = {"publishedWeb":true}
//Procedure: jsplashCancel//
//October 25, 1995
MESSAGES OFF:C175

//ON ERR CALL("jOECAlert")
//$theString:=(5+vHere)*"."
//PostEvt ($theString;256;myErr)
CANCEL:C270
//ON ERR CALL("")
jNavResetSplash
jCancelClrRays
myCycle:=0
myOk:=0
booDuringDo:=False:C215  //needed for action buttons
MESSAGES ON:C181