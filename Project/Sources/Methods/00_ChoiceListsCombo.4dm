//%attributes = {}
///https://blog.4d.com/use-collections-and-lists-within-forms-objects/

$o:=New object:C1471

// prepare the tab control object
$o.oTab:=New object:C1471
$o.oTab.values:=New collection:C1472("Alpha"; "Bravo"; "Charlie")
$o.oTab.index:=0  // select the "Alpha" Tab

// prepare the Title object
$o.oCombo:=New object:C1471
$o.oCombo.values:=New collection:C1472("Mr"; "Mz"; "Dr")
$o.oCombo.currentValue:=""

// prepare the Status object
// tip : when the index = -1, the currentValue is used as a placeholder !
$o.oPop:=New object:C1471
$o.oPop.values:=New collection:C1472("Single"; "Married"; "Widdow"; "Divorced")
$o.oPop.currentValue:="Select status…"
$o.oPop.index:=-1

$win:=Open form window:C675("00ComboExample")
DIALOG:C40("00ComboExample"; $o)