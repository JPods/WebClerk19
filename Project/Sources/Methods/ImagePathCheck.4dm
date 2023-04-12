//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: ImagePathCheck
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 

// ### bj ### 20191207_0030
C_TEXT:C284($resultImage; $resultTN; $vtReport)
TRACE:C157

C_OBJECT:C1216($obSel; $obRec)
ARRAY TEXT:C222($prop; 0)
OB GET PROPERTY NAMES:C1232(ds:C1482.Item; $prop)
If (Records in selection:C76([Item:4])=0)
	$obSel:=ds:C1482.Item.query("typeID = Sega")
Else 
	$obSel:=Create entity selection:C1512([Item:4])
End if 
For each ($obRec; $obSel)
	If ($obRec.imagePath="")
		$obRec.indicator4:=404
	Else 
		If (Test path name:C476($obRec.imagePath)=1)
			$obRec.indicator4:=200
		Else 
			$obRec.indicator4:=405
			$obRec.obGeneral.imagePath:=$obRec.imagePath
			$obRec.imagePath:=""
		End if 
	End if 
	If ($obRec.imagePathTn="")
		$obRec.indicator5:=404
	Else 
		If (Test path name:C476($obRec.imagePathTn)=1)
			$obRec.indicator5:=200
		Else 
			$obRec.indicator5:=405
			$obRec.obGeneral.imagePathTn:=$obRec.imagePathTn
			$obRec.imagePathTn:=""
		End if 
	End if 
	$result_o:=$obRec.save()
	$vtReport:=$vtReport+$obRec.itemNum+"\t"+$obRec.imagePath+"\t"+String:C10($obRec.indicator4)
	$vtReport:=$vtReport+"\t"+$obRec.imagePathTn+"\t"+String:C10($resultTN)+"\r"
	ConsoleLog($obRec.itemNum+": Image: "+String:C10($resultImage)+": TN: "+String:C10($obRec.indicator5))
End for each 
SET TEXT TO PASTEBOARD:C523($vtReport)
TEXT TO DOCUMENT:C1237(Storage:C1525.folder.jitExports+"ItemImagePath"+DateTime_RFCString+".txt"; $vtReport)

