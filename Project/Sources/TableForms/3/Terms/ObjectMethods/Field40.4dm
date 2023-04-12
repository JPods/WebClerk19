C_TEXT:C284($tempStr)
// zzzqqq PopUpWildCard(->[Order:3]actionBy:55; -><>aNameID; ->[Employee:19])
//If ([Order]ProducedBy#Old([Order]ProducedBy))
//$tempStr:="Order Assigned to "+[Order]ProducedBy+"."
//// zzzqqq jDateTimeStamp (->[Order]CommentProcess;$tempStr)
//releaseTime:=Current time
//releaseDate:=Current date
//[Order]DTProdRelease:=jDateTimeEnter 
//d03Release:=Date_strYrMmDd (releaseDate;0)
//End if 
// zzzqqq U_DTStampFldMod(->[Order:3]commentProcess:12; ->[Order:3]actionBy:55)