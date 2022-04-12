//%attributes = {"publishedWeb":true}
//Procedure: Dup_CombineLead
C_TEXT:C284($thePhone; $theEmail; $firstName; $lastName; $comments)

CONFIRM:C162("Combine "+("previous"*Num:C11(optKey=1))+("next"*Num:C11(optKey=0))+" into current.")
If (OK=1)
	Dup_LeadDetails(optKey; 0; 0)
End if 