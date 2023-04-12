//%attributes = {}

// Modified by: Bill James (2022-04-08T05:00:00Z)
// Method: 19_PathTests
// Description 
// Parameters
// ----------------------------------------------------
var $folder_o : Object
var $path_ts; $path_p; $path_pos : Text

$folder_o:=Folder:C1567(fk resources folder:K87:11)
//https://doc.4d.com/4Dv19/4D/19.1/folderpath.303-5652975.en.html
$path_t:=Folder:C1567(fk resources folder:K87:11).path
$path_t:=Folder:C1567(fk resources folder:K87:11).platformPath
$path_par:=HFS_ParentName($path_t)  //$path_t.parent
$path_par:=Folder:C1567(fk resources folder:K87:11).platformPath.parent



$folder_o:=Folder:C1567(fk applications folder:K87:20)
$folder_o:=Folder:C1567(fk applications folder:K87:20)


$folder_o:=Folder:C1567(fk data folder:K87:12)
$folder_o:=Folder:C1567(fk data folder:K87:12)


$folder_o:=Folder:C1567(fk editor theme folder:K87:23)
$folder_o:=Folder:C1567(fk editor theme folder:K87:23)


$folder_o:=Folder:C1567(fk documents folder:K87:21)
$folder_o:=Folder:C1567(fk documents folder:K87:21)

$folder_o:=Folder:C1567(fk documents folder:K87:21)
$folder_o:=Folder:C1567(fk documents folder:K87:21)

$folder_o:=Folder:C1567(fk documents folder:K87:21)
$folder_o:=Folder:C1567(fk documents folder:K87:21)