//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/13/21, 02:26:00
// ----------------------------------------------------
// Method: WCapiTask_GetQAChoices
// Description
// 
//
// Parameters
// ----------------------------------------------------

ARRAY OBJECT:C1221($aoAnswers; 0)
C_OBJECT:C1216($voQuestions; $voSelAnswers)
$voSelAnswers:=ds:C1482.QaAnswer.query("QuestionKey = :1 "; $viQuestionKey)

//{
//"userUUIDKey" : "\"DF221D6FCE5D9E468A1F04F1972CF308\"",
//"id" : "176D9D221AFB4C2DACB4A7709833509D",
//"photo":null,
//"answer" : "dfgdfgdfg",
//"answerUUIDKey:"dfsdffddsf"}"