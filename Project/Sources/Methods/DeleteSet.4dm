//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 05/09/19, 15:57:51
// ----------------------------------------------------
// Method: DeleteSet
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($myOK; $error; $theElement)
C_TEXT:C284($myFileName)
$theElement:=aText4
//TRACE
If (Size of array:C274(aText4)>0)
	
	If (($theElement>0) & ($theElement<=Size of array:C274(aText4)))
		
		$vtConfirm:="Delete Set \""+aText5{$theElement}+"\""
		CONFIRM:C162($vtConfirm; " Delete Set "; " Cancel ")
		
		If (OK=1)
			
			// File name Begins with S_ & Ends with 4ST 
			If ((aText4{$theElement}="S_@") & (aText4{$theElement}="@4ST"))
				
				$error:=HFS_Delete(Storage:C1525.folder.jitPrefPath+aText4{$theElement})
				$vbDelete:=True:C214
				
			Else   // set is a TallyMaster
				
				// ### jwm ### 20190509_1509
				QUERY:C277([TallyMaster:60]; [TallyMaster:60]id:38=aText4{$theElement})
				
				If (Records in selection:C76([TallyMaster:60])=1)
					
					DELETE RECORD:C58([TallyMaster:60])
					$vbDelete:=True:C214
					
				Else 
					
					ConsoleLog("ERROR: Unable To Delete Saved Set Not Found")
					
				End if   // tallmaster = 1
				
			End if   // set is a file
			
			If ($vbDelete=True:C214)
				
				DELETE FROM ARRAY:C228(aTmpLong2; $theElement; 1)
				DELETE FROM ARRAY:C228(aTmpLong1; $theElement; 1)
				DELETE FROM ARRAY:C228(aText3; $theElement; 1)
				DELETE FROM ARRAY:C228(aText4; $theElement; 1)
				DELETE FROM ARRAY:C228(aText5; $theElement; 1)
				//  --  CHOPPED  AL_UpdateArrays(eFileList; -2)
				
			End if 
			
		End if   //"Delete Set"
		
	End if   // array element is selected
	
End if   // sets array not empty