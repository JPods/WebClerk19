//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-10-02T00:00:00, 11:05:52
// ----------------------------------------------------
// Method: My_Special7
// Description
// Modified: 10/02/13
// 
// 
//
// Parameters
// ----------------------------------------------------

TRACE:C157
vi9:=0
C_OBJECT:C1216(obSelection; obRecord)
vText11:="https://www.webclerk.net/hearth/"
obSelection:=ds:C1482.Item.query("ImagePath # :1"; "")
For each (obRecord; obSelection)
	vi5:=Position:C15("catalog"; obRecord.imagePath)
	If (vi5>0)
		obRecord.imagePath:=vText11+Substring:C12(obRecord.imagePath; vi5)
		obRecord.imagePath:=Replace string:C233(obRecord.imagePath; "\\"; "/")
		obRecord.save()
		vi9:=vi9+1
	End if 
	vi5:=Position:C15("catalog"; obRecord.imagePath)
	If (vi5>0)
		obRecord.imagePath:=vText11+Substring:C12(obRecord.imagePath; vi5)
		obRecord.imagePath:=Replace string:C233(obRecord.imagePath; "\\"; "/")
		obRecord.save()
	End if 
End for each 
ALERT:C41("Done: "+String:C10(vi9))

TRACE:C157

TRACE:C157
vi9:=0
C_OBJECT:C1216(obSelection; obRecord)
vText11:="http://data.webclerk.com/"
obSelection:=ds:C1482.QA.query("Path # :1"; "")
For each (obRecord; obSelection)
	vi5:=Position:C15("Customer"; obRecord.Path)
	If (vi5>0)
		obRecord.imagePath:=vText11+Substring:C12(obRecord.imagePath; vi5)
		obRecord.imagePath:=Replace string:C233(obRecord.imagePath; "\\"; "/")
		obRecord.save()
		vi9:=vi9+1
	End if 
	vi5:=Position:C15("catalog"; obRecord.imagePathTn)
	If (vi5>0)
		obRecord.imagePathTn:=vText11+Substring:C12(obRecord.imagePathTn; vi5)
		obRecord.imagePathTn:=Replace string:C233(obRecord.imagePathTn; "\\"; "/")
		obRecord.save()
	End if 
End for each 
ALERT:C41("Done: "+String:C10(vi9))
