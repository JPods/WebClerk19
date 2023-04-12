//%attributes = {}

// Modified by: Bill James (2022-07-21T05:00:00Z)
// Method: LBX_GetSetBox
// Description 
// Parameters
// ----------------------------------------------------
// much better documentation
//  https://livedoc.4d.com/4D-Language-Reference-19-R6/List-Box/LISTBOX-SET-PROPERTY.301-5911042.en.html

// FOR REFERENCE ONLY

// this is for the listbox as a whole
// set selection
LISTBOX SET PROPERTY:C1440(*; "LB1"; lk selection mode:K53:35; lk none:K53:57)
LISTBOX SET PROPERTY:C1440(*; "LB1"; lk selection mode:K53:35; lk single:K53:58)
LISTBOX SET PROPERTY:C1440(*; "LB1"; lk selection mode:K53:35; lk multiple:K53:59)

// get selection  -> returns integer
$selMode:=LISTBOX Get property:C917(*; "LB1"; lk selection mode:K53:35)

Case of 
	: ($selMode=lk none:K53:57)
		vResult:="lk none"
	: ($selMode=lk single:K53:58)
		vResult:="lk single"
	: ($selMode=lk multiple:K53:59)
		vResult:="lk multiple"
	Else 
		vResult:="???"
End case 

// set single click entry
LISTBOX SET PROPERTY:C1440(*; "LB22"; lk single click edit:K53:70; lk no:K53:68)
LISTBOX SET PROPERTY:C1440(*; "LB22"; lk single click edit:K53:70; lk yes:K53:69)

// get single click edit -> returns boolean
$result:=LISTBOX Get property:C917(*; "LB22"; lk single click edit:K53:70)
vResult:=Choose:C955($result; "No"; "Yes")


// set double clicking  
LISTBOX SET PROPERTY:C1440(*; "LB9"; lk double click on row:K53:43; lk do nothing:K53:52)
LISTBOX SET PROPERTY:C1440(*; "LB9"; lk double click on row:K53:43; lk edit record:K53:53)
LISTBOX SET PROPERTY:C1440(*; "LB9"; lk double click on row:K53:43; lk display record:K53:54)

// get double clicking  -> returns integer
$Action:=LISTBOX Get property:C917(*; "LB9"; lk double click on row:K53:43)
Case of 
	: ($Action=lk do nothing:K53:52)
		vResult:="Do nothing"
		
	: ($Action=lk edit record:K53:53)
		vResult:="Edit record"
		
	: ($Action=lk display record:K53:54)
		vResult:="Display record"
		
	Else 
		vResult:="???"
End case 

// set detailed form to use on double click  
LISTBOX SET PROPERTY:C1440(*; "LB10"; lk detail form name:K53:44; vFormName_t)

// get detailed form to use on double click   -> returns text
vFormName_t:=LISTBOX Get property:C917(*; "LB10"; lk detail form name:K53:44)






// set resize
LISTBOX SET PROPERTY:C1440(*; "LB2"; lk resizing mode:K53:36; lk manual:K53:60)
LISTBOX SET PROPERTY:C1440(*; "LB2"; lk resizing mode:K53:36; lk automatic:K53:61)

// get resize  -> returns integer
$selMode:=LISTBOX Get property:C917(*; "LB2"; lk resizing mode:K53:36)
Case of 
	: ($selMode=lk manual:K53:60)
		vResult:="lk manual"
	: ($selMode=lk automatic:K53:61)
		vResult:="lk automatic"
	Else 
		vResult:="???"
End case 


// set truncate
LISTBOX SET PROPERTY:C1440(*; "LB3"; lk truncate:K53:37; lk without ellipsis:K53:64)
LISTBOX SET PROPERTY:C1440(*; "LB3"; lk truncate:K53:37; lk with ellipsis:K53:65)

// set for a column, use name of column
LISTBOX SET PROPERTY:C1440(*; "LB3_Col1"; lk truncate:K53:37; lk without ellipsis:K53:64)
LISTBOX SET PROPERTY:C1440(*; "LB3_Col1"; lk truncate:K53:37; lk with ellipsis:K53:65)

// get column truncate  -> returns integer
$selMode:=LISTBOX Get property:C917(*; "LB3_Col1"; lk truncate:K53:37)
Case of 
	: ($selMode=lk without ellipsis:K53:64)
		vResult:="Without ellipsis"
	: ($selMode=lk with ellipsis:K53:65)
		vResult:="With ellipsis"
	Else 
		vResult:="???"
End case 

// set extra rows 
LISTBOX SET PROPERTY:C1440(*; "LB4"; lk extra rows:K53:38; lk hide:K53:63)
LISTBOX SET PROPERTY:C1440(*; "LB4"; lk extra rows:K53:38; lk display:K53:62)

// get extra rows  -> returns integer
$selMode:=LISTBOX Get property:C917(*; "LB4"; lk extra rows:K53:38)
Case of 
	: ($selMode=lk hide:K53:63)
		vResult:="Hidden"
	: ($selMode=lk display:K53:62)
		vResult:="Displayed"
	Else 
		vResult:="???"
