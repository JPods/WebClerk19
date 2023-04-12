
// Modified by: Bill James (2021-12-18T06:00:00Z)
// Method: LBXDynamicDemo
// Description 
// Parameters
// ----------------------------------------------------
//  Called by LBX_DemoDynamic_00


Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284(jsonText; $demoSpanText)
		C_LONGINT:C283($nCol)
		///ARRAY TEXT(PDDLDISP; 0)
		ARRAY TEXT:C222(colNames2; 0)
		C_OBJECT:C1216(form_o)
		
		
		
		
		
		//OBJECT SET SUBFORM(*; "Subform"; $form)
	: (Form:C1466.LB_Tables.cur=Null:C1517)
		If (Form:C1466.dataClassName#Null:C1517)
			Form:C1466.LB_Tables.sel:=Form:C1466.LB_Tables.ents.query("tableName = :1"; "Customer")
		Else 
			Form:C1466.LB_Tables.sel:=Form:C1466.LB_Tables.ents.query("tableName = :1"; Form:C1466.dataClassName)
		End if 
		Form:C1466.LB_Tables.cur:=Form:C1466.LB_Tables.sel[0]
		//Form.dataClassName:=Form.LB_Tables.cur.tableName
		
End case 