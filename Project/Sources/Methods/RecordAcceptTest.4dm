//%attributes = {}
// ----------------------------------------------------
// User name (OS): root
// Date and time: 08/13/06, 21:40:50
// ----------------------------------------------------
// Method: RecordAcceptTest
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_BOOLEAN:C305($1; $0; $acceptTests)
C_POINTER:C301($2)
C_LONGINT:C283($theTableNum)
$0:=False:C215
//Case of 
//: (ptCurTable=(->[Base]))



// MustFixQQQZZZ: Bill James (2022-05-26T05:00:00Z)
// Look for new rules for saving
$0:=True:C214  //allow printing from Control without saving
//: (Size of array(<>asiteIDs)>1)  // Modified by: williamjames (130215)

//Case of 
//: (ptCurTable=(->[Invoice]))
//If ([Invoice]siteID="")
//$0:=False
//If (allowAlerts_boo)
//jAlertMessage(9251)
//End if 
//End if 
//: (ptCurTable=(->[PO]))
//If ([PO]siteID="")
//$0:=False
//If (allowAlerts_boo)
//jAlertMessage(9251)
//End if 
//End if 
//Else 

//End case 
//End case 
//If (ptCurTable#(->[Base]))
//If (Size of array(<>aAcceptTest)=0)
//$0:=$1
//Else 
//If (<>aAcceptTest{Table($2)}="")
//$0:=$1
//Else 
//If (booAccept)  // skip Accept test if already false
//C_LONGINT($tableNum; $countTests; $incTM)
//$tableNum:=Table($2)
//If (<>aAcceptTest{$tableNum}="AcceptStack")
//QUERY([TallyMaster]; [TallyMaster]purpose="AcceptTestStack"; *)
//QUERY([TallyMaster];  & [TallyMaster]tableNum=$tableNum; *)
//QUERY([TallyMaster];  & [TallyMaster]publish>0)
//ARRAY TEXT($scriptsAccept; 0)
//$countTM:=Records in selection([TallyMaster])
//If ($countTM>0)
//ORDER BY([TallyMaster]; [TallyMaster]seq)
//FIRST RECORD([TallyMaster])
//For ($incTM; 1; $countTM)
//APPEND TO ARRAY($scriptsAccept; [TallyMaster]script)
//NEXT RECORD([TallyMaster])
//End for 
//End if 
//vResponse:=""
//REDUCE SELECTION([TallyMaster]; 0)
//myOK:=1  // set so the sequence of tests could be approved and dropped out without running all
//For ($incTM; 1; $countTests)
//If ((booAccept) & (myOK=1))
//ExecuteText(0; $scriptsAccept{$incTM})
//$0:=booAccept
//If (myOK=0)
//$incTM:=$countTests
//End if 
//Else 
//booAccept:=(myOK=1)  // if myOK is 1, booAccept drops out as true
//$0:=booAccept
//$incTM:=$countTM
//End if 
//End for 
//Else 
//vResponse:=""
//// ### jwm ### 20190205_0936 update this
//ExecuteText(0; <>aAcceptTest{Table($2)})
//$0:=booAccept
//End if 
//// Else 
//// jAlertMessage (9231)
//If (False)  // turn off acceptTest)
//ARRAY TEXT(<>aAcceptTest; 0)
//End if 
//End if 
//End if 
//End if 
//End if 
//If ($0=False)  //&(vResponse=""))
//jAlertMessage(9231)
//If (RequiredField#"")
//HIGHLIGHT TEXT(*; RequiredField; 1; 255)
//RequiredField:=""
//End if 
//End if 