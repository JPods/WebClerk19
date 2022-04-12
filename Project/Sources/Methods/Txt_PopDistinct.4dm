//%attributes = {"publishedWeb":true}
//Procedure: Txt_PopDistinct
C_LONGINT:C283($1)
//
TRACE:C157
C_LONGINT:C283($doOpt)
If (Count parameters:C259=0)
	$doOpt:=0
Else 
	$doOpt:=$1
End if 
Case of 
	: ([PopUp:23]arrayName:3="<>aContactsProfile1")  // ### jwm ### 20171110_1543 added <>aContactsProfiles
		Txt_FieldDistin(->[Contact:13]; ->[Contact:13]profile1:18; $doOpt)
	: ([PopUp:23]arrayName:3="<>aContactsProfile2")
		Txt_FieldDistin(->[Contact:13]; ->[Contact:13]profile2:19; $doOpt)
	: ([PopUp:23]arrayName:3="<>aContactsProfile3")
		Txt_FieldDistin(->[Contact:13]; ->[Contact:13]profile3:20; $doOpt)
	: ([PopUp:23]arrayName:3="<>aContactsProfile4")
		Txt_FieldDistin(->[Contact:13]; ->[Contact:13]profile4:21; $doOpt)
	: ([PopUp:23]arrayName:3="<>aContactsProfile5")
		Txt_FieldDistin(->[Contact:13]; ->[Contact:13]profile5:22; $doOpt)
	: ([PopUp:23]arrayName:3="<>aTypeSale")
		Txt_FieldDistin(->[Customer:2]; ->[Customer:2]typeSale:18; $doOpt)
	: ([PopUp:23]arrayName:3="<>aProspect")
		Txt_FieldDistin(->[Customer:2]; ->[Customer:2]prospect:17; $doOpt)
	: ([PopUp:23]arrayName:3="<>aNeed")
		Txt_FieldDistin(->[Customer:2]; ->[Customer:2]need:21; $doOpt)
	: ([PopUp:23]arrayName:3="<>aRank")
		Txt_FieldDistin(->[Customer:2]; ->[Customer:2]rank:131; $doOpt)
	: ([PopUp:23]arrayName:3="<>aProfile1")
		Txt_FieldDistin(->[Customer:2]; ->[Customer:2]profile1:26; $doOpt)
	: ([PopUp:23]arrayName:3="<>aProfile2")
		Txt_FieldDistin(->[Customer:2]; ->[Customer:2]profile2:27; $doOpt)
	: ([PopUp:23]arrayName:3="<>aProfile3")
		Txt_FieldDistin(->[Customer:2]; ->[Customer:2]profile3:28; $doOpt)
	: ([PopUp:23]arrayName:3="<>aProfile4")
		Txt_FieldDistin(->[Customer:2]; ->[Customer:2]profile4:29; $doOpt)
	: ([PopUp:23]arrayName:3="<>aProfile5")
		Txt_FieldDistin(->[Customer:2]; ->[Customer:2]profile5:30; $doOpt)
		//: ([PopUp]ArrayName="<>aReasons")
		//Txt_FieldDistin ([dInventory];[dInventory]Reason;$doOpt)
		//: ([PopUp]ArrayName="<>aJobType")
		//Txt_FieldDistin ([Employee];[Employee]JobType;$doOpt)
	: ([PopUp:23]arrayName:3="<>aActions")
		Txt_FieldDistin(->[Customer:2]; ->[Customer:2]action:60; $doOpt)
	: ([PopUp:23]arrayName:3="<>aNoteType")
		
		//: ([PopUp]ArrayName="<>aSalutation")
		//Txt_FieldDistin ([Contact];[Contact]Salutation;$doOpt)
	: ([PopUp:23]arrayName:3="<>aProposalsStatus")
		Txt_FieldDistin(->[Proposal:42]; ->[Proposal:42]status:2; $doOpt)
	: ([PopUp:23]arrayName:3="<>aStatus")
		Txt_FieldDistin(->[Order:3]; ->[Order:3]status:59; $doOpt)
	: ([PopUp:23]arrayName:3="<>aActivities")
		Txt_FieldDistin(->[WorkOrder:66]; ->[WorkOrder:66]activity:7; $doOpt)
	: ([PopUp:23]arrayName:3="<>aItemXRefsAction")
		Txt_FieldDistin(->[ItemXRef:22]; ->[ItemXRef:22]action:15; $doOpt)
	: ([PopUp:23]arrayName:3="<>aConsign")
		Txt_FieldDistin(->[Invoice:26]; ->[Invoice:26]consignment:63; $doOpt)
		//: ([PopUp]ArrayName="<>aFOB")
		//Txt_FieldDistin ([Order];[Order]FOB;$doOpt)
	: ([PopUp:23]arrayName:3="<>aPOsStatus")
		Txt_FieldDistin(->[Customer:2]; ->[Customer:2]prospect:17; $doOpt)
		//: ([PopUp]ArrayName="<>aPOsProfile1")
		//Txt_FieldDistin ([PO];[PO]Profile1;$doOpt)
		//: ([PopUp]ArrayName="<>aPOsProfile2")
		//Txt_FieldDistin ([PO];[PO]Profile2;$doOpt)
		//: ([PopUp]ArrayName="<>aPOsProfile3")
		//Txt_FieldDistin ([PO];[PO]Profile3;$doOpt)
		//: ([PopUp]ArrayName="<>aOrdersProfile1")
		//Txt_FieldDistin ([Order];[Order]Profile1;$doOpt)
		//: ([PopUp]ArrayName="<>aOrdersProfile2")
		//Txt_FieldDistin ([Order];[Order]Profile2;$doOpt)
		//: ([PopUp]ArrayName="<>aOrdersProfile3")
		//Txt_FieldDistin ([Order];[Order]Profile3;$doOpt)
	: ([PopUp:23]arrayName:3="<>aItemsType")
		Txt_FieldDistin(->[Item:4]; ->[Item:4]typeid:26; $doOpt)
	: ([PopUp:23]arrayName:3="<>aItemsProfile1")
		Txt_FieldDistin(->[Item:4]; ->[Item:4]profile1:35; $doOpt)
	: ([PopUp:23]arrayName:3="<>aItemsProfile2")
		Txt_FieldDistin(->[Item:4]; ->[Item:4]profile2:36; $doOpt)
	: ([PopUp:23]arrayName:3="<>aItemsProfile3")
		Txt_FieldDistin(->[Item:4]; ->[Item:4]profile3:37; $doOpt)
	: ([PopUp:23]arrayName:3="<>aItemsProfile4")
		Txt_FieldDistin(->[Item:4]; ->[Item:4]profile4:38; $doOpt)
		//: ([PopUp]ArrayName="<>aItemSpecProfile1")
		//Txt_FieldDistin ([ItemSpec];[ItemSpec]Profile1;$doOpt)
		//: ([PopUp]ArrayName="<>aItemSpecProfile2")
		//Txt_FieldDistin ([ItemSpec];[ItemSpec]Profile2;$doOpt)
		//: ([PopUp]ArrayName="<>aItemSpecProfile3")
		//Txt_FieldDistin ([ItemSpec];[ItemSpec]Profile3;$doOpt)
		//: ([PopUp]ArrayName="<>aItemSpecProfile4")
		//Txt_FieldDistin ([ItemSpec];[ItemSpec]Profile4;$doOpt)
		//: ([PopUp]ArrayName="<>aItemSpecProfile5")
		//Txt_FieldDistin ([ItemSpec];[ItemSpec]Profile5;$doOpt)
		//: ([PopUp]ArrayName="<>aItemSpecProfile6")
		//Txt_FieldDistin ([ItemSpec];[ItemSpec]Profile6;$doOpt)
		//: ([PopUp]ArrayName="<>aItemSpecProfile7")
		//Txt_FieldDistin ([ItemSpec];[ItemSpec]Profile7;$doOpt)
		//: ([PopUp]ArrayName="<>aItemSpecProfile8")
		//Txt_FieldDistin ([ItemSpec];[ItemSpec]Profile8;$doOpt)
		//: ([PopUp]ArrayName="<>aItemSpecProfile9")
		//Txt_FieldDistin ([ItemSpec];[ItemSpec]Profile9;$doOpt)
		//: ([PopUp]ArrayName="<>aItemSpecProfile10")
		//Txt_FieldDistin ([ItemSpec];[ItemSpec]Profile10;$doOpt)
		//: ([PopUp]ArrayName="<>aItemSpecProfile11")
		//Txt_FieldDistin ([ItemSpec];[ItemSpec]Profile11;$doOpt)
		//: ([PopUp]ArrayName="<>aItemSpecProfile12")
		//Txt_FieldDistin ([ItemSpec];[ItemSpec]Profile12;$doOpt)
		//: ([PopUp]ArrayName="<>aItemSpecProfile13")
		//Txt_FieldDistin ([ItemSpec];[ItemSpec]Profile13;$doOpt)
		//: ([PopUp]ArrayName="<>aItemSpecProfile14")
		//Txt_FieldDistin ([ItemSpec];[ItemSpec]Profile14;$doOpt)
		//: ([PopUp]ArrayName="<>aItemSpecProfile15")
		//Txt_FieldDistin ([ItemSpec];[ItemSpec]Profile15;$doOpt)
		//: ([PopUp]ArrayName="<>aItemSpecProfile16")
		//Txt_FieldDistin ([ItemSpec];[ItemSpec]Profile16;$doOpt)
		//: ([PopUp]ArrayName="<>aItemSpecProfile17")
		//Txt_FieldDistin ([ItemSpec];[ItemSpec]Profile17;$doOpt)
		//: ([PopUp]ArrayName="<>aItemSpecProfile18")
		//Txt_FieldDistin ([ItemSpec];[ItemSpec]Profile18;$doOpt)
		//: ([PopUp]ArrayName="<>aItemSpecProfile19")
		//Txt_FieldDistin ([ItemSpec];[ItemSpec]Profile19;$doOpt)
		//: ([PopUp]ArrayName="<>aItemSpecProfile20")
		//Txt_FieldDistin ([ItemSpec];[ItemSpec]Profile20;$doOpt)
		//: ([PopUp]ArrayName="<>aItemSpecProfile21")
		//Txt_FieldDistin ([ItemSpec];[ItemSpec]Profile21;$doOpt)
	: ([PopUp:23]arrayName:3="<>aFilCustPro")
		//BEEP
	: ([PopUp:23]arrayName:3="<>aFilPpPro")
		//BEEP
	: ([PopUp:23]arrayName:3="<>aFilPoPro")
		//BEEP
	: ([PopUp:23]arrayName:3="<>aFilInvPro")
		//BEEP
	: ([PopUp:23]arrayName:3="<>aFilOrdPro")
		//BEEP
	: ([PopUp:23]arrayName:3="<>aFilVdPro")
		//BEEP
	: ([PopUp:23]arrayName:3="<>aRequisitionsProfile1")
		Txt_FieldDistin(->[Requisition:83]; ->[Requisition:83]profile1:26; $doOpt)
	: ([PopUp:23]arrayName:3="<>aRequisitionsProfile2")
		Txt_FieldDistin(->[Requisition:83]; ->[Requisition:83]profile2:27; $doOpt)
	: ([PopUp:23]arrayName:3="<>aRequisitionsProfile3")
		Txt_FieldDistin(->[Requisition:83]; ->[Requisition:83]profile3:28; $doOpt)
	: ([PopUp:23]arrayName:3="<>aRequisitionsProfile4")
		Txt_FieldDistin(->[Requisition:83]; ->[Requisition:83]profile4:29; $doOpt)
	: ([PopUp:23]arrayName:3="<>aRequisitionsStatus")
		Txt_FieldDistin(->[Requisition:83]; ->[Requisition:83]status:47; $doOpt)
	: ([PopUp:23]arrayName:3="<>aRequisitionsAction")
		Txt_FieldDistin(->[Requisition:83]; ->[Requisition:83]action:10; $doOpt)
	: ([PopUp:23]arrayName:3="<>aWOdrawsStatus")
		Txt_FieldDistin(->[WOdraw:68]; ->[WOdraw:68]status:9; $doOpt)
End case 