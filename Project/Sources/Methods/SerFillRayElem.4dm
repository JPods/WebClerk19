//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/20/19, 01:14:21
// ----------------------------------------------------
// Method: SerFillRayElem
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($0)
C_TEXT:C284($1; $2; $3)
C_DATE:C307($4)
C_TIME:C306($5)
C_TEXT:C284($6; $7; $8)
C_LONGINT:C283($9)

APPEND TO ARRAY:C911(aServiceTableName; $1)
APPEND TO ARRAY:C911(aServiceActionBy; $2)
APPEND TO ARRAY:C911(aServiceAction; $3)
APPEND TO ARRAY:C911(aServiceDate; $4)
APPEND TO ARRAY:C911(aServiceTime; $5)
APPEND TO ARRAY:C911(aServiceCompany; $6)
APPEND TO ARRAY:C911(aServiceAttention; $7)
APPEND TO ARRAY:C911(aServiceVariable; $8)  // [CallReport]Subject, [Service]NoteType, [Lead]AdSource
//  [Contact]Profile1, [Customer]AdSource
APPEND TO ARRAY:C911(aServiceRecs; $9)
