//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/20/19, 23:02:28
// ----------------------------------------------------
// Method: Ray_ZeroElement
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_LONGINT:C283($i; $k; $k2)
C_POINTER:C301($1; $2; $3; $4; $5; $6; $7; $8; $9; $10; $11; $12; $13; $14; $15; $16; $17; $18; $19; $20; $21; $22; $23; $24; $25; $26; $27; $28; $29; $30; $31; $32; $33)
$k:=Count parameters:C259
For ($i; 1; $k)
	$k2:=Size of array:C274(${$i}->)
	If ($k2>0)
		DELETE FROM ARRAY:C228(${$i}->; 1; $k2)
	End if 
End for 
//Case of 
//  : (Type(${$i})=14)
//    ARRAY REAL(${$i};0)
//  : (Type(${$i})=15)
//    ARRAY LONGINT(${$i};0)
//  : (Type(${$i})=16)
//    ARRAY LONGINT(${$i};0)
//  : (Type(${$i})=17)
//    ARRAY DATE(${$i};0)
//  : (Type(${$i})=18)
//    ARRAY TEXT(${$i};0)
//  : (Type(${$i})=19)
//    ARRAY PICTURE(${$i};0)
//  : (Type(${$i})=20)
//    ARRAY POINTER(${$i};0)
//  : (Type(${$i})=21)
//    $k2:=Size of array(${$i})
//    If ($k2>0)
//      
//    End if 
//  : (Type(${$i})=22)
//    ARRAY BOOLEAN(${$i};0)
//End case //
//End for 