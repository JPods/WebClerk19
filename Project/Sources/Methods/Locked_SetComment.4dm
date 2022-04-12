//%attributes = {"publishedWeb":true}
//Method: Locked_SetComment
C_POINTER:C301($1; $2)
If (Locked:C147($1->))
	OBJECT SET ENTERABLE:C238($2->; False:C215)
	OBJECT SET RGB COLORS:C628($2->; 0x0000; 0x00CCCCCC)
Else 
	OBJECT SET ENTERABLE:C238($2->; True:C214)
	OBJECT SET RGB COLORS:C628($2->; 0x0000; 0x00FFFFFF)
End if 