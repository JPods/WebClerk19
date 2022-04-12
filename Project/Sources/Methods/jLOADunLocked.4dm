//%attributes = {"publishedWeb":true}
//File to Load;"Comment";Unlocked variable - unLocked
C_POINTER:C301($1; $3)
C_TEXT:C284($2; $4)
C_LONGINT:C283(vLockedFile)
C_LONGINT:C283($curRecNum)
$3->:=0
$curRecNum:=Record number:C243($1->)
If ($curRecNum<0)
	$3->:=1
Else 
	$3->:=Num:C11(Not:C34(Locked:C147($1->)))
	//  If (Not(Locked($1)))
	//    $3:=1
	//  Else 
	//    vLockedFile:=File($1)
	//    ON EVENT CALL("jotcTrap")
	//    loop:=True
	//    While (Loop&Locked($1))
	//      MESSAGE($2+vCR+vCR+"  Press Q to CANCEL.")
	//      LOAD RECORD($1)
	//    End while 
	//    ON EVENT CALL("")
	//    If (Not(Locked($1)))
	//      $3:=1
	//    Else 
	//    $3:=0
	//    End if 
End if 
//vLockedFile:=0