//%attributes = {"publishedWeb":true}
C_POINTER:C301($1)
C_LONGINT:C283(bRayNx; bRayPrev)
Case of 
	: (Size of array:C274($1->)<2)
		OBJECT SET ENABLED:C1123(bRayPrev; False:C215)
		OBJECT SET ENABLED:C1123(bRayNx; False:C215)
	: ($1-><=1)  //2 or more records
		OBJECT SET ENABLED:C1123(bRayPrev; False:C215)
		OBJECT SET ENABLED:C1123(bRayNx; True:C214)
	: ($1->=Size of array:C274($1->))
		OBJECT SET ENABLED:C1123(bRayPrev; True:C214)
		OBJECT SET ENABLED:C1123(bRayNx; False:C215)
	Else 
		OBJECT SET ENABLED:C1123(bRayPrev; True:C214)
		OBJECT SET ENABLED:C1123(bRayNx; True:C214)
End case 