TRACE:C157
If (Size of array:C274(aReqSelLns)>0)
	Rq_FillArrays(-8; aReqSelLns{1}; 1)
	ARRAY LONGINT:C221(aReqSelLns; 1)
	aReqSelLns{1}:=Size of array:C274(aRqRecNum)
	//  --  CHOPPED  AL_UpdateArrays(eActiveReqs; -2)
	// -- AL_SetSelect(eActiveReqs; aReqSelLns)
	viVert:=aReqSelLns{1}
	// -- AL_SetScroll(eActiveReqs; viVert; viHorz)
End if 