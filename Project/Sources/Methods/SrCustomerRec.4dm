//%attributes = {"publishedWeb":true}
C_LONGINT:C283(bChangeRec; $4)
C_POINTER:C301($1; $2; $3)
C_BOOLEAN:C305($5)
Case of 
	: ($4=1)
		If ($5)
			// zzzqqq jCapitalize1st($3)  //point to string (sr)
		End if 
		$2->:=$3->
		//: ($4=2)    //  If (bNewRec=0) array set to new
		//add an add record cabability here    
	Else 
		If (Modified record:C314($1->))
			SAVE RECORD:C53($1->)
		End if 
		jSrchCustLoad($1; $2; $3)
End case 