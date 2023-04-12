C_OBJECT:C1216($event_o)
C_LONGINT:C283($eventCode_i)
$eventCode_i:=Form event code:C388
$event_o:=FORM Event:C1606

Case of 
	: (LBDraftTable=Null:C1517)
		
	: ($eventCode_i=On Header Click:K2:40)
		
		
		
	: ($eventCode_i=On Clicked:K2:4)
		column_i:=$event_o.column
		$lbName:="LB_Draft"
		ARRAY TEXT:C222($arrColNames; 0)
		ARRAY TEXT:C222($arrHeaderNames; 0)
		ARRAY POINTER:C280($arrColVars; 0)
		ARRAY POINTER:C280($arrHeaderVars; 0)
		ARRAY BOOLEAN:C223($arrColsVisible; 0)
		ARRAY POINTER:C280($arrStyles; 0)
		ARRAY TEXT:C222($arrFooterNames; 0)
		ARRAY POINTER:C280($arrFooterVars; 0)
		LISTBOX GET ARRAYS:C832(*; $lbName; $arrColNames; $arrHeaderNames; $arrColVars; $arrHeaderVars; $arrColsVisible; $arrStyles; $arrFooterNames; $arrFooterVars)
		
		//.$arrColNames{column_i}
		Form:C1466.column:=Form:C1466.obHarvest.columns[String:C10(column_i-1)]
		
	: ($eventCode_i=On Begin Drag Over:K2:44)
		lbDragFrom_t:="LB_Draft"
		
	: ($eventCode_i=On Drag Over:K2:13)
		
	: ($eventCode_i=On Drop:K2:12)
		If (lbDragFrom_t="lbFields")
			
			
		End if 
		
		
		Form:C1466.column:=Form:C1466.obHarvest.columns[String:C10($event_o.column)]
End case 