//%attributes = {"publishedWeb":true}
C_DATE:C307($firstDay)
$firstDay:=Date_ThisMon(vdDateBeg; 0)
//   CHOPPED CS_SetRange(eTimeCrdCal; $firstDay; !00-00-00!)
ARRAY DATE:C224(aDayRay; 0)
//  CHOPPED  CS_SetSelect(eTimeCrdCal; vdDateBeg; vdDateEnd; 1; aDayRay)
//  CHOPPED   Area_Refresh(eTimeCrdCal)