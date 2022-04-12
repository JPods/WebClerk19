//%attributes = {"publishedWeb":true}
////Procedure: GL_MapInsightDv
////Noah Dykoski  December 9, 1998 / 11:08 PM

//C_TEXT($0)  //True Insight Division looked up from the DivDefaults
//C_TEXT($1; $DivDfltID)  //The theCustomer Division
//$DivDfltID:=$1

//QUERY([DivisionDefault]; [DivisionDefault]idNum=$DivDfltID)
//If (Records in selection([DivisionDefault])=1)
//$0:=[DivisionDefault]insightDiv
//Else 
//$0:=$DivDfltID
//End if 