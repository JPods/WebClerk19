//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2021-12-08T06:00:00Z)
// Method: QuoteQuick
// Description 
// Parameters
// ----------------------------------------------------

var $new_o : Object
var $vPricePoint; $tableName; $id : Text
//Procedure: QuoteQuick 
C_LONGINT:C283($found)

$found:=Prs_CheckRunnin("QuickQuote")
Case of 
	: (Count parameters:C259=1)
		<>prcControl:=0
		Process_InitLocal
		ptCurTable:=(->[Item:4])
		
		vUseBase:=2
		//$floatWindow:=False
		//$tempBase:=vUseBase
		//$tempSale:=<>aTypeSale{1}
		//DELETE ELEMENT(<>aTypeSale;1;1)
		bItemShow:=0
		vPartNum:=""
		srItem:=""
		srItemMfgItemNum:=""
		srItemDscrp:=""
		srItemType:=""
		srItemsProfile1:=""
		srItemsProfile2:=""
		srItemsProfile3:=""
		srItemsProfile4:=""
		srItemsProfile5:=""
		READ ONLY:C145([Item:4])
		READ ONLY:C145([ItemSpec:31])
		
		If (Screen height:C188>700)
			$form_t:="QuickQuoteLong"
		Else 
			$form_t:="QuickQuote"
		End if 
		
		var process_o : Object
		var $form_t : Text
		process_o:=$1
		
		// MODIFY RECORD([Control])
		// HOWTO: Dialog 
		// var $obWindows: object
		// $obWindows:=WindowCountToShow  // example
		//$win_l:=Open form window([Control]; $form_t; Plain form window; $obWindows.leftOffset; 53+$obWindows.topOffset;*)
		$win_l:=Open form window:C675($form_t; Plain form window:K39:10; Screen width:C187-690; 53+20)
		
		
		process_o.window:=$win_l
		DIALOG:C40([Admin:1]; $form_t)
		
		ARRAY LONGINT:C221(<>aLsSrRec; 0)
		ARRAY LONGINT:C221(<>aItemLines; 0)
		
		bItemShow:=0
		vPartNum:=""
		srItem:=""
		srItemMfgItemNum:=""
		srItemDscrp:=""
		srItemType:=""
		srItemsProfile1:=""
		srItemsProfile2:=""
		srItemsProfile3:=""
		srItemsProfile4:=""
		srItemsProfile5:=""
		READ WRITE:C146([Item:4])
		READ WRITE:C146([ItemSpec:31])
		
	: ($found>0)
		If (<>vItemNum#"")
			POST OUTSIDE CALL:C329(<>aPrsNum{$found})
		End if 
		BRING TO FRONT:C326($found)
	Else   // : (Count parameters=0)
		If (ptCurTable#Null:C1517)
			$tableName:=Table name:C256(ptCurTable)
		End if 
		var vHere : Integer
		If (vhere>1)
			Case of 
				: (ptCurTable=(->[Customer:2]))
					$vPricePoint:=[Customer:2]typeSale:18
				: (ptCurTable=(->[Order:3]))
					$vPricePoint:=[Order:3]typeSale:22
				: (ptCurTable=(->[Invoice:26]))
					$vPricePoint:=[Invoice:26]typeSale:49
				: (ptCurTable=(->[Proposal:42]))
					$vPricePoint:=[Proposal:42]typeSale:20
				Else 
					$vPricePoint:=Storage:C1525.default.typeSale
			End case 
			var $ptID : Pointer
			$id:=STR_Get_idPointer($tableName)->
			
		Else 
			$vPricePoint:=Storage:C1525.default.typeSale
		End if 
		var $process_i : Integer
		$new_o:=New object:C1471("ents"; New object:C1471; \
			"pricePoint"; $vPricePoint; \
			"tableName"; "Item"; \
			"windowParent"; Current form window:C827; \
			"tableParent"; $tableName; \
			"idParent"; $id)
		$process_i:=New process:C317("QuoteQuick"; 0; "QuickQuote"; $new_o)
		
End case 