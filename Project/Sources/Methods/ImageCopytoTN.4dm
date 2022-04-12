//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/11/20, 14:20:19
// ----------------------------------------------------
// Method: ImageCopytoTN
// Description
// --WORKONTHIS--
//
// Parameters
// ----------------------------------------------------
// ### bj ### 20200111_1420
// complete the image handling procedures for scaling and TN

C_POINTER:C301(ptTable; ptField; ptFieldTN)
ptTable:=(->[QACustomer:70])
ptField1:=(->[QACustomer:70]photo:19)
ptFieldTN:=(->[QACustomer:70]photoTN:24)

ptTable:=(->[Document:100])
ptField1:=(->[Document:100]Path:4)
ptFieldTN:=(->[Document:100]PathTN:5)

ptTable:=(->[Item:4])
ptField1:=(->[Item:4]photo:104)
ptFieldTN:=(->[Item:4]photoTn:114)

vi2:=Records in selection:C76(ptTable->)
FIRST RECORD:C50(ptTable->)
For (vi1; 1; vi2)
	ptFieldTN->:=ptField1->
	SAVE RECORD:C53(ptTable->)
	NEXT RECORD:C51(ptTable->)
End for 
UNLOAD RECORD:C212(ptTable->)

