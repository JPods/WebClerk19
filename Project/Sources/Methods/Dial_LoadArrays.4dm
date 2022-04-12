//%attributes = {"publishedWeb":true}
ALL RECORDS:C47([DialingInfo:81])
SELECTION TO ARRAY:C260([DialingInfo:81]AreaPrefix:1; <>yDIAreaPrfx; [DialingInfo:81]StripAreaCode:2; <>yDILeaveOut; [DialingInfo:81]ProceedWith:3; <>yDIProceedW; [DialingInfo:81]FollowWith:6; <>yDIFollowW; [DialingInfo:81]TotalLength:4; <>yDITotalLen)
UNLOAD RECORD:C212([DialingInfo:81])