//%attributes = {}

// ----------------------------------------------------
// User name (OS): Andy
// Date and time: 12/26/20, 12:58:14
// ----------------------------------------------------
// Method: WC_ProfilingTimeStamp
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1)
DebugMessage("WS Request Timing - "+$1+": "+String:C10(Milliseconds:C459-voState.debugging.requestStartTime); 1)
voState.debugging.requestStartTime:=Milliseconds:C459