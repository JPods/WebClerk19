
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-11-10T00:00:00, 17:06:24
// ----------------------------------------------------
// Method: [SyncRelation].Input1.Button2
// Description
// Modified: 11/10/16
// 
// 
//
// Parameters
// ----------------------------------------------------

QUERY:C277([DefaultQQQ:15]; [DefaultQQQ:15]PrimeDefault:176=1)
If (Locked:C147([DefaultQQQ:15]))
	ALERT:C41("Default record must be locked or closed")
Else 
	[DefaultQQQ:15]CCPartner:159:=[SyncRelation:103]Partner1AccountID:36
	[DefaultQQQ:15]CCVerHost:118:="SyncRelation"
	[DefaultQQQ:15]CCDeviceType:71:=9  // "SyncRelation"
	// Line 417
	// JsetDefaultVar
	[DefaultQQQ:15]CCPartner:159:=[SyncRelation:103]Partner1AccountID:36
	[DefaultQQQ:15]CCVerHost:118:="SyncRelation"
	[DefaultQQQ:15]CCVerURL:123:=""
	[DefaultQQQ:15]CCVerPort:119:=0
	[DefaultQQQ:15]CCVerUserName:120:=""
	[DefaultQQQ:15]CCVerPassword:121:=""
	[DefaultQQQ:15]CCVerClientID:122:=""
	
	<>tcCCPartner:=[DefaultQQQ:15]CCPartner:159
	<>tcCCVerHost:=[DefaultQQQ:15]CCVerHost:118
	<>tcCCVerURL:=[DefaultQQQ:15]CCVerURL:123
	<>tcCCVerPort:=[DefaultQQQ:15]CCVerPort:119
	<>tcCCVerUserName:=[DefaultQQQ:15]CCVerUserName:120
	<>tcCCVerPassword:=[DefaultQQQ:15]CCVerPassword:121
	<>tcCCVerClientID:=[DefaultQQQ:15]CCVerClientID:122
	
	<>tcCcDevice:=<>ciCCDevSyncRelations  // 9
	
	SAVE RECORD:C53([DefaultQQQ:15])
	ALL RECORDS:C47([DefaultAccount:32])
	// <>tcCcDevice
	UNLOAD RECORD:C212([DefaultQQQ:15])
	UNLOAD RECORD:C212([DefaultAccount:32])
	ALERT:C41("Default set")
End if 