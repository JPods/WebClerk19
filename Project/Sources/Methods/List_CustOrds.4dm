//%attributes = {"publishedWeb":true}
//Procedure: List_CustOrds
C_LONGINT:C283($1)
C_TEXT:C284($2)
// -- AL_SetHeaders($1; 1; 8; "T"; "Item Number"; "Description"; "Qty"; "Unit Cost"; "Disc"; "Days"; "")
// -- AL_SetHeaders($1; 9; 8; ""; ""; ""; ""; "Date"; "Doc"; "Customer"; "")



If (False:C215)  //(Size of array(<>aiCOPiWide2)=14)
	// -- AL_SetWidths($1; 1; 8; <>aiCOPiWide2{1}; <>aiCOPiWide2{2}; <>aiCOPiWide2{3}; <>aiCOPiWide2{4}; <>aiCOPiWide2{5}; <>aiCOPiWide2{6}; <>aiCOPiWide2{7})
	// -- AL_SetWidths($1; 9; 8; <>aiCOPiWide2{8}; <>aiCOPiWide2{9}; <>aiCOPiWide2{10}; <>aiCOPiWide2{11}; <>aiCOPiWide2{12}; <>aiCOPiWide2{13}; <>aiCOPiWide2{14})
	// -- AL_SetSort($1; <>aiCOPiSort2{1}; <>aiCOPiSort2{2}; <>aiCOPiSort2{3}; <>aiCOPiSort2{4}; <>aiCOPiSort2{5}; <>aiCOPiSort2{6}; <>aiCOPiSort2{7}; <>aiCOPiSort2{8})
	// -- AL_SetColLock($1; <>vlCOPiLock2)  //Lock after Alt Item Num
Else 
	// -- AL_SetWidths($1; 1; 8; 10; 50; 54; 48; 48; 20; <>wAlDate; 3)
	// -- AL_SetWidths($1; 9; 8; 51; 71; 3; 3; <>wAlDate; 58; 200; 30)
End if 

$doCustomer:=False:C215
$doPop:=False:C215
Case of 
	: ((vhere>2) & (Record number:C243([Order:3])#-1))
		PUSH RECORD:C176([Order:3])
		$doPop:=True:C214
	: ($2="")
		QUERY:C277([OrderLine:49]; [OrderLine:49]customerID:2=[Customer:2]customerID:1)
	: ((CmdKey=1) & ($2#""))
		QUERY:C277([OrderLine:49]; [OrderLine:49]customerID:2=[Customer:2]customerID:1; *)
		QUERY:C277([OrderLine:49];  & [OrderLine:49]itemNum:4=$2)
	Else 
		QUERY:C277([OrderLine:49];  & [OrderLine:49]itemNum:4=$2)
		If (ptCurTable=(->[Order:3]))
			PUSH RECORD:C176([Order:3])
		End if 
		$doCustomer:=True:C214
End case 
List_RaySize(0)
C_LONGINT:C283($i; $k; $w)

$k:=Records in selection:C76([OrderLine:49])

SELECTION TO ARRAY:C260([OrderLine:49]idNumOrder:1; aLsSrRec; [OrderLine:49]itemNum:4; aLsItemNum; [OrderLine:49]description:5; aLsItemDesc; [OrderLine:49]qty:6; aLsQtyOH; [OrderLine:49]unitPrice:9; aLsQtySO; [OrderLine:49]discount:10; aLsQtyPO; [OrderLine:49]dateRequired:23; aLsDate)


$k:=Size of array:C274(aLsItemNum)
ARRAY REAL:C219(aLsPrice; $k)
ARRAY REAL:C219(aLsCost; $k)
ARRAY REAL:C219(aLsMargin; $k)
ARRAY TEXT:C222(aLsText1; $k)
ARRAY TEXT:C222(aLsText2; $k)
//ARRAY LONGINT(aLsSrRec;$k)//Record number([Item])
ARRAY TEXT:C222(aLsDocType; $k)
ARRAY LONGINT:C221(aLsLeadTime; $k)
ARRAY REAL:C219(aLsDiscount; $k)  //Discount
ARRAY REAL:C219(aLsDiscountPrice; $k)  //Discounted Price

For ($i; 1; $k)
	If ($doCustomer)
		If (aLsSrRec{$i}#[Order:3]idNum:2)
			QUERY:C277([Order:3]; [Order:3]idNum:2=aLsSrRec{$i})
		End if 
		aLsText2{$i}:=[Order:3]billToCompany:76
	End if 
	If (aLsDate{$i}=!00-00-00!)
		aLsDate{$i}:=!1901-01-01!
	End if 
	aLsText1{$i}:=String:C10(aLsSrRec{$i})
	aLsSrRec{$i}:=-1  //Record number([Item])
	aLsDocType{$i}:="ol"
	aLsLeadTime{$i}:=Current date:C33-aLsDate{$i}
	aLsDiscount{$i}:=0
	aLsDiscountPrice{$i}:=0
End for   //use "h" to trigger a search
Case of 
	: (((ptCurTable=(->[Order:3])) & ($doCustomer)) | ($doPop))
		POP RECORD:C177([Order:3])
	: ((ptCurTable#(->[Order:3])) | (vHere<2))
		UNLOAD RECORD:C212([Order:3])
End case 

If ($k>1)
	Case of 
		: (aLoCustOPi=4)  //{4}:="Pp_Lines"
			// -- AL_SetSort($1; -14)
		: (aLoCustOPi=6)  //{6}:="ordLines"
			// -- AL_SetSort($1; -14)
		: (aLoCustOPi=8)  //{8}:="Inv_Lines"
			// -- AL_SetSort($1; -14)
		Else 
			// -- AL_SetSort($1; -5)
	End case 
End if 
// -- AL_SetColOpts($1; 1; 0; 1; 0; 0)  //$columnCnt;0)
//C_LONGINT($i;$k)
//$k:=Size of array(aLsSrRec)
//For ($i;1;$k)
//If (aLsDocType{$i}="o@")
//// -- AL_SetRowColor ($1;$i;"Black";0;"Yellow";0)
//End if 
//End for 
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
// -- AL_SetRowColor($1; 0; "Black"; 0; "white"; 0)
//  --  CHOPPED  AL_UpdateArrays($1; -2)