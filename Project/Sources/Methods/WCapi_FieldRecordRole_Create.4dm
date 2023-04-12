//%attributes = {}

// ### bj ### 20210220_2052
// Make simplier


// // ----------------------------------------------------
// // User name (OS): Bill James
// // Date and time: 01/07/21, 12:04:42
// // ----------------------------------------------------
// // Method: WCapi_FieldRecordRole_Create
// // Description
// // 
// //
// // Parameters
// // ----------------------------------------------------
// 
// $vtRole:="minRole"
// $vtTables:="Customer,Contact,Order,OrderLine,Invoice,InvoiceLine,Payment,Ledger,Item,Proposal,ProposalLine,RemoteUser,Objective,Project,WorkOrder,QAQuestion,QAAnswer,QA,Service"
// $viSecureLvl:=5000
// $vtQuery:="Roles = :1 "
// 
// If (Count parameters>0)
// $vtRole:="@"+$1+"@"
// C_OBJECT($voFCs)
// C_TEXT($vtQuery)
// $vtQuery:="Roles = :1 "
// If (Count parameters>1)
// $vtTables:=$2
// If (Count parameters>2)
// $viSecureLvl:=$3
// $vtQuery:=$vtQuery+" AND SecurityLevel = :2 "
// End if 
// End if 
// End if 
// 
// TRACE
// C_TEXT($tableName; $tableName)
// C_OBJECT($voSelFieldChar; $voRecFieldChar)
// C_OBJECT($voSelFields; $voRecFields)
// C_TEXT($vtFieldName)
// $voSelFieldChar:=ds.FC.query($vtQuery; $vtRole; $viSecureLvl)
// If ($voSelFieldChar.length=0)
// ARRAY TEXT($vtArrayTables; 0)
// TextToArray($vtTables; ->$vtArrayTables; ",")
// C_LONGINT($incRay; $cntRay)
// $cntRay:=Size of array($vtArrayTables)
// For ($incRay; 1; $cntRay)
// $tableName:=$vtArrayTables{$incRay}
// 
// If (<>voTables[$vtTableNameLC]#Null)
// $tableName:=<>voTables[$tableName].tableName
// $voSelFields:=<>voTables[$tableName].fields
// For each ($vtFieldName; $voSelFields)
// $voRecFields:=ds.FC.new()
// $voRecFields.purpose:="List_"+$vtRole
// $voRecFields.roles:=$vtRole
// $voRecFields.securityLevel:=$viSecureLvl
// $voRecFields.tableName:=<>voTables[$tableName].tableName
// $voRecFields.tableNumber:=<>voTables[$tableName].tableNum
// $voRecFields.fieldNumber:=$voSelFields[$vtFieldName].fieldNum
// $voRecFields.fieldName:=$voSelFields[$vtFieldName].fieldName
// $voRecFields.save()
// End for each 
// End if 
// End for 
// End if 