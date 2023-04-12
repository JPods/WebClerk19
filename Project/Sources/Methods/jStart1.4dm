//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/11/10, 11:51:21
// ----------------------------------------------------
// Method: jStart1
// Description
// 
//
// Parameters
// ----------------------------------------------------

$viMilliseconds:=Milliseconds:C459

C_LONGINT:C283(<>userCount)

//
C_LONGINT:C283($userIs)
//: (Application type=4D Client)
// $docPath:=Structure file
//Else 

//End case 
C_LONGINT:C283(<>cartSize)
C_TEXT:C284(<>cartWarning)
<>cartSize:=28000
<>cartWarning:="% of Max Cart"

GOTO RECORD:C242([DefaultAccount:32]; 0)
If ([DefaultAccount:32]rst4:71="")
	READ WRITE:C146([DefaultAccount:32])
	LOAD RECORD:C52([DefaultAccount:32])
	[DefaultAccount:32]rst4:71:="92609326873495318189713456236987439871234679817235098340349881"
	SAVE RECORD:C53([DefaultAccount:32])
	READ ONLY:C145([DefaultAccount:32])
End if 
vi1:=[DefaultAccount:32]rs1t:68  //Registration Number

If ([DefaultAccount:32]rs2t:69=0)
	READ WRITE:C146([DefaultAccount:32])
	LOAD RECORD:C52([DefaultAccount:32])
	[DefaultAccount:32]rs2t:69:=DateTime_DTTo+Random:C100  //Serial Number
	SAVE RECORD:C53([DefaultAccount:32])
	READ ONLY:C145([DefaultAccount:32])
End if 
vi2:=[DefaultAccount:32]rs2t:69  //Serial Number
vi3:=[DefaultAccount:32]rst3:70
vi4:=DateTime_DTTo
vText9:=[DefaultAccount:32]taxOnShipping:72
//



C_BOOLEAN:C305(<>allowFAX; <>allowZip; <>skipSTA)

<>allowFAX:=((Substring:C12([DefaultAccount:32]rst4:71; 14; 3)="623") & (Is macOS:C1572))
<>allowZip:=(Substring:C12([DefaultAccount:32]rst4:71; 6; 3)="267")
<>skipSTA:=False:C215

//



<>viDoHttpLog:=0
//
REDUCE SELECTION:C351([DefaultAccount:32]; 0)

ARRAY TEXT:C222(<>aProjectList; 0)
ARRAY LONGINT:C221(<>aProjectNumberList; 0)
QUERY:C277([Project:24]; [Project:24]active:3=True:C214)
ORDER BY:C49([Project:24]; [Project:24]description:2; [Project:24]idNum:1)
$k:=Records in selection:C76([Project:24])
If ($k>96)
	REDUCE SELECTION:C351([Project:24]; 96)
End if 
FIRST RECORD:C50([Project:24])
For ($i; 1; $k)
	APPEND TO ARRAY:C911(<>aProjectList; Substring:C12([Project:24]description:2; 1; 64)+"_"+String:C10([Project:24]idNum:1; "0000-0000"))
	APPEND TO ARRAY:C911(<>aProjectNumberList; [Project:24]idNum:1)
	NEXT RECORD:C51([Project:24])
End for 
REDUCE SELECTION:C351([Project:24]; 0)
INSERT IN ARRAY:C227(<>aProjectList; 1; 1)
INSERT IN ARRAY:C227(<>aProjectNumberList; 1; 1)
<>aProjectList{1}:="Project"
<>aProjectNumberList{1}:=-1

$viMilliseconds:=Milliseconds:C459-$viMilliseconds

ConsoleLog("jStart1\t"+String:C10($viMilliseconds))
