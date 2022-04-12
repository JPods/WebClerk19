//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1)  //Area Name
C_LONGINT:C283($2)  //Action that Caused Entry Finished
C_LONGINT:C283($col; $row)
Case of 
	: ($1=eSrchPat)
		//  CHOPPED  AL_GetCurrCell(eSrchPat; $col; $row)
		aQueryFieldNames:=$row
End case 