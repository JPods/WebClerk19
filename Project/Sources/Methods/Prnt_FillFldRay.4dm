//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $2)  //menu number; file number
C_LONGINT:C283($w; $k; $i)
C_TEXT:C284($strFile; $strMenu)
StructureFields($2)
SORT ARRAY:C229(theFields; theFldNum; theUniques; theTypes)
//
$w:=Size of array:C274(aStructure)+1
$k:=Size of array:C274(theFields)
INSERT IN ARRAY:C227(aStructure; $w; 1)
aStructure{$w}:="1;0;0;"+Table name:C256($2)
$w:=$w+1  //step over the title
INSERT IN ARRAY:C227(aStructure; $w; $k)
$k:=$k+$w-1
$strMenu:=String:C10($1)+";"+String:C10($2)
$i:=0
For ($w; $w; $k)
	$i:=$i+1
	aStructure{$w}:=$strMenu+";"+String:C10(theFldNum{$i})+";"+theFields{$i}
End for 
vi1:=vi1+1