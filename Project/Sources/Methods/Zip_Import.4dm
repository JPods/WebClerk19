//%attributes = {"publishedWeb":true}
If (False:C215)
	//Date: 03/20/02
	//Who: Peter Fleming, Arkware
	//Description: Zipcode import
	VERSION_960
End if 

C_TEXT:C284($Text1; $vData)
C_TIME:C306($MyDoc)
C_LONGINT:C283($TotalRecs; $RecsDeleted; $QtyToDelete; $ZipCount; $TotalCount; $SaveCount; $QtyToSave)

$Text1:=Get_FileName("Select Zipcode file:"; "TEXT")
If ($Text1#"")
	$MyDoc:=Open document:C264($Text1; "TEXT")
	If (OK=1)  //file opened successfully 
		
		Open window:C153(40; 80; 440; 180; 8)
		
		ALL RECORDS:C47([QQQZipCode:96])
		
		$TotalRecs:=Records in selection:C76([QQQZipCode:96])
		$RecsDeleted:=0
		$QtyToDelete:=200
		
		//Delete in bunches so other users can keep working
		//otherwise 4D Server appears to hang
		
		Repeat 
			REDUCE SELECTION:C351([QQQZipCode:96]; $QtyToDelete)
			DELETE SELECTION:C66([QQQZipCode:96])
			FLUSH CACHE:C297
			ALL RECORDS:C47([QQQZipCode:96])
			$RecsDeleted:=$RecsDeleted+$QtyToDelete
			GOTO XY:C161(1; 1)
			MESSAGE:C88("Deleting old zip code records: "+String:C10($RecsDeleted)+" of "+String:C10($TotalRecs))
			IDLE:C311
		Until (Records in selection:C76([QQQZipCode:96])=0)
		
		$TotalCount:=0
		$ZipCount:=0
		$SaveCount:=0
		$QtyToSave:=200
		ERASE WINDOW:C160
		
		Repeat 
			
			RECEIVE PACKET:C104($MyDoc; $vData; 129)
			
			If (($vData#"") & (Substring:C12($vData; 1; 1)="D"))
				
				CREATE RECORD:C68([QQQZipCode:96])
				
				//All available fields in the USPS zipcode data are listed
				//Just importing what's needed
				
				//[Table1]Code:=Substring($vData;1;1)
				[QQQZipCode:96]ZipCode:1:=Substring:C12($vData; 2; 5)
				//[Table1]CityStateKey:=Substring($vData;7;6)
				//[Table1]ZipClass:=Substring($vData;13;1)
				[QQQZipCode:96]CityName:2:=Txt_TrimSpaces(Substring:C12($vData; 14; 28))
				//[Table1]CtyStateNameAbbr:=Txt_TrimSpaces (Substring($vData;42;13))
				//[Table1]CtyStFacCode:=Substring($vData;55;1)
				//[Table1]CtyStMailingNameInd:=Substring($vData;56;1)
				//[Table1]PrefdLastLineCtyStKey:=Txt_TrimSpaces (Substring($vData;57;6))
				[QQQZipCode:96]PreferredCityName:3:=Txt_TrimSpaces(Substring:C12($vData; 63; 28))
				//[Table1]CityDelvInd:=Substring($vData;91;1)
				//[Table1]CarrRteRateSortInd:=Substring($vData;92;1)
				//[Table1]UniqueZipNameInc:=Substring($vData;93;1)
				//[Table1]FinanceNo:=Substring($vData;94;6)
				[QQQZipCode:96]StateAbbr:4:=Substring:C12($vData; 100; 2)
				//[Table1]CountyNo:=Substring($vData;102;3)
				//[Table1]CountyName:=Txt_TrimSpaces (Substring($vData;105;25))
				
				SAVE RECORD:C53([QQQZipCode:96])
				
				$ZipCount:=$ZipCount+1
				$SaveCount:=$SaveCount+1
				If ($SaveCount=$QtyToSave)
					FLUSH CACHE:C297
					$SaveCount:=0
				End if 
				
			End if 
			
			$TotalCount:=$TotalCount+1
			GOTO XY:C161(1; 1)
			MESSAGE:C88("Reading zip code file: "+String:C10($TotalCount)+" records"+Char:C90(13)+Char:C90(13)+" "+String:C10($ZipCount)+" zip code records found of approximately 76500")
			
		Until (OK=0)
		
		FLUSH CACHE:C297
		CLOSE DOCUMENT:C267($MyDoc)
		CLOSE WINDOW:C154
		
	End if 
End if 


REDRAW WINDOW:C456