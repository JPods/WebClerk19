C_LONGINT:C283($error; $i; $k)
Case of 
		//  : (Size of array(aHtPage)=0)//drop out if no arrays
	: (ALProEvt=0)
	: (ALProEvt=1)
		//  CHOPPED  $error:=AL_GetSelect(eHttpEdit; aRayLines)
		GOTO OBJECT:C206(iLoText5)
		iLoText2:=aHtBkGraf{aRayLines{1}}  //[ImagePath]Title
		iLoText8:=aHtBkColor{aRayLines{1}}  //[ImagePath]Description
		iLoText10:=aHtLink{aRayLines{1}}  //[ImagePath]KeywordText
		//iLoText2:=aHtvLink{aRayLines{1}}//$aStrRecs{$fia}
		//iLoText2:=aHtaLink{aRayLines{1}}//[ImagePath]PathHiRes
		iLoText3:=aHtText{aRayLines{1}}  //[ImagePath]ImageName
		iLoText4:=aHtBody{aRayLines{1}}  //[ImagePath]Event
		iLoText5:=aHtReason{aRayLines{1}}  //String([ImagePath]Publish)
		//aHtStyle{aRayLines{1}}//[ImagePath]CopyrightPath
		
		
	: (ALProEvt=2)
		//  CHOPPED  $error:=AL_GetSelect(eHttpEdit; aRayLines)
		GOTO OBJECT:C206(iLoText5)
		iLoText2:=aHtBkGraf{aRayLines{1}}  //[ImagePath]Title
		iLoText8:=aHtBkColor{aRayLines{1}}  //[ImagePath]Description
		iLoText10:=aHtLink{aRayLines{1}}  //[ImagePath]KeywordText
		//iLoText2:=aHtvLink{aRayLines{1}}//$aStrRecs{$fia}
		//iLoText2:=aHtaLink{aRayLines{1}}//[ImagePath]PathHiRes
		iLoText3:=aHtText{aRayLines{1}}  //[ImagePath]ImageName
		iLoText4:=aHtBody{aRayLines{1}}  //[ImagePath]Event
		iLoText5:=aHtReason{aRayLines{1}}  //String([ImagePath]Publish)
		//aHtStyle{aRayLines{1}}//[ImagePath]CopyrightPath
		vText2:=""
		vText1:=iLoText1+aHtPage{aRayLines{1}}
		AE_LaunchDoc(vText1)
	: (ALProEvt=-2)  //Edit menu Select All    
		AL_CmdAll(->aHtPage; ->aRayLines)
	: (ALProEvt=-3)  //Column Resize    
	: (ALProEvt=-4)  //Column Lock Changed
	: ((ALProEvt=-5) | (ALProEvt=-1))  //Line has been dragged    
		//  --  CHOPPED  AL_UpdateArrays(eHttpEdit; -2)
	: (ALProEvt=-6)  //User invoked Sort Editor       
End case 
C_LONGINT:C283($error)
ALProEvt:=0