//%attributes = {"publishedWeb":true}



// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-12-27T00:00:00, 15:19:52
// ----------------------------------------------------
// Method: itemProfiles2LineRecords
// Description
// Modified: 12/27/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


// Should no longer be used
// 
// If (False)
//   //Method: ItemsProfiles2Records
//   //Date: 03/11/03
//   //Who: Bill
//   //Description: 
// End if 
// C_POINTER($1)
// C_LONGINT($2;$docID)
// C_Longint($i;$k)
// READ ONLY([Item])
// READ WRITE($1->)
// $docID:=0
// If (COUNT PARAMTERS>1)
// $docID:=$2
// End if 
// Case of 
// : ($1=(->[POLine]))
// If ($docID>0)
// QUERY([POLine];[POLine]PONum=$docID)
// End if 
// $k:=Records in selection($1->)
// For ($i;1;$k)
// QUERY([Item];[Item]ItemNum=[POLine]ItemNum)
// If (Records in selection([Item])=1)
//   //[Item]Profile1
//   //[Item]Profile2
//   //[Item]Profile3
//   //[Item]Profile4
//   //[Item]MfgID
//   //[Item]typeID
// End if 
// SAVE RECORD([POLine])
// NEXT RECORD([POLine])
// End for 
// : ($1=(->[ProposalLine]))
// If ($2>0)
// QUERY([ProposalLine];[ProposalLine]ProposalNum=$docID)
// End if 
// $k:=Records in selection($1->)
// For ($i;1;$k)
// QUERY([Item];[Item]ItemNum=[ProposalLine]ItemNum)
// If (Records in selection([Item])=1)
// [ProposalLine]Profile1:=[Item]Profile1
// [ProposalLine]Profile2:=[Item]Profile2
// [ProposalLine]Profile3:=[Item]Profile3
//   //[Item]Profile4
//   //[Item]MfgID
//   //[Item]typeID
// End if 
// SAVE RECORD([ProposalLine])
// NEXT RECORD([ProposalLine])
// End for 
// 
// : ($1=(->[OrderLine]))
// If ($docID>0)
// QUERY([OrderLine];[OrderLine]OrderNum=$docID)
// End if 
// $k:=Records in selection($1->)
// For ($i;1;$k)
// QUERY([Item];[Item]ItemNum=[OrderLine]ItemNum)
// If (Records in selection([Item])=1)
// [OrderLine]Profile1:=[Item]Profile1
// [OrderLine]Profile2:=[Item]Profile2
// [OrderLine]Profile3:=[Item]Profile3
//   //[Item]Profile4
//   //[Item]MfgID
//   //[Item]typeID
// End if 
// SAVE RECORD([OrderLine])
// NEXT RECORD([OrderLine])
// End for 
// 
// : ($1=(->[InvoiceLine]))
// If ($docID>0)
// QUERY([InvoiceLine];[InvoiceLine]InvoiceNum=$docID)
// End if 
// $k:=Records in selection($1->)
// For ($i;1;$k)
// QUERY([Item];[Item]ItemNum=[InvoiceLine]ItemNum)
// If (Records in selection([Item])=1)
// [InvoiceLine]Profile1:=[Item]Profile1
// [InvoiceLine]Profile2:=[Item]Profile2
// [InvoiceLine]Profile3:=[Item]Profile3
//   //[Item]Profile4
//   //[Item]MfgID
//   //[Item]typeID
// End if 
// SAVE RECORD([InvoiceLine])
// NEXT RECORD([InvoiceLine])
// End for 
// End case 
// READ ONLY($1->)