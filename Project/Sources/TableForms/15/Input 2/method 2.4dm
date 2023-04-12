C_POINTER:C301($ptLastTable)
C_BOOLEAN:C305($fillFromPrevious; $doMore)
C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
If ($formEvent=On Unload:K2:2)
	UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
	READ WRITE:C146(ptCurTable->)
Else 
	Case of 
		: ($formEvent=On Outside Call:K2:11)
			Prs_OutsideCall
		: ($formEvent=On Load:K2:1)
			If (Is new record:C668([Default:15]))
				jAlertMessage(9000)
				CANCEL:C270
			Else 
				
				Case of 
					: (ptCurTable=(->[Customer:2]))
						DISABLE MENU ITEM:C150(3; 14)
						DISABLE MENU ITEM:C150(3; 15)
					: (ptCurTable=(->[Order:3]))
						DISABLE MENU ITEM:C150(4; 10)
						DISABLE MENU ITEM:C150(4; 11)
						DISABLE MENU ITEM:C150(4; 12)
					: (ptCurTable=(->[Proposal:42]))
						DISABLE MENU ITEM:C150(4; 18)
						DISABLE MENU ITEM:C150(4; 19)
					: (ptCurTable=(->[Invoice:26]))
						DISABLE MENU ITEM:C150(5; 6)
						DISABLE MENU ITEM:C150(5; 7)
						DISABLE MENU ITEM:C150(5; 10)
				End case 
				jsetBefore(->[Default:15])
				
				
				If (ptCurTable#(->[TallyMaster:60]))
					TallyMasterPopuuScriptsGeneral(->[DefaultSetup:86]; "DefaultSetups"; ""; "aLooLoScripts")
				End if 
				
				
				booAccept:=(([Default:15]terms:14#"") & ([Default:15]typeSale:16#"") & ([Default:15]shipVia1:7#""))
				b41:=1
				b42:=0
				b43:=0
				b51:=0
				b52:=0
				b53:=0
				
				If ([Default:15]order2POByBLQ:156=0)
					[Default:15]order2POByBLQ:156:=2
				End if 
				ARRAY TEXT:C222(iLoaText1; 5)
				iLoaText1{1}:="Order2POByBLQ"
				iLoaText1{2}:="Select Quantity"
				iLoaText1{3}:="Zero Quantity"
				iLoaText1{4}:="Order Quantity"
				iLoaText1{5}:="Backlog Quantity"
				
				iLoaText1:=[Default:15]order2POByBLQ:156+2
				
				If ([Default:15]helpSource:166=0)
					[Default:15]helpSource:166:=1
				End if 
				ARRAY TEXT:C222(iLoaText2; 3)
				iLoaText2{1}:="WebClerk"
				If (<>vLocalHost#"")
					iLoaText2{2}:=<>vLocalHost
				Else 
					iLoaText2{2}:="No Local web server defined."
				End if 
				iLoaText2{3}:="Both"
				iLoaText2:=[Default:15]helpSource:166
				
				vHeading:=[Default:15]headingPrd1:34
				vClosing:=[Default:15]closingPrd1:35
				//          
				ARRAY TEXT:C222(aText1; 19)
				aText1{1}:="ItemNum Only"
				aText1{2}:="ItemNum then Barcode"
				aText1{3}:="ItemNum then Mfg Num"
				aText1{4}:="Item Num then Barcode then Mfg Num"
				aText1{5}:="Item Num then Mfg Num then Barcode"
				//
				aText1{6}:="Barcode Only"
				aText1{7}:="Barcode then ItemNum"
				aText1{8}:="Barcode then Mfg Num"
				aText1{9}:="Barcode then ItemNum then Mfg Num"
				aText1{10}:="Barcode then Mfg Num then ItemNum"
				//
				aText1{11}:="Mfg Num Only"
				aText1{12}:="Mfg Num then ItemNum"
				aText1{13}:="Mfg Num then Barcode"
				aText1{14}:="Mfg Num then ItemNum then Barcode"
				aText1{15}:="Mfg Num then Barcode then ItemNum"
				//
				aText1{16}:="ItemNum then VendorNum"
				aText1{17}:="ItemNum then VendorNum then Barcode"
				aText1{18}:="VendorNum then ItemNum"
				aText1{19}:="VendorNum then ItemNum then Barcode"
				//
				ARRAY TEXT:C222(aTmpText2; 4)
				aTmpText2{1}:="Store only last 4"
				aTmpText2{2}:="Store encrypted"
				aTmpText2{3}:="Store unencrypted, testing only"
				If ([Default:15]ccStoragePolicy:117=0)
					[Default:15]ccStoragePolicy:117:=1
				End if 
				aTmpText2:=[Default:15]ccStoragePolicy:117
				
				If (([Default:15]itemSrSequence:46>15) | ([Default:15]itemSrSequence:46<1))
					[Default:15]itemSrSequence:46:=1
				End if 
				aText1:=[Default:15]itemSrSequence:46
				jFormatPhone(->[Default:15]fax:12; ->[Default:15]phone:15)
				//
				READ WRITE:C146([Counter:41])
				ALL RECORDS:C47([Counter:41])
				SELECTION TO ARRAY:C260([Counter:41]tableName:2; aTmp20Str1; [Counter:41]counter:1; aTmpLong1; [Counter:41]; aTmpLong2)
				$w:=Find in array:C230(aTmpLong2; 0)
				If ($w>0)
					DELETE FROM ARRAY:C228(aTmp20Str1; $w; 1)
					DELETE FROM ARRAY:C228(aTmpLong1; $w; 1)
					DELETE FROM ARRAY:C228(aTmpLong2; $w; 1)
				End if 
				
				//
				vi2:=0
				If ([Default:15]selectInvField:124<1)
					[Default:15]selectInvField:124:=1
				End if 
				<>aSelectInvField:=[Default:15]selectInvField:124
				
				If ([Default:15]findCustChkbx:126<1)
					[Default:15]findCustChkbx:126:=8
				End if 
				<>aFindCustChkbx:=[Default:15]findCustChkbx:126
				C_PICTURE:C286(<>pNavPalletChange)
				<>pNavPalletChange:=<>pNavPallet
			End if 
	End case 
End if 
If (ptCurTable#(->[Default:15]))
	jsetDuringIncl(->[Default:15])
End if 
If (vMod)
	Case of 
		: (b41=1)
			[Default:15]headingPrd1:34:=vHeading
			[Default:15]closingPrd1:35:=vClosing
		: (b42=1)
			[Default:15]headingPrd2:36:=vHeading
			[Default:15]closingPrd2:37:=vClosing
		: (b43=1)
			[Default:15]headingPrd3:38:=vHeading
			[Default:15]closingPrd3:39:=vClosing
		: (b51=1)
			[Default:15]shipCondition:62:=vHeading
		: (b52=1)
			[Default:15]invoiceCondition:63:=vHeading
		: (b53=1)
			[Default:15]pOCondition:64:=vHeading
	End case 
	vMod:=False:C215
End if 
booAccept:=(([Default:15]terms:14#"") & ([Default:15]typeSale:16#"") & ([Default:15]shipVia1:7#""))
