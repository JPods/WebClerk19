//%attributes = {}
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
	
	$vtVendorID:="CCS"
	$vtVendorTag:="-CCS"
	$vtPathToCatalog:="/Users/williamjames/Downloads/Copperfield/Copperfield-2022-08-10Price File Complete.txt"
	
End if 

var $reportOut : Text

C_OBJECT:C1216($obCatalog)
$obCatalog:=New object:C1471
$obCatalog.id:=CounterNew(->[zzzDialingInfo:81])  // uniqueID
$obCatalog.name:="CCS"
C_LONGINT:C283($viDTSync)  // define a DT for records in this import
$viDTSync:=DateTime_DTTo
$obCatalog.dtSync:=$viDTSync
$obCatalog.date:=Current date:C33
$obCatalog.time:=Current time:C178

C_LONGINT:C283($viProgressID)
$viProgressID:=Progress New

$vtCatalog:=Document to text:C1236($vtPathToCatalog)

var $vcLines; $line_c; $cReport; $cDataIn; $cDataOut; $cHeader : Collection
var $report_o : Object
$cData:=New collection:C1472()
$cResult:=New collection:C1472()
$report_o:=New object:C1471()

var $orig_s : Object
$orig_s:=ds:C1482.Item.query("itemNum = :1"; "@"+$vtVendorTag)

// load catalog into an array
C_LONGINT:C283($incC; $cntC; $incC)
$cDataIn:=Split string:C1554($vtCatalog; "\r")
$cReport.push("Incoming"; $cDataIn.length-3)

ConsoleLog("Incoming catalog: "+"\t"+String:C10($cDataIn.length))

$cntC:=$cDataIn.length
$incC:=0

C_TEXT:C284($vtItemNum)
C_REAL:C285($vrCostChange; $vrPerCent; $vrCostOriginal)
C_TEXT:C284($vtChangeLine)
C_TEXT:C284($vtDescription)
C_LONGINT:C283($viRecordNum)
var $line_o : Object

// read in the Excel file and create an object

For each ($line_t; $cDataIn)  // how many lines on a page
	$incC:=$incC+1
	ProgressUpdate($viProgressID; $incCat; $cntCat; "Updating Items")
	
	$line_o:=New object:C1471
	$line_c:=Split string:C1554($line_t; "/t")
	
	If ($line_c.length>0)
		Case of   // deal with each line
			: (($line_c[0]="") & ($inc<6))  //some of the first lines are empty (($incLines=1) | ($incLines=3))
				// this is the date row
			: ($line_c[0]="@Price File As@")  // find the header line
				
				
			: ($line_c.length<6)
				// drop out spread sheet has to F, 6 values for Copperfield
			: ($line_c[0]="Inventory ID")  // names of values
				$cHeader:=$line_c
			Else   //  a data line
				For each ($value; $line_c)
					
					
					
					
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
					
				End for each 
		End case 
	End if 
End for each 
//$cntLines:=Size of array($aExistingArray)
//For ($incLines; 1; $cntLines)
//GOTO RECORD([Item]; $aExistingArray{$incLines})
//[Item]indicator7:=222
//[Item]indicator6:=$obCatalog.id
//// save record([Item])
//End for 

CatalogDeltaReport("End")
Text_To_Document(Storage:C1525.folder.jitF+$vtVendorID+"-"+DateTime("yyyymmdd_hhmm")+".txt"; $vtChangeReport)
Progress QUIT($viProgressID)

ON ERR CALL:C155("")