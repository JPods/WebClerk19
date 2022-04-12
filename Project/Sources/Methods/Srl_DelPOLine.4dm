//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $index)  //index into PO line arrays
$index:=Find in array:C230(aSPOPOLnNum; aPOLineNum{$1})
Case of 
	: (aPOSerialRc{$1}>0)  //existing serial number record, not alerted
		//    aPOSerialed is the on going status of this line's serial number
		//    aPOSerialRc is at startup
		$index:=Size of array:C274(aSPOFPPONum)+1
		Ray_InsertElems($index; 1; ->aSPOItmAlph; ->aSPOItmDesc; ->aSPOSerialN; ->aSPOModelN; ->aSPOPOLnNum; ->aSPOOnFP; ->aSPOFPlanID; ->aSPOFPLnNum; ->aSPOFPExpir; ->aSPOFPPONum; ->aSPOFPVndID)
		aSPOFPPONum{$index}:=-aPOSerialRc{$1}
		aSPOPOLnNum{$index}:=-aPOLineNum{$1}
		aPOSerialRc{$1}:=<>ciSRUnknown
		aPOSerialNm{$1}:=""
	: ($index>0)  //changed only in the current unsaved array of serial numbers
		Ray_DeleteElems($index; 1; ->aSPOItmAlph; ->aSPOItmDesc; ->aSPOSerialN; ->aSPOModelN; ->aSPOPOLnNum; ->aSPOOnFP; ->aSPOFPlanID; ->aSPOFPLnNum; ->aSPOFPExpir; ->aSPOFPPONum; ->aSPOFPVndID)
		aPOSerialNm{$1}:=""
End case 