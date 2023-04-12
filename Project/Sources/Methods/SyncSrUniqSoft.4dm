//%attributes = {"publishedWeb":true}
C_BOOLEAN:C305($0)
C_POINTER:C301($ptCurFile)
$ptCurFile:=aSyncFilePt{aSyncCnt}
$0:=True:C214
Case of 
	: ($ptCurFile=(->[Contact:13]))
		vText6:=[Contact:13]company:23
		vText7:=[Contact:13]nameFirst:2
		vText8:=[Contact:13]nameLast:4
		$0:=SyncSrThese(->[Contact:13]company:23; ->vText6; ->[Contact:13]nameFirst:2; ->vText7; ->[Contact:13]nameLast:4; ->vText8)
		//
	: ($ptCurFile=(->[Customer:2]))
		vText7:=[Customer:2]company:2
		vText6:=[Customer:2]phone:13
		$0:=SyncSrThese(->[Customer:2]phone:13; ->vText6; ->[Customer:2]company:2; ->vText7)
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
		vi1:=[Service:6]dtDocument:16
		vText6:=[Service:6]actionCreatedBy:40
		$0:=SyncSrThese(->[Service:6]actionCreatedBy:40; ->vText6; ->[Service:6]dtDocument:16; ->vi1)
		//
	: ($ptCurFile=(->[Proposal:42]))
		vText6:=[Proposal:42]inquiryCode:6
		vText7:=[Proposal:42]company:11
		vDate1:=[Proposal:42]dateDocument:3
		$0:=SyncSrThese(->[Proposal:42]inquiryCode:6; ->vText6; ->[Proposal:42]company:11; ->vText7; ->[Proposal:42]dateDocument:3; ->vDate1)
		//
	: ($ptCurFile=(->[Order:3]))
		vText6:=[Order:3]customerPO:3
		vText7:=[Order:3]company:15
		vDate1:=[Order:3]dateDocument:4
		$0:=SyncSrThese(->[Order:3]customerPO:3; ->vText6; ->[Order:3]company:15; ->vText7; ->[Order:3]dateDocument:4; ->vDate1)
		//    
	: ($ptCurFile=(->[Invoice:26]))
		vText6:=[Invoice:26]customerPO:29
		vText7:=[Invoice:26]company:7
		vDate1:=[Invoice:26]dateDocument:35
		$0:=SyncSrThese(->[Invoice:26]customerPO:29; ->vText6; ->[Invoice:26]company:7; ->vText7; ->[Invoice:26]dateDocument:35; ->vDate1)
End case 