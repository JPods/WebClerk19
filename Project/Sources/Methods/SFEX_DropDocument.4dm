//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/30/21, 22:38:58
// ----------------------------------------------------
// Method: SFEX_DropDocument
// Description
//
// Parameters
// ----------------------------------------------------


ARRAY TEXT:C222($atDocs; 0)
$n:=1
Repeat 
	$vfileArray:=Get file from pasteboard:C976($n)
	If ($vfileArray#"")
		APPEND TO ARRAY:C911($atDocs; $vfileArray)
		$n:=$n+1
	End if 
Until ($vfileArray="")
var $obRec : Object
// LB_Document.ents:=Form.obSel.copy()

// should already be loaded
// LB_Document.ents:=ds.Document.query("customerID = :1 and tableNum = :2"; [Customer]customerID; 2)

var $theFolder : Text
//   $theFolder:=Path_CustomerTask
var $vtPathCopyTo; $vtPathFolder : Text
If (Test path name:C476(Storage:C1525.paths.serverComEx)=0)
	$vtPathFolder:=Storage:C1525.paths.serverComEx
Else 
	$vtPathFolder:=Storage:C1525.paths.localComEx
End if 

Case of 
	: (process_o.dataClassName="TechNote")
		$vtPathFolder:=$vtPathFolder+process_o.dataClassName+Folder separator:K24:12+String:C10(LB_Document.cur.idNum)+Folder separator:K24:12
	: (process_o.dataClassName="Project")
		$vtPathFolder:=$vtPathFolder+process_o.dataClassName+Folder separator:K24:12+String:C10(LB_Document.cur.idNum)+Folder separator:K24:12
	: (LB_Document.cur.customerID#Null:C1517)
		$vtPathFolder:=$vtPathFolder+"Customer"+Folder separator:K24:12+LB_Document.cur.customerID+Folder separator:K24:12
	: (LB_Document.cur.vendorID#Null:C1517)
		$vtPathFolder:=$vtPathFolder+"Vendor"+Folder separator:K24:12+LB_Document.cur.vendorID+Folder separator:K24:12
	: (LB_Document.cur.itemNum#Null:C1517)
		$vtPathFolder:=$vtPathFolder+"Item"+Folder separator:K24:12+LB_Document.cur.itemNum+Folder separator:K24:12
	Else 
		$vtPathFolder:=$vtPathFolder+process_o.dataClassName+Folder separator:K24:12+String:C10(LB_Document.cur.id)+Folder separator:K24:12
End case 
If (LB_Document.cur.idNumTask#Null:C1517)
	$vtPathFolder:=$vtPathFolder+"task_"+String:C10(LB_Document.cur.idNumTask)+Folder separator:K24:12
End if 
If (Test path name:C476($vtPathFolder)#0)
	CREATE FOLDER:C475($vtPathFolder; *)
End if 

var $cnt; $countSaved; $inc; $path_i; $viNum : Integer
$cnt:=Size of array:C274($atDocs)
For ($inc; 1; $cnt)
	$viNum:=$viNum+1
	$obRec:=ds:C1482.Document.new()
	ARRAY TEXT:C222($atPath; 0)
	TextToArray($atDocs{$inc}; ->$atPath; Folder separator:K24:12)  // get the document name
	
	// MustFixQQQZZZ: Bill James (2021-11-20T06:00:00Z)
	// size the image if it is too large, maybe. Only applies to some types of documents
	
	$vtPathCopyTo:=$vtPathFolder+$atPath{Size of array:C274($atPath)}  // name is last elemeny
	//$path_i:=Test path name($atDocs{$inc})
	//$path_i:=Test path name($vtPathFolder)
	//$path_i:=Test path name($vtPathCopyTo)
	
	COPY DOCUMENT:C541($atDocs{$inc}; $vtPathCopyTo; *)  // copy document to the server drive
	//COPY DOCUMENT($atDocs{$inc}; $vtPathFolder; *)  // copy document to the server drive
	
	$obRec.path:=Convert path system to POSIX:C1106($vtPathCopyTo)  // save path in POSIX
	
	$obRec.dateEntered:=Current date:C33
	$obRec.dtEvent:=DateTime_DTTo
	
	// expand to cases of items, projects, vendors, etc....
	If (LB_Document.cur.idNumTask#Null:C1517)
		$obRec.idNumTask:=LB_Document.cur.idNumTask
		$queryBy:="idNumTask"
	End if 
	If (LB_Document.cur.customerID#Null:C1517)
		$obRec.customerID:=LB_Document.cur.customerID
		$queryBy:="Customer"
	End if 
	
	$obRec.tableNum:=LB_Document.cur.getDataClass().getInfo().tableNumber
	
	$obRec.title:=$atPath{Size of array:C274($atPath)}
	
	Case of 
		: (LB_Document.cur.company#Null:C1517)
			$obRec.description:=$obRec.title+"-"+String:C10($viCnt)+"-"+LB_Document.cur.company
		: (LB_Document.cur.itemNum#Null:C1517)
			$obRec.description:=$obRec.title+"-"+String:C10($viCnt)+"-"+LB_Document.cur.itemNum
		Else 
			$obRec.description:=$obRec.title+"-"+String:C10($viCnt)+"-"+Substring:C12(LB_Document.cur.id; 1; 20)
	End case 
	$result_o:=$obRec.save()
End for 

Case of 
	: (process_o.dataClassName="Customer")
		$tableNum_i:=ds:C1482["Customer"].getInfo().tableNumber
		LB_Document.ents:=ds:C1482.Document.query("customerID = :1 & tableNum= :2"; LB_Document.cur.customerID; $tableNum_i)
		
		// expand to items, projects, technotes, etc...
		
	Else 
		LB_Document.ents:=ds:C1482.Document.query("idNumTask = :1 "; LB_Document.cur.idNumTask)
End case 
$0:="Documents added: "+String:C10($cnt)
If (<>viDebugMode>410)
	ConsoleLog($tableName+": SFEX_DropDocument count: "+String:C10($cnt))
End if 