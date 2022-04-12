//%attributes = {"publishedWeb":true}
//CONFIRM("Import PressAccess?")
//If (OK=1)
//myDoc:=Open document("")
//If (OK=1)
////the script to parse the file minus the open document line
////          
//ARRAY TEXT($theText;0)
//ARRAY TEXT($parsedValues;8)
//vi1:=0
//vText1:=""
//Repeat //load in the document
//vi1:=vi1+1
//INSERT ELEMENT($theText;vi1;1)
//RECEIVE PACKET(myDoc;$theText{vi1};15000)
//Until ((OK=0)|(Length($theText{vi1})<15000))
//CLOSE DOCUMENT(myDoc)
//
//While (Size of array($theText)>0)
//vi1:=vi1+1
//If ((Length(vText1)<14000)&(Size of array($theText)>0))
//vText1:=vText1+$theText{1}
//If (Size of array($theText)>1)
//DELETE ELEMENT($theText;1;1)
//Else 
//aText1{1}:=""
//End if 
//End if 
