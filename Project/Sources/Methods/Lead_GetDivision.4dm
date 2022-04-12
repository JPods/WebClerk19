//%attributes = {"publishedWeb":true}
//Method: Method: Lead_GetDivision
//Noah Dykoski   August 28, 1999 / 3:15 PM
C_TEXT:C284($0)  //Lead Division or default division

If ([Lead:48]division:45#"")
	$0:=[Lead:48]division:45
Else 
	$0:=Storage:C1525.default.division
End if 