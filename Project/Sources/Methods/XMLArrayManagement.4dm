//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: XMLArrayManagement
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_LONGINT:C283($1)
C_LONGINT:C283($1; $2; $3; $4; $5)
Case of 
	: ($1=0)
		ARRAY TEXT:C222(aXMLTable; 0)
		ARRAY TEXT:C222(aXMLField; 0)
		ARRAY TEXT:C222(aXMLTag; 0)
		ARRAY TEXT:C222(aXMLTagParams; 0)
		ARRAY TEXT:C222(aXMLValue; 0)
		ARRAY LONGINT:C221(aXMLMatch; 0)
		ARRAY LONGINT:C221(aXMLSequence; 0)
		
		ARRAY TEXT:C222(aXMLAction; 0)
		ARRAY LONGINT:C221(aXMLTableNum; 0)
		ARRAY LONGINT:C221(aXMLFieldNum; 0)
		ARRAY TEXT:C222(aXMLReadTag; 0)
		//
		ARRAY LONGINT:C221(aXMLLineSelect; 0)
	: ($1>0)
		ARRAY TEXT:C222(aXMLTable; $1)
		ARRAY TEXT:C222(aXMLField; $1)
		ARRAY TEXT:C222(aXMLTag; $1)
		ARRAY TEXT:C222(aXMLTagParams; $1)
		ARRAY TEXT:C222(aXMLValue; $1)
		ARRAY LONGINT:C221(aXMLMatch; $1)
		ARRAY LONGINT:C221(aXMLSequence; $1)
		
		ARRAY TEXT:C222(aXMLAction; $1)
		ARRAY LONGINT:C221(aXMLTableNum; $1)
		ARRAY LONGINT:C221(aXMLFieldNum; $1)
		ARRAY TEXT:C222(aXMLReadTag; $1)
		//
		ARRAY LONGINT:C221(aXMLLineSelect; 0)
		
	: ($1=-1)
		DELETE FROM ARRAY:C228(aXMLTable; $2; $3)
		DELETE FROM ARRAY:C228(aXMLField; $2; $3)
		DELETE FROM ARRAY:C228(aXMLTag; $2; $3)
		DELETE FROM ARRAY:C228(aXMLTagParams; $2; $3)
		DELETE FROM ARRAY:C228(aXMLValue; $2; $3)
		DELETE FROM ARRAY:C228(aXMLMatch; $2; $3)
		DELETE FROM ARRAY:C228(aXMLSequence; $2; $3)
		
		DELETE FROM ARRAY:C228(aXMLAction; $2; $3)
		DELETE FROM ARRAY:C228(aXMLTableNum; $2; $3)
		DELETE FROM ARRAY:C228(aXMLFieldNum; $2; $3)
		DELETE FROM ARRAY:C228(aXMLReadTag; $2; $3)
		//
		ARRAY LONGINT:C221(aXMLLineSelect; 0)
		
	: ($1=-3)
		INSERT IN ARRAY:C227(aXMLTable; $2; $3)
		INSERT IN ARRAY:C227(aXMLField; $2; $3)
		INSERT IN ARRAY:C227(aXMLTag; $2; $3)
		INSERT IN ARRAY:C227(aXMLTagParams; $2; $3)
		INSERT IN ARRAY:C227(aXMLValue; $2; $3)
		INSERT IN ARRAY:C227(aXMLMatch; $2; $3)
		INSERT IN ARRAY:C227(aXMLSequence; $2; $3)
		
		INSERT IN ARRAY:C227(aXMLAction; $2; $3)
		INSERT IN ARRAY:C227(aXMLTableNum; $2; $3)
		INSERT IN ARRAY:C227(aXMLFieldNum; $2; $3)
		INSERT IN ARRAY:C227(aXMLReadTag; $2; $3)
		//
	: ($1=-7)  //update element
		
		
		
End case 