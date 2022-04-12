//%attributes = {"publishedWeb":true}
//Procedure: EDI_InTestFiles
QUERY:C277([EDISetID:76]; [EDISetID:76]InputOutput:2=True:C214; *)  //input types
QUERY:C277([EDISetID:76]; [EDISetID:76]Active:13=True:C214)  // ### jwm ### 20180108_1601 Active 

C_LONGINT:C283($index; $index2)
For ($index; 1; Records in selection:C76([EDISetID:76]))
	ARRAY TEXT:C222(aText1; 0)
	C_LONGINT:C283($result)
	$result:=HFS_CatToArray2([EDISetID:76]SrcDestFolder:8; ->aText1)
	ARRAY TEXT:C222($aText1; 0)
	COPY ARRAY:C226(aText1; $aText1)
	ARRAY TEXT:C222(aText1; 0)  //just in cast aText1 is used elsewhere
	If ($result=0)
		For ($index2; 1; Size of array:C274($aText1))
			C_TEXT:C284(tEDIInPath)  //must use unique Global here
			tEDIInPath:=[EDISetID:76]SrcDestFolder:8+$aText1{$index2}
			$result:=TIOI_ReadFile(->[EDISetID:76]TextIOFileName:6; ->tEDIInPath)
			If ($result=<>ciTIOINoErr)
				$result:=TIOI_ReadFile(->[EDISetID:76]TextIOContent:7; ->tEDIInPath)
				U_SafeHFSMove(tEDIInPath; [EDISetID:76]CompletedFolder:9)
			End if 
		End for 
	End if   //$result=0
	NEXT RECORD:C51([EDISetID:76])
End for 