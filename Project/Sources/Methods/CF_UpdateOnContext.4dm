//%attributes = {}



// 4D_25Invoice - 2022-01-15
If (Form:C1466.currentPage=Null:C1517)
	Form:C1466.currentPage:=FORM Get current page:C276
End if 

Case of 
	: (Form:C1466.currentPage=1)
		OBJECT SET ENABLED:C1123(*; "@_SEL_@"; (Num:C11(Form:C1466.selectedSubset.length)>0))
		
	: (Form:C1466.currentPage=2)
		Util25_HandleButtons(Form:C1466.editEntity)
		
End case 
Util25_SetWindowTitle(Form:C1466; Current form window:C827)


If (False:C215)
	If (Form:C1466.editEntity#Null:C1517)  //Specific for each DataClass
		Case of 
			: (Form:C1466.dataClassName="Invoices")  //Specific for Invoices
				$proforma:=Not:C34(OB Is empty:C1297(Form:C1466.editEntity))
				If ($proforma)
					$proforma:=Form:C1466.editEntity.ProForma
				End if 
				OBJECT SET VISIBLE:C603(*; "@_PROF_@"; $proforma)
				
		End case 
	End if 
End if 