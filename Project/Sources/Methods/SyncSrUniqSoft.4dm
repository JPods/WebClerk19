//%attributes = {"publishedWeb":true}
C_BOOLEAN:C305($0)
C_POINTER:C301($ptCurFile)
$ptCurFile:=aSyncFilePt{aSyncCnt}
$0:=True:C214
Case of 
	: ($ptCurFile=(->[Lead:48]))
		vText6:=[Lead:48]NameLast:2
		vText7:=[Lead:48]Phone:4
		$0:=SyncSrThese(->[Lead:48]NameLast:2; ->vText6; ->[Lead:48]Phone:4; ->vText7)
	: ($ptCurFile=(->[QQQContact:13]))
		vText6:=[QQQContact:13]Company:23
		vText7:=[QQQContact:13]NameFirst:2
		vText8:=[QQQContact:13]NameLast:4
		$0:=SyncSrThese(->[QQQContact:13]Company:23; ->vText6; ->[QQQContact:13]NameFirst:2; ->vText7; ->[QQQContact:13]NameLast:4; ->vText8)
		//
	: ($ptCurFile=(->[QQQCustomer:2]))
		vText7:=[QQQCustomer:2]company:2
		vText6:=[QQQCustomer:2]phone:13
		$0:=SyncSrThese(->[QQQCustomer:2]phone:13; ->vText6; ->[QQQCustomer:2]company:2; ->vText7)
		//    
		//KeyModifierCurrent 
		//Case of 
		//: ((OptKey=1)&($0=False))
		//TRACE
		//$theString:="("
		//PostEvt ($theString;256;myErr)
		//: ((OptKey=1)&($0=True))
		//BEEP
		//BEEP
		//End case 
	: ($ptCurFile=(->[Service:6]))
		vi1:=[Service:6]dtEntered:16
		vText6:=[Service:6]ActionCreatedBy:40
		$0:=SyncSrThese(->[Service:6]ActionCreatedBy:40; ->vText6; ->[Service:6]dtEntered:16; ->vi1)
		//
	: ($ptCurFile=(->[Proposal:42]))
		vText6:=[Proposal:42]inquiryCode:6
		vText7:=[Proposal:42]company:11
		vDate1:=[Proposal:42]dateProposed:3
		$0:=SyncSrThese(->[Proposal:42]inquiryCode:6; ->vText6; ->[Proposal:42]company:11; ->vText7; ->[Proposal:42]dateProposed:3; ->vDate1)
		//
	: ($ptCurFile=(->[Order:3]))
		vText6:=[Order:3]customerPOId:3
		vText7:=[Order:3]company:15
		vDate1:=[Order:3]dateOrdered:4
		$0:=SyncSrThese(->[Order:3]customerPOId:3; ->vText6; ->[Order:3]company:15; ->vText7; ->[Order:3]dateOrdered:4; ->vDate1)
		//    
	: ($ptCurFile=(->[Invoice:26]))
		vText6:=[Invoice:26]customerPoNum:29
		vText7:=[Invoice:26]company:7
		vDate1:=[Invoice:26]dateInvoiced:35
		$0:=SyncSrThese(->[Invoice:26]customerPoNum:29; ->vText6; ->[Invoice:26]company:7; ->vText7; ->[Invoice:26]dateInvoiced:35; ->vDate1)
End case 