Srch_FullDia(->[Document:100])
TRACE:C157
$k:=Records in selection:C76([Document:100])
If ($k>0)
	C_LONGINT:C283($i; $k)
	TRACE:C157
	HtPageRay(0)
	FIRST RECORD:C50([Document:100])
	iLoText1:=[Document:100]path:4
	For ($i; 1; $k)
		$w:=Size of array:C274(aHtPage)+1
		HtPageRay(-3; $w; 1)
		
		aHtBkGraf{$w}:=[Document:100]title:8
		aHtBkColor{$w}:=[Document:100]description:3
		aHtLink{$w}:=[Document:100]keyTags:11
		aHtPage{$w}:=[Document:100]imageName:2
		aHtvLink{$w}:=String:C10([Document:100]idNum:1)
		aHtaLink{$w}:=[Document:100]pathTN:5
		aHtPage{$w}:=[Document:100]imageName:2
		aHtBody{$w}:=[Document:100]event:9
		aHtReason{$w}:=String:C10([Document:100]publish:12)
		aHtStyle{$w}:=[Document:100]copyrightPath:15
		NEXT RECORD:C51([Document:100])
	End for 
	//  --  CHOPPED  AL_UpdateArrays(eHttpEdit; -2)
End if 