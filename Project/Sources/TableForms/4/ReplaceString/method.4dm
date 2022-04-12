Case of 
	: (Before:C29)
		jaFilesInitial(True:C214; True:C214)  //restricted access; auto load search field
		Fld_ALDefine(eExportFlds)
		vText6:=Table name:C256(ptCurTable)
		ARRAY TEXT:C222(aTmp20Str2; 4)
		aTmp20Str2{1}:="Exact Match"
		aTmp20Str2{2}:="Begins with"
		aTmp20Str2{3}:="Contains"
		aTmp20Str2{4}:="Apply2UserSet"
		aTmp20Str2:=1
		ARRAY TEXT:C222(aTmp20Str1; 4)
		aTmp20Str1{1}:="Set CASE in fields"
		aTmp20Str1{2}:="Sentence Case"
		aTmp20Str1{3}:="UPPER CASE"
		aTmp20Str1{4}:="lower case"
		aTmp20Str1:=1
		
	Else 
		
End case 