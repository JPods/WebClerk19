//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/12/07, 13:16:42
// ----------------------------------------------------
// Method: PKPrintingArrays
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (Count parameters:C259#2)
	
Else 
	C_POINTER:C301($ptTable; $1)
	C_TEXT:C284($2)
	
	If (Record number:C243($1->)>-1)
		Case of 
			: ($ptTable=(->[Order:3]))
				If ($2="Packages")
					QUERY:C277([LoadTag:88]; [LoadTag:88]orderNum:29=[Order:3]orderNum:2)
					ORDER BY:C49([LoadTag:88]; [LoadTag:88]ContainerType:26; [LoadTag:88]idUnique:1)
					SELECTION TO ARRAY:C260([LoadTag:88]; aPrintRecNums)
					$cntRay:=Size of array:C274(aPrintRecNums)
					QUERY:C277([TallyMaster:60]; [TallyMaster:60]Purpose:3="PK"; *)
					QUERY:C277([TallyMaster:60];  & [TallyMaster:60]Purpose:3="Packages")
					$recNum:=Record number:C243([TallyMaster:60])
					For ($incRay; 1; $cntRay)
						aPrintTableNum{$incRay}:=Table:C252(->[LoadTag:88])
						aPrintTMRec{$incRay}:=$recNum
					End for 
				End if 
			: ($ptTable=(->[Invoice:26]))
				
			: ($ptTable=(->[LoadItem:87]))
				
				
			: ($ptTable=(->[LoadTag:88]))
				
				
			: ($1=(->[LoadTag:88]))
				
				Case of 
					: ($2="InMeExpanded")
						
						
					: ($2="InMe")
						
						
					: ($2="InSuperior")
						
						If (Record number:C243([LoadTag:88])>-1)
							PrintArray(-3; 1; 1)
							$uniqueIdCurrent:=[LoadTag:88]idUnique:1
							QUERY:C277([LoadTag:88]; [LoadTag:88]idUniqueSuperior:27=$uniqueIdCurrent)
							$k:=Records in selection:C76([LoadTag:88])
							If ($k>0)
								FIRST RECORD:C50([LoadTag:88])
								For ($i; 1; $k)
									$w:=Size of array:C274(aPrintTableNum)+1
									//PKPRintArrayLoadTags(-3;$w;1;(->[LoadTag]))
									NEXT RECORD:C51([LoadTag:88])
								End for 
							Else 
								QUERY:C277([LoadItem:87]; [LoadItem:87]LoadTagID:8=$uniqueIdCurrent)
								$k:=Records in selection:C76([LoadTag:88])
								If ($k>0)
									FIRST RECORD:C50([LoadTag:88])
									For ($i; 1; $k)
										$w:=Size of array:C274(aPrintTableNum)+1
										//PKPRintArrayLoadTags(-3;$w;1;(->[LoadTag]))
										NEXT RECORD:C51([LoadTag:88])
									End for 
								End if 
							End if 
						End if 
						
				End case 
				
			: ($1=(->[LoadItem:87]))
				
				
		End case 
		
	End if 
End if 