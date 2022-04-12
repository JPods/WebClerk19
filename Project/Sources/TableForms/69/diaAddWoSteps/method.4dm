Case of 
	: (Before:C29)
		WO_FillStepRays(0)
		Ws_ALDefine(eWoStepList)
		<>aJobTypes:=1
		<>aCostCause:=1
		<>aWoTypes:=1
		vi1:=0
		vi2:=0
		v1:=""
		ARRAY LONGINT:C221(aWoStepLns; 0)
	Else 
		Case of 
			: (doSearch>0)
				//  --  CHOPPED  AL_UpdateArrays(eWoStepList; -2)
				doSearch:=0
			: ((doSearch=-3) & (Size of array:C274(aWoStepLns)>0))
				
				WO_BuildFromTemplate
				
				CANCEL:C270
		End case 
End case 