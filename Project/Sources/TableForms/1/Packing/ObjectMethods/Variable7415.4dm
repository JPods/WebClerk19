PkScaleStart
If (<>closeScale=0)
	OBJECT SET ENABLED:C1123(b53; False:C215)  // stop
	OBJECT SET ENABLED:C1123(b54; True:C214)  // startup
Else 
	OBJECT SET ENABLED:C1123(b53; True:C214)  // stop
	OBJECT SET ENABLED:C1123(b54; False:C215)  // startup
End if 