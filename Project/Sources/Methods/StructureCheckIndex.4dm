//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/19/09, 12:14:11
// ----------------------------------------------------
// Method: StructureCheckIndex
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TIME:C306(myDoc)
C_TEXT:C284($readLine)
If (Application type:C494#4D Server:K5:6)
	myDoc:=Open document:C264(Storage:C1525.folder.jitF+"jitIndex.txt"; Read mode:K24:5)
	If (OK=1)
		//5 and 10 are missing in from the Field Type number code
		$TList:="ARTPD B*IL H1234567890qweyuosXfghjkzcvnm"
		C_LONGINT:C283($incTable; $incField; $viType; $length; $myCount; $theCount; $tableNum; $fieldNum)
		C_TEXT:C284($type; $Index)
		C_BOOLEAN:C305($bIndexed; $doDoc)
		C_TEXT:C284($TList)
		C_TEXT:C284($tResult; $theCommand)
		$myCount:=20
		$theCount:=0
		$theCommands:=""
		Repeat 
			RECEIVE PACKET:C104(myDoc; $readLine; "\r")
			If (OK=1)
				TextToArray($readLine; ->aText1; "\t"; True:C214)
				If (Size of array:C274(aText1)>5)  //it is a field
					$tableNum:=Num:C11(aText1{1})
					If (($tableNum>0) & ($tableNum<=Get last table number:C254))
						$fieldNum:=Num:C11(aText1{2})
						If (($fieldNum>0) & ($fieldNum<=Get last field number:C255($tableNum)))
							GET FIELD PROPERTIES:C258(Field:C253($tableNum; $fieldNum); $viType; $length; $bIndexed)  // get the field attributes
							$bHistoricalIndexed:=False:C215
							If (Size of array:C274(aText1)>6)
								$bHistoricalIndexed:=(aText1{7}="indexed")
							End if 
							Case of 
								: (($bIndexed) & ($bHistoricalIndexed))
									If ($theCount<$myCount)
										$tResult:=$tResult+"matched indexed"+"\t"+$readLine+"\r"
									End if 
								: (($bIndexed=False:C215) & ($bHistoricalIndexed))
									$tResult:=$tResult+"data indexed"+"\t"+$readLine+"\r"
									$theTableField:="["+Table name:C256($tableNum)+"]"+Field name:C257($tableNum; $fieldNum)
									$theCommand:=$theCommand+"SET INDEX("+$theTableField+";true)"+"\r"
								: (($bIndexed) & ($bHistoricalIndexed=False:C215))
									$tResult:=$tResult+"data not indexed"+"\t"+$readLine+"\r"
									$theTableField:="["+Table name:C256($tableNum)+"]"+Field name:C257($tableNum; $fieldNum)
									$theCommand:=$theCommand+"SET INDEX("+$theTableField+";false)"+"\r"
								Else 
									If ($theCount<$myCount)
										$tResult:=$tResult+"matched false"+"\t"+$readLine+"\r"
									End if 
							End case 
						End if 
					End if 
				End if 
			End if 
			$theCount:=$theCount+1
		Until (OK=0)
		CLOSE DOCUMENT:C267(myDoc)
		If ($theCommand="")
			ALERT:C41("Indexes match the jitIndex.txt file.")
		Else 
			ALERT:C41("Commands to correct are on the clipboard.")
			SET TEXT TO PASTEBOARD:C523($theCommand)
		End if 
	End if 
End if 