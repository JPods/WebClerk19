//%attributes = {"publishedWeb":true}
//Procedure: List_XRefLink
C_LONGINT:C283($1)
C_POINTER:C301($2)
QUERY:C277([ItemXRef:22]; [ItemXRef:22]itemNumMaster:1=$2->; *)
QUERY:C277([ItemXRef:22];  & [ItemXRef:22]xRefLinked:17>0)
List_RaySize(0)
C_LONGINT:C283($i; $k; $w)
$k:=Records in selection:C76([ItemXRef:22])

SELECTION TO ARRAY:C260([ItemXRef:22]itemNumXRef:2; aLsItemNum; [ItemXRef:22]descriptionXRef:3; aLsItemDesc; [ItemXRef:22]quantity:12; aLsQtyOH; [ItemXRef:22]leadTime:6; aLsLeadTime)

UNLOAD RECORD:C212([ItemXRef:22])
$k:=Size of array:C274(aLsItemNum)
ARRAY REAL:C219(aLsQtySO; $k)
ARRAY REAL:C219(aLsQtyPO; $k)
ARRAY DATE:C224(aLsDate; $k)
ARRAY REAL:C219(aLsPrice; $k)
ARRAY REAL:C219(aLsCost; $k)
ARRAY REAL:C219(aLsMargin; $k)
ARRAY TEXT:C222(aLsText1; $k)
ARRAY TEXT:C222(aLsText2; $k)
ARRAY LONGINT:C221(aLsSrRec; $k)  //Record number([Item])
ARRAY TEXT:C222(aLsDocType; $k)
ARRAY REAL:C219(aLsDiscount; $k)  //Discount
ARRAY REAL:C219(aLsDiscountPrice; $k)  //Discounted Price
//ARRAY LONGINT(aLsLeadTime;$k)
//TRACE
For ($i; 1; $k)
	//aLsText1{$i}:=String(aLsSrRec{$i};"0000-0000")
	aLsSrRec{$i}:=-1  //Record number([Item])
	aLsDocType{$i}:="lk"
End for   //use "h" to trigger a search
// -- AL_SetHeaders($1; 1; 8; "T"; "Item Number"; "Description"; "Qty"; ""; ""; "Days"; "")
// -- AL_SetHeaders($1; 9; 8; ""; ""; ""; ""; ""; ""; ""; "")
// -- AL_SetWidths($1; 1; 8; 10; 70; 120; 48; 3; 3; <>wAlDate; 3)
// -- AL_SetWidths($1; 9; 8; 3; 3; 3; 3; 3; 58; 200; 30)
//// -- AL_SetSort ($1;2)//sorted before it is filled
// -- AL_SetColOpts($1; 1; 0; 1; 0; 0)  //$columnCnt;0)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
//  --  CHOPPED  AL_UpdateArrays($1; -2)