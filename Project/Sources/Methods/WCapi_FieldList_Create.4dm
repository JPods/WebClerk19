//%attributes = {}
// ### bj ### 20210220_2048
// Find a simpler way to do this

// // ----------------------------------------------------
// // User name (OS): Bill James
// // Date and time: 01/07/21, 11:53:28
// // ----------------------------------------------------
// // Method: WCapi_FieldList_Create
// // Description
// // 
// //
// // Parameters
// // ----------------------------------------------------
// 
// 
// TRACE
// C_OBJECT($voTable; $voFields; $voFieldListByTable)
// C_TEXT($vtRole; $vtTables)
// C_TEXT($tableName; $vtFieldName)
// C_TEXT($vtFieldList; $vtFolderPath; $vtDocName)
// C_LONGINT($viSecureLvl)
// C_TIME($myDoc)
// CONFIRM("Are your sure you wish to overwrite all existing fieldLists?")
// If (OK=1)
// CONFIRM("Really, you are sure?")
// If (OK=1)
// // some defaults for examples
// $vtRole:="@Sales@"
// $vtTables:="Customer,Contact,Order,OrderLine,Invoice,InvoiceLine,Payment,Ledger,Item,Proposal,ProposalLine,RemoteUser,Objective,Project,WorkOrder,QAQuestion,QAAnswer,QA,Service"
// $viSecureLvl:=5000
// $vtQuery:="Roles = :1 "
// 
// If (Count parameters>0)
// $vtRole:="@"+$1+"@"
// C_OBJECT($obSel)
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
// // a list of lists
// $obSel:=ds.FC.query($vtQuery; $vtRole; $viSecureLvl)
// $rayCnt:=$obSel.length
// If ($rayCnt>0)
// C_OBJECT($voByTable)
// $obSel.orderBy("TableName asc, FieldName asc")
// C_OBJECT($obRec)
// C_OBJECT($voFCCreate)
// $tableName:=""
// $voFieldListByTable:=New object
// For each ($obRec; $obSel)
// If ($tableName#$obRec.tableName)
// If ($tableName#"")  // skip if there is no table yet set 
// $vtFieldList:=Substring($vtFieldList; 1; Length($vtFieldList)-1)
// $vtFieldList:=Replace string($vtFieldList; "id"; "")
// $vtFieldList:=Replace string($vtFieldList; ",,"; ",")
// If ($vtFieldList[[Length($vtFieldList)]]=",")
// $vtFieldList:=Substring($vtFieldList; 1; Length($vtFieldList)-1)
// End if 
// $vtFieldList:=FieldList_ForceUUIDFirst($vtFieldList)
// $voFieldListByTable[$tableName]:=$vtFieldList
// 
// $voFCCreate:=ds.FC.new()
// $voFCCreate.tableName:=$tableName
// $voFCCreate.purpose:="List_"+$vtRole
// $voFCCreate.obGeneral:=New object
// $voFCCreate.obGeneral.list:=$vtFieldList
// $voFCCreate.obGeneral.data:=$vtFieldList
// $voFCCreate.obGeneral.form:=$vtFieldList
// $voFCCreate.save()
// End if 
// $tableName:=$obRec.TableName
// $vtFieldList:=""
// End if 
// $vtFieldList:=$vtFieldList+$obRec.FieldName+","
// End for each 
// $vtFieldList:=Substring($vtFieldList; 1; Length($vtFieldList)-1)
// $voFieldListByTable[$tableName]:=$vtFieldList
// $voFCCreate:=ds.FC.new()
// $voFCCreate.tableName:=$tableName
// $voFCCreate.purpose:="List_"+$vtRole
// $voFCCreate.obGeneral:=New object
// $voFCCreate.obGeneral.list:=$vtFieldList
// $voFCCreate.obGeneral.data:=$vtFieldList
// $voFCCreate.obGeneral.form:=$vtFieldList
// $voFCCreate.save()
// End if 
// End if 
// End if 
// 