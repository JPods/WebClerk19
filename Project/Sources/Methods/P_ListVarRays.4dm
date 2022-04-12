//%attributes = {"publishedWeb":true}
C_POINTER:C301($1; $2; $3; $4; $5; $6; $7; $8; $9; $10; $11; $12; $13; $14; $15; $16; $17; $18; $19; $20; $21; $22; $23; $24; $25; $26; $27; $28; $29; $30; $31; $32; $33; $34; $35; $36; $37; $38; $39; $40; $41; $42; $43; $44; $45; $46; $47; $48; $49; $50; $51; $52; $53; $54; $55; $56; $57; $58; $59)
C_LONGINT:C283($w; $i; $k)
$k:=Count parameters:C259
ARRAY TEXT:C222(SRVarNames; $k)
ARRAY LONGINT:C221(SRVarTypes; $k)
For ($i; 1; $k)
	$theType:=Type:C295(${$i}->)
	If ($theType=24)
		$theType:=0
	End if 
	SRVarTypes{$i}:=$theType
	SRVarNames{$i}:=${$i}->
End for 
$w:=$k+1
INSERT IN ARRAY:C227(SRVarNames; $w; 10)
INSERT IN ARRAY:C227(SRVarTypes; $w; 10)
$k:=$k+10
$i:=1
Repeat 
	SRVarTypes{$w}:=1
	SRVarNames{$w}:="vR"+String:C10($i)
	$i:=$i+1
	$w:=$w+1
Until ($w>$k)
INSERT IN ARRAY:C227(SRVarNames; $w; 10)
INSERT IN ARRAY:C227(SRVarTypes; $w; 10)
$k:=$k+10
$i:=1
Repeat 
	SRVarTypes{$w}:=1
	SRVarNames{$w}:="vText"+String:C10($i)
	$i:=$i+1
	$w:=$w+1
Until ($w>$k)
$w:=$k
INSERT IN ARRAY:C227(SRVarNames; $w; 12)
INSERT IN ARRAY:C227(SRVarTypes; $w; 12)
SRVarTypes{$w+1}:=0
SRVarNames{$w+1}:="<>tc_Company"
SRVarTypes{$w+2}:=0
SRVarNames{$w+2}:="<>tc_Address1"
SRVarTypes{$w+3}:=0
SRVarNames{$w+3}:="<>tc_Address2"
SRVarTypes{$w+4}:=0
SRVarNames{$w+4}:="<>tc_City"
SRVarTypes{$w+5}:=0
SRVarNames{$w+5}:="<>tc_State"
SRVarTypes{$w+6}:=0
SRVarNames{$w+6}:="<>tc_FOB"
SRVarTypes{$w+7}:=0
SRVarNames{$w+7}:="<>tc_Zip"
SRVarTypes{$w+8}:=0
SRVarNames{$w+8}:="<>tc_Country"
SRVarTypes{$w+9}:=0
SRVarNames{$w+9}:="<>tc_Phone"
SRVarTypes{$w+10}:=0
SRVarNames{$w+10}:="<>tc_FAX"
SRVarTypes{$w+11}:=2
SRVarNames{$w+11}:="<>tc_FullCo"
SRVarTypes{$w+12}:=9
SRVarNames{$w+12}:="curLines"