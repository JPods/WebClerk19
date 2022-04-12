//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/08/20, 22:01:12
// ----------------------------------------------------
// Method: HO_CatalogCCS_dead
// Description
// 
//
// Parameters
// ----------------------------------------------------



If (False:C215)
	ALL RECORDS:C47([Item:4])
	DELETE SELECTION:C66([Item:4])
	
	curTableNum:=4
	C_TEXT:C284($vtPath)
	$vtPath:=Convert path POSIX to system:C1107("/Users/williamjames/Documents/CommerceExpert/jitExports/004_Items_202005052.out")
	Records_In(Table:C252(curTableNum); ->$vtPath)
	
	QUERY:C277([Item:4]; [Item:4]itemNum:1="@-Copp@")
	QUERY:C277([Item:4]; [Item:4]itemNum:1="@-CSS")
	vi2:=Records in selection:C76([Item:4])
	FIRST RECORD:C50([Item:4])
	For (vi1; 1; vi2)
		[Item:4]itemNum:1:=Replace string:C233([Item:4]itemNum:1; "-Copperfield"; "-CCS")
		[Item:4]itemNum:1:=Replace string:C233([Item:4]itemNum:1; "-Copperfld"; "-CCS")
		[Item:4]itemNum:1:=Replace string:C233([Item:4]itemNum:1; "-CSS"; "-CCS")
		SAVE RECORD:C53([Item:4])
		NEXT RECORD:C51([Item:4])
	End for 
	
End if 

C_TEXT:C284($vtChangeReport)
C_REAL:C285($costDifference; $vrPerCentChange)

C_POINTER:C301($ptRowArray)
ARRAY TEXT:C222($aRowArray; 0)
ARRAY TEXT:C222($aExistingArray; 0)

C_TEXT:C284($1; $vtPathToCatalog; $2; $vtVendor)
C_TEXT:C284($vtCatalog)

C_TEXT:C284($vtMfgID; $vtMfgItemNum; $vtVendorID; $vtVendorItemNum; $vtBarCode; $vtEAN)

C_OBJECT:C1216($obPage)
C_OBJECT:C1216($obCatalog)
//
ARRAY OBJECT:C1221($aObRecords; 0)
If (Count parameters:C259=2)
	TEXT TO DOCUMENT:C1237($1; $vtCatalog)
	$vtVendor:=$2
Else 
	CONFIRM:C162("Open Copperfield Catagory Catalog")
	If (OK=1)
		$vtVendor:="CCS"
		myDoc:=Open document:C264("")
		//myDoc:=Open document("Beldin:Users:williamjames:Dropbox:AdvanceChimney:Copperfield-Data:archive-2020-Feb-12-184836:archive-2020-Apr-08-134149:productsbyvendor_9990819437-10.txt")
		If (OK=1)
			CLOSE DOCUMENT:C267(myDoc)
			$vtCatalog:=Document to text:C1236(document)
		End if 
	End if 
End if 



If ($vtCatalog="")
	ALERT:C41("No Catalog found")
