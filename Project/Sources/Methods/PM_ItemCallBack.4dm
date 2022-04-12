//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/03/12, 13:42:59
// ----------------------------------------------------
// Method: PM_ItemCallBack
// Description
// 
//
// Parameters
// ----------------------------------------------------

//January 2, 1996//TRACE
//called in AL Definitions
C_BOOLEAN:C305($0)  //Entry Valid (True) or Entry Rejected (False)
C_LONGINT:C283($1)  //Area Name
C_LONGINT:C283($2)  //Action that Caused Entry Finished
$0:=True:C214
C_LONGINT:C283($col; $row)
If (False:C215)  //  CHOPPED  AL_GetCellMod($1)=1)  //cell was modified
	//
	//  CHOPPED  AL_GetCurrCell($1; $col; $row)
	If ($row>0)
		READ WRITE:C146([PriceMatrix:105])
		
		PriceMatrix_FillArrays(-13; $row)
		//READ ONLY([WorkOrder])
	End if 
	//  --  CHOPPED  AL_UpdateArrays($1; -2)
End if 