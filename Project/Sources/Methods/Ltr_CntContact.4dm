//%attributes = {"publishedWeb":true}
C_POINTER:C301($2; $1)
$1->:=0
$2->:=""
Case of 
	: (ptCurTable=(->[Customer:2]))
		$1->:=CountContacts(->[Contact:13]; ->[Contact:13]customerID:1; ->[Customer:2]customerID:1; ->[Contact:13]letterList:13; [Customer:2]individual:72)
		$2->:=[Customer:2]repid:58
	: (ptCurTable=(->[Service:6]))
		JSr_MatchRelate(->[Customer:2]; ->[Customer:2]customerID:1; ->[Service:6]customerid:1)
		JSr_MatchRelate(->[Rep:8]; ->[Rep:8]repid:1; ->[Service:6]repid:2)
		$1->:=CountContacts(->[Contact:13]; ->[Contact:13]customerID:1; ->[Customer:2]customerID:1; ->[Contact:13]letterList:13; [Customer:2]individual:72)
		$2->:=[Service:6]repid:2
	: (ptCurTable=(->[Order:3]))
		JSr_MatchRelate(->[Customer:2]; ->[Customer:2]customerID:1; ->[Order:3]customerid:1)
		$1->:=CountContacts(->[Contact:13]; ->[Contact:13]customerID:1; ->[Order:3]customerid:1; ->[Contact:13]letterList:13; [Customer:2]individual:72)
		$2->:=[Order:3]repid:8
	: (ptCurTable=(->[Invoice:26]))
		JSr_MatchRelate(->[Customer:2]; ->[Customer:2]customerID:1; ->[Invoice:26]customerid:3)
		$1->:=CountContacts(->[Contact:13]; ->[Contact:13]customerID:1; ->[Invoice:26]customerid:3; ->[Contact:13]letterList:13; [Customer:2]individual:72)
		$2->:=[Invoice:26]repid:22
	: (ptCurTable=(->[Proposal:42]))
		JSr_MatchRelate(->[Customer:2]; ->[Customer:2]customerID:1; ->[Proposal:42]customerid:1)
		$1->:=CountContacts(->[Contact:13]; ->[Contact:13]customerID:1; ->[Proposal:42]customerid:1; ->[Contact:13]letterList:13; [Customer:2]individual:72)
		$2->:=[Proposal:42]repid:7
	: (ptCurTable=(->[Contact:13]))
		$1->:=1
		JSr_MatchRelate(->[Customer:2]; ->[Customer:2]customerID:1; ->[Contact:13]customerID:1)
		$2->:=[Customer:2]repid:58
	: (ptCurTable=(->[Rep:8]))
		$1->:=CountContacts(->[RepContact:10]; ->[RepContact:10]repid:1; ->[Rep:8]repid:1; ->[RepContact:10]letterList:2; False:C215)
		$2->:=[Rep:8]repid:1
	: (ptCurTable=(->[RepContact:10]))
		$1->:=1
		If ([Rep:8]repid:1#[RepContact:10]repid:1)
			QUERY:C277([Rep:8]; [Rep:8]repid:1=[RepContact:10]repid:1)
		End if 
		$2->:=[Rep:8]repid:1
End case 
//If ($1=0)
$1->:=1
//End if 