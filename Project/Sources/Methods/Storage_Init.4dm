//%attributes = {}

// Modified by: Bill James (2022-01-09T06:00:00Z)
// Method: Storage_Init
// Description
// Parameters
// ----------------------------------------------------


var $rev : Text
var $o : Object
If (False:C215)  // testing
	$o:=New object:C1471
	//$rev:="19-am"
	//$o:=New object
	//$o.date:=!2023-02-05!
	$o.rev:=$rev
	$o.collect:=New collection:C1472(1; 2; New collection:C1472(New object:C1471("fn"; "John"; "ln"; "Smith"); New object:C1471("fn"; "Suzy"; "ln"; "Que")); New collection:C1472(41; 42; 43; 44); 5)
	$o.title:="CommerceExpert "+$rev  //used in the title bar
	
	Storage_Replace($o; "version")
End if 


$o:=New object:C1471
$o.rev:="19-af"
$o.date:=!2020-12-09!
$o.rev:=$rev
$o.title:="CommerceExpert "+$rev  //used in the title bar
// $o.titleCompany:=Storage.default.company+" - "+$o.title
Storage_ToNew($o; "version")


$o:=New object:C1471
$o.currency:=2
$o.qty:=1
$o.cost:=2
Storage_ToNew($o; "precision")

$o:=New object:C1471

$o.console:=0
//  $o.workers:=New shared collection
$o.techNote:=0
$o.salesService:=0
$o.processList:=0
$o.qq:=0
Storage_ToNew($o; "process")


$o:=New object:C1471
Case of 
	: (Is macOS:C1572)
		$o.folderDelim:=":"
		$o.lineBreak:=Char:C90(13)
	: (Is Windows:C1573)
		$o.folderDelim:="\\"
		$o.lineBreak:=Char:C90(13)+Char:C90(10)
	Else 
		$o.folderDelim:="/"
		$o.lineBreak:=Char:C90(10)
End case 
// "\t":="\t"
// "\r":="\r" 
$o.cr:=Char:C90(13)  //  "\r"
$o.tab:=Char:C90(9)  //  "\t"
$o.lf:=Char:C90(10)  //  "\n"
$o.quote:=Char:C90(34)  //  "\""
$o.crlf:=Char:C90(13)+Char:C90(10)
$o.nbsp:="&nbsp;"
$o.space:=Char:C90(32)  //  " "
$o.semicolon:=Char:C90(59)  //  ";"
$o.comment:=Char:C90(32)+Char:C90(32)+Char:C90(47)+Char:C90(47)
$o.openpar:="("
$o.closepar:=")"
Storage_ToNew($o; "char")

$o:=New object:C1471
$o.begin:=New object:C1471("days"; -3; \
"timeOfDay"; ?00:00:00?; \
"timeSpan"; 0)
$o.end:=New object:C1471("days"; 7; \
"timeOfDay"; ?24:59:59?; \
"timeSpan"; 0)
Storage_ToNew($o; "dateSpan")

// to use in cEntry
//$o:=New object
//$o.left:=10
//$o.top:=10
//$o.width:=120
//$o.height:=new object("text";16
//$o.left:=10
//$o.left:=10
//$o.left:=10
//$o.left:=10
//$o.left:=10
//$o.left:=10

//Storage_ToNew($o; "dataEntryForm")

$o:=New object:C1471
$o.afterLengthMin:=2
Storage_ToNew($o; "query")


$o:=New object:C1471
Storage_Default
var $c : Collection
var $jitf; $foldersList; $property : Text
$jitf:=System folder:C487(Documents folder:K41:18)+"CommerceExpert"+Folder separator:K24:12  // create a folder in the Users Folder for documents
$o:=New object:C1471
$o.jitF:=$jitf
$foldersList:="catalog;jitCatalog;jitCerts;certs;jitLabels;jitDebug;jitFaxF;"+\
"jitAudits;jitDocs;jitExports;jitReports;jitScripts;jitSetups;jitShip"
$c:=Split string:C1554($foldersList; ";")
var $folder_o : Object
var $created : Boolean

// HOWTO:folder

For each ($property; $c)
	$o[$property]:=$jitf+$property+Folder separator:K24:12
	$folder_o:=Folder:C1567($jitf+$property+Folder separator:K24:12)
	If ($folder_o.exists=False:C215)
		$created:=Folder:C1567($jitf+$property+Folder separator:K24:12).create()
	End if 
End for each 
//If (False)
//$o.catalog:=$jitf+"catalog"+Folder separator
//$o.jitCatalog:=$jitf+"jitCatalog"+Folder separator
//$o.jitCerts:=$jitf+"jitCerts"+Folder separator
//$o.certs:=$jitf+"certs"+Folder separator
//$o.jitLabels:=$jitf+"jitLabels"+Folder separator
//$o.jitDebug:=$jitf+"jitDebug"+Folder separator
//$o.jitFaxF:=$jitf+"jitFaxF"+Folder separator
//$o.jitAudits:=$jitf+"jitAudits"+Folder separator
//$o.jitDocs:=$jitf+"jitDocs"+Folder separator
//$o.jitExports:=$jitf+"jitExports"+Folder separator
//$o.jitReports:=$jitf+"jitReports"+Folder separator
//$o.jitScripts:=$jitf+"jitScripts"+Folder separator
//$o.jitSetUps:=$jitf+"jitSetups"+Folder separator
////<>jitScript is not a folder clean up
//$o.jitShip:=$jitf+"jitShip"+Folder separator
////$o.applicaion:=Application file
////$o.data:=Data file
//End if 
Storage_ToNew($o; "folder")

