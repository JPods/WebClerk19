//%attributes = {"publishedWeb":true}
//FC_SumYear
// Dan 1/11/2002

// returns sum of usages for an item number given a year
//      Uses the year of the date passed in
C_TEXT:C284($itemNum; $1)
$itemNum:=$1
C_DATE:C307($YearToSum; $2; $EndOfYear)
$YearToSum:=$2
C_REAL:C285($0; $sum)

$EndOfYear:=Date_ThisYear($YearToSum; 1)  //end of year
QUERY:C277([Usage:5]; [Usage:5]ItemNum:1=$itemNum; *)
QUERY:C277([Usage:5];  & ; [Usage:5]PeriodDate:2>=$YearToSum; *)
QUERY:C277([Usage:5];  & ; [Usage:5]PeriodDate:2<=$EndOfYear)
C_LONGINT:C283($i)
$0:=Sum:C1([Usage:5]SalesQtyActual:4)+Sum:C1([Usage:5]BOMQtyActual:36)
//For ($i;1;Records in selection([Usage]))
// $sum:=$sum+[Usage]SalesQtyActual+[Usage]BOMQtyActual
//NEXT RECORD([Usage])
//End for 
