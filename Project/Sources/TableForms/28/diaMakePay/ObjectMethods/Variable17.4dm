// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/25/09, 09:00:59
// ----------------------------------------------------
// Method: Object Method: pCreditCard
// Description
// 
//
// Parameters
// ----------------------------------------------------


//CCPaymentAutoSel 
C_BOOLEAN:C305($done)
C_TEXT:C284($creditCardNum)
//no encrypting is needed until saving
$done:=CCSelectCCType(pCreditCard; -><>aPayTypes)


CC_VerifyPayType(<>aTndClass{<>aPayTypes}; <>ciTCCrdtCrd)
Format_CreditCd(Self:C308)