//%attributes = {}
$SW:=Screen width:C187\2
$SH:=(Screen height:C188\2)
$WW:=$1\2
$WH:=$2\2
Case of 
	: (Count parameters:C259=2)
		Open window:C153($SW-$WW; $SH-$WH; $SW+$WW; $SH+$WH)
	: (Count parameters:C259=3)
		Open window:C153($SW-$WW; $SH-$WH; $SW+$WW; $SH+$WH; $3)
	: (Count parameters:C259=5)
		Open window:C153($SW-$WW; $SH-$WH; $SW+$WW; $SH+$WH; $3; $4; $5)
End case 