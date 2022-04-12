//%attributes = {"publishedWeb":true}
Case of 
	: ((Record number:C243(ptCurTable->)=-3) | (Size of array:C274(aServiceRecs)<2))
		OBJECT SET ENABLED:C1123(bPrevious; False:C215)
		OBJECT SET ENABLED:C1123(bNext; False:C215)
	: (aServiceRecs=1)  //2 or more records
		OBJECT SET ENABLED:C1123(bPrevious; False:C215)
		OBJECT SET ENABLED:C1123(bNext; True:C214)
	: (aServiceRecs=Size of array:C274(aServiceRecs))
		OBJECT SET ENABLED:C1123(bPrevious; True:C214)
		OBJECT SET ENABLED:C1123(bNext; False:C215)
	Else 
		OBJECT SET ENABLED:C1123(bPrevious; True:C214)
		OBJECT SET ENABLED:C1123(bNext; True:C214)
End case 