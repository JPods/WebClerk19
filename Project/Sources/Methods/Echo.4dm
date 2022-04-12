//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 09/19/18, 14:07:28
// ----------------------------------------------------
// Method: Echo
// Description This method allows users to add strings
// to the buffer from inside of a -6 script tag.
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; echo_t)

echo_t:=echo_t+$1

// DON'T RETURN ANYTHING DIRECTLY.