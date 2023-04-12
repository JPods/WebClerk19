//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/23/10, 12:49:52
// ----------------------------------------------------
// Method: jNavResetSplash
// Description
// 
//
// Parameters
// ----------------------------------------------------
MESSAGES OFF:C175
StopAddLoop:=True:C214
StopModLoop:=True:C214
//ON ERR CALL("jOECNoAction")//May 3, 1995
//USE SET("AddRecSet")//why was this here
//CLEAR SET("AddRecSet")
//ON ERR CALL("")
If (vHere=2)
	doOLO:=True:C214
Else 
	doOLO:=False:C215
End if 
READ WRITE:C146([Customer:2])
Wcc_ReduceSelection(1)
If (vHere>1)  //changed vHere from zero to vHere:=vHere-1 to fix the re-direct by included layouts to their table on closing the iLo
	vHere:=vHere-1
	If (vHere=1)
		OLO_HereAndMenu
	End if 
Else 
	vHere:=0
End if 
ARRAY LONGINT:C221(aPagePath; Get last table number:C254)
aPagePath{Table:C252(ptCurTable)}:=1  // done in the before phase
booSorted:=False:C215
vComStr60:=""
//TRACE
//If (Current process=1)
C_LONGINT:C283($viProcess)
$viProcess:=Current process:C322
//MENU BAR(splashMenu;$viProcess;*)
//End if 

SET WINDOW TITLE:C213(Storage:C1525.default.MenuTitle)
MESSAGES ON:C181
srVarLoad(0)
//List_RaySize (0)//May 22, 2000 ignor this
ARRAY TEXT:C222(aStructure; 0)

//MapProgram 
C_LONGINT:C283(seniorProcess)
If (seniorProcess>0)
	C_LONGINT:C283(<>reLoadRecords)
	<>prcControl:=301
	POST OUTSIDE CALL:C329(seniorProcess)
	seniorProcess:=0
End if 