End case 

// set wordwrap
LISTBOX SET PROPERTY:C1440(*; "LB5"; lk allow wordwrap:K53:39; lk no:K53:68)
LISTBOX SET PROPERTY:C1440(*; "LB5"; lk allow wordwrap:K53:39; lk yes:K53:69)

// set for a column, use name of column
LISTBOX SET PROPERTY:C1440(*; "LB5_Col1"; lk allow wordwrap:K53:39; lk no:K53:68)

// get wordwrap, listbox or column   -> returns boolean
$result:=LISTBOX Get property:C917(*; "LB5_Col1"; lk allow wordwrap:K53:39)
//vResult:=Choose($result; "No"; "Yes")

// set resize by listbox or by column name
LISTBOX SET PROPERTY:C1440(*; "LB6"; lk column resizable:K53:40; lk no:K53:68)
LISTBOX SET PROPERTY:C1440(*; "LB6"; lk column resizable:K53:40; lk yes:K53:69)

// get resize by listbox or by column name
$result:=LISTBOX Get property:C917(*; "P6_Col1"; lk column resizable:K53:40)
//vResult:=Choose($result; "No"; "Yes")

// set highlight
LISTBOX SET PROPERTY:C1440(*; "LB7"; lk hide selection highlight:K53:41; lk yes:K53:69)

// get selection highlight  -> returns boolean
$result:=LISTBOX Get property:C917(*; "LB7"; lk hide selection highlight:K53:41)
vResult:=Choose:C955($result; "No"; "Yes")


//This parameter defines the unit to be used for the row height.
//Possible values are "Pixels" or "Lines"
LISTBOX SET PROPERTY:C1440(*; "LB8"; lk row height unit:K53:42; lk pixels:K53:22)

//ARRAY TEXT(col1; 0)  // size of array of data in listbox type array
//$n:=Size of array(col1)
//ARRAY LONGINT(_Height; $n)
//$n:=Size of array(Col1)
//For ($i; 1; $n)
//_Height{$i}:=60
//End for 

LISTBOX SET PROPERTY:C1440(*; "LB8"; lk row height unit:K53:42; lk pixels:K53:22)

//$n:=Size of array(Col1)
//For ($i; 1; $n)
//_Height{$i}:=60
//End for 

// get row height unit of lines or pixels  -> returns integer
vRowsHeight:=LISTBOX Get property:C917(*; "LB8"; lk row height unit:K53:42)
Case of 
	: (vRowsHeight=lk pixels:K53:22)
		vResult:="Pixels"
		
	: (vRowsHeight=lk lines:K53:23)
		vResult:="Lines"
		
	Else 
		vResult:="???"
End case 


// set allow sort  
LISTBOX SET PROPERTY:C1440(*; "LB11"; lk sortable:K53:45; lk no:K53:68)
LISTBOX SET PROPERTY:C1440(*; "LB11"; lk sortable:K53:45; lk yes:K53:69)

// get allow sort   -> returns boolean
$result:=LISTBOX Get property:C917(*; "LB11"; lk sortable:K53:45)
vResult:=Choose:C955($result; "No"; "Yes")

// set format 
LISTBOX SET PROPERTY:C1440(*; "LB12"; lk display type:K53:46; lk numeric format:K53:55)
LISTBOX SET PROPERTY:C1440(*; "LB12"; lk display type:K53:46; lk three states checkbox:K53:56)
// set format by column name
LISTBOX SET PROPERTY:C1440(*; "LB12_Col1"; lk display type:K53:46; lk numeric format:K53:55)

// get format   -> returns integer
$display:=LISTBOX Get property:C917(*; "LB12_Col1"; lk display type:K53:46)

Case of 
	: ($display=lk three states checkbox:K53:56)
		vResult:="three states"
	: ($display=lk numeric format:K53:55)
		vResult:="numeric format"
	Else 
		vResult:="???"
End case 

// set background color by 
$expression:="Random"
LISTBOX SET PROPERTY:C1440(*; "LB13"; lk background color expression:K53:47; $expression)
$expression:="SetColor(\"background\")"  // this is a method
LISTBOX SET PROPERTY:C1440(*; "LB13"; lk background color expression:K53:47; $expression)
$expression:="0xFFA080"
LISTBOX SET PROPERTY:C1440(*; "LB13"; lk background color expression:K53:47; $expression)

// get allow sort   -> returns text
vResult:=LISTBOX Get property:C917(*; "LB13"; lk background color expression:K53:47)


// set font color by 
$expression:="Random"
LISTBOX SET PROPERTY:C1440(*; "LB14"; lk font color expression:K53:48; $expression)
$expression:="SetColor(\"fontcolor\")"  // this is a method
LISTBOX SET PROPERTY:C1440(*; "LB14"; lk font color expression:K53:48; $expression)
$expression:="0xFFA0A0"
LISTBOX SET PROPERTY:C1440(*; "LB14"; lk font color expression:K53:48; $expression)

// set font color    -> returns text
vResult:=LISTBOX Get property:C917(*; "LB14"; lk font color expression:K53:48)


// set font sytle
$expression:="Random:C100%2"  //  plain (0) or bold (1)
LISTBOX SET PROPERTY:C1440(*; "LB15"; lk font style expression:K53:49; $expression)
$expression:="SetColor(\"fontstyle\")"  // this is a method
LISTBOX SET PROPERTY:C1440(*; "LB15"; lk font style expression:K53:49; $expression)
$expression:="Choose:C955([TEST]Value>0;0;4)"  // plain or Bold
LISTBOX SET PROPERTY:C1440(*; "LB15"; lk font style expression:K53:49; $expression)

// set font sytle    -> returns text
vResult:=LISTBOX Get property:C917(*; "LB15"; lk font style expression:K53:49)

// set column min and max width 
LISTBOX SET PROPERTY:C1440(*; "LB16"; lk column min width:K53:50; 50)
LISTBOX SET PROPERTY:C1440(*; "LB16"; lk column min width:K53:50; 100)
LISTBOX SET PROPERTY:C1440(*; "LB17"; lk column max width:K53:51; 200)

//By column
LISTBOX SET PROPERTY:C1440(*; "P16_Col1"; lk column min width:K53:50; 50)

// get column min width    -> returns integer
$result:=LISTBOX Get property:C917(*; "P16_Col1"; lk column min width:K53:50)
vResult:=String:C10($result)


// set multi sytle
LISTBOX SET PROPERTY:C1440(*; "LB23"; lk multi style:K53:71; lk no:K53:68)
LISTBOX SET PROPERTY:C1440(*; "LB23"; lk multi style:K53:71; lk yes:K53:69)

// by column
LISTBOX SET PROPERTY:C1440(*; "LB23_Col1"; lk multi style:K53:71; lk no:K53:68)

// get multi sytle  -> returns text
$result:=LISTBOX Get property:C917(*; "LB23_Col1"; lk multi style:K53:71)
vResult:=Choose:C955($result; "No"; "Yes")





// set a selection to a set 

LISTBOX SET PROPERTY:C1440(*; "LB18"; lk highlight set:K53:66; "$SetA")
LISTBOX SET PROPERTY:C1440(*; "LB18"; lk highlight set:K53:66; "$SetB")

// get a selection to a set   -> returns text
$CR:=Char:C90(Carriage return:K15:38)

$setName:=LISTBOX Get property:C917(*; "LB18"; lk highlight set:K53:66)
If ($setName#"")
	vResult:="highlight set: "+$setName
Else 
	vResult:="highlight set: none"
End if 
vResult:=vResult+$cr+$cr
vResult:=vResult+"$SetA: "+String:C10(Records in set:C195("$SetA"))+" records"+$cr
vResult:=vResult+"$SetB: "+String:C10(Records in set:C195("$SetB"))+" records"+$cr


// set a named selection changes the data displayed
LISTBOX SET PROPERTY:C1440(*; "LB19"; lk named selection:K53:67; "SelA")
LISTBOX SET PROPERTY:C1440(*; "LB19"; lk named selection:K53:67; "SelB")


// get a named selection to a set   -> returns text
C_TEXT:C284($selName)
$selName:=LISTBOX Get property:C917(*; "LB19"; lk named selection:K53:67)
If ($selName#"")
	vResult:="Selecion name: "+$selName
Else 
	vResult:="Selecion name: none"
End if 



// Listbox only

// set hide/show footer
LISTBOX SET PROPERTY:C1440(*; "LB20"; lk display footer:K53:20; lk no:K53:68)
LISTBOX SET PROPERTY:C1440(*; "LB20"; lk display footer:K53:20; lk yes:K53:69)

// get hide/show footer
$result:=LISTBOX Get property:C917(*; "LB21"; lk display footer:K53:20)
vResult:=Choose:C955($result; "No"; "Yes")



// set hide/show header
$result:=LISTBOX Get property:C917(*; "LB20"; lk display header:K53:4)
vResult:=Choose:C955($result; "No"; "Yes")

// get hide/show header  -> returns boolean
$result:=LISTBOX Get property:C917(*; "LB21"; lk display header:K53:4)
vResult:=Choose:C955($result; "No"; "Yes")


$result:=LISTBOX Get property:C917(*; "LB28"; lk hor scrollbar height:K53:7)
vResult:=String:C10($result)


// set movable rows
LISTBOX SET PROPERTY:C1440(*; "LB24"; lk movable rows:K53:76; lk yes:K53:69)
LISTBOX SET PROPERTY:C1440(*; "LB24"; lk movable rows:K53:76; lk no:K53:68)

// get movable rows  -> returns boolean
$result:=LISTBOX Get property:C917(*; "LB24"; lk movable rows:K53:76)
vResult:=Choose:C955($result; "No"; "Yes")
