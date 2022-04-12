//%attributes = {"publishedWeb":true}
//Procedure: Pro_RdVNamePpl
//read the value field for the [Profile] 
//from the current Proposal with a specific name
C_TEXT:C284($0)  //return the value field
C_TEXT:C284($1; $Name)
$Name:=$1
C_TEXT:C284($2; $Default)
If (Count parameters:C259>=2)
	$Default:=$2
Else 
	$Default:=""
End if 

QUERY:C277([Profile:59]; [Profile:59]tableNum:1=Table:C252(->[Proposal:42]); *)
QUERY:C277([Profile:59];  & [Profile:59]DocNumID:2=[Proposal:42]proposalNum:5; *)
QUERY:C277([Profile:59];  & [Profile:59]DocAlphaID:3=""; *)
QUERY:C277([Profile:59];  & [Profile:59]Name:4=$Name)

If (Records in selection:C76([Profile:59])=1)
	$0:=[Profile:59]Value:5
Else 
	$0:=$Default
End if 