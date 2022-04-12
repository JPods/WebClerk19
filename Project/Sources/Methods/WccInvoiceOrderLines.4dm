//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: WccInvoiceOrderLines
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_LONGINT:C283($1; $viSocket)
C_POINTER:C301($2)
C_TEXT:C284($vText11)  // 
If (Count parameters:C259>1)
	$vText11:=$2->
	$viSocket:=$1
End if 
IvcLn_RaySize(0; 0; 0)
CREATE RECORD:C68([Invoice:26])
createInvoice
C_LONGINT:C283($i; $k)
$k:=Size of array:C274(aiLineAction)
TRACE:C157
For ($i; 1; $k)
	aiQtyShip{$i}:=0
	//  aiQtyRemain{$i}:=aOQtyBL{$i}
End for 

C_LONGINT:C283($p; $pEqual; $pEnd; $pCR; $pEndSeg; $orderNum; $lineRecNum; $w; $lineRecID)
C_REAL:C285($qtyShipped)
C_TEXT:C284($fromWarehouse)
$endLoop:=False:C215
$p:=Position:C15("LineRecordNum"; $vText11)  //do the lines  
ARRAY LONGINT:C221(aTmpLong1; 0)  //record number
ARRAY LONGINT:C221(aTmpLong2; 0)  //order number
ARRAY LONGINT:C221(aTmpLong3; 0)  //OrderLine UniqueID
ARRAY REAL:C219(aTmpReal1; 0)  //qty
ARRAY TEXT:C222(aTmp35Str1; 0)  //warehouse

If ($p>0)
	Repeat 
		vText7:=""
		$p:=Position:C15("LineRecordNum"; $vText11)  //do the lines  
		$vText11:=Substring:C12($vText11; $p+4)  //clip off thru the "&" string     
		$pNext:=Position:C15("LineRecordNum"; $vText11)  //do the lines
		If ($pNext=0)
			vText7:="Line"+$vText11
			$endLoop:=True:C214
			$vText11:=""
		Else 
			vText7:="Line"+Substring:C12($vText11; 1; $pNext-1)  //clip incoming to a single item record
		End if 
		//If ($p=0)
		//$runQty:=0
		//$runPrice:=0
		//$valueBonus:=0
		//End if 
		If (vText7#"")
			$baseQty:=0
			$lineRecNum:=Num:C11(PageParameterParse(vText7; "LineRecordNum"; ""))
			$lineRecID:=Num:C11(PageParameterParse(vText7; "LineRecordID"; ""))
			$orderNum:=Num:C11(PageParameterParse(vText7; "OrderNum"; ""))
			$qtyShipped:=Num:C11(PageParameterParse(vText7; "QtyShipped"; ""))
			$fromWarehouse:=PageParameterParse(vText7; "Warehouse"; "")
			INSERT IN ARRAY:C227(aTmpLong1; 1; 1)  //record number
			INSERT IN ARRAY:C227(aTmpLong2; 1; 1)  //order number
			INSERT IN ARRAY:C227(aTmpLong3; 1; 1)  //line record id
			INSERT IN ARRAY:C227(aTmpReal1; 1; 1)  //qty
			INSERT IN ARRAY:C227(aTmp35Str1; 1)  //warehouse
			aTmpLong1{1}:=$lineRecNum
			aTmpLong2{1}:=$orderNum
			aTmpLong3{1}:=$lineRecID
			aTmpReal1{1}:=$qtyShipped
			aTmp35Str1{1}:=$fromWarehouse
		End if 
	Until ($endLoop)
End if 
If (Size of array:C274(aTmpLong1)>0)
	$k:=Size of array:C274(aiLineNum)
	For ($i; 1; $k)
		$w:=Find in array:C230(aTmpLong3; aiLnOrdUnique{$i})
		If ($w>0)
			aiQtyShip{$i}:=aTmpReal1{$w}
			IvcLnExtend($i)
		End if 
	End for 
	vLineMod:=True:C214
	acceptInvoice(True:C214)
	If ([Invoice:26]orderNum:1>9)
		QUERY:C277([Payment:28]; [Payment:28]orderNum:2=[Invoice:26]orderNum:1)
	Else 
		QUERY:C277([Payment:28]; [Payment:28]invoiceNum:3=[Invoice:26]invoiceNum:2)
	End if 
	pTotal:=Sum:C1([Payment:28]amount:1)
	pPayAmount:=Sum:C1([Payment:28]amountAvailable:19)
	pBalance:=[Invoice:26]total:18-pPayAmount
End if 
ARRAY LONGINT:C221(aTmpLong1; 0)  //record number
ARRAY LONGINT:C221(aTmpLong2; 0)  //order number
ARRAY LONGINT:C221(aTmpLong3; 0)  //OrderLine UniqueID
ARRAY REAL:C219(aTmpReal1; 0)  //qty
ARRAY TEXT:C222(aTmp35Str1; 0)  //warehouse