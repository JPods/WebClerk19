//%attributes = {"publishedWeb":true}
//C_LONGINT($CurFile)
//C_TEXT($1)
//$CurFile:=curFile
//curFile:=File([PO])
//vPhone:=""
//vZip:=""
//vName:=""
//vAcct:=""
//If (Count parameters=1)
//v2:=$1
//Else 
//v2:="Go To PO"
//End if 
//vDiaCom:="Locate Vendor By"
//v4:="Add Vendor"
//jCenterWindow (472;284;1)
//DIALOG([Customer];"FINDAddRecRay")
//CLOSE WINDOW
//array TEXT(aCustomers;0)
//array TEXT(aCustCity;0)
//array TEXT(aCustZip;0)
//array TEXT(aCustPhone;0)
//array TEXT(aCustAcct;0)
//array TEXT(aCustRep;0)
//array TEXT(aCustSales;0)
//array TEXT(aCustCodes;0)
//array TEXT(aBullets;0)
//ARRAY LONGINT(aBulletCnt;0)
//vPhone:=""
//vZip:=""
//vName:=""
//vAcct:=""
//v2:=""
//v3:=""
//v4:=""
//curFile:=$CurFile
//Case of 
//: (myOK=0)
//// vHere:=5
//// jsplashCancel 
//: (myOK=2)
//USE SET("Bullets")
//ON ERR CALL("OECNoAction")
//CLEAR SET("AllCusts")
//CLEAR SET("Bullets")
//ON ERR CALL("")
//loadVendor2PO 
//: (myOK=4)
//ADD RECORD([Vendor])
//loadVendor2PO 
//End case 