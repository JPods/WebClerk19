//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 04/01/11, 16:35:52
// ----------------------------------------------------
// Method: ParseDex
// Description
// 
//
// Parameters
// ----------------------------------------------------


$theClip:=Get text from pasteboard:C524

vText5:=Get text from pasteboard:C524
If (vText5="")
	vText5:=[UserReport:46]template:7
End if 
vi5:=Position:C15("<div id="+Char:C90(34)+"listing1"; vText5)
vText5:=Substring:C12(vText5; vi5)

ALERT:C41(Substring:C12(vText5; 1; 20))

vi5:=Position:C15("\r"; vText5)
vText5:=Substring:C12(vText5; vi5+1)

ALERT:C41(Substring:C12(vText5; 1; 20))


vi5:=Position:C15("addPoint("; vText5)  //vi5:=Position("addPoint({index:";vText5)
vText5:=Substring:C12(vText5; 1; vi5)  //vText5:=substring(vText5;1;vi5-1)

ALERT:C41(Substring:C12(vText5; 1; 20))


vi9:=1
TextToArray(vText5; ->aText1; "\r")
vi2:=Size of array:C274(aText1)

ALERT:C41(String:C10(vi2))

For (vi1; 1; vi2)
	vText5:=aText1{vi1}
	If (Length:C16(vText5)>14)
		vText1:=Substring:C12(vText5; 1; 14)
		
		vi5:=Position:C15("title="+Char:C90(34)+"LE"; vText5)  //Company Name
		vText5:=Substring:C12(vText5; vi5+10)  //Chop to Name
		vi5:=Position:C15("</A>"; vText5)  //End of Company Name
		vText2:=Substring:C12(vText5; 1; vi5-1)
		//
		vi5:=Position:C15("class="+Char:C90(34)+"address"; vText5)
		vText5:=Substring:C12(vText5; vi5+16)  //Chop to Address
		
		vi5:=Position:C15("<"; vText5)  //End of Company Name
		vText3:=Substring:C12(vText5; 1; vi5-2)
		
		
		TextToArray(vText3; ->aText2; ", ")
		CREATE RECORD:C68([Lead:48])
		[Lead:48]phone:4:=vText1
		[Lead:48]company:5:=vText2
		[Lead:48]address1:6:=aText2{1}
		// [Lead]Address2
		[Lead:48]city:8:=aText2{2}
		[Lead:48]state:9:=aText2{3}
		[Lead:48]zip:10:=aText2{4}
		
		[Lead:48]dateEntered:21:=Current date:C33
		SAVE RECORD:C53([Lead:48])
	End if 
End for 

