//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1)
ARRAY TEXT:C222(aSyncFiles; $1)
ARRAY LONGINT:C221(aSyncCnt; $1)
ARRAY TEXT:C222(aSyncAction; $1)
ARRAY POINTER:C280(aSyncFilePt; $1)
ARRAY POINTER:C280(aSyncFldPt; $1)
If ($1>0)
	aSyncFiles{1}:="Customer"
	aSyncFiles{2}:="Contact"
	
	aSyncFiles{3}:="Proposal"
	aSyncFiles{4}:="Order"
	aSyncFiles{5}:="Invoice"
	aSyncFiles{6}:="Service"
	aSyncFiles{7}:="ShowLeads"
	//  "Payment"
	//  aSyncFiles{8}:="PO's"
	//  aSyncFiles{9}:="Item"
	//  aSyncFiles{10}:="BOM"
	//  aSyncFiles{11}:="Special Discounts"
	//  aSyncFiles{12}:="Taxes"
	//  aSyncFiles{13}:="Rep"
	//  aSyncFiles{14}:="Rep Contacts"
	aSyncFilePt{1}:=->[Customer:2]
	aSyncFilePt{2}:=->[Contact:13]
	
	aSyncFilePt{3}:=->[Proposal:42]
	aSyncFilePt{4}:=->[Order:3]
	aSyncFilePt{5}:=->[Invoice:26]
	aSyncFilePt{6}:=->[Service:6]
	aSyncFilePt{7}:=->[Lead:48]
	//[Payment]
	//  aSyncFilePt{8}:=[PO]
	//  aSyncFilePt{9}:=[Item]
	//  aSyncFilePt{10}:=[BOM]
	//  aSyncFilePt{11}:=[SpecDscnt]
	//  aSyncFilePt{12}:=[Taxe]
	//  aSyncFilePt{13}:=[Rep]
	//  aSyncFilePt{14}:=[RepContact]
	aSyncFldPt{1}:=->[Customer:2]obSync:10
	aSyncFldPt{2}:=->[Contact:13]obSync:17
	
	aSyncFldPt{3}:=->[Proposal:42]obSync:44
	aSyncFldPt{4}:=->[Order:3]lng:34
	aSyncFldPt{5}:=->[Invoice:26]obSync:47
	aSyncFldPt{6}:=->[Service:6]obSync:29
	aSyncFldPt{7}:=->[Lead:48]obSync:25
	//[Payment]DateTimeSync
	//  aSyncFldPt{8}:=[PO]DateTimeSync
	//  aSyncFldPt{9}:=[Item]DateTimeSync
	//  aSyncFldPt{10}:=[BOM]DateTimeSync
	//  aSyncFldPt{11}:=[SpecDscnt]DateTimeSync
	//  aSyncFldPt{12}:=[Taxe]DateTimeSync
	//  aSyncFldPt{13}:=[Rep]DateTimeSync
	//  aSyncFldPt{14}:=[RepContact]DateTimeSync
	aSyncAction{1}:="ind"
	aSyncAction{2}:="ind"
	aSyncAction{3}:="ind"
	aSyncAction{4}:="ind"
	aSyncAction{5}:="ind"
	aSyncAction{6}:="ind"
	aSyncAction{7}:="ind"
End if 