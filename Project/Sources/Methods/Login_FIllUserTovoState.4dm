//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/04/21, 16:43:41
// ----------------------------------------------------
// Method: Login_FIllUserTovoState
// Description
// 
// Parameters
// ----------------------------------------------------



Case of 
	: (obRemoteUser.id=Null:C1517)  // no RemoteUser located
		voState.user.end.typeSale:=<>tcPriceLvlA  // set for value of PricePointA
		
	: (obRemoteUser.tableNum=19)  //  | (obRemoteUser.tableName="Employee") | (obRemoteUser.tableName="Rep"))
		voState.user.wcc.idPrimary:=obRemoteUser.idPrimary
		voState.user.wcc.tableName:=obRemoteUser.tableName
		voState.user.wcc.securityLevel:=obRemoteUser.securityLevel
		voState.user.wcc.idRemote:=obRemoteUser.id
		voState.user.wcc.userName:=obRemoteUser.id
		voState.user.wcc.role:=obRemoteUser.role
		voState.user.wcc.route:=obRemoteUser.route
	Else 
		voState.user.end.id:=obRemoteUser.idPrimary
		voState.user.end.tableName:=obRemoteUser.tableName
		voState.user.end.securityLevel:=obRemoteUser.securityLevel
		voState.user.end.idRemote:=obRemoteUser.id
		voState.user.end.userName:=obRemoteUser.id
		voState.user.end.role:=obRemoteUser.role
		voState.user.end.route:=obRemoteUser.route
		C_COLLECTION:C1488($catalogs)
		$catalogs:=New collection:C1472
		C_OBJECT:C1216($obRec)
		// need to adjust this for contacts and others
		voState.user.end.typeSale:=ds:C1482[obRemoteUser.tableName].query("id = :1"; obRemoteUser.idPrimary).first().typeSale
		Case of 
			: (voState.user.end.typeSale=Null:C1517)
				voState.user.end.typeSale:=<>tcPriceLvlA  // set for value of PricePointA
			: (voState.user.end.typeSale="")
				voState.user.end.typeSale:=<>tcPriceLvlA
				
		End case 
		voState.user.end.catalogs:=$catalogs
End case 