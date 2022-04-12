//%attributes = {"publishedWeb":true}
//Procedure: ELog_NewRecMsg
C_LONGINT:C283($1)  //event number (i.e. error number)
C_TEXT:C284($2)  //event type (i.e. error vs other events)
C_TEXT:C284($3)  //Text of event message
//jMessageWindow ($3)
ConsoleMessage($3)  // ### jwm ### 20160812_1122
ELog_NewRecord($1; $2; $3)
