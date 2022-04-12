//%attributes = {}

// Modified by: Bill James (2022-01-23T06:00:00Z)
// Method: Folder_Testing
// Description 
// Parameters
// ----------------------------------------------------

var $pathData; $pathResources; $pathForms; $pathTableForms : Text
var $o_data; $o_resouce; $o_ce; $parent : Object
//$pathData:=Folder("/DATA/")
//$pathResources:=Folder("/RESOURCES/")
$o_data:=Folder:C1567("/DATA")
$o_resouce:=Folder:C1567("/RESOURCES")
$parent:=$o_resouce.platformPath.parent
$o_ce:=Folder:C1567(Storage:C1525.folder.jitF)

$pathResources:=Get 4D folder:C485(Current resources folder:K5:16)
$pathData:=Get 4D folder:C485(Current resources folder:K5:16)

$projectName:=Folder:C1567(fk database folder:K87:14).name

