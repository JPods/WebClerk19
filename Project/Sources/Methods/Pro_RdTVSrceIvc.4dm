//%attributes = {"publishedWeb":true}
//Procedure: Pro_RdTVSrceIvc
//read the TextValue field for the [Profile] 
//from the current Invoice with a specific name
C_TEXT:C284($0)  //return the TextValue field
C_TEXT:C284($1; $Source)
$Source:=$1
C_TEXT:C284($2; $Default)
If (Count parameters:C259>=2)
	$Default:=$2
Else 
	$Default:=""
End if 

QUERY:C277([Profile:59]; [Profile:59]tableNum:1=Table:C252(->[Invoice:26]); *)
QUERY:C277([Profile:59];  & [Profile:59]DocNumID:2=[Invoice:26]invoiceNum:2; *)
QUERY:C277([Profile:59];  & [Profile:59]DocAlphaID:3=""; *)
QUERY:C277([Profile:59];  & [Profile:59]Source:7=$Source)

If (Records in selection:C76([Profile:59])=1)
	$0:=[Profile:59]TextValue:6
Else 
	$0:=$Default
End if 