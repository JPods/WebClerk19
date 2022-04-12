//%attributes = {"publishedWeb":true}
ALERT:C41("This procedure has been superseded.")
// 
//   //Procedure: Ship_FillArray
// C_LONGINT($1;$2;$3;$incRay;$sizeRay;$diff;$p;$w;$k;$i)
// Case of 
// : ($1=0)
// ARRAY LONGINT(aLongInt1;$1)
// array TEXT(a20Str1;$1)
// array TEXT(a20Str2;$1)
// array TEXT(a20Str3;$1)
// array TEXT(a20Str4;$1)
// ARRAY REAL(aReal1;$1)
// ARRAY REAL(aReal2;$1)
// ARRAY REAL(aReal3;$1)
// array TEXT(atrackID;$1)
// ARRAY LONGINT(aTrackTagID;$1)
// ARRAY TEXT(aTagContents;$1)
//   //
// ARRAY LONGINT(aShipSel;0)
// : ($1>0)
// ARRAY LONGINT(aLongInt1;$1)
// array TEXT(a20Str1;$1)
// array TEXT(a20Str2;$1)
// array TEXT(a20Str3;$1)
// array TEXT(a20Str4;$1)
// ARRAY REAL(aReal1;$1)
// ARRAY REAL(aReal2;$1)
// ARRAY REAL(aReal3;$1)
// array TEXT(atrackID;$1)
// ARRAY LONGINT(aTrackTagID;$1)
// ARRAY TEXT(aTagContents;$1)
// FIRST SUBRECORD([Invoice]MultipleFreight)
// For ($i;1;$1)
// aLongInt1{$i}:=[Invoice]MultipleFreight'Weight
// aReal1{$i}:=[Invoice]MultipleFreight'Charges
// a20Str1{$i}:=Num([Invoice]MultipleFreight'GroundTrack)*"x"
// a20Str2{$i}:=Num([Invoice]MultipleFreight'OverSized)*"x"
// a20Str3{$i}:=Num([Invoice]MultipleFreight'Insurance)*"x"
// a20Str4{$i}:=Num([Invoice]MultipleFreight'CallTag)*"x"
// aReal3{$i}:=[Invoice]MultipleFreight'Value
// aReal2{$i}:=[Invoice]MultipleFreight'OtherCharges
// atrackID{$i}:=[Invoice]MultipleFreight'TrackingID
// aTrackTagID{$i}:=[Invoice]MultipleFreight'UniqueID
// aTagContents{$i}:=[Invoice]MultipleFreight'Contents
// NEXT SUBRECORD([Invoice]MultipleFreight)
// End for 
// ARRAY LONGINT(aShipSel;1)
// aShipSel{1}:=1
// : ($1=-1)  //delete an element
// DELETE FROM ARRAY(aLongInt1;$2;$3)
// DELETE FROM ARRAY(a20Str1;$2;$3)
// DELETE FROM ARRAY(a20Str2;$2;$3)
// DELETE FROM ARRAY(a20Str3;$2;$3)
// DELETE FROM ARRAY(a20Str4;$2;$3)
// DELETE FROM ARRAY(aReal1;$2;$3)
// DELETE FROM ARRAY(aReal2;$2;$3)
// DELETE FROM ARRAY(aReal3;$2;$3)
// DELETE FROM ARRAY(atrackID;$2;$3)
// DELETE FROM ARRAY(aTrackTagID;$2;$3)
// DELETE FROM ARRAY(aTagContents;$2;$3)
// doSearch:=1
// If ($w>Size of array(aReal3))
// ARRAY LONGINT(aShipSel;1)
// aShipSel{1}:=$2
// End if 
// $doEnter:=(aReal3>0)
// OBJECT SET ENTERABLE(vi1;$doEnter)
// OBJECT SET ENTERABLE(vR1;$doEnter)
// OBJECT SET ENTERABLE(vR2;$doEnter)
// OBJECT SET ENTERABLE(vR3;$doEnter)
// : ($1=-3)  //insert an element    
// INSERT IN ARRAY(aLongInt1;$2;$3)
// INSERT IN ARRAY(a20Str1;$2;$3)
// INSERT IN ARRAY(a20Str2;$2;$3)
// INSERT IN ARRAY(a20Str3;$2;$3)
// INSERT IN ARRAY(a20Str4;$2;$3)
// INSERT IN ARRAY(aReal1;$2;$3)
// INSERT IN ARRAY(aReal2;$2;$3)
// INSERT IN ARRAY(aReal3;$2;$3)
// INSERT IN ARRAY(atrackID;$2;$3)
// INSERT IN ARRAY(aTrackTagID;$2;$3)
// INSERT IN ARRAY(aTagContents;$2;$3)
//   // $doEnter:=(aReal3>0)
//   //SET ENTERABLE(vi1;$doEnter)
//   //SET ENTERABLE(vR1;$doEnter)
//   //SET ENTERABLE(vR2;$doEnter)
//   //SET ENTERABLE(vi2;$doEnter)
//   //SET ENTERABLE(v1;$doEnter)
// ARRAY LONGINT(aShipSel;$2)
// aShipSel{1}:=$2
//   //vi1:=0
//   //vR3:=0
//   //vR1:=0
//   //vR2:=0
//   //b1:=0
//   //b2:=0
//   //b3:=0
//   //b4:=0
// 
// : ($1=-4)  //Fill a record
// 
// : ($1=-5)  //array to selection
// $k:=Records in sub_selection([Invoice]MultipleFreight)
// $p:=Size of array(atrackID)
// For ($i;$p;1;-1)
// If (aLongInt1{$i}=0)
// DELETE FROM ARRAY(aLongInt1;$i)
// DELETE FROM ARRAY(a20Str1;$i)
// DELETE FROM ARRAY(a20Str2;$i)
// DELETE FROM ARRAY(a20Str3;$i)
// DELETE FROM ARRAY(a20Str4;$i)
// DELETE FROM ARRAY(aReal1;$i)
// DELETE FROM ARRAY(aReal2;$i)
// DELETE FROM ARRAY(aReal3;$i)
// DELETE FROM ARRAY(atrackID;$i)
// DELETE FROM ARRAY(aTrackTagID;$i)
// DELETE FROM ARRAY(aTagContents;$i)
// End if 
// End for 
// $p:=Size of array(atrackID)
// $w:=$k-$p
// Case of 
// : ($k=$p)
// : ($k>$p)
// For ($i;1;$w)
// ALL SUBRECORDS([Invoice]MultipleFreight)
// LAST SUBRECORD([Invoice]MultipleFreight)
// DELETE SUBRECORD([Invoice]MultipleFreight)
// End for 
// Else   //($k>$p)
// $w:=Abs($w)
// For ($i;1;$w)
// CREATE SUBRECORD([Invoice]MultipleFreight)
// End for 
// End case 
// ALL SUBRECORDS([Invoice]MultipleFreight)
// FIRST SUBRECORD([Invoice]MultipleFreight)
// For ($i;1;$p)
// [Invoice]MultipleFreight'Weight:=aLongInt1{$i}
// [Invoice]MultipleFreight'Charges:=aReal1{$i}
// [Invoice]MultipleFreight'GroundTrack:=(a20Str1{$i}#"")
// [Invoice]MultipleFreight'OverSized:=(a20Str2{$i}#"")
// [Invoice]MultipleFreight'Insurance:=(a20Str3{$i}#"")
// [Invoice]MultipleFreight'CallTag:=(a20Str4{$i}#"")
// [Invoice]MultipleFreight'Value:=aReal3{$i}
// [Invoice]MultipleFreight'OtherCharges:=aReal2{$i}
// If (atrackID{$i}#"")
// [Invoice]MultipleFreight'TrackingID:=atrackID{$i}
// End if 
// NEXT SUBRECORD([Invoice]MultipleFreight)
// End for 
//   //
// : ($1=-6)  //Update an array
// 
// 
// : ($1=-7)
// 
// End case 