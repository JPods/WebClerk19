//%attributes = {"publishedWeb":true}
//Procedure: Date_Set
C_DATE:C307(cdYesterday; <>cdYesterday; <>cdMonth; cdToday; cdWeekAgo; cdMonthAgo; <>cdWeekAgo; <>cdMonthAgo; cdTomorrow; cdWeekNext)
C_DATE:C307(<>cdSixMonthsAgo; <>cdSixMonthsAgo; cdYearAgo; cdYearAgo; cdQuarterAgo; <>cdQuarterAgo)
<>cdYesterday:=Current date:C33-1
<>cdWeekAgo:=Current date:C33-7
<>cdMonthAgo:=Current date:C33-30
<>cdSixMonthsAgo:=Current date:C33-182
<>cdYearAgo:=Current date:C33-365
<>cdQuarterAgo:=Current date:C33-90
cdYearAgo:=<>cdYearAgo
cdSixMonthsAgo:=<>cdSixMonthsAgo
cdQuarterAgo:=<>cdQuarterAgo
cdYesterday:=<>cdYesterday
cdTomorrow:=Current date:C33+1
cdWeekNext:=Current date:C33+7
cdMonthNext:=Current date:C33+30
cdWeekAgo:=<>cdWeekAgo
cdMonthAgo:=<>cdMonthAgo
cdToday:=Current date:C33
//