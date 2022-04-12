//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-04-22T00:00:00, 15:08:38
// ----------------------------------------------------
// Method: ExecuteTallyMasters_Test
// Description
// Modified: 04/22/17
// 
// 
//
// Parameters
// ----------------------------------------------------

QUERY:C277([Customer:2]; [Customer:2]customerID:1="A10006160")
C_POINTER:C301($ptField; $ptVariable)
$ptField:=PointerFromName("[Customer]customerID")
$ptField:=PointerFromName("[Customer]Profile4")
$ptField:=PointerFromName("[Customer]Profile5")
$ptVariable:=Get pointer:C304("vText1")


viRecursive:=0
vScriptRecursive:=""
Execute_TallyMaster("Level1"; "Test")