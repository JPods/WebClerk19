//%attributes = {}
// // ----------------------------------------------------
// // User name(OS): William James
// // Date and time: 2014-7-11T00:00:00, 08:21:48
// // ----------------------------------------------------
// // Method: Convert2TablePopups
// // Description
// // Modified: 07/11/14
// // Structure: CEv13_131005
// // 
// // 
// //  Parameters
// //  ----------------------------------------------------
// 
// 
// 
// C_LONGINT($cntRec;$incRec;$cntSubRec;$incSubRec)
// C_TEXT($nameArray)
// 
// ALL RECORDS([PopUp])
// $cntRec:=Records in table([PopUp])
// FIRST RECORD([PopUp])
// For ($incRec;1;$cntRec)
// $nameArray:=[PopUp]ArrayName
// ALL SUBRECORDS([PopUp]Choices)
// $cntSubRec:=Records in sub_selection([PopUp]Choices)
// If ($cntSubRec>0)
// FIRST SUBRECORD([PopUp]Choices)
// For ($incSubRec;1;$cntSubRec)
// QUERY([PopupChoice];[PopupChoice]ArrayName=$nameArray;*)
// QUERY([PopupChoice]; & [PopupChoice]Choice=[PopUp]Choices'Choice)
// If (Records in selection([PopupChoice])=0)
// CREATE RECORD([PopupChoice])
// 
// [PopupChoice]ArrayName:=$nameArray
// [PopupChoice]Choice:=[PopUp]Choices'Choice
// SAVE RECORD([PopupChoice])
// End if 
// NEXT SUBRECORD([PopUp]Choices)
// End for 
// end if
// 
// NEXT RECORD([PopUp])
// End for 
// 
// ALL RECORDS([zzzPopUps_Choice])
// DELETE SELECTION([zzzPopUps_Choice])