Else 
	CREATE EMPTY SET:C140([Item:4]; "CatalogUpdated")
	CREATE EMPTY SET:C140([Item:4]; "Not-In-Catalog")
	CREATE EMPTY SET:C140([Item:4]; "In-Catalog")
	CREATE EMPTY SET:C140([Item:4]; "Has-Image")
	CREATE EMPTY SET:C140([Item:4]; "No-Image")
	
	
	
	// get the records in the database. Put them into an array to test against
	QUERY:C277([Item:4]; [Item:4]itemNum:1="@-"+$vtVendor)
	
	CREATE SET:C116([Item:4]; "Existing")
	
	C_LONGINT:C283($viRecordsInDB; $viMalFormed)
	SELECTION TO ARRAY:C260([Item:4]itemNum:1; $aExistingArray)
	$viRecordsInDB:=Size of array:C274($aExistingArray)
	ConsoleMessage("  ----  ")
	ConsoleMessage("Items in table Start: "+"\t"+String:C10(Records in table:C83([Item:4])))
	ConsoleMessage("Items in database: "+"\t"+String:C10($viRecordsInDB))
	OB SET:C1220($obCatalog; "In database"; Size of array:C274($aExistingArray))
	
	// get the size of the catalog
	TextToArray($vtCatalog; ->$aRowArray; "\r")
	ConsoleMessage("Incoming catalog: "+"\t"+String:C10(Size of array:C274($aRowArray)))
	OB SET:C1220($obCatalog; "Incoming"; Size of array:C274($aRowArray))
	
	ARRAY TEXT:C222($atHeaders; 0)
	ARRAY TEXT:C222($atValues; 0)
	
	C_LONGINT:C283($cntCat; $incCat)
	C_TEXT:C284($vtTypeUpdate)
	C_LONGINT:C283($cntFields; $incFields; $viArrayFound)
	C_LONGINT:C283($viMatching; $viCatalogOnly; $viDatabaseOnly)
	C_TEXT:C284($vtItemNum)
	C_REAL:C285($vrCostChange; $vrChangeScale; $vrCostOriginal)
	C_LONGINT:C283($dtCurrent)
	$dtCurrent:=DateTime_Enter
	
	$cntCat:=Size of array:C274($aRowArray)
	If ($cntCat>1)
		// grab the headers
		TextToArray($aRowArray{1}; ->$atHeaders; "\t")
		$cntFields:=Size of array:C274($atHeaders)
		$vtChangeReport:="Status"+"\t"+"ItemNum"+"\t"+"DecriptionOld"+"\t"+"DecriptionNew"+"\t"+"CostOld"+"\t"+"CostNew"+"\t"+"Change"+"\t"+"%"+"\t"+"image"+"\t"+"otherItems"+"\r"
		
		C_LONGINT:C283($viProgressID)
		$viProgressID:=Progress New
		
		
		// loop through the catalog
		For ($incCat; 2; $cntCat)
			
			ProgressUpdate($viProgressID; $incCat; $cntCat; "Updating Items")
			
			If (Shift down:C543)
				
				
			End if 
			
			// harvest each row / item
			ARRAY TEXT:C222($atRow; 0)
			TextToArray($aRowArray{$incCat}; ->$atRow; "\t")
			If (Size of array:C274($atRow)#10)  // clip emptry rows
				// see what is in these rows, my guess is nothing.
				$viMalFormed:=$viMalFormed+1
				$vtChangeReport:=$vtChangeReport+"Malformed"
				If (Size of array:C274($atRow)>0)
					$vtChangeReport:=$vtChangeReport+"\t"+$atRow{1}
				End if 
				$vtChangeReport:=$vtChangeReport+"\t"+$aRowArray{$incCat}+"\r"
			Else 
				// build an object catalog
				$voRow:=New object:C1471
				For ($incFields; 1; $cntFields)
					OB SET:C1220($voRow; $atHeaders{$incFields}; $atRow{$incFields})
				End for 
				
				
				$vtItemNum:=$atRow{1}+"-"+$vtVendor
				QUERY:C277([Item:4]; [Item:4]itemNum:1=$vtItemNum)
				If ([Item:4]obGeneral:127=Null:C1517)
					[Item:4]obGeneral:127:=New object:C1471
				End if 
				Case of 
					: (Records in selection:C76([Item:4])>1)
						$vtTypeUpdate:=""
						ConsoleMessage("Multiples: "+"\t"+$vtItemNum)
						OB SET:C1220($voRow; "RecordCount"; Records in selection:C76([Item:4]))
						$vtChangeReport:=$vtItemNum+"\t"+"MultipleItems"+"\t"+String:C10(Records in selection:C76([Item:4]))+"\r"
					: (Records in selection:C76([Item:4])=1)
						$vtTypeUpdate:="UD"
						OB SET:C1220($voRow; "RecordCount"; 1)
						$viArrayFound:=Find in array:C230($aExistingArray; $vtItemNum)
						If ($viArrayFound>0)
							DELETE FROM ARRAY:C228($aExistingArray; $viArrayFound; 1)
						End if 
						
						C_LONGINT:C283($viCntOrderLines; $viCntOrderLinesBL; $viCntPOLines; $viCntPOLinesBL; $viCntPPLines; $viCntPPLinesOpen)
						QUERY:C277([OrderLine:49]; [OrderLine:49]itemNum:4=$vtItemNum; *)
						QUERY:C277([OrderLine:49];  & [OrderLine:49]qtyBackLogged:8#0)
						$viCntOrderLines:=Records in selection:C76([OrderLine:49])
						$viCntOrderLinesBL:=Sum:C1([OrderLine:49]qtyBackLogged:8)
						
						[Item:4]indicator1:95:=$viCntOrderLines
						[Item:4]indicator2:96:=$viCntOrderLinesBL
						
						QUERY:C277([POLine:40]; [POLine:40]itemNum:2=$vtItemNum; *)
						QUERY:C277([POLine:40];  & [POLine:40]qtyBackLogged:5#0)
						$viCntPOLines:=Records in selection:C76([POLine:40])
						$viCntPOLinesBL:=Sum:C1([POLine:40]qtyBackLogged:5)
						
						[Item:4]indicator3:97:=$viCntPOLines
						[Item:4]indicator4:98:=$viCntPOLinesBL
						
						QUERY:C277([ProposalLine:43]; [ProposalLine:43]itemNum:2=$vtItemNum; *)
						QUERY:C277([ProposalLine:43];  & [ProposalLine:43]complete:35=False:C215)
						$viCntPPLines:=Records in selection:C76([ProposalLine:43])
						$viCntPPLinesOpen:=Sum:C1([ProposalLine:43]qtyOpen:51)
						
						[Item:4]indicator5:99:=$viCntPPLines
						[Item:4]indicator6:100:=$viCntPPLinesOpen
						
						If (False:C215)
							READ WRITE:C146([Proposal:42])
							READ WRITE:C146([ProposalLine:43])
							QUERY:C277([Proposal:42]; [Proposal:42]complete:56=True:C214)
							vi2:=Records in selection:C76([Proposal:42])
							FIRST RECORD:C50([Proposal:42])
							For (vi1; 1; vi2)
								QUERY:C277([ProposalLine:43]; [ProposalLine:43]idNumProposal:1=[Proposal:42]idNum:5)
								vi4:=Records in selection:C76([ProposalLine:43])
								FIRST RECORD:C50([ProposalLine:43])
								For (vi3; 1; vi4)
									[ProposalLine:43]complete:35:=True:C214
									SAVE RECORD:C53([ProposalLine:43])
									NEXT RECORD:C51([ProposalLine:43])
								End for 
								NEXT RECORD:C51([Proposal:42])
							End for 
							REDUCE SELECTION:C351([ProposalLine:43]; 0)
							REDUCE SELECTION:C351([Proposal:42]; 0)
						End if 
						
						
						ADD TO SET:C119([Item:4]; "CatalogUpdated")
						
						[Item:4]obGeneral:127.DescriptionOld:=[Item:4]description:7
						[Item:4]obGeneral:127.CostOld:=[Item:4]costLastInShip:47
						[Item:4]obGeneral:127.typeIDOld:=[Item:4]type:26
						[Item:4]obGeneral:127.ClassOld:=[Item:4]class:92
						[Item:4]obGeneral:127.Profile1Old:=[Item:4]profile1:35
						[Item:4]obGeneral:127.Profile2Old:=[Item:4]profile2:36
						[Item:4]obGeneral:127.Profile3Old:=[Item:4]profile3:37
						[Item:4]obGeneral:127.Profile4Old:=[Item:4]profile4:38
						[Item:4]obGeneral:127.Profile5Old:=[Item:4]profile5:93
						[Item:4]obGeneral:127.Profile6Old:=[Item:4]profile6:94
						
						// build a record
						OB SET:C1220($voRow; "DescriptionOld"; [Item:4]description:7)
						OB SET:C1220($voRow; "CostOld"; [Item:4]costLastInShip:47)
						OB SET:C1220($voRow; "typeIDOld"; [Item:4]type:26)
						OB SET:C1220($voRow; "ClassOld"; [Item:4]class:92)
						OB SET:C1220($voRow; "Profile1Old"; [Item:4]profile1:35)
						OB SET:C1220($voRow; "Profile2Old"; [Item:4]profile2:36)
						OB SET:C1220($voRow; "Profile3Old"; [Item:4]profile3:37)
						OB SET:C1220($voRow; "Profile4Old"; [Item:4]profile4:38)
						OB SET:C1220($voRow; "Profile5Old"; [Item:4]profile5:93)
						OB SET:C1220($voRow; "Profile6Old"; [Item:4]profile6:94)
						OB SET:C1220($voRow; "DownLoadDate"; $atRow{10})
						
						
						C_REAL:C285($vrNewCost)
						$vrNewCost:=Num:C11($atRow{3})
						$vrCostOriginal:=[Item:4]costLastInShip:47
						$vrCostChange:=$vrNewCost-$vrCostOriginal
						If ([Item:4]costLastInShip:47=0)
							$vrPerCentChange:=100
						Else 
							$vrPerCentChange:=Round:C94($vrCostChange/[Item:4]costLastInShip:47*100; 2)
						End if 
						OB SET:C1220($voRow; "CostPerCent"; $vrPerCentChange)
						OB SET:C1220($voRow; "CostChange"; $vrCostChange)
						[Item:4]costLastInShip:47:=$vrNewCost
						
						C_TEXT:C284($vtMfgID; $vtMfgItemNum; $vtVendorID; $vtVendorItemNum; $vtBarCode; $vtEAN)
						$vtMfgID:=[Item:4]mfrID:53
						$vtMfgItemNum:=[Item:4]mfrItemNum:39
						$vtVendorID:=[Item:4]vendorID:45
						$vtVendorItemNum:=[Item:4]vendorItemNum:40
						$vtBarCode:=[Item:4]barCode:34
						$vtEAN:=[Item:4]ean:82
					Else 
						$vtTypeUpdate:="New"
						
						OB SET:C1220($voRow; "RecordCount"; 0)
						CREATE RECORD:C68([Item:4])
						[Item:4]dateCreated:129:=Current date:C33
						[Item:4]itemNum:1:=$vtItemNum
						OB SET:C1220($voRow; "DescriptionOld"; "New Item")
						
						OB SET:C1220($voRow; "CostOld"; -3)
						OB SET:C1220($voRow; "CostChange"; 0)
						
						[Item:4]costLastInShip:47:=Num:C11($atRow{3})
						OB SET:C1220($voRow; "CostNew"; [Item:4]costLastInShip:47)
						$vrCostOriginal:=0
						$vrCostChange:=0
						$vrPerCentChange:=0
						
						ADD TO SET:C119([Item:4]; "Not-In-Catalog")
						
				End case 
				
				
				If ($vtTypeUpdate#"")
					ADD TO SET:C119([Item:4]; "In-Catalog")
					
					OB SET:C1220([Item:4]obGeneral:127; "CatalogUpdate"; $atRow{10})
					
					C_TEXT:C284($vtDecriptionOld)
					$vtDecriptionOld:=[Item:4]description:7
					[Item:4]description:7:=URL_Decode($atRow{2})
					[Item:4]description:7:=Replace string:C233([Item:4]description:7; "&quot;"; "\"")
					[Item:4]description:7:=Replace string:C233([Item:4]description:7; "&#39;"; "'")
					[Item:4]description:7:=Parse_UnWanted([Item:4]description:7)
					
					If ($vtDecriptionOld=[Item:4]description:7)
						$vtDecriptionOld:="Same"
					End if 
					
					C_TEXT:C284($vtImagePath; $vtValidImage)
					$vtImagePath:=Storage:C1525.folder.jitF+"catalog"+Folder separator:K24:12+$vtVendor+Folder separator:K24:12+$atRow{1}+".jpg"
					If (Test path name:C476($vtImagePath)=1)
						[Item:4]imagePath:104:=Convert path system to POSIX:C1106($vtImagePath)
						OB SET:C1220($voRow; "ImagePath"; "valid")
						$vtValidImage:="Image"
						
						ADD TO SET:C119([Item:4]; "Has-Image")
						
					Else 
						[Item:4]imagePath:104:=""
						OB SET:C1220($voRow; "ImagePath"; "fail")
						$vtValidImage:="No Image"
						ADD TO SET:C119([Item:4]; "No-Image")
					End if 
					
					
					[Item:4]priceA:2:=[Item:4]costLastInShip:47*2
					[Item:4]priceMSR:109:=[Item:4]priceA:2
					[Item:4]vendorItemNum:40:=$atRow{1}
					If ($atRow{4}#"&nbsp;")
						[Item:4]mfrItemNum:39:=$atRow{4}
					End if 
					If ($atRow{5}#"&nbsp;")
						[Item:4]mfrID:53:=$atRow{5}
						[Item:4]mfrName:91:=$atRow{5}
					End if 
					If (Length:C16($atRow{6})>5)
						[Item:4]barCode:34:=$atRow{6}
					End if 
					[Item:4]profile4:38:=$atRow{7}
					[Item:4]profile5:93:=$atRow{8}
					[Item:4]profile6:94:=$atRow{9}
					
					If (Length:C16([Item:4]mfrItemNum:39)<3)
						[Item:4]mfrItemNum:39:=""
					End if 
					If (Length:C16([Item:4]vendorItemNum:40)<3)
						[Item:4]vendorItemNum:40:=""
					End if 
					
					SAVE RECORD:C53([Item:4])
					
					PUSH RECORD:C176([Item:4])
					ARRAY TEXT:C222($atItemMatches; 0)
					ARRAY LONGINT:C221($aiItemRecord; 0)
					ARRAY REAL:C219($aiItemCost; 0)
					ARRAY REAL:C219($aiItemPrice; 0)
					
					If (($vtVendorID#"") & ($vtVendorItemNum#""))
						QUERY:C277([Item:4]; [Item:4]vendorID:45=$vtVendorID; *)
						QUERY:C277([Item:4];  & ; [Item:4]vendorItemNum:40=$vtVendorItemNum)
						SELECTION TO ARRAY:C260([Item:4]; $aiItemRecord; [Item:4]itemNum:1; $atItemMatches; [Item:4]costLastInShip:47; $aiItemCost; [Item:4]priceA:2; $aiItemPrice)
					End if 
					
					C_LONGINT:C283($incMore; $cntMore; $found)
					If (($vtMfgID#"") & ($vtMfgItemNum#"") & ($vtMfgItemNum#"&nbsp;"))
						QUERY:C277([Item:4]; [Item:4]mfrID:53=$vtMfgID; *)
						QUERY:C277([Item:4];  & ; [Item:4]mfrItemNum:39=$vtMfgItemNum)
						$cntMore:=Records in selection:C76([Item:4])
						If ($cntMore>0)
							DuplicatesBuild(->[Item:4]; ->[Item:4]itemNum:1; ->$atItemMatches; ->$aiItemRecord; ->[Item:4]costLastInShip:47; ->$aiItemCost; ->[Item:4]priceA:2; ->$aiItemPrice)
						End if 
					End if 
					
					If ($vtBarCode#"")
						QUERY:C277([Item:4]; [Item:4]barCode:34=$vtBarCode)
						$cntMore:=Records in selection:C76([Item:4])
						If ($cntMore>0)
							DuplicatesBuild(->[Item:4]; ->[Item:4]itemNum:1; ->$atItemMatches; ->$aiItemRecord; ->[Item:4]costLastInShip:47; ->$aiItemCost; ->[Item:4]priceA:2; ->$aiItemPrice)
						End if 
					End if 
					
					If ($vtEAN#"")
						QUERY:C277([Item:4]; [Item:4]barCode:34=$vtEAN)
						$cntMore:=Records in selection:C76([Item:4])
						If ($cntMore>0)
							DuplicatesBuild(->[Item:4]; ->[Item:4]itemNum:1; ->$atItemMatches; ->$aiItemRecord; ->[Item:4]costLastInShip:47; ->$aiItemCost; ->[Item:4]priceA:2; ->$aiItemPrice)
						End if 
					End if 
					
					POP RECORD:C177([Item:4])
					
					C_TEXT:C284($vtMatchItems; $vtMatchCosts)
					$vtMatchItems:=""
					$vtMatchCosts:=""
					$cntMore:=Size of array:C274($atItemMatches)
					If ($cntMore>0)
						For ($incMore; 1; $cntMore)
							If ($atItemMatches{$incMore}#[Item:4]itemNum:1)
								$vtMatchItems:=$vtMatchItems+$atItemMatches{$incMore}+", "
								$vtMatchCosts:=$vtMatchCosts+$atItemMatches{$incMore}+": "+String:C10($aiItemCost{$incMore})+": "+String:C10($aiItemPrice{$incMore})+", "
							End if 
						End for 
						If (Length:C16($vtMatchItems)>1)
							$vtMatchItems:=Substring:C12($vtMatchItems; 1; Length:C16($vtMatchItems)-2)
							$vtMatchCosts:=Substring:C12($vtMatchCosts; 1; Length:C16($vtMatchCosts)-2)
						End if 
					End if 
					
					$vtChangeReport:=$vtChangeReport+$vtTypeUpdate+"\t"+[Item:4]itemNum:1+"\t"+$vtDecriptionOld+"\t"+[Item:4]description:7+"\t"+String:C10($vrCostOriginal)+"\t"+String:C10([Item:4]costLastInShip:47)+"\t"+String:C10($vrCostChange)+"\t"+String:C10($vrPerCentChange)+"\t"+$vtValidImage+"\t"+$vtMatchCosts+"\r"
					
					[Item:4]obGeneral:127.Duplicates:=$vtMatchItems
					[Item:4]dtItemDate:33:=$dtCurrent
					[Item:4]dtLastSync:121:=$dtCurrent
					SAVE RECORD:C53([Item:4])
				End if 
				APPEND TO ARRAY:C911($aObRecords; $voRow)
			End if 
		End for 
		
		OB SET ARRAY:C1227($obCatalog; "Item"; $aObRecords)
		
		Progress QUIT($viProgressID)
		
		CREATE EMPTY SET:C140([Item:4]; "DBnotCat")
		C_LONGINT:C283($incRec; $cntRec)
		$cntRec:=Size of array:C274($aExistingArray)
		C_TEXT:C284($vtNotInCatalog; $vtScript)
		$vtNotInCatalog:="NotInCatatlog: "+DateTime
		$vtTypeUpdate:="DB-Cat"
		For ($incRec; 1; $cntRec)
			QUERY:C277([Item:4]; [Item:4]itemNum:1=$aExistingArray{$incRec})
			ADD TO SET:C119([Item:4]; "DBnotCat")
			$vtValidImage:="no image"
			If ([Item:4]imagePath:104#"")
				$vtImagePath:=Convert path POSIX to system:C1107([Item:4]imagePath:104)
				If (Test path name:C476($vtImagePath)=1)
					$vtValidImage:="valid"
				End if 
			End if 
			$vtChangeReport:=$vtChangeReport+$vtTypeUpdate+"\t"+[Item:4]itemNum:1+"\t"+[Item:4]description:7+"\t"+""+"\t"+""+"\t"+""+"\t"+String:C10([Item:4]costLastInShip:47)+"\t"+""+"\t"+$vtValidImage+"\r"
			[Item:4]profile6:94:=$vtNotInCatalog
			
			If (False:C215)
				ILOTEXT1:="ItemNum: "+[Item:4]itemNum:1
				ILOTEXT2:="QUERY([OrderLine];[OrderLine]ItemNum="+ILOTEXT1+";*)"+"\r"
				ILOTEXT2:=ILOTEXT2+"QUERY([OrderLine]; & [OrderLine]QtyBackLogged#"+String:C10(0)+")"
				//ProcessTableOpen (->[OrderLine];ILOTEXT2;ILOTEXT1)
				
				
			End if 
			
			C_LONGINT:C283($viCntOrderLines; $viCntOrderLinesBL; $viCntPOLines; $viCntPOLinesBL; $viCntPPLines; $viCntPPLinesOpen)
			QUERY:C277([OrderLine:49]; [OrderLine:49]itemNum:4=$vtItemNum; *)
			QUERY:C277([OrderLine:49];  & [OrderLine:49]qtyBackLogged:8#0)
			$viCntOrderLines:=Records in selection:C76([OrderLine:49])
			$viCntOrderLinesBL:=Sum:C1([OrderLine:49]qtyBackLogged:8)
			
			[Item:4]indicator1:95:=$viCntOrderLines
			[Item:4]indicator2:96:=$viCntOrderLinesBL
			
			QUERY:C277([POLine:40]; [POLine:40]itemNum:2=$vtItemNum; *)
			QUERY:C277([POLine:40];  & [POLine:40]qtyBackLogged:5#0)
			$viCntPOLines:=Records in selection:C76([POLine:40])
			$viCntPOLinesBL:=Sum:C1([POLine:40]qtyBackLogged:5)
			
			[Item:4]indicator3:97:=$viCntPOLines
			[Item:4]indicator4:98:=$viCntPOLinesBL
			
			QUERY:C277([ProposalLine:43]; [ProposalLine:43]itemNum:2=$vtItemNum; *)
			QUERY:C277([ProposalLine:43];  & [ProposalLine:43]complete:35=False:C215)
			$viCntPPLines:=Records in selection:C76([ProposalLine:43])
			$viCntPPLinesOpen:=Sum:C1([ProposalLine:43]qtyOpen:51)
			
			[Item:4]indicator5:99:=$viCntPPLines
			[Item:4]indicator6:100:=$viCntPPLinesOpen
			
			
			
			
			SAVE RECORD:C53([Item:4])
		End for 
		USE SET:C118("DBnotCat")
		CLEAR SET:C117("DBnotCat")
		ProcessTableOpen(Table:C252(->[Item:4]); ""; "DB but not In Catalog")
		ConsoleMessage("  ----  ")
		CREATE RECORD:C68([TallyResult:73])
		[TallyResult:73]dtCreated:11:=DateTime_Enter
		[TallyResult:73]dtReport:12:=DateTime_Enter
		[TallyResult:73]dateCreated:53:=Current date:C33
		[TallyResult:73]name:1:="Catalog Update "+$vtVendor
		[TallyResult:73]nameProfile1:26:="Vendor"
		[TallyResult:73]profile1:17:=$vtVendor
		[TallyResult:73]nameReal1:20:="Incoming Lines"
		[TallyResult:73]real1:13:=$cntCat
		ConsoleMessage([TallyResult:73]nameReal1:20+": "+"\t"+String:C10([TallyResult:73]real1:13))
		
		[TallyResult:73]nameReal2:21:="Records Start"
		[TallyResult:73]real2:14:=$viRecordsInDB
		ConsoleMessage([TallyResult:73]nameReal2:21+": "+"\t"+String:C10([TallyResult:73]real2:14))
		
		[TallyResult:73]nameReal3:22:="Unmatched Existing"
		[TallyResult:73]real3:15:=Size of array:C274($aExistingArray)
		ConsoleMessage([TallyResult:73]nameReal3:22+": "+"\t"+String:C10([TallyResult:73]real3:15))
		
		[TallyResult:73]nameReal4:23:="No Image"
		[TallyResult:73]real4:16:=Records in set:C195("No-Image")
		ConsoleMessage([TallyResult:73]nameReal4:23+": "+"\t"+String:C10([TallyResult:73]real4:16))
		
		[TallyResult:73]nameReal5:33:="Has Image"
		[TallyResult:73]real5:32:=Records in set:C195("Has-Image")
		ConsoleMessage([TallyResult:73]nameReal5:33+": "+"\t"+String:C10([TallyResult:73]real5:32))
		
		[TallyResult:73]nameReal6:37:="Malformed"
		[TallyResult:73]real6:42:=$viMalFormed
		ConsoleMessage([TallyResult:73]nameReal6:37+": "+"\t"+String:C10([TallyResult:73]real6:42))
		
		[TallyResult:73]nameReal7:38:="In-Catalog"
		[TallyResult:73]real7:43:=Records in set:C195("In-Catalog")
		ConsoleMessage([TallyResult:73]nameReal7:38+": "+"\t"+String:C10([TallyResult:73]real7:43))
		
		QUERY:C277([Item:4]; [Item:4]itemNum:1="@-"+$vtVendor)
		[TallyResult:73]nameReal8:39:="Records Final"
		[TallyResult:73]real8:44:=Records in selection:C76([Item:4])
		ConsoleMessage([TallyResult:73]nameReal8:39+": "+"\t"+String:C10([TallyResult:73]real8:44))
		ProcessTableOpen(Table:C252(->[Item:4]); ""; "Final Items for "+$vtVendor)
		
		OB SET:C1220([TallyResult:73]obGeneral:56; "catalog items"; $aObRecords)
		//  OB SET([TallyResult]ObGeneral;"RecordNotInCatalog";$aObRecords)
		// [TallyResult]TextBlk1:=$vtChangeReport
		SAVE RECORD:C53([TallyResult:73])
		
		ConsoleMessage("Items in table Final: "+"\t"+String:C10(Records in table:C83([Item:4])))
		ConsoleMessage("  ----  ")
		
		Text_To_Document(Storage:C1525.folder.jitF+$vtVendor+"-"+DateTime("yyyymmdd_hhmm")+".txt"; $vtChangeReport)
		
		$vtChangeReport:=JSON Stringify:C1217($obCatalog)
		Text_To_Document(Storage:C1525.folder.jitF+$vtVendor+"OBJ-"+DateTime("yyyymmdd_hhmm")+".txt"; $vtChangeReport)
		
		ProcessTableOpen(Table:C252(->[TallyResult:73]); "Query([TallyResult];[TallyResult]Name=\"Catalog Update "+$vtVendor+"\")"; "Catalog Update "+$vtVendor)
		
		USE SET:C118("Existing")
		CLEAR SET:C117("Existing")
		ProcessTableOpen(Table:C252(->[Item:4]); ""; "Existing Items for "+$vtVendor)
		
		
		USE SET:C118("In-Catalog")
		CLEAR SET:C117("In-Catalog")
		ProcessTableOpen(Table:C252(->[Item:4]); ""; "In-Catalog"+$vtVendor)
		
		USE SET:C118("Not-In-Catalog")
		CLEAR SET:C117("Not-In-Catalog")
		ProcessTableOpen(Table:C252(->[Item:4]); ""; "Existing Items Not-In-Catalog Update "+$vtVendor)
		
		
		USE SET:C118("Has-Image")
		CLEAR SET:C117("Has-Image")
		ProcessTableOpen(Table:C252(->[Item:4]); ""; "Update with Valid Image"+$vtVendor)
		
		USE SET:C118("No-Image")
		CLEAR SET:C117("No-Image")
		ProcessTableOpen(Table:C252(->[Item:4]); ""; "Update with No Image"+$vtVendor)
		
		ALERT:C41("Complete")
	End if 
End if 