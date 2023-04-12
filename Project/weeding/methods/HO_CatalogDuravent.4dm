//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 06/19/20, 19:55:22
// ----------------------------------------------------
// Method: HO_CatalogDuravent
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $vtPathToCatalog; $2; $vtVendor)
C_BOOLEAN:C305($3)


// text fields to manage each page
C_TEXT:C284($vtCatalog; $vtPathToCatalog)
C_TEXT:C284($vtWebData)

C_TEXT:C284($vtChangeReport)
$vtChangeReport:=""

// ON ERR CALL("OEC_Web")
ON ERR CALL:C155("")

If (Count parameters:C259=2)
	TEXT TO DOCUMENT:C1237($1; $vtCatalog)
	$vtVendor:=$2
Else 
	// CONFIRM("Open DuraVent Catagory Folder")
	OK:=1
	If (OK=1)
		$vtVendor:="DuraVent"
		$vtPathFolder:="/Users/williamjames/Dropbox/AdvanceChimney/DuraventKeyworded/Pages"
		$vtPathFolder:=Convert path POSIX to system:C1107($vtPathFolder)
		ARRAY TEXT:C222($atFiles; 0)
		DOCUMENT LIST:C474($vtPathFolder; $atFiles)
		// $vtPathFolder=select folder("")
	End if 
End if 

CREATE EMPTY SET:C140([Item:4]; "CatalogUpdated")
CREATE EMPTY SET:C140([Item:4]; "Added-Catalog")
CREATE EMPTY SET:C140([Item:4]; "Skipped")


C_OBJECT:C1216($obCatalog)
$obCatalog:=New object:C1471
$obCatalog.id:=91006
$obCatalog.name:="Duravent"

ARRAY OBJECT:C1221($aObPages; 0)  // create an array with an element for each page

C_LONGINT:C283($viDTSync)  // define a DT for records in this import
$viDTSync:=DateTime_DTTo
$obCatalog.dtSync:=$viDTSync

C_LONGINT:C283($incFiles; $cntFiles)
$cntFiles:=Size of array:C274($atFiles)
For ($incFiles; 1; $cntFiles)
	$vtPathToCatalog:=$vtPathFolder+Folder separator:K24:12+$atFiles{$incFiles}
	$vtCatalog:=Document to text:C1236($vtPathToCatalog)
	C_TEXT:C284($vtTableReport)
	$vtTableReport:=""
	
	// make a new object to build catalog for this page
	
	C_REAL:C285($costDifference; $vrPerCentChange)
	
	
	C_POINTER:C301($ptRowArray)
	ARRAY TEXT:C222($aRowArray; 0)
	
	C_OBJECT:C1216($voPage)
	$voPage:=New object:C1471
	
	C_TEXT:C284($vtPageName)
	C_LONGINT:C283($w)
	$w:=Position:C15("-Table"; $atFiles{$incFiles})
	If ($w>0)  // skip if note a Table export
		$vtPageName:=Substring:C12($atFiles{$incFiles}; 1; $w-1)
		$vtPageName:=Txt_TrimSpaces($vtPageName)
		$vtPageName:=Replace string:C233($vtPageName; " "; "-")
		
		
		// append each subcatagory 
		
		
		// load catalog into an array
		C_LONGINT:C283($cntLines; $incLines)
		TextToArray($vtCatalog; ->$aRowArray; "\r")
		ConsoleLog("Incoming catalog: "+"\t"+String:C10(Size of array:C274($aRowArray)))
		OB SET:C1220($voPage; "Incoming"; Size of array:C274($aRowArray))
		$cntLines:=Size of array:C274($aRowArray)
		
		ARRAY TEXT:C222($atHeaders; 0)  // set headers to empty to find first data
		ARRAY TEXT:C222($atCells; 0)
		// create an object array to store "child" "value" pairs on each page
		ARRAY OBJECT:C1221($aObSubCat; 0)
		
		
		C_TEXT:C284($vtFirstRow)
		C_TEXT:C284($vtTypeUpdate)
		C_LONGINT:C283($viMatching; $viCatalogOnly; $viDatabaseOnly)
		C_TEXT:C284($vtItemNum)
		C_REAL:C285($vrCostChange; $vrChangeScale; $vrCostOriginal)
		C_LONGINT:C283($incHeader; $cntHeader)
		C_LONGINT:C283($incCells; $cntCells)
		C_TEXT:C284($vtSubCategory; $vtPreCategory; $vtFirstRow)
		C_TEXT:C284($vtChangeLine)
		C_TEXT:C284($vtDescription)
		
		// specific values to look for on each page
		$vtChangeLine:=""
		$vtFirstRow:=""
		$vtPreCategory:=""
		$vtSubCategory:=""
		
		// repeat with each page of the report
		$vtChangeReport:=$vtChangeReport+"\r"+"\r"+"\r"+"FirstRow"+"\t"+"PreCategory"+"\t"+"SubCategory"+"\t"+"BarCode"+"\t"+"ItemNum"+"\t"+"DecriptionOld"+"\t"+"DecriptionNew"+"\t"+"CostOld"+"\t"+"CostNew"+"\t"+"Change"+"\t"+"%"+"\t"+"image"+"\t"+"otherItems"
		
		
		
		For ($incLines; 1; $cntLines)  // how many lines on a page
			$vtChangeLine:=""  // set the line reporting value to empty
			TextToArray($aRowArray{$incLines}; ->$atCells)
			$cntCells:=Size of array:C274($atCells)
			
			C_TEXT:C284($vtDuplicatesLikely)
			$vtDuplicatesLikely:=""
			C_BOOLEAN:C305($vbQuery)
			$vbQuery:=True:C214
			
			
			Case of 
				: ($incLines=1)
					$vtFirstRow:=$atCells{1}
					$vtFirstRow:=Parse_UnWanted($vtFirstRow)
					// ob set($voRow;"FirstRow";$vtFirstRow)
					$vtChangeLine:="\r"+$vtFirstRow+"\r"  // new table in the report
					$vtWebData:=$vtWebData+"\t"+"firstrow"+"\t"+$vtFirstRow+"\r"
					
					C_TEXT:C284($vtFirstRowNoSpace; $vtFirstRow10)
					$vtFirstRowNoSpace:=Replace string:C233($vtFirstRow; " "; "")
					$vtFirstRow10:=Substring:C12($vtFirstRow10; 1; 10)+String:C10($incFiles)  // build a keyword for the page
					C_LONGINT:C283($viSizesObPages)
					$viSizesObPages:=Size of array:C274($aObPages)+1
					INSERT IN ARRAY:C227($aObPages; $viSizesObPages; 1)
					OB SET:C1220($aObPages{$viSizesObPages}; "page"; $vtFirstRow)
					OB SET:C1220($aObPages{$viSizesObPages}; "child"; $vtFirstRow10)
					
				: ($cntCells<10)
					// drop out
				: (($atCells{1}="") & ($atCells{2}=""))
					// empty row
				: ($atCells{1}="UPC-A Listing")
					
					If ($vtSubCategory="")  //no subcatagory was defined add a standard 
						$vtSubCategory:="main"
						//$vtSubCategory:=$vtSubCategory
						C_LONGINT:C283($viSizesObSubCat)
						$viSizesObSubCat:=Size of array:C274($aObSubCat)+1
						INSERT IN ARRAY:C227($aObSubCat; $viSizesObSubCat; 1)
						OB SET:C1220($aObSubCat{$viSizesObSubCat}; "child"; $vtSubCategory)
					End if 
					
					COPY ARRAY:C226($atCells; $atHeaders)
					//  ob set($voRow;"Headers";replace string($aRowArray{$incLines};"\t";","))
					
					$vtChangeLine:=$aRowArray{$incLines}
					
					
				: (($atCells{1}="") & ($atCells{2}#"") & (Size of array:C274($atHeaders)>0))
					C_TEXT:C284($vtSubCategory)
					$vtSubCategory:=$atCells{2}
					$vtSubCategory:=Parse_UnWanted($vtSubCategory)
					// ob set($voRow;"subcategory";$vtSubCategory)
					// APPEND TO ARRAY($atSubCategories;$vtSubCategory)
					$vtChangeLine:="Subcategory"+"\t"+$vtSubCategory  // new table in the report
					$vtSubCategory:=Replace string:C233($vtSubCategory; " "; "")
					$vtSubCategory:=Replace string:C233($vtSubCategory; "\""; "in")
					$vtSubCategory:=Substring:C12($vtSubCategory; 1; 8)
					
					$vtWebData:=$vtWebData+"\t"+"subcategory"+$vtSubCategory+"\r"
					ARRAY OBJECT:C1221($aObChoices; 0)
					
				: (($atCells{1}="") & ($atCells{2}#""))
					$vtPreCategory:=$atCells{2}
					$vtSubCategory:=Parse_UnWanted($vtSubCategory)
					// OB SET($voRow;"Precategory";$vtPreCategory)
					// APPEND TO ARRAY($atSubCategories;$vtPreCategory)
					
					$vtChangeLine:="Precategory"+"\t"+$vtSubCategory  // new table in the report
					
					
					$vtWebData:=$vtWebData+"\t"+"Precategory"+$vtSubCategory+"\r"
					
				: ($atCells{1}#"")  // likely item row
					If ($vtSubCategory="")  // there was no subcatagory defined
						$vtSubCategory:="main"
					End if 
					$vbKeywords:=False:C215
					$vtDescription:=$atCells{2}  // needed in multiple places
					$vtDescription:=Parse_UnWanted($vtDescription)
					
					$vbUpdateRecord:=False:C215
					$vbQuery:=True:C214
					
					C_TEXT:C284($vtItemNum)
					$vtItemNum:=($atCells{4})+"-"+$vtVendor
					
					If ($vbQuery)
						If (Length:C16($atCells{1})>10)
							QUERY:C277([Item:4]; [Item:4]barCode:34=$atCells{1})
							If (Records in selection:C76([Item:4])=1)
								
								If ([Item:4]itemNum:1=$vtItemNum)
									$vbUpdateRecord:=True:C214
									$vbQuery:=False:C215
								Else 
									$vtChangeLine:=$vtFirstRow+"\t"+$vtPreCategory+"\t"+$vtSubCategory+"\t"+"Not matched barcode to itemnum"+"\t"+[Item:4]barCode:34+"\t"+[Item:4]itemNum:1
								End if 
							Else 
								C_LONGINT:C283($viCountRecords)
								$viCountRecords:=Records in selection:C76([Item:4])
								$vtChangeLine:=$vtFirstRow+"\t"+$vtPreCategory+"\t"+$vtSubCategory+"\t"+"BarCodeRecs: "+String:C10($viCountRecords)+"\t"+[Item:4]barCode:34+"\t"+[Item:4]itemNum:1
								
							End if 
						Else 
							$vtChangeLine:=$vtFirstRow+"\t"+$vtPreCategory+"\t"+$vtSubCategory+"\t"+"<11 Characters"+"\t"+[Item:4]barCode:34+"\t"+[Item:4]itemNum:1
						End if 
					End if 
					
					// ItemNum
					If ($vbQuery)
						QUERY:C277([Item:4]; [Item:4]itemNum:1=$vtItemNum)
						If (Records in selection:C76([Item:4])=1)
							$vbUpdateRecord:=True:C214
							$vbQuery:=False:C215  // no more query
						End if 
					End if 
					
					// Mfr ID
					If ($vbQuery)
						QUERY:C277([Item:4]; [Item:4]mfrItemNum:39=$atCells{3}; *)
						QUERY:C277([Item:4];  | ; [Item:4]mfrItemNum:39=$atCells{4}; *)
						QUERY:C277([Item:4];  | ; [Item:4]mfrItemNum:39=$atCells{5}; *)
						QUERY:C277([Item:4];  & ; [Item:4]mfrID:53=$vtVendor)
						Case of 
							: (Records in selection:C76([Item:4])>0)
								ADD TO SET:C119([Item:4]; "Skipped")
								C_LONGINT:C283($incRecs; $cntRecs)
								C_TEXT:C284($vtDuplicatesLikely)
								FIRST RECORD:C50([Item:4])
								For ($incRecs; 1; $cntRecs)
									If ($incRecs>1)
										$vtDuplicatesLikely:=$vtDuplicatesLikely+", "+[Item:4]itemNum:1
									Else 
										$vtDuplicatesLikely:=[Item:4]itemNum:1
									End if 
									//save record([Item])
									NEXT RECORD:C51([Item:4])
								End for 
								// OB SET($voRow;"duplicatesPossible";$vtDuplicatesLikely)
								$vtChangeLine:=$vtFirstRow+"\t"+$vtPreCategory+"\t"+$vtSubCategory+"\t"+"Multiples"+"\t"+$vtDuplicatesLikely
								
							: (Records in selection:C76([Item:4])=1)
								
								
								If ([Item:4]itemNum:1=$atCells{4}+"-"+$vtVendor)
									$vbUpdateRecord:=True:C214
									$vbQuery:=False:C215
								Else 
									$vtChangeLine:=$vtFirstRow+"\t"+$vtPreCategory+"\t"+$vtSubCategory+"\t"+"Not matched MfrVendor"+"\t"+[Item:4]itemNum:1+"\t"+[Item:4]mfrItemNum:39+"\t"+[Item:4]mfrID:53
								End if 
								
							Else 
								
								QUERY:C277([Item:4]; [Item:4]itemNum:1=$atCells{4}+"-"+$vtVendor)
								If (Records in selection:C76([Item:4])>0)
									$vtChangeLine:=$vtFirstRow+"\t"+$vtPreCategory+"\t"+$vtSubCategory+"\t"+[Item:4]barCode:34+"\t"+[Item:4]itemNum:1+"\t"+""+"\t"+[Item:4]description:7+"\t"+String:C10([Item:4]costLastInShip:47)+"\t"+""+"\t"+""+"\t"+""+"\t"+""+"\t"+"ItemNumQuery2"+"\r"
									// double checking
								Else 
									
									$vbCreateRecord:=True:C214
									
								End if 
						End case 
						
					End if 
					
					
					// Vendor ID
					If ($vbQuery)
						QUERY:C277([Item:4]; [Item:4]vendorItemNum:40=$atCells{3}; *)
						QUERY:C277([Item:4];  | ; [Item:4]vendorItemNum:40=$atCells{4}; *)
						QUERY:C277([Item:4];  | ; [Item:4]vendorItemNum:40=$atCells{5}; *)
						QUERY:C277([Item:4];  & ; [Item:4]vendorID:45=$vtVendor)
						Case of 
							: (Records in selection:C76([Item:4])>0)
								ADD TO SET:C119([Item:4]; "Skipped")
								C_LONGINT:C283($incRecs; $cntRecs)
								C_TEXT:C284($vtDuplicatesLikely)
								FIRST RECORD:C50([Item:4])
								For ($incRecs; 1; $cntRecs)
									If ($incRecs>1)
										$vtDuplicatesLikely:=$vtDuplicatesLikely+", "+[Item:4]itemNum:1
									Else 
										$vtDuplicatesLikely:=[Item:4]itemNum:1
									End if 
									//save record([Item])
									NEXT RECORD:C51([Item:4])
								End for 
								// OB SET($voRow;"duplicatesPossible";$vtDuplicatesLikely)
								$vtChangeLine:=$vtFirstRow+"\t"+$vtPreCategory+"\t"+$vtSubCategory+"\t"+"Multiples"+"\t"+$vtDuplicatesLikely
								
							: (Records in selection:C76([Item:4])=1)
								If ([Item:4]itemNum:1=$vtItemNum)
									$vbUpdateRecord:=True:C214
									$vbQuery:=False:C215
								Else 
									$vtChangeLine:=$vtFirstRow+"\t"+$vtPreCategory+"\t"+$vtSubCategory+"\t"+"Not matched MfrVendor"+"\t"+[Item:4]itemNum:1+"\t"+[Item:4]mfrItemNum:39+"\t"+[Item:4]mfrID:53
								End if 
								
							Else 
								
								QUERY:C277([Item:4]; [Item:4]itemNum:1=$vtItemNum)
								If (Records in selection:C76([Item:4])>0)
									$vtChangeLine:="Multiples: "+String:C10(Records in selection:C76([Item:4]))+"\t"+$vtPreCategory+"\t"+$vtSubCategory+"\t"+[Item:4]barCode:34+"\t"+[Item:4]itemNum:1+"\t"+""+"\t"+[Item:4]description:7+"\t"+String:C10([Item:4]costLastInShip:47)+"\t"+""+"\t"+""+"\t"+""+"\t"+""+"\t"+"ItemNumQuery2"
									// double checking
								Else 
									$vbCreateRecord:=True:C214
								End if 
						End case 
						
					End if 
					
					
					// update a found record, create a record, or skip action
					Case of 
						: ($vbCreateRecord)
							QUERY:C277([Item:4]; [Item:4]itemNum:1=$vtItemNum)
							If (Records in selection:C76([Item:4])>0)
								$vtChangeLine:="=$vtItemNum: "+String:C10(Records in selection:C76([Item:4]))+"\t"+$vtPreCategory+"\t"+$vtSubCategory+"\t"+[Item:4]barCode:34+"\t"+$vtItemNum+"Add but exists"
							Else 
								
								CREATE RECORD:C68([Item:4])
								[Item:4]itemNum:1:=$vtItemNum
								[Item:4]dateCreated:129:=Current date:C33
								[Item:4]dateLastCost:54:=Current date:C33
								[Item:4]dtLastSync:121:=$viDTSync
								[Item:4]dtItemDate:33:=$viDTSync
								
								[Item:4]barCode:34:=$atCells{1}
								[Item:4]type:26:=$vtSubCategory
								[Item:4]class:92:=$vtFirstRow
								[Item:4]description:7:=$atCells{2}
								[Item:4]profile3:37:=$atCells{3}
								
								
								[Item:4]mfrItemNum:39:=$atCells{4}
								[Item:4]mfrID:53:=$vtVendor
								[Item:4]vendorItemNum:40:=$atCells{4}
								[Item:4]vendorID:45:=$vtVendor
								
								[Item:4]profile4:38:=$atCells{5}
								[Item:4]qtyBulk:118:=Num:C11($atCells{6})
								[Item:4]weightBulk:83:=Num:C11($atCells{7})
								[Item:4]cube:107:=Num:C11($atCells{8})
								[Item:4]qtyMasterPack:115:=Num:C11($atCells{9})
								
								// 10 skipped it is a calculation
								If (Size of array:C274($atCells)>10)
									[Item:4]priceMSR:109:=Num:C11($atCells{11})
								End if 
								[Item:4]costLastInShip:47:=[Item:4]priceMSR:109*0.61
								If ($cntCells>11)
									[Item:4]profile5:93:=$atCells{12}
								End if 
								//[Item]obSync:=$viDTSync
								
								SAVE RECORD:C53([Item:4])
								
								$vbKeywords:=True:C214
								
								ADD TO SET:C119([Item:4]; "Added-Catalog")
								
								$vtChangeLine:=$vtFirstRow+"\t"+$vtPreCategory+"\t"+$vtSubCategory+"\t"+[Item:4]barCode:34+"\t"+[Item:4]itemNum:1+"\t"+""+"\t"+[Item:4]description:7+"\t"+String:C10([Item:4]costLastInShip:47)+"\t"+""+"\t"+""+"\t"+""+"\t"+"NoPath"+"\t"+"Added"
								
							End if 
							
							
						: ($vbUpdateRecord)
							If ([Item:4]itemNum:1#$vtItemNum)
								$vtChangeLine:="Existing #$vtItemNum"+"\t"+$vtPreCategory+"\t"+$vtSubCategory+"\t"+[Item:4]barCode:34+"\t"+[Item:4]itemNum:1+"\t"+$vtItemNum+"\t"+[Item:4]description:7+"\t"+String:C10([Item:4]costLastInShip:47)+"\t"+""+"\t"+""+"\t"+""+"\t"+"NoPath"+"\t"+""
								
							Else 
								ADD TO SET:C119([Item:4]; "CatalogUpdated")
								
								If ([Item:4]obGeneral:127.previous=Null:C1517)
									[Item:4]obGeneral:127.previous:=New object:C1471
								End if 
								
								[Item:4]dateLastCost:54:=Current date:C33
								[Item:4]dtLastSync:121:=$viDTSync
								[Item:4]dtItemDate:33:=$viDTSync
								
								[Item:4]obGeneral:127.previous.BarCode:=[Item:4]barCode:34  //    $vtSubCategory
								[Item:4]barCode:34:=$atCells{1}
								
								[Item:4]obGeneral:127.previous.typeID:=[Item:4]type:26  //    $vtSubCategory
								[Item:4]type:26:=$vtSubCategory
								[Item:4]obGeneral:127.previous.Class:=[Item:4]class:92  //  $vtFirstRow
								[Item:4]class:92:=$vtFirstRow
								[Item:4]obGeneral:127.previous.Description:=[Item:4]description:7  // $atCells{2}
								[Item:4]description:7:=$atCells{2}
								
								[Item:4]obGeneral:127.previous.Profile3:=[Item:4]profile3:37  // $atCells{3}   // old stock#
								[Item:4]profile3:37:=$atCells{3}
								[Item:4]obGeneral:127.previous.ItemNum:=[Item:4]itemNum:1  // $atCells{4}
								[Item:4]obGeneral:127.previous.MfrItemNum:=[Item:4]mfrItemNum:39
								[Item:4]obGeneral:127.previous.mfrID:=[Item:4]mfrID:53
								[Item:4]obGeneral:127.previous.VendorItemNum:=[Item:4]vendorItemNum:40
								[Item:4]obGeneral:127.previous.VendorID:=[Item:4]vendorID:45
								
								
								[Item:4]mfrItemNum:39:=$atCells{4}
								[Item:4]mfrID:53:=$vtVendor
								[Item:4]vendorItemNum:40:=$atCells{4}
								[Item:4]vendorID:45:=$vtVendor
								
								[Item:4]obGeneral:127.previous.Profile4:=[Item:4]profile4:38  // $atCells{5}   // stock#
								[Item:4]profile4:38:=$atCells{5}
								
								[Item:4]obGeneral:127.previous.Bulk:=[Item:4]qtyBulk:118  // $atCells{6}  Pcs/Ctn
								[Item:4]qtyBulk:118:=Num:C11($atCells{6})
								
								[Item:4]obGeneral:127.previous.WeightBulk:=[Item:4]weightBulk:83  // $atCells{7}  Lbs/ctn
								[Item:4]weightBulk:83:=Num:C11($atCells{7})
								
								[Item:4]obGeneral:127.previous.Cube:=[Item:4]cube:107  // $atCells{8}  Lbs/ctn
								[Item:4]cube:107:=Num:C11($atCells{8})
								
								[Item:4]obGeneral:127.previous.QtyMasterPack:=[Item:4]qtyMasterPack:115  // $atCells{8}  Lbs/ctn
								[Item:4]qtyMasterPack:115:=Num:C11($atCells{9})
								
								// 10 skipped it is a calculation
								[Item:4]obGeneral:127.previous.MSRP:=[Item:4]priceMSR:109
								If (Size of array:C274($atCells)>10)
									[Item:4]priceMSR:109:=Num:C11($atCells{11})
								End if 
								[Item:4]obGeneral:127.previous.CostLastInShip:=[Item:4]costLastInShip:47  // .61 of MSRP
								[Item:4]costLastInShip:47:=[Item:4]priceMSR:109*0.61
								
								[Item:4]obGeneral:127.previous.Profile5:=[Item:4]profile5:93  // $atCells{12}  NET
								
								If ($cntCells>11)
									[Item:4]profile5:93:=$atCells{12}
								End if 
								
								C_DATE:C307($vdLastUpdate)
								//..$vdLastUpdate:=jDateTimeRDate([Item]obSync)
								[Item:4]obGeneral:127.previous.LastUpdate:=[Item:4]profile5:93  // $atCells{12}  NET
								//[Item]obSync:=$viDTSync
								
								
								C_REAL:C285($vrCostChange; $vrPerCentChange)
								$vrCostChange:=[Item:4]costLastInShip:47-Old:C35([Item:4]costLastInShip:47)
								$vrPerCentChange:=Round:C94(([Item:4]costLastInShip:47-Old:C35([Item:4]costLastInShip:47))/Old:C35([Item:4]costLastInShip:47)*100; 2)
								
								C_TEXT:C284($vtImageStatus)
								Case of 
									: ([Item:4]imagePath:104="")
										$vtImageStatus:="no image"
									: (Test path name:C476([Item:4]imagePath:104)=1)
										$vtImageStatus:="valid"
									Else 
										$vtImageStatus:="Invalid"
								End case 
								
								$vtChangeLine:=$vtFirstRow+"\t"+$vtPreCategory+"\t"+$vtSubCategory+"\t"+[Item:4]barCode:34+"\t"+[Item:4]itemNum:1+"\t"+Old:C35([Item:4]description:7)+"\t"+"[Item]Description"+"\t"+String:C10([Item:4]costLastInShip:47)+"\t"+String:C10(Old:C35([Item:4]costLastInShip:47))+"\t"+String:C10($vrCostChange)+"\t"+String:C10($vrPerCentChange)+"\t"+$vtImageStatus+"\t"+"updated"
								
								SAVE RECORD:C53([Item:4])
								$vbKeywords:=True:C214
							End if 
							
					End case 
					
					If ($vbKeywords)
						
						KeyWordsMake(->[Item:4])
						
					End if 
					
			End case 
			
			$vtTableReport:=$vtTableReport+"\r"+$vtChangeLine
			$vtChangeReport:=$vtChangeReport+"\r"+$vtChangeLine
		End for 
		Text_To_Document(Storage:C1525.folder.jitF+$vtVendor+"-"+Substring:C12($vtFirstRow; 1; 15)+DateTime("yyyymmdd_hhmm")+".txt"; $vtTableReport)
		
	End if 
	
	
End for 
$vtChangeReport:=$vtChangeReport+"\r"
TRACE:C157
Text_To_Document(Storage:C1525.folder.jitF+$vtVendor+"-"+DateTime("yyyymmdd_hhmm")+".txt"; $vtChangeReport)
TRACE:C157
Text_To_Document(Storage:C1525.folder.jitF+$vtVendor+"-web-"+DateTime("yyyymmdd_hhmm")+".txt"; $vtWebData)

ON ERR CALL:C155("")

If (False:C215)
	USE SET:C118("Added-Catalog")
	CLEAR SET:C117("Added-Catalog")
	ProcessTableOpen(Table:C252(->[Item:4]); ""; "Added-Catalog "+$vtVendor)
	
	
	USE SET:C118("CatalogUpdated")
	CLEAR SET:C117("CatalogUpdated")
	ProcessTableOpen(Table:C252(->[Item:4]); ""; "CatalogUpdated "+$vtVendor)
	
	
	USE SET:C118("Skipped")
	CLEAR SET:C117("Skipped")
	ProcessTableOpen(Table:C252(->[Item:4]); ""; "Skipped "+$vtVendor)
End if 