C_TEXT:C284($Name)
C_LONGINT:C283($k; $RecNum)
//$name:=[Employee]nameID
//PUSH RECORD([Employee])
//SEARCH([Employee];[Employee]nameID=$Name)
//$k:=Records in selection([Employee])
//POP RECORD([Employee])
//If ($k=0)
//  CONFIRM("This Employee's nameID will be FIXED as:  "+$Name+".")
//  If (OK=1)
// zzzqqq jCapitalize1st(->[Employee:19]nameid:1)
//   SAVE RECORD([Employee])
//    SET ENTERABLE([Employee]nameID;False)
// Else 
//    GOTO AREA([Employee]nameID)
//    HIGHLIGHT TEXT([Employee]nameID;1;25)
//  End if 
//Else 
// ALERT("This nameID already exists.  Choose another name.")
//  GOTO AREA([Employee]nameID)
//  HIGHLIGHT TEXT([Employee]nameID;1;25)
//End if 
iLo35String1:=[Employee:19]nameid:1