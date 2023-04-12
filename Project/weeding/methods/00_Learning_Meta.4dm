//%attributes = {}

// Modified by: Bill James (2022-07-20T05:00:00Z)
// Method: 00_Learning_Meta
// Description 
// Parameters
// ----------------------------------------------------

// https://4dmethod.com/2020/06/25/june-30-meeting-modularizing-collection-and-entity-selection-list-boxes-kirk-brooks-guy-algot/
// meta style are ignored if you use any other style settings on the listbox
// background color
// style 
// font color




//  add a return expression ($0)
//  add basic error protection
//  "This" refers to the current entity oor collection member

C_OBJECT:C1216($0)

$MetaInfo_o:=New object:C1471
$MetaInfo_o.cell:=New object:C1471

$MetaInfo_o.cell.Balance_Col:=New object:C1471
Case of 
	: (This:C1470.PT_AccountHolder.Balance<0)
		$MetaInfo_o.cell.Balance_Col.stroke:="#000000"
	: (This:C1470.PT_AccountHolder.Balance=0)
		$MetaInfo_o.cell.Balance_Col.stroke:="#0000FF"
	Else 
		$MetaInfo_o.cell.Balance_Col.stroke:="#FF0000"
End case 

$MetaInfo_o.cell.AcctID_Col:=New object:C1471
Case of 
	: (This:C1470.AH_Id_Fk<0)
		$MetaInfo_o.cell.AcctID_Col.stroke:="#FF0000"
	: (This:C1470.AH_Id_Fk=0)
		$MetaInfo_o.cell.AcctID_Col.stroke:="#0000FF"
	Else 
		$MetaInfo_o.cell.AcctID_Col.stroke:="#000000"
End case 

$0:=$MetaInfo_o