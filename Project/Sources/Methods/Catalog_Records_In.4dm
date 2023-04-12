//%attributes = {}

// Modified by: Bill James (2022-10-27T05:00:00Z)
// Method: Catalog_Records_In
// Description 
// Parameters
// ----------------------------------------------------



var $sel_o : Object
$sel_o:=ds:C1482.Item.query("indicator7 = 2023")
If (False:C215)
	
	
	
	If (False:C215)
		ALL RECORDS:C47([Item:4])
		Records_Out(->[Item:4])
		
	Else 
		ALL RECORDS:C47([Item:4])
		DELETE SELECTION:C66([Item:4])
		ALL RECORDS:C47([Item:4])
		myDocName:="/Users/williamjames/Documents/CommerceExpert/jitExports/004_Item_20230125.out"
		myDocName:=Convert path POSIX to system:C1107(myDocName)
		Records_In(->[Item:4]; ->myDocName)
		
		
		
		ALL RECORDS:C47([ProposalLine:43])
		DELETE SELECTION:C66([ProposalLine:43])
		ALL RECORDS:C47([ProposalLine:43])
		myDocName:="/Users/williamjames/Documents/CommerceExpert/act/043_ProposalLine_20221111.out"
		myDocName:=Convert path POSIX to system:C1107(myDocName)
		Records_In(->[ProposalLine:43]; ->myDocName)
	End if 
End if 

