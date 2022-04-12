//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/08/20, 21:55:34
// ----------------------------------------------------
// Method: HO_CatalogCCS
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $vtPathToCatalog; $2; $vtVendorID; $3; $vtVendorTag)



// text fields to manage each page
C_TEXT:C284($vtCatalog; $vtPathToCatalog)
C_TEXT:C284($vtWebData)

C_TEXT:C284($vtChangeReport)
$vtChangeReport:=""

// ON ERR CALL("OEC_Web")
ON ERR CALL:C155("")

If (Count parameters:C259=3)
	$vtPathFolder:=$1
	$vtVendorID:=$2
	$vtVendorTag:=$3
	OK:=1
Else 
	// CONFIRM("Open DuraVent Catagory Folder")
	OK:=1
	If (OK=1)
		$vtVendorID:="CCS"
		$vtVendorTag:="-CCS"
		$vtPathFolder:="/Users/williamjames/Dropbox/AdvanceChimney/Copperfield-Data/CCS-text"
		
		// $vtPathFolder=select folder("")
	End if 
End if 

If (OK=1)
	$vtPathFolder:=Convert path POSIX to system:C1107($vtPathFolder)
	ARRAY TEXT:C222($atFiles; 0)
	DOCUMENT LIST:C474($vtPathFolder; $atFiles)
	
	
	
	
	
	
	
	CatalogDeltaReport("Start")
	
	C_OBJECT:C1216($obCatalog)
	$obCatalog:=New object:C1471
	$obCatalog.id:=CounterNew(->[DialingInfo:81])  // uniqueID
	$obCatalog.name:="CCS"
	C_LONGINT:C283($viDTSync)  // define a DT for records in this import
	$viDTSync:=DateTime_Enter
	$obCatalog.dtSync:=$viDTSync
	$obCatalog.date:=Current date:C33
	$obCatalog.time:=Current time:C178
	
	C_LONGINT:C283($viProgressID)
	$viProgressID:=Progress New
	
	QUERY:C277([Item:4]; [Item:4]itemNum:1="@"+$vtVendorTag)
	C_LONGINT:C283($viRecordsInDB; $viMalFormed)
	ARRAY LONGINT:C221($aExistingArray; 0)
	SELECTION TO ARRAY:C260([Item:4]; $aExistingArray)
	
	C_LONGINT:C283($incFiles; $cntFiles)
	$cntFiles:=Size of array:C274($atFiles)
	For ($incFiles; 1; $cntFiles)
		$vtPathToCatalog:=$vtPathFolder+Folder separator:K24:12+$atFiles{$incFiles}
		C_LONGINT:C283($w)
		$w:=Position:C15(".txt"; $atFiles{$incFiles})
		If ($w>0)  // skip if note a Table export
			$vtCatalog:=Document to text:C1236($vtPathToCatalog)
			
			C_COLLECTION:C1488($vcLines)
			$vcLines:=New collection:C1472
			$vcLines:=Split string:C1554($vtCatalog; "\r"; sk ignore empty strings:K86:1+sk trim spaces:K86:2)
			
			
			C_TEXT:C284($vtSheetName)
			$vtSheetName:=""
			
			ARRAY TEXT:C222($aRowArray; 0)
			
			C_OBJECT:C1216($voPage)  /// for each page/file
			$voPage:=New object:C1471
			C_TEXT:C284($vtPageName)
			
			$vtPageName:=Substring:C12($atFiles{$incFiles}; 1; $w-1)
			$vtPageName:=Replace string:C233($vtPageName; " "; "-")
			
			// load catalog into an array
			C_LONGINT:C283($cntLines; $incLines)
			TextToArray($vtCatalog; ->$aRowArray; "\r")
			OB SET:C1220($voPage; "Incoming"; Size of array:C274($aRowArray))
			$cntLines:=Size of array:C274($aRowArray)
			ConsoleMessage("Incoming catalog: "+"\t"+String:C10($cntLines))
			
			ARRAY TEXT:C222($atHeaders; 0)  // set headers to empty to find first data
			ARRAY TEXT:C222($atCells; 0)
			
			C_TEXT:C284($vtItemNum)
			C_REAL:C285($vrCostChange; $vrPerCent; $vrCostOriginal)
			C_TEXT:C284($vtChangeLine)
			C_TEXT:C284($vtDescription)
			C_LONGINT:C283($viRecordNum)
			
			For ($incLines; 1; $cntLines)  // how many lines on a page
				
				ProgressUpdate($viProgressID; $incCat; $cntCat; "Updating Items")
				
				$vtChangeLine:=""  // set the line reporting value to empty
				$vrCostChange:=0
				TextToArray($aRowArray{$incLines}; ->$atCells)
				$cntCells:=Size of array:C274($atCells)
				
				C_TEXT:C284($vtDuplicatesLikely)
				$vtDuplicatesLikely:=""
				
				$raySize:=Size of array:C274($atCells)  // skip if there are no values
				If ($raySize>0)
					Case of   // deal with each line
						: (($incLines=1) | ($incLines=3))
							// this is the date row
						: ($incLines=2)
							$vtSheetName:=$atCells{1}  // get the sheet name
							
						: ($cntCells<6)
							// drop out spread sheet has to F, 6 values for Copperfield
						: ($incLines=4)  // names of values
							COPY ARRAY:C226($atCells; $atHeaders)
							ARRAY TEXT:C222($atHeaders; 6)
							APPEND TO ARRAY:C911($atHeaders; "Sheet")
							APPEND TO ARRAY:C911($atHeaders; "Action")
							APPEND TO ARRAY:C911($atHeaders; "Diff")  // difference
							APPEND TO ARRAY:C911($atHeaders; "Change")  // % Change
							APPEND TO ARRAY:C911($atHeaders; "Old Description")  // old description
							APPEND TO ARRAY:C911($atHeaders; "various")  // old description
							
							If ($vtChangeReport="")  // do this only once
								arrayToText(->$atHeaders; ->$vtChangeReport)
							End if 
						Else   //  a data line
							C_OBJECT:C1216($obItem)
							$obItem:=New object:C1471
							$vtItemNum:=$atCells{1}+$vtVendorTag
							QUERY:C277([Item:4]; [Item:4]itemNum:1=$vtItemNum)
							Case of 
								: (Records in selection:C76([Item:4])=1)
									$viRecordNum:=Record number:C243([Item:4])
									ArrayRemove(->$aExistingArray; ->$viRecordNum)
									
									ARRAY TEXT:C222($atCells; 6)
									APPEND TO ARRAY:C911($atCells; $vtSheetName)
									APPEND TO ARRAY:C911($atCells; "Update")
									
									If ([Item:4]costMSC:110=0)
										[Item:4]costMSC:110:=[Item:4]costLastInShip:47
									End if 
									$vrCostOriginal:=[Item:4]costMSC:110
									[Item:4]costMSC:110:=Num:C11($atCells{6})
									CatCostDifference($vrCostOriginal; Num:C11($atCells{6}); ->$vrCostChange; ->$vrPerCent)
									APPEND TO ARRAY:C911($atCells; String:C10($vrCostChange))  // difference
									APPEND TO ARRAY:C911($atCells; String:C10($vrPerCent))  // % Change
									If ([Item:4]description:7=$atCells{4})
										APPEND TO ARRAY:C911($atCells; "")  // old descriptio
									Else 
										APPEND TO ARRAY:C911($atCells; [Item:4]description:7)  // old descriptio
									End if 
									[Item:4]description:7:=$atCells{4}
									If ([Item:4]type:26#$atCells{3})
										$vtChangeLine:=$vtChangeLine+"\t"+" 3: "+[Item:4]type:26+" # "+$atCells{3}
									End if 
									If ([Item:4]vendorID:45=$vtVendorID)
										$vtChangeLine:=$vtChangeLine+"\t"+" 0: "+"\t"+[Item:4]vendorID:45+" # "+$vtVendorID
									End if 
									If ([Item:4]vendorItemNum:40#$atCells{1})
										$vtChangeLine:=$vtChangeLine+"\t"+" 1: "+[Item:4]vendorItemNum:40+" # "+$atCells{1}
									End if 
									If ([Item:4]mfrItemNum:39#$atCells{2})
										$vtChangeLine:=$vtChangeLine+"\t"+" 2: "+[Item:4]mfrItemNum:39+" # "+$atCells{2}
									End if 
									If ([Item:4]type:26#$atCells{3})
										$vtChangeLine:=$vtChangeLine+"\t"+" 3: "+[Item:4]type:26+" # "+$atCells{3}
									End if 
									If ($vrCostChange#0)
										CatDeltaLineItemCost(->$obCatalog; ->$vtChangeReport; $vrCostChange; $vrPerCent)
									End if 
									APPEND TO ARRAY:C911($atCells; $vtChangeLine)  // odds and ends
									
									[Item:4]obGeneral:127.catalog.id:=$obCatalog.id
									[Item:4]obGeneral:127.catalog.date:=$obCatalog.date
									[Item:4]obGeneral:127.catalog.status:="updated"
									[Item:4]obGeneral:127.catalog.old:=$vtChangeLine
									
									OB SET ARRAY:C1227($obCatalog; "updated"; $atCells)
									
								: (Records in selection:C76([Item:4])=0)
									CREATE RECORD:C68([Item:4])
									[Item:4]itemNum:1:=$vtItemNum
									[Item:4]vendorItemNum:40:=$atCells{1}
									[Item:4]vendorID:45:=$vtVendorID
									[Item:4]mfrItemNum:39:=$atCells{2}
									[Item:4]type:26:=$atCells{3}
									[Item:4]description:7:=$atCells{4}
									[Item:4]profile1:35:=$atCells{5}
									
									[Item:4]costMSC:110:=Num:C11($atCells{6})
									[Item:4]costAverage:13:=[Item:4]costMSC:110
									[Item:4]costLastInShip:47:=[Item:4]costAverage:13
									
									
									[Item:4]dtLastSync:121:=$viDTSync
									[Item:4]dateLastCost:54:=Current date:C33
									[Item:4]dateCreated:129:=Current date:C33
									//SAVE RECORD([Item])
									ARRAY TEXT:C222($atCells; 6)
									APPEND TO ARRAY:C911($atCells; $vtSheetName)
									APPEND TO ARRAY:C911($atCells; "New")
									APPEND TO ARRAY:C911($atCells; "0")  // difference
									APPEND TO ARRAY:C911($atCells; "0")  // % Change
									APPEND TO ARRAY:C911($atCells; "")  // old description
									APPEND TO ARRAY:C911($atCells; "new")  // odds and ends
									arrayToText(->$atCells; ->$vtChangeReport)
									OB SET ARRAY:C1227($obCatalog; "newItem"; $atCells)
								Else 
									ARRAY TEXT:C222($atCells; 6)
									APPEND TO ARRAY:C911($atCells; $vtSheetName)
									APPEND TO ARRAY:C911($atCells; "New")
									APPEND TO ARRAY:C911($atCells; "0")  // difference
									APPEND TO ARRAY:C911($atCells; "0")  // % Change
									APPEND TO ARRAY:C911($atCells; "")  // old description
									APPEND TO ARRAY:C911($atCells; "multiples")  // odds and ends
									
									OB SET ARRAY:C1227($obCatalog; "multiples"; $atCells)
							End case 
							
							$vtValidImage:="noImage"
							If ([Item:4]imagePath:104#"")
								$vtImagePath:=Convert path POSIX to system:C1107([Item:4]imagePath:104)
								If (Test path name:C476($vtImagePath)=1)
									$vtValidImage:="image"
								End if 
							End if 
							APPEND TO ARRAY:C911($atCells; $vtValidImage)  // old description
							$vtValidImage:="noTN"
							If ([Item:4]imagePathTn:114#"")
								$vtImagePath:=Convert path POSIX to system:C1107([Item:4]imagePathTn:114)
								If (Test path name:C476($vtImagePath)=1)
									$vtValidImage:="TN"
								End if 
							End if 
							APPEND TO ARRAY:C911($atCells; $vtValidImage)  // old description
							
							[Item:4]dtItemDate:33:=$dtCurrent
							[Item:4]dtLastSync:121:=$dtCurrent
							
							If ([Item:4]obGeneral:127=Null:C1517)
								[Item:4]obGeneral:127:=New object:C1471
							End if 
							[Item:4]obGeneral:127.catalog.id:=$obCatalog.id
							[Item:4]obGeneral:127.catalog.date:=$obCatalog.date
							[Item:4]obGeneral:127.catalog.status:="added"
							
							
							OB SET ARRAY:C1227($obCatalog; [Item:4]itemNum:1; $atCells)
							
							arrayToText(->$atCells; ->$vtChangeReport)
					End case 
				End if 
			End for 
		End if 
	End for 
	$cntLines:=Size of array:C274($aExistingArray)
	For ($incLines; 1; $cntLines)
		GOTO RECORD:C242([Item:4]; $aExistingArray{$incLines})
		[Item:4]indicator7:101:=222
		[Item:4]indicator6:100:=$obCatalog.id
		// save record([Item])
	End for 
	
	CatalogDeltaReport("End")
	Text_To_Document(Storage:C1525.folder.jitF+$vtVendorID+"-"+DateTime("yyyymmdd_hhmm")+".txt"; $vtChangeReport)
	Progress QUIT($viProgressID)
End if 
ON ERR CALL:C155("")

