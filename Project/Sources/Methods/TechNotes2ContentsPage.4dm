//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/25/08, 00:38:46
// ----------------------------------------------------
// Method: TechNotes2ContentsPage
// Description
// 
//
// Parameters
// ----------------------------------------------------


myDoc:=Create document:C266("")
If (OK=1)
	vi2:=Records in selection:C76([TechNote:58])
	ORDER BY:C49([TechNote:58]; [TechNote:58]chapter:14; >; [TechNote:58]section:15; >)
	FIRST RECORD:C50([TechNote:58])
	
	
	vText6:="<Table width="+Txt_Quoted("100%")+">"
	vText6:=vText6+"<TR class="+Txt_Quoted("TechTitle")+">"+"\r"
	vText6:=vText6+"<TD>Chapter</TD>"
	vText6:=vText6+"<TD>Section</TD>"
	vText6:=vText6+"<TD>Name</TD>"
	vText6:=vText6+"<TD>Subject</TD>"
	vText6:=vText6+"<TD>Table</TD>"
	vText6:=vText6+"<TD>Version</TD>"
	vText6:=vText6+"<TD>Date</TD>"
	vText6:=vText6+"<TD>Author</TD>"+"\r"
	vText6:=vText6+"</TR>"+"\r"
	vi9:=0
	For (vi4; 1; vi2)
		
		If ([TechNote:58]chapter:14>vi9)
			vText6:=vText6+"<TR class="+Txt_Quoted("TechChapter")+">"+"\r"
			vText6:=vText6+"<TD colspan="+Txt_Quoted("2")+">Chapter: "+String:C10([TechNote:58]chapter:14)+"</TD>"
			vText6:=vText6+"<TD colspan="+Txt_Quoted("6")+">"+[TechNote:58]subject:6+"\r"
			vText6:=vText6+"</TR>"+"\r"
			vi9:=[TechNote:58]chapter:14
		Else 
			vText6:=vText6+"<TR class="+Txt_Quoted("TechSection")+">"+"\r"
			vText6:=vText6+"<TD>"+String:C10([TechNote:58]chapter:14)+"</TD>"
			vText6:=vText6+"<TD>"+String:C10([TechNote:58]section:15)+"</TD>"
			vText6:=vText6+"<TD><a href="+Txt_Quoted("Chap_"+String:C10([TechNote:58]chapter:14; "000")+"/"+String:C10([TechNote:58]chapter:14)+"_"+String:C10([TechNote:58]section:15)+".html")+">"+[TechNote:58]name:2+"</a></TD>"
			vText6:=vText6+"<TD>"+[TechNote:58]subject:6+"</TD>"
			If ([TechNote:58]tableNum:12>0)
				vText9:=Table name:C256(Table:C252([TechNote:58]tableNum:12))
			Else 
				vText9:="n/a"
			End if 
			vText6:=vText6+"<TD>"+vText9+"</TD>"
			vText6:=vText6+"<TD>"+[TechNote:58]version:9+"</TD>"
			vText6:=vText6+"<TD>"+String:C10([TechNote:58]datePublished:5)+"</TD>"
			vText6:=vText6+"<TD>"+[TechNote:58]author:10+"</TD>"+"\r"
			vText6:=vText6+"</TR>"+"\r"
		End if 
		NEXT RECORD:C51([TechNote:58])
		SEND PACKET:C103(myDoc; vText6)
		vText6:=""
	End for 
	SEND PACKET:C103(myDoc; "</TABLE>"+"\r")
	CLOSE DOCUMENT:C267(myDoc)
End if 

