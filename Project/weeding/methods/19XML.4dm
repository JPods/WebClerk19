//%attributes = {}
var $oXML : Object
var $txml : Text

$t_xml:=Get text from pasteboard:C524
$t_path:="/Users/williamjames/Documents/CommerceExpert/00WebClerk19/Resources/CE13ztjEN.xlf"
//$t_path:="/Users/williamjames/Documents/CommerceExpert/00WebClerk19/Project/Sources/catalog copy.4DCatalog"

$oXML:=cs:C1710.xml.new()
$oXML.newRef($t_path)

$oXML.root:=$t_path
$oXLM.xml:=$oXML.root.toObject()