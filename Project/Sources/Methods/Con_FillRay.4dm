//%attributes = {"publishedWeb":true}
//Method: Con_FillRay
C_LONGINT:C283($1; $incElem; $2)
C_BOOLEAN:C305($doAreaList)
$doAreaList:=False:C215
If (Count parameters:C259=2)
	If ($2#0)
		$doAreaList:=True:C214
		//  --  CHOPPED  AL_UpdateArrays($2; -2)
		// -- AL_SetSort($2; -7)
	End if 
End if 
Case of 
	: ($1=0)
		ARRAY TEXT:C222(aConFirstName; 0)
		ARRAY TEXT:C222(aConLastName; 0)
		ARRAY TEXT:C222(aConProfile1; 0)
		ARRAY TEXT:C222(aConKeyWords; 0)
		ARRAY BOOLEAN:C223(aConPrimeShip; 0)
		ARRAY LONGINT:C221(aConUniqueID; 0)
		ARRAY BOOLEAN:C223(aConLetterList; 0)
		ARRAY DATE:C224(aConActionDate; 0)
		ARRAY TEXT:C222(aConAction; 0)
		ARRAY TEXT:C222(aConPhone; 0)
		ARRAY TEXT:C222(aConEmail; 0)
		ARRAY TEXT:C222(aConCity; 0)
		ARRAY TEXT:C222(aConZip; 0)
		ARRAY LONGINT:C221(aConRecordNum; 0)
		//
		ARRAY LONGINT:C221(aConSelect; 0)
	: ($1>0)
		SELECTION TO ARRAY:C260([Contact:13]; aConRecordNum; [Contact:13]idNum:28; aConUniqueID; [Contact:13]action:32; aConAction; [Contact:13]actionDate:33; aConActionDate; [Contact:13]nameFirst:2; aConFirstName; [Contact:13]nameLast:4; aConLastName; [Contact:13]keyTags:14; aConKeyWords; [Contact:13]letterList:13; aConLetterList; [Contact:13]city:8; aConCity; [Contact:13]zip:11; aConZip; [Contact:13]profile1:18; aConProfile1; [Contact:13]phone:30; aConPhone; [Contact:13]email:35; aConEmail)
		If (Count parameters:C259=2)
			If ($2#0)
				//  --  CHOPPED  AL_UpdateArrays($2; -2)
				// -- AL_SetSort($2; -7)
			End if 
		End if 
End case 
//If ($doAreaList)
////  --  CHOPPED  AL_UpdateArrays ($2;-2)
//// -- AL_SetSort ($2;-7)
//End if 