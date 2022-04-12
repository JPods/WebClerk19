// (OM) HTTPClient_AddParamButton

C_LONGINT:C283($row)

$row:=Size of array:C274(HTTPClient_ParamName)+1
LISTBOX INSERT ROWS:C913(HTTPClient_ParamListbox; $row)
EDIT ITEM:C870(HTTPClient_ParamName; $row)
