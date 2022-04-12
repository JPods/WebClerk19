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
	//$rev:="19-af"
	//$o:=New object
	//$o.date:=!2020-12-14!
	$o.rev:=$rev
	$o.collect:=New collection:C1472(1; 2; New collection:C1472(New object:C1471("fn"; "John"; "ln"; "Smith"); New object:C1471("fn"; "Suzy"; "ln"; "Que")); New collection:C1472(41; 42; 43; 44); 5)
	$o.title:="CommerceExpert "+$rev  //used in the title bar
	
	Storage_Replace($o; "version")
End if 


$o:=New object:C1471
$rev:="19-af"
$o:=New object:C1471
$o.date:=!2020-12-09!
$o.rev:=$rev
$o.title:="CommerceExpert "+$rev  //used in the title bar
// $o.titleCompany:=Storage.default.company+" - "+$o.title
Storage_ToNew($o; "version")

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
Storage_Default

var $jitf : Text
$jitf:=System folder:C487(Documents folder:K41:18)+"CommerceExpert"+Folder separator:K24:12  // create a folder in the Users Folder for documents
$o:=New object:C1471
$o.jitF:=$jitf
$o.catalog:=$jitf+"catalog"+Folder separator:K24:12
$o.jitCatalog:=$jitf+"jitCatalog"+Folder separator:K24:12
$o.jitCerts:=$jitf+"jitCerts"+Folder separator:K24:12
$o.certs:=$jitf+"certs"+Folder separator:K24:12
$o.jitLabels:=$jitf+"jitLabels"+Folder separator:K24:12
$o.jitDebug:=$jitf+"jitDebug"+Folder separator:K24:12
$o.jitFaxF:=$jitf+"jitFaxF"+Folder separator:K24:12
$o.jitAudits:=$jitf+"jitAudits"+Folder separator:K24:12
$o.jitDocs:=$jitf+"jitDocs"+Folder separator:K24:12
$o.jitExports:=$jitf+"jitExports"+Folder separator:K24:12
$o.jitReports:=$jitf+"jitReports"+Folder separator:K24:12
$o.jitScripts:=$jitf+"jitScripts"+Folder separator:K24:12
//<>jitScript is not a folder clean up

$o.jitShip:=$jitf+"jitShip"+Folder separator:K24:12
//$o.applicaion:=Application file
//$o.data:=Data file
Storage_ToNew($o; "folder")

$o:=New object:C1471
$o.cashe:=64000
$o.ediPass:=True:C214
$o.doArchive:=False:C215
Storage_ToNew($o; "k")


$o:=New object:C1471

$o.console:=0
//  $o.workers:=New shared collection
$o.techNote:=0
$o.salesService:=0
$o.qq:=0
Storage_ToNew($o; "process")


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



