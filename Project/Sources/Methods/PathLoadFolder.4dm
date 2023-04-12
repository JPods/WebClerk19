//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/26/06, 04:52:37
// ----------------------------------------------------
// Method: PathLoadFolder
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $ptTable)
C_TEXT:C284($2; $thePath; $thePathAndDoc; $itemNum)
C_LONGINT:C283($poNum; $idNumTask; $uniqueIDRelated)
C_TEXT:C284($accoutID)
C_TEXT:C284($3; $fillArrays)


$idNumTask:=0
$poNum:=0
$ptTable:=$1
$thePath:=""
If (Count parameters:C259>1)
	If ($2#"")
		$thePath:=$2
	End if 
	If (Count parameters:C259>2)
		$fillArrays:="fillArrays"
	End if 
End if 
If ($thePath="")
	$thePath:=Path_CustomerTask
End if 

Case of 
	: ($ptTable=(->[TechNote:58]))
		QUERY:C277([Document:100]; [Document:100]idTechNote:31=[TechNote:58]idNum:1)
		
	: ($ptTable=(->[Customer:2]))
		$accoutID:=[Customer:2]customerID:1
		QUERY:C277([Document:100]; [Document:100]customerID:7=$accoutID; *)
		QUERY:C277([Document:100];  & [Document:100]tableNum:6=2)
		
	: ($ptTable=(->[Order:3]))
		$accoutID:=[Order:3]customerID:1
		$idNumTask:=[Order:3]idNumTask:85
		
		QUERY:C277([Document:100]; [Document:100]idNumTask:21=$idNumTask)
		
	: ($ptTable=(->[Invoice:26]))
		$accoutID:=[Invoice:26]customerID:3
		$idNumTask:=[Invoice:26]idNumTask:78
		
		QUERY:C277([Document:100]; [Document:100]idNumTask:21=$idNumTask)
		
	: ($ptTable=(->[WorkOrder:66]))
		$accoutID:=[WorkOrder:66]customerID:28
		$idNumTask:=[WorkOrder:66]idNumTask:22
		
		QUERY:C277([Document:100]; [Document:100]idNumTask:21=$idNumTask)
		
	: ($ptTable=(->[Proposal:42]))
		$accoutID:=[Proposal:42]customerID:1
		$idNumTask:=[Proposal:42]idNumTask:70
		
		QUERY:C277([Document:100]; [Document:100]idNumTask:21=$idNumTask)
		
	: ($ptTable=(->[PO:39]))
		$accoutID:=[PO:39]vendorID:1
		$poNum:=[PO:39]idNum:5
		$idNumTask:=[PO:39]idNumTask:69
		// QUERY([DocPath];[DocPath]PONum=$poNum)
		QUERY:C277([Document:100]; [Document:100]idNumTask:21=$idNumTask)
		
	: ($ptTable=(->[Employee:19]))
		$accoutID:=[Employee:19]nameID:1
		QUERY:C277([Document:100]; [Document:100]customerID:7=$accoutID; *)
		QUERY:C277([Document:100];  & [Document:100]tableNum:6=Table:C252(->[Employee:19]))
		
		
	: ($ptTable=(->[AdSource:35]))
		$uniqueIDRelated:=[AdSource:35]idNum:56
		QUERY:C277([Document:100]; [Document:100]idRelated:17=[AdSource:35]id:58; *)
		QUERY:C277([Document:100];  & [Document:100]tableNum:6=Table:C252(->[AdSource:35]))
		$itemNum:=[AdSource:35]marketEffort:2
		
	: ($ptTable=(->[Vendor:38]))
		$accoutID:=[Vendor:38]vendorID:1
		QUERY:C277([Document:100]; [Document:100]customerID:7=$accoutID; *)
		QUERY:C277([Document:100];  & [Document:100]tableNum:6=Table:C252(->[Vendor:38]))
		
		//clip effort if no taskID
	: ($ptTable=(->[Item:4]))
		$itemNum:=[Item:4]itemNum:1
		QUERY:C277([Document:100]; [Document:100]itemNum:20=[Item:4]itemNum:1; *)
		If ([Item:4]specid:62#"")
			QUERY:C277([Document:100];  | [Document:100]itemNum:20=[Item:4]specid:62; *)
		End if 
		QUERY:C277([Document:100])
End case 



If ($fillArrays="fillArrays")
	// ### bj ### 20210609_1015
	//Doc_FillArrays(Records in selection([Document]))
	//If (eListDocuments>0)
	////  --  CHOPPED  AL_UpdateArrays(eListDocuments; -2)
	//End if 
Else 
	// create an array of existing records
	ARRAY TEXT:C222($aPathExisting; 0)
	SELECTION TO ARRAY:C260([Document:100]path:4; $aPathExisting)
	
	C_LONGINT:C283($w; $incRay; $cntRay)
	
	ARRAY TEXT:C222($aDocNames; 0)
	If ($thePath#"")  // create an array of documents
		DOCUMENT LIST:C474($thePath; $aDocNames)
		
		ARRAY TEXT:C222($aChapterDocs; 0)
		If (ptCurTable=(->[TechNote:58]))
			If (Test path name:C476(vtTNPathSystem)=0)
				DOCUMENT LIST:C474(vtTNPathSystem; $aChapterDocs)
			End if 
		End if 
	End if 
	
	// ### bj ### 20181024_1937
	// may want to consolidate files or test paths
	// but at this time only chech for documents in the choosen folder
	// at some time look at library functions for moving documents
	// this can make multiple references to local and server documents
	// make CronJob feature to align local CommerceExpert folders with ShareDrive
	
	// keep this simple
	
	C_TEXT:C284($thePath; $pathUniversal)
	C_OBJECT:C1216($obRec)
	$cntRay:=Size of array:C274($aDocNames)
	If ($cntRay>0)
		For ($incRay; 1; $cntRay)  //skip folder
			If ($aDocNames{$incRay}[[1]]#".")  // skip hidden documents
				$thePathAndDoc:=$thePath+$aDocNames{$incRay}
				$pathUniversal:=PathtoUniversal($thePathAndDoc)  // switch to universal to test and saving
				
				$w:=Find in array:C230($aPathExisting; $pathUniversal)  // check if there is already an existing record at this location
				If ($w<0)
					C_BOOLEAN:C305($vbOnWindows; $vbDoIt; $vbLocked; $vbInvisible)
					C_TIME:C306($vhDocRef; $vhCreatedAt; $vhModifiedAt)
					C_DATE:C307($vdCreatedOn; $vdModifiedOn)
					GET DOCUMENT PROPERTIES:C477($thePathAndDoc; $vbLocked; $vbInvisible; $vdCreatedOn; $vhCreatedAt; $vdModifiedOn; $vhModifiedAt)
					$obRec:=ds:C1482.Document.new()
					$obRec.customerID:=$accoutID
					$obRec.idNumTask:=$idNumTask
					$obRec.poNum:=$poNum
					$obRec.itemNum:=$itemNum
					//$obRec.ideTechNote:=[TechNote]idNum
					$obRec.idRelated:=$uniqueIDRelated
					$obRec.tableNum:=Table:C252($ptTable)
					$obRec.path:=$pathUniversal  // switch to universal to test and saving
					$obRec.description:=$aDocNames{$incRay}
					$obRec.title:=$aDocNames{$incRay}
					//[DocPath]Suffix:=SuffixGet ($aDocNames{$incRay})
					//[DocPath]Creator:=Document creator($thePathAndDoc)
					$obRec.seq:=$incRay
					$obRec.dateEntered:=Current date:C33
					$obRec.dtDocument:=DateTime_DTTo($vdCreatedOn; $vhCreatedAt)  // document date time
					$result_o:=$obRec.save()
				End if 
			End if 
		End for 
	End if 
	// recursive to fill arrays
	// queries are already defined above
	PathLoadFolder($ptTable; ""; "fillArrays")
End if 