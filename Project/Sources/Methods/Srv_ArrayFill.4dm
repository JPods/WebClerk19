//%attributes = {"publishedWeb":true}
//Method: Srv_ArrayFill
C_LONGINT:C283($1; $2; $3; $4; $areaList)
If (Count parameters:C259<4)
	$areaList:=0
Else 
	$areaList:=$4
End if 
Case of 
	: ($1=0)
		ARRAY TEXT:C222(atAction; 0)
		ARRAY TEXT:C222(atactionName; 0)
		ARRAY TEXT:C222(atAttention; 0)
		ARRAY TEXT:C222(atCompany; 0)
		ARRAY BOOLEAN:C223(atCompleted; 0)
		ARRAY LONGINT:C221(atcontactID; 0)
		ARRAY TEXT:C222(atcustomerID; 0)
		ARRAY TEXT:C222(atDescription; 0)
		ARRAY DATE:C224(at_DTActionDate; 0)
		ARRAY LONGINT:C221(at_DTActionTime; 0)
		ARRAY TEXT:C222(atNameCreatedBy; 0)
		ARRAY TEXT:C222(atRepID; 0)
		ARRAY LONGINT:C221(attaskID; 0)
		ARRAY LONGINT:C221(aServiceRec; 0)
		//Service_ALDefine
		ARRAY LONGINT:C221(aServiceSelect; 0)
	: ($1>0)
		ARRAY LONGINT:C221($tempDT; 0)
		SELECTION TO ARRAY:C260([Service:6]action:20; atAction; [Service:6]actionBy:12; atactionName; [Service:6]attention:30; atAttention; [Service:6]company:48; atCompany; [Service:6]complete:17; atCompleted; [Service:6]contactID:52; atcontactID; [Service:6]customerID:1; atcustomerID; [Service:6]description:50; atDescription; [Service:6]dtAction:35; $tempDT; [Service:6]actionCreatedBy:40; atNameCreatedBy; [Service:6]repID:2; atRepID; [Service:6]idNumTask:51; attaskID; [Service:6]; aServiceRec)
		C_LONGINT:C283($i; $k)
		$k:=Size of array:C274($tempDT)
		ARRAY DATE:C224(at_DTActionDate; $k)
		ARRAY LONGINT:C221(at_DTActionTime; $k)
		For ($i; 1; $k)
			DateTime_DTFrom($tempDT{$i}; ->at_DTActionDate{$i}; ->at_DTActionTime{$i})
			at_DTActionTime{$i}:=at_DTActionTime{$i}*1
		End for 
		If ($areaList#0)
			//  --  CHOPPED  AL_UpdateArrays($areaList; -2)
			// -- AL_SetSort($areaList; -7)
		End if 
End case 
