//%attributes = {"publishedWeb":true}
//Procedure: Pro_RdTVName
//read the TextValue field for the [Profile] with a specific name
C_TEXT:C284($0)  //return the TextValue field
C_POINTER:C301($1; $FilePtr)
$FilePtr:=$1
C_LONGINT:C283($OrgFileID)
C_LONGINT:C283($2; $LongID; $OrgLongID)
$LongID:=$2
C_TEXT:C284($3; $AlphaID; $OrgAlphaID)
$AlphaID:=$3
C_TEXT:C284($4; $Name)
$Name:=$4
C_TEXT:C284($5; $Default)
If (Count parameters:C259>=5)
	$Default:=$5
Else 
	$Default:=""
End if 

QUERY:C277([Profile:59]; [Profile:59]tableNum:1=$OrgFileID; *)
QUERY:C277([Profile:59];  & [Profile:59]DocNumID:2=$OrgLongID; *)
QUERY:C277([Profile:59];  & [Profile:59]DocAlphaID:3=$OrgAlphaID; *)
QUERY:C277([Profile:59];  & [Profile:59]Name:4=$Name)

If (Records in selection:C76([Profile:59])=1)
	$0:=[Profile:59]TextValue:6
Else 
	$0:=$Default
End if 