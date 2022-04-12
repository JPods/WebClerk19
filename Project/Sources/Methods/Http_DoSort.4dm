//%attributes = {"publishedWeb":true}
//If (False)
//  //Method: Http_DoSort(SortStr)
//  //Date: 07/01/02
//  //Who: Bill
//  //Description: List of structure
//  End if 
C_LONGINT:C283($p; $file; $0)
C_TEXT:C284($1; $myText)
C_TEXT:C284(vURLSortScript)
//  $p:=Position("_jitSort_"; $1)
//  $0:=0
//  If ($p>0)
//  If (Substring($1; Length($1)-2)#"jj")  //being submitted from a Begin Statement
//  $1:=$1+"jj"
//  End if 
//  $myText:=Substring($1; $p+9; 20)
//  $p:=Position(<>midTag; $myText)
//  $file:=Num(Substring($myText; 1; $p-1))
//  $myText:=Substring($myText; $p+1)
//  $p:=Position(<>endTag; $myText)
//  $myText:=Substring($myText; 1; $p-1)
//  $field1:=0
//  $field2:=0
//  $field3:=0
//  C_LONGINT($field1; $field2; $field3; $i)
//  C_LONGINT($absfield1; $absfield2; $absfield3)
//  $i:=0
//  Repeat 
//  $i:=$i+1
//  $p:=Position(<>midTag; $myText)
//  Case of 
//  : ($i=1)
//  If ($p=0)
//  $p:=3
//  End if 
//  $field1:=Num(Substring($myText; 1; $p-1))
//  $absfield1:=Abs($field1)
//  : ($i=2)
//  If ($p=0)
//  $p:=3
//  End if 
//  $field2:=Num(Substring($myText; 1; $p-1))
//  $absfield2:=Abs($field2)
//  : ($i=3)
//  If ($p=0)
//  $p:=3
//  End if 
//  $field3:=Num(Substring($myText; 1; $p-1))
//  $absfield3:=Abs($field3)
//  End case 
//  $myText:=Substring($myText; $p+1)
//  Until (($p=0) | ($i=3))
//  $i:=Get last field number($file)
//  C_TEXT($sort1; $sort2; $sort3)
//  $sort1:=("<"*Num($field1<0))+(">"*Num($field1>0))
//  $sort2:=("<"*Num($field2<0))+(">"*Num($field2>0))
//  $sort3:=("<"*Num($field3<0))+(">"*Num($field3>0))
//  $sortFile:="["+Table name($file)+"]"
//  Case of 
//  : (($absfield1>0) & ($absfield1<=$i) & ($absfield2>0) & ($absfield2<=$i) & ($absfield3>0) & ($absfield3<=$i))
//  //ORDER BY(Table($file)->;Field($file;$absfield1)->;$sort1;Field($file
//  //;$absfield2)->;$sort2;Field($file;$absfield3)->;$sort3)
//  vURLSortScript:="Order By("+$sortFile+";"+$sortFile+Field name(Field($file; $absfield1))+";"+$sort1+";"+$sortFile+Field name(Field($file; $absfield2))+";"+$sort2+";"+$sortFile+Field name(Field($file; $absfield3))+";"+$sort3+")"
//  : (($absfield1>0) & ($absfield1<=$i) & ($absfield2>0) & ($absfield2<=$i))
//  //ORDER BY(Table($file)->;Field($file;$absfield1)->;$sort1;Field($file
//  //;$absfield2)->;$sort2)
//  vURLSortScript:="Order By("+$sortFile+";"+$sortFile+Field name(Field($file; $absfield1))+";"+$sort1+";"+$sortFile+Field name(Field($file; $absfield2))+";"+$sort2+")"
//  : (($absfield1>0) & ($absfield1<=$i))
//  //ORDER BY(Table($file)->;Field($file;$absfield1)->;$sort1)
//  vURLSortScript:="Order By("+$sortFile+";"+$sortFile+Field name(Field($file; $absfield1))+";"+$sort1+")"
//  End case 
//  ExecuteText(0; vURLSortScript)
//  $myText:=""
//  $0:=$absfield1
//  [EventLog]wccEmail:=vURLSortScript
//  If ([EventLog]idNum#0)
//  SAVE RECORD([EventLog])
//  End if 
//  End if 
//  
//  