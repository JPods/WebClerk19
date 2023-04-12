//%attributes = {}

// Modified by: Bill James (2021-11-19T06:00:00Z)
// Method: 000FixImageCustomers
// Description 
// Parameters
// ----------------------------------------------------

var rec_ent; sel_ent : Object
var path_t; original_t : Text
var count_o; count_s; count_c : Integer


If (False:C215)
	sel_ent:=ds:C1482.Document.query("path  = :1"; "@/Applications/4D v18 R5/@")
	For each (rec_ent; sel_ent)
		rec_ent.path:=Replace string:C233(rec_ent.path; "/Applications/4D v18 R5/"; "")
		rec_ent.save()
	End for each 
End if 


If (False:C215)
	vi2:=Records in selection:C76([Document:100])
	FIRST RECORD:C50([Document:100])
	vtext10:="//ACFS1/ACTshare/CommerceExpert"
	For (vi1; 1; vi2)
		vi8:=Position:C15("Customer"; [Document:100]path:4)
		If (vi8>0)
			[Document:100]copyrightPath:15:=[Document:100]path:4
			vText8:=Substring:C12([Document:100]path:4; vi8)
			vText8:=Replace string:C233(vText8; "Customers"; "Customer")
			vText8:=Replace string:C233(vText8; "\\"; "/")
			vText8:=vtext10+"/"+Replace string:C233(vText8; ":"; "/")
			[Document:100]path:4:=vText8
			//[Document]path:=Convert path system to POSIX(vText8)
			SAVE RECORD:C53([Document:100])
		End if 
		NEXT RECORD:C51([Document:100])
	End for 
	ALERT:C41("Complete")
	
	vtext10:="\\ACFS1\\ACTshare\\CommerceExpert"
	sel_ent:=ds:C1482.Document.query("path  # :1"; "")
	For each (rec_ent; sel_ent)
		rec_ent.copyrightPath:=rec_ent.path
		vi8:=Position:C15(":Customer"; rec_ent.path)
		If (vi8>0)
			vText8:=Substring:C12(rec_ent.path; vi8)
			vText8:=Replace string:C233(vText8; "Customers"; "Customer")
			vText8:=vtext10+Replace string:C233(vText8; ":"; "\\")
			rec_ent.path:=Convert path system to POSIX:C1106(vText8)
			
			rec_ent.itemNum:=Substring:C12(rec_ent.path; 1; 35)
		End if 
		rec_ent.save()
	End for each 
End if 

If (False:C215)
	sel_ent:=ds:C1482.Document.query("path  = :1"; "@/Applications/4D v18 R5/@")
	For each (rec_ent; sel_ent)
		rec_ent.path:=Replace string:C233(rec_ent.path; "/Applications/4D v18 R5/"; "")
		rec_ent.save()
	End for each 
End if 

sel_ent:=ds:C1482.Document.query("path  # :1"; "")
count_o:=sel_ent.length
CONFIRM:C162("Convert to POSIX: "+String:C10(count_o))
For each (rec_ent; sel_ent)
	original_t:=rec_ent.path
	path_t:=Convert path POSIX to system:C1107(rec_ent.path)
	If (path_t#rec_ent.path)
		count_c:=count_c+1
	End if 
	If (Position:C15("/Customers/"; path_t)>0)
		count_s:=count_s+1
	End if 
	path_t:=Replace string:C233(path_t; "/Customers/"; "/Customer/")
	
	Case of 
		: (Test path name:C476(path_t)=1)
			
		: (Test path name:C476(path_t)=0)
			rec_ent.sizeBytes:=0
		Else 
			rec_ent.sizeBytes:=-1
	End case 
	rec_ent.path:=Convert path system to POSIX:C1106(path_t)
	
	If (rec_ent.pathTN#"")
		path_t:=Convert path POSIX to system:C1107(rec_ent.pathTN)
		path_t:=Replace string:C233(path_t; "/Customers/"; "/Customer/")
		rec_ent.pathTN:=Convert path system to POSIX:C1106(path_t)
	End if 
	rec_ent.save()
End for each 
ALERT:C41("Counts start: "+String:C10(count_o)+", OS: "+String:C10(count_c)+", Customers: "+String:C10(count_s))