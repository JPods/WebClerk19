//%attributes = {"publishedWeb":true}
If (False:C215)
	// Method: BugAlert (routine info{; details})
	
	TCStrong_nds
	//02/21/2002.nds
	
End if 

C_TEXT:C284($1; $2)

Case of 
	: (Count parameters:C259=1)
		ALERT:C41("An error has occurred in the "+$1+".  Please notify the database developer.")
	: (Count parameters:C259=2)
		ALERT:C41("An error has occurred in the "+$1+".  "+$2+"  Please notify the database developer.")
	Else 
		ALERT:C41("An error has occurred in the BugAlert method."+"  Please notify the database developer.")
End case 

If (Not:C34(Is compiled mode:C492))  //replaced <>Development Foundation var
	TRACE:C157  // A developer is running the code.
Else 
	ABORT:C156  // An end-user is using the db.  Try to keep from doing any more damage.
End if 