$o:=New object:C1471
$o.cashe:=64000
$o.ediPass:=True:C214
$o.doArchive:=False:C215
Storage_ToNew($o; "k")

$o:=New object:C1471
$o.ediPass:=True:C214
$o.dialog:=True:C214
$o.console:=True:C214
Storage_ToNew($o; "alerts")

$o:=New object:C1471
$o.noImage:=Storage:C1525.folder.catalog+"images"+Folder separator:K24:12+"NoImage.jpg"
$o.pathEmpty:=Storage:C1525.folder.catalog+"images"+Folder separator:K24:12+"pathEmpty.jpg"
Storage_ToNew($o; "images")



var $tableName : Text
var $keyFieldNames : Text

// HOWTO:DefaultDoc
var $path : Text
$path:=Storage:C1525.folder.jitF+"Settings"+Folder separator:K24:12+"TitleFields.txt"
If (Test path name:C476($path)#1)
	var $o : Object
	$o:=New object:C1471
	For each ($tableName; ds:C1482)
		If ($tableName#"zz@")
			$o[$tableName]:="id"
		End if 
	End for each 
	$keyFieldNames:=JSON Stringify:C1217($o)
	TEXT TO DOCUMENT:C1237($path; $keyFieldNames)
End if 
$o:=New object:C1471
$o:=JSON Parse:C1218(Document to text:C1236($path))
Storage_ToNew($o; "menuField")

$o:=New object:C1471
$oSel:=New object:C1471
$data:=New object:C1471
$old:=New object:C1471

For each ($tableName; ds:C1482)
	If ($tableName#"zz@")
		$data:=ds:C1482[$tableName].all().orderBy("id desc")
		$old[$tableName]:=True:C214
		If ($data.length=0)
			$o[$tableName]:=""
			$oSel[$tableName]:=Null:C1517
		Else 
			$o[$tableName]:=$data.orderBy("id desc").first().id
			$oSel[$tableName]:=ds:C1482[$tableName].all()
		End if 
	End if 
End for each 
Storage_ToNew($old; "archiveDo")
Storage_ToNew($o; "lastEntity")
//Storage_ToNew($oSel; "lastSelection")



//$o:=New object
//var $rec_o : Object
//$rec_o:=ds.Employee.query("nameID = :1"; Current user).first()
//If ($rec_o=Null)
//$rec_o:=ds.Employee.new()
//$rec_o.nameID:=Current user
//$rec_o.role:="min"
//$rec_o.obGeneral:=Init_obGeneral
//$rec_o.save()
//End if 
////If ($rec_o.obSetup=Null)
////$rec_o.obSetup:=Init_obSetup
////$rec_o.save()
////End if 


Default_Employee



$o:=New object:C1471
$o.Array2D:=13
$o.Blobarray:=31
$o.Booleanarray:=22
$o.Datearray:=17
$o.Integerarray:=15
$o.Isalphafield:=0
$o.IsBLOB:=30
$o.IsBoolean:=6
$o.Iscollection:=42
$o.IsDate:=4
$o.Isinteger:=8
$o.Isinteger64:=25
$o.Islongint:=9
$o.IsNull:=255
$o.Isobject:=38
$o.Ispicture:=3
$o.Ispointer:=23
$o.Isreal:=1
$o.Isstringvar:=24
$o.Issubtable:=7
$o.Istext:=2
$o.IsTime:=11
$o.IsUndefined:=5
$o.Isvariant:=12
$o.LongIntarray:=16
$o.Objectarray:=39
$o.Picturearray:=19
$o.Pointerarray:=20
$o.Realarray:=14
$o.Stringarray:=21
$o.Textarray:=18
$o.Timearray:=32
$o["0"]:="Is alpha field"
$o["1"]:="Is real"
$o["2"]:="Is text"
$o["3"]:="Is picture"
$o["4"]:="Is date"
$o["5"]:="Is undefined"
$o["6"]:="Is Boolean"
$o["7"]:="Is subtable"
$o["8"]:="Is integer"
$o["9"]:="Is longint"
$o["11"]:="Is time"
$o["12"]:="Is variant"
$o["13"]:="Array 2D"
$o["14"]:="Real array"
$o["15"]:="Integer array"
$o["16"]:="LongInt array"
$o["17"]:="Date array"
$o["18"]:="Text array"
$o["19"]:="Picture array"
$o["20"]:="Pointer array"
$o["21"]:="String array"
$o["22"]:="Boolean array"
$o["23"]:="Is pointer"
$o["24"]:="Is string var"
$o["25"]:="Is integer 64 bits"
$o["30"]:="Is BLOB"
$o["31"]:="Blob array"
$o["32"]:="Time array"
$o["38"]:="Is object"
$o["39"]:="Object array"
$o["42"]:="Is collection"
$o["255"]:="Is null"
Storage_ToNew($o; "types4D")