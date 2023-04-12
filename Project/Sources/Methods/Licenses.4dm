//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2018-08-08T00:00:00, 07:59:25
// ----------------------------------------------------
// Method: Licenses
// Description
// Modified: 08/08/18
// Structure: gkgkgk
// 
//
// Parameters
// ----------------------------------------------------

If (Is macOS:C1572)
	$result:=NTK Register("UAK0LJULJ65M1X82582P")  //  ("AT44C616X9775WNW")  // ("DH1LU58342ETWF")
	//  "66UL60V0PP58PXQX"   // 2017
Else 
	$result:=NTK Register("UAD68U76UT4NE5340541")  //("1FRR29DFXSKK8C0S")  // ("PEUEB5N3565TB7")
	// "776U8UPU005434X4" // 2017
End if 
$result:=NTK Set Error Handler("NTKErrorHandler")

// ### bj ### 20190215_0839 
// forcing the primary licenses unless overwritten by TallyMaster
// having in the case statement causes empty TallyMasters to prevent license recognition

//AreaList Pro v10/255 Users(OEM): 
//Valid until 08/12/21(DD/MM/YY)
//  CHOPPED  AL_Register("009860-OEM JIT CORP-N7Jwz+hkx4TeRob6hIF+PyaAOVRKiBHU")
//www.e-node.net/alp


//CalendarSet v6/255 Users(OEM): 
//Valid until 08/12/21(DD/MM/YY)
//  CHOPPED  CS_Register("009862-OEM JIT CORP-KwktfJXAypV0pC/0yahXOokBy3i+YvHq")
//https:  //www.e-node.net/cs

//PrintList Pro v6/255 Users(OEM): 
//Valid until 08/12/21(DD/MM/YY)
//PL_Register("009863-OEM JIT CORP-pClx3iE5SF7lj+IQnkE300opbVpdaDFb")
//www.e-node.net/plp

//SuperReport Pro v4/255 Users(OEM): 
//Valid until 08/12/21(DD/MM/YY)
SR_Register("009864-OEM JIT CORP-Rg7zQ3sCAohPy4bD3G5FXjsI8SP1l2ID")
//www.e-node.net/srp

// www.e-node.net/srp
C_LONGINT:C283($result)
ConsoleLog("Internal licenses")

QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="Admin"; *)
QUERY:C277([TallyMaster:60];  | [TallyMaster:60]purpose:3="databaselicenses"; *)
QUERY:C277([TallyMaster:60];  & [TallyMaster:60]name:8="databaselicenses")
Case of 
	: (Records in selection:C76([TallyMaster:60])>1)
		
		DELAY PROCESS:C323(Current process:C322; 60)
		ConsoleLog("Multiple TallyMasters records named: databaselicenses")
		REDUCE SELECTION:C351([TallyMaster:60]; 0)
	: (Records in selection:C76([TallyMaster:60])=1)
		//  Execute_TallyMaster ("Startup";"Admin")
		ConsoleLog("TallyMasters named: databaselicenses")
		ExecuteText(0; [TallyMaster:60]script:9)
		REDUCE SELECTION:C351([TallyMaster:60]; 0)
	Else 
		
		// AreaList Pro v10 / 255 Users (OEM):
		// Valid until 5/8/2019
		// 008072-OEM JITCORP-7nY84Dd72iDTlGTfTh05VJBo9IZ2PgDU
		
End case 