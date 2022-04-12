// (OM) HTTPClient_DelParamButton

C_LONGINT:C283($row)

$row:=HTTPClient_ParamListbox
If (($row>=1) & ($row<=Size of array:C274(HTTPClient_ParamListbox)))
	LISTBOX DELETE ROWS:C914(HTTPClient_ParamListbox; $row)
End if 
