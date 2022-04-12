
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/24/18, 19:02:22
// ----------------------------------------------------
// Method: [Customer].Input.Button1
// Description
// 
//
// Parameters
// ----------------------------------------------------

PathLoadFolder(->[TechNote:58])
QUERY:C277([Document:100]; [Document:100]customerID:7=[Customer:2]customerID:1; *)
QUERY:C277([Document:100];  & [Document:100]tableNum:6=Table:C252(->[Customer:2]))
//Doc_FillArrays(Records in selection([Document]))
If (eListDocuments>0)
	//  --  CHOPPED  AL_UpdateArrays(eListDocuments; -2)
End if 

