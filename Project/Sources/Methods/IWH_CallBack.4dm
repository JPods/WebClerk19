//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/03/12, 13:41:58
// ----------------------------------------------------
// Method: IWH_CallBack
// Description
// used in the ItemWarehouse layout
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1; $2)
//$1  =  eItemWarehouse
//$2 =  long integer that reports what action caused data entry to begin in the cell
//$3 = long integer that reports whether the record was loaded or not (when fields are being displayed)
C_BOOLEAN:C305($doThis)  //Entry Valid (True) or Entry Rejected (False)

//C_LONGINT($2)//Action that Caused Entry Finished
C_LONGINT:C283($modCell)
$doThis:=True:C214
C_LONGINT:C283($col; $row)
If (False:C215)  ///  CHOPPED  AL_GetCellMod($1)=1)  //cell was modified
	//
	
	
	//  CHOPPED  $modCell:=AL_GetCellMod($1)
	
	//aExtended{vRow}:=aQty{vRow}*aPrice{vRow}  is for arrays, need to find what works for records.
	
	//  CHOPPED  AL_GetCurrCell($1; $col; $row)
	READ WRITE:C146([ItemWarehouse:117])
	
	If ($row>0)
		C_BOOLEAN:C305($doChange)
		$doChange:=(UserInPassWordGroup("Inventory"))
		If ($doChange)
			Case of 
				: ($col=1)
					
				: ($col=2)
					LOAD RECORD:C52([ItemWarehouse:117])
					ItemWarehouseCombine(1)
					SAVE RECORD:C53([ItemWarehouse:117])
					UNLOAD RECORD:C212([ItemWarehouse:117])
				: ($col=3)
					
					
				: ($col=4)
					
				: ($col=5)
					
				: ($col=6)
					
				: ($col=7)
					
					
				: ($col=8)
					
			End case 
		End if 
		//  --  CHOPPED  AL_UpdateArrays($1; 2)
	End if 
End if 