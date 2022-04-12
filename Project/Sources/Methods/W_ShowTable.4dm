//%attributes = {}



C_OBJECT:C1216($settings; $targetSelection; $params)
C_LONGINT:C283($left; $top; $right; $bottom; $windowRef)
C_BOOLEAN:C305($fl_Select)
C_TEXT:C284($1)
C_OBJECT:C1216($2)
$dataClass:=$1  //Name of the table AND the dialog
$params:=$2  //Is there a selection? if yes, use it

If (Storage:C1525.windowList[$dataClass]=Null:C1517)  //This DataClass doesn't have a dialog
	$fl_Exist:=False:C215
Else 
	$windowReference:=Storage:C1525.windowList[$dataClass]
	ARRAY LONGINT:C221($ar_References; 0)
	WINDOW LIST:C442($ar_References)
	$fl_Exist:=(Find in array:C230($ar_References; $windowReference)>0)  //...we have to verify if the window itself still exists
End if 

If ($fl_Exist)
	//A window with this reference exists already, so we just call it
	CALL FORM:C1391($windowReference; "Call_TableFmWRef"; $dataClass; $params)
Else 
	//We have to create the Object from Class TableShow, 
	$tableObject:=cs:C1710.TableShow.new($dataClass)
	$tableObject.showIt($params)
	CALL FORM:C1391($tableObject.mainWindow; "Call_TableFmWRef"; $dataClass; $params)
End if 
