//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $2; $3)
Case of 
	: ($1=0)
		ARRAY TEXT:C222(aHtSelect; 0)
		ARRAY TEXT:C222(aHtPage; 0)  //file name
		//
		ARRAY TEXT:C222(aHtReason; 0)  //meta tag
		//
		ARRAY TEXT:C222(aHtStyle; 0)  //parse for rel=
		//
		ARRAY TEXT:C222(aHtUpDate; 0)  //meta tag
		ARRAY TEXT:C222(aHtRevisionDate; 0)  //meta tag
		ARRAY TEXT:C222(aHtrevisionID; 0)  //meta tag
		ARRAY TEXT:C222(aHtProtection; 0)  //meta tag
		//
		ARRAY TEXT:C222(aHtJavaScript; 0)  //parse for rel=
		ARRAY TEXT:C222(aHtLocaljs; 0)  //parse page
		ARRAY TEXT:C222(aHtLocalstyle; 0)  //parse page
	: ($1=-3)
		INSERT IN ARRAY:C227(aHtSelect; $2; $3)
		INSERT IN ARRAY:C227(aHtPage; $2; $3)
		//
		INSERT IN ARRAY:C227(aHtReason; $2; $3)
		//
		INSERT IN ARRAY:C227(aHtStyle; $2; $3)
		//
		INSERT IN ARRAY:C227(aHtUpDate; $2; $3)  //meta tag
		INSERT IN ARRAY:C227(aHtRevisionDate; $2; $3)  //meta tag
		INSERT IN ARRAY:C227(aHtrevisionID; $2; $3)  //meta tag
		INSERT IN ARRAY:C227(aHtProtection; $2; $3)  //meta tag
		//
		INSERT IN ARRAY:C227(aHtJavaScript; $2; $3)  //parse for rel=
		INSERT IN ARRAY:C227(aHtLocaljs; $2; $3)  //parse page
		INSERT IN ARRAY:C227(aHtLocalstyle; $2; $3)  //parse page
		
End case 