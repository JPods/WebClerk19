If (Not:C34([Invoice:26]jrnlComplete:48))
	// zzzqqq jCapitalize1st(Self:C308)
	If ((OptKey#1) & (Length:C16(Self:C308->)=2))
		Self:C308->:=Uppercase:C13(Self:C308->)
	End if 
	Find Ship Zone(->[Invoice:26]zip:12; ->[Invoice:26]zone:6; ->[Invoice:26]shipVia:5; ->[Invoice:26]country:13; ->[Invoice:26]siteid:86)
	Tt_FindByZip(->[Invoice:26]zip:12; ->[Invoice:26]salesNameID:23; ->[Invoice:26]repID:22)
	Zip_LoadCitySt(->[Invoice:26]city:10; ->[Invoice:26]state:11; ->[Invoice:26]zip:12; ->[Invoice:26]country:13)
End if 