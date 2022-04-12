//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 04/24/21, 00:37:32
// ----------------------------------------------------
// Method: SelectList_Declare
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_TEXT:C284($0)
If (False:C215)
	ARRAY TEXT:C222(<>aActions; Size of array:C274(<>aActions))
	ARRAY TEXT:C222(<>aActionsContacts; Size of array:C274(<>aActionsContacts))
	ARRAY TEXT:C222(<>aActionsInvoices; Size of array:C274(<>aActionsInvoices))
	ARRAY TEXT:C222(<>aActionsOrders; Size of array:C274(<>aActionsOrders))
	ARRAY TEXT:C222(<>aActionsPOs; Size of array:C274(<>aActionsPOs))
	ARRAY TEXT:C222(<>aActionsProjects; Size of array:C274(<>aActionsProjects))
	ARRAY TEXT:C222(<>aActionsProposals; Size of array:C274(<>aActionsProposals))
	ARRAY TEXT:C222(<>aActionsVendors; Size of array:C274(<>aActionsVendors))
	ARRAY TEXT:C222(<>aActionsWorkOrders; Size of array:C274(<>aActionsWorkOrders))
	ARRAY TEXT:C222(<>aActivities; Size of array:C274(<>aActivities))
	ARRAY TEXT:C222(<>aBillInstructions; Size of array:C274(<>aBillInstructions))
	ARRAY TEXT:C222(<>aCommoDeviceType; Size of array:C274(<>aCommoDeviceType))
	ARRAY TEXT:C222(<>aConsign; Size of array:C274(<>aConsign))
	ARRAY TEXT:C222(<>aCountryList; Size of array:C274(<>aCountryList))
	ARRAY TEXT:C222(<>aCustomersPO; Size of array:C274(<>aCustomersPO))
	ARRAY TEXT:C222(<>aFilCustPro; Size of array:C274(<>aFilCustPro))
	ARRAY TEXT:C222(<>aFilInvPro; Size of array:C274(<>aFilInvPro))
	ARRAY TEXT:C222(<>aFilOrdPro; Size of array:C274(<>aFilOrdPro))
	ARRAY TEXT:C222(<>aFilPoPro; Size of array:C274(<>aFilPoPro))
	ARRAY TEXT:C222(<>aFilPpPro; Size of array:C274(<>aFilPpPro))
	ARRAY TEXT:C222(<>aFilVdPro; Size of array:C274(<>aFilVdPro))
	ARRAY TEXT:C222(<>aFOB; Size of array:C274(<>aFOB))
	ARRAY TEXT:C222(<>aItemsClass; Size of array:C274(<>aItemsClass))
	ARRAY TEXT:C222(<>aItemSpecProfile1; Size of array:C274(<>aItemSpecProfile1))
	ARRAY TEXT:C222(<>aItemSpecProfile10; Size of array:C274(<>aItemSpecProfile10))
	ARRAY TEXT:C222(<>aItemSpecProfile11; Size of array:C274(<>aItemSpecProfile11))
	ARRAY TEXT:C222(<>aItemSpecProfile12; Size of array:C274(<>aItemSpecProfile12))
	ARRAY TEXT:C222(<>aItemSpecProfile13; Size of array:C274(<>aItemSpecProfile13))
	ARRAY TEXT:C222(<>aItemSpecProfile14; Size of array:C274(<>aItemSpecProfile14))
	ARRAY TEXT:C222(<>aItemSpecProfile15; Size of array:C274(<>aItemSpecProfile15))
	ARRAY TEXT:C222(<>aItemSpecProfile16; Size of array:C274(<>aItemSpecProfile16))
	ARRAY TEXT:C222(<>aItemSpecProfile17; Size of array:C274(<>aItemSpecProfile17))
	ARRAY TEXT:C222(<>aItemSpecProfile18; Size of array:C274(<>aItemSpecProfile18))
	ARRAY TEXT:C222(<>aItemSpecProfile19; Size of array:C274(<>aItemSpecProfile19))
	ARRAY TEXT:C222(<>aItemSpecProfile2; Size of array:C274(<>aItemSpecProfile2))
	ARRAY TEXT:C222(<>aItemSpecProfile20; Size of array:C274(<>aItemSpecProfile20))
	ARRAY TEXT:C222(<>aItemSpecProfile21; Size of array:C274(<>aItemSpecProfile21))
	ARRAY TEXT:C222(<>aItemSpecProfile3; Size of array:C274(<>aItemSpecProfile3))
	ARRAY TEXT:C222(<>aItemSpecProfile4; Size of array:C274(<>aItemSpecProfile4))
	ARRAY TEXT:C222(<>aItemSpecProfile5; Size of array:C274(<>aItemSpecProfile5))
	ARRAY TEXT:C222(<>aItemSpecProfile6; Size of array:C274(<>aItemSpecProfile6))
	ARRAY TEXT:C222(<>aItemSpecProfile7; Size of array:C274(<>aItemSpecProfile7))
	ARRAY TEXT:C222(<>aItemSpecProfile8; Size of array:C274(<>aItemSpecProfile8))
	ARRAY TEXT:C222(<>aItemSpecProfile9; Size of array:C274(<>aItemSpecProfile9))
	ARRAY TEXT:C222(<>aItemsProfile1; Size of array:C274(<>aItemsProfile1))
	ARRAY TEXT:C222(<>aItemsProfile1Alt; Size of array:C274(<>aItemsProfile1Alt))
	ARRAY TEXT:C222(<>aItemsProfile2; Size of array:C274(<>aItemsProfile2))
	ARRAY TEXT:C222(<>aItemsProfile3; Size of array:C274(<>aItemsProfile3))
	ARRAY TEXT:C222(<>aItemsProfile4; Size of array:C274(<>aItemsProfile4))
	ARRAY TEXT:C222(<>aItemsProfile5; Size of array:C274(<>aItemsProfile5))
	ARRAY TEXT:C222(<>aItemsProfile6; Size of array:C274(<>aItemsProfile6))
	ARRAY TEXT:C222(<>aItemsType; Size of array:C274(<>aItemsType))
	ARRAY TEXT:C222(<>aItemsTypeAlt; Size of array:C274(<>aItemsTypeAlt))
	ARRAY TEXT:C222(<>aItemXRefsAction; Size of array:C274(<>aItemXRefsAction))
	ARRAY TEXT:C222(<>aJobType; Size of array:C274(<>aJobType))
	ARRAY TEXT:C222(<>aNeed; Size of array:C274(<>aNeed))
	ARRAY TEXT:C222(<>aNoteType; Size of array:C274(<>aNoteType))
	ARRAY TEXT:C222(<>aOrdersProfile1; Size of array:C274(<>aOrdersProfile1))
	ARRAY TEXT:C222(<>aOrdersProfile2; Size of array:C274(<>aOrdersProfile2))
	ARRAY TEXT:C222(<>aOrdersProfile3; Size of array:C274(<>aOrdersProfile3))
	ARRAY TEXT:C222(<>aPayAction; Size of array:C274(<>aPayAction))
	ARRAY TEXT:C222(<>aPOsProfile1; Size of array:C274(<>aPOsProfile1))
	ARRAY TEXT:C222(<>aPOsProfile2; Size of array:C274(<>aPOsProfile2))
	ARRAY TEXT:C222(<>aPOsProfile3; Size of array:C274(<>aPOsProfile3))
	ARRAY TEXT:C222(<>aPOsStatus; Size of array:C274(<>aPOsStatus))
	ARRAY TEXT:C222(<>aPriorities; Size of array:C274(<>aPriorities))
	ARRAY TEXT:C222(<>aProfile1; Size of array:C274(<>aProfile1))
	ARRAY TEXT:C222(<>aProfile2; Size of array:C274(<>aProfile2))
	ARRAY TEXT:C222(<>aProfile3; Size of array:C274(<>aProfile3))
	ARRAY TEXT:C222(<>aProfile4; Size of array:C274(<>aProfile4))
	ARRAY TEXT:C222(<>aProfile5; Size of array:C274(<>aProfile5))
	ARRAY TEXT:C222(<>aProfile6; Size of array:C274(<>aProfile6))
	ARRAY TEXT:C222(<>aProfile7; Size of array:C274(<>aProfile7))
	ARRAY TEXT:C222(<>aProposalsStatus; Size of array:C274(<>aProposalsStatus))
	ARRAY TEXT:C222(<>aProspect; Size of array:C274(<>aProspect))
	ARRAY TEXT:C222(<>aRank; Size of array:C274(<>aRank))
	ARRAY TEXT:C222(<>aReasons; Size of array:C274(<>aReasons))
	ARRAY TEXT:C222(<>aRepsProfile1; Size of array:C274(<>aRepsProfile1))
	ARRAY TEXT:C222(<>aRepsProfile2; Size of array:C274(<>aRepsProfile2))
	ARRAY TEXT:C222(<>aRepsProfile3; Size of array:C274(<>aRepsProfile3))
	ARRAY TEXT:C222(<>aRepsProfile4; Size of array:C274(<>aRepsProfile4))
	ARRAY TEXT:C222(<>aRepsProfile5; Size of array:C274(<>aRepsProfile5))
	ARRAY TEXT:C222(<>aRequisitionsAction; Size of array:C274(<>aRequisitionsAction))
	ARRAY TEXT:C222(<>aRequisitionsProfile1; Size of array:C274(<>aRequisitionsProfile1))
	ARRAY TEXT:C222(<>aRequisitionsProfile2; Size of array:C274(<>aRequisitionsProfile2))
	ARRAY TEXT:C222(<>aRequisitionsProfile3; Size of array:C274(<>aRequisitionsProfile3))
	ARRAY TEXT:C222(<>aRequisitionsProfile4; Size of array:C274(<>aRequisitionsProfile4))
	ARRAY TEXT:C222(<>aRequisitionsStatus; Size of array:C274(<>aRequisitionsStatus))
	ARRAY TEXT:C222(<>aSalutation; Size of array:C274(<>aSalutation))
	ARRAY TEXT:C222(<>aSector; Size of array:C274(<>aSector))
	ARRAY TEXT:C222(<>aServiceProfile1; Size of array:C274(<>aServiceProfile1))
	ARRAY TEXT:C222(<>aServiceProfile2; Size of array:C274(<>aServiceProfile2))
	ARRAY TEXT:C222(<>aServiceProfile3; Size of array:C274(<>aServiceProfile3))
	ARRAY TEXT:C222(<>aServiceProfile4; Size of array:C274(<>aServiceProfile4))
	ARRAY TEXT:C222(<>aServiceReference; Size of array:C274(<>aServiceReference))
	ARRAY TEXT:C222(<>aStateList; Size of array:C274(<>aStateList))
	ARRAY TEXT:C222(<>aStatus; Size of array:C274(<>aStatus))
	ARRAY TEXT:C222(<>atProfiles_Contacts; Size of array:C274(<>atProfiles_Contacts))
	ARRAY TEXT:C222(<>atProfiles_Customers; Size of array:C274(<>atProfiles_Customers))
	ARRAY TEXT:C222(<>atProfiles_Invoices; Size of array:C274(<>atProfiles_Invoices))
	ARRAY TEXT:C222(<>atProfiles_Items; Size of array:C274(<>atProfiles_Items))
	ARRAY TEXT:C222(<>atProfiles_Orders; Size of array:C274(<>atProfiles_Orders))
	ARRAY TEXT:C222(<>aTQStatus; Size of array:C274(<>aTQStatus))
	ARRAY TEXT:C222(<>aTypeSale; Size of array:C274(<>aTypeSale))
	ARRAY TEXT:C222(<>aVendorsProfile1; Size of array:C274(<>aVendorsProfile1))
	ARRAY TEXT:C222(<>aVendorsProfile2; Size of array:C274(<>aVendorsProfile2))
	ARRAY TEXT:C222(<>aVendorsProfile3; Size of array:C274(<>aVendorsProfile3))
	ARRAY TEXT:C222(<>aVendorsProfile4; Size of array:C274(<>aVendorsProfile4))
	ARRAY TEXT:C222(<>aVendorsProfile5; Size of array:C274(<>aVendorsProfile5))
	ARRAY TEXT:C222(<>aVendorsProfile6; Size of array:C274(<>aVendorsProfile6))
	ARRAY TEXT:C222(<>aVendorsProfile7; Size of array:C274(<>aVendorsProfile7))
	ARRAY TEXT:C222(<>aWOdrawsStatus; Size of array:C274(<>aWOdrawsStatus))
	ARRAY TEXT:C222(<>aWorkOrdersProfile1; Size of array:C274(<>aWorkOrdersProfile1))
	ARRAY TEXT:C222(<>aWorkOrdersProfile2; Size of array:C274(<>aWorkOrdersProfile2))
	ARRAY TEXT:C222(<>aWorkOrdersProfile3; Size of array:C274(<>aWorkOrdersProfile3))
	ARRAY TEXT:C222(<>aWorkOrdersProfile4; Size of array:C274(<>aWorkOrdersProfile4))
	ARRAY TEXT:C222(<>aWorkOrdersStatus; Size of array:C274(<>aWorkOrdersStatus))
End if 

ARRAY TEXT:C222(<>aActions; 0)
C_TEXT:C284(<>vActions)
ARRAY TEXT:C222(<>aActionsContacts; 0)
C_TEXT:C284(<>vActionsContacts)
ARRAY TEXT:C222(<>aActionsInvoices; 0)
C_TEXT:C284(<>vActionsInvoices)
ARRAY TEXT:C222(<>aActionsOrders; 0)
C_TEXT:C284(<>vActionsOrders)
ARRAY TEXT:C222(<>aActionsPOs; 0)
C_TEXT:C284(<>vActionsPOs)
ARRAY TEXT:C222(<>aActionsProjects; 0)
C_TEXT:C284(<>vActionsProjects)
ARRAY TEXT:C222(<>aActionsProposals; 0)
C_TEXT:C284(<>vActionsProposals)
ARRAY TEXT:C222(<>aActionsVendors; 0)
C_TEXT:C284(<>vActionsVendors)
ARRAY TEXT:C222(<>aActionsWorkOrders; 0)
C_TEXT:C284(<>vActionsWorkOrders)
ARRAY TEXT:C222(<>aActivities; 0)
C_TEXT:C284(<>vActivities)
ARRAY TEXT:C222(<>aBillInstructions; 0)
C_TEXT:C284(<>vBillInstructions)
ARRAY TEXT:C222(<>aCommoDeviceType; 0)
C_TEXT:C284(<>vCommoDeviceType)
ARRAY TEXT:C222(<>aConsign; 0)
C_TEXT:C284(<>vConsign)
ARRAY TEXT:C222(<>aCountryList; 0)
C_TEXT:C284(<>vCountryList)
ARRAY TEXT:C222(<>aCustomersPO; 0)
C_TEXT:C284(<>vCustomersPO)
ARRAY TEXT:C222(<>aFilCustPro; 0)
C_TEXT:C284(<>vFilCustPro)
ARRAY TEXT:C222(<>aFilInvPro; 0)
C_TEXT:C284(<>vFilInvPro)
ARRAY TEXT:C222(<>aFilOrdPro; 0)
C_TEXT:C284(<>vFilOrdPro)
ARRAY TEXT:C222(<>aFilPoPro; 0)
C_TEXT:C284(<>vFilPoPro)
ARRAY TEXT:C222(<>aFilPpPro; 0)
C_TEXT:C284(<>vFilPpPro)
ARRAY TEXT:C222(<>aFilVdPro; 0)
C_TEXT:C284(<>vFilVdPro)
ARRAY TEXT:C222(<>aFOB; 0)
C_TEXT:C284(<>vFOB)
ARRAY TEXT:C222(<>aItemsClass; 0)
C_TEXT:C284(<>vItemsClass)
ARRAY TEXT:C222(<>aItemSpecProfile1; 0)
C_TEXT:C284(<>vItemSpecProfile1)
ARRAY TEXT:C222(<>aItemSpecProfile10; 0)
C_TEXT:C284(<>vItemSpecProfile10)
ARRAY TEXT:C222(<>aItemSpecProfile11; 0)
C_TEXT:C284(<>vItemSpecProfile11)
ARRAY TEXT:C222(<>aItemSpecProfile12; 0)
C_TEXT:C284(<>vItemSpecProfile12)
ARRAY TEXT:C222(<>aItemSpecProfile13; 0)
C_TEXT:C284(<>vItemSpecProfile13)
ARRAY TEXT:C222(<>aItemSpecProfile14; 0)
C_TEXT:C284(<>vItemSpecProfile14)
ARRAY TEXT:C222(<>aItemSpecProfile15; 0)
C_TEXT:C284(<>vItemSpecProfile15)
ARRAY TEXT:C222(<>aItemSpecProfile16; 0)
C_TEXT:C284(<>vItemSpecProfile16)
ARRAY TEXT:C222(<>aItemSpecProfile17; 0)
C_TEXT:C284(<>vItemSpecProfile17)
ARRAY TEXT:C222(<>aItemSpecProfile18; 0)
C_TEXT:C284(<>vItemSpecProfile18)
ARRAY TEXT:C222(<>aItemSpecProfile19; 0)
C_TEXT:C284(<>vItemSpecProfile19)
ARRAY TEXT:C222(<>aItemSpecProfile2; 0)
C_TEXT:C284(<>vItemSpecProfile2)
ARRAY TEXT:C222(<>aItemSpecProfile20; 0)
C_TEXT:C284(<>vItemSpecProfile20)
ARRAY TEXT:C222(<>aItemSpecProfile21; 0)
C_TEXT:C284(<>vItemSpecProfile21)
ARRAY TEXT:C222(<>aItemSpecProfile3; 0)
C_TEXT:C284(<>vItemSpecProfile3)
ARRAY TEXT:C222(<>aItemSpecProfile4; 0)
C_TEXT:C284(<>vItemSpecProfile4)
ARRAY TEXT:C222(<>aItemSpecProfile5; 0)
C_TEXT:C284(<>vItemSpecProfile5)
ARRAY TEXT:C222(<>aItemSpecProfile6; 0)
C_TEXT:C284(<>vItemSpecProfile6)
ARRAY TEXT:C222(<>aItemSpecProfile7; 0)
C_TEXT:C284(<>vItemSpecProfile7)
ARRAY TEXT:C222(<>aItemSpecProfile8; 0)
C_TEXT:C284(<>vItemSpecProfile8)
ARRAY TEXT:C222(<>aItemSpecProfile9; 0)
C_TEXT:C284(<>vItemSpecProfile9)
ARRAY TEXT:C222(<>aItemsProfile1; 0)
C_TEXT:C284(<>vItemsProfile1)
ARRAY TEXT:C222(<>aItemsProfile1Alt; 0)
C_TEXT:C284(<>vItemsProfile1Alt)
ARRAY TEXT:C222(<>aItemsProfile2; 0)
C_TEXT:C284(<>vItemsProfile2)
ARRAY TEXT:C222(<>aItemsProfile3; 0)
C_TEXT:C284(<>vItemsProfile3)
ARRAY TEXT:C222(<>aItemsProfile4; 0)
C_TEXT:C284(<>vItemsProfile4)
ARRAY TEXT:C222(<>aItemsProfile5; 0)
C_TEXT:C284(<>vItemsProfile5)
ARRAY TEXT:C222(<>aItemsProfile6; 0)
C_TEXT:C284(<>vItemsProfile6)
ARRAY TEXT:C222(<>aItemsType; 0)
C_TEXT:C284(<>vItemsType)
ARRAY TEXT:C222(<>aItemsTypeAlt; 0)
C_TEXT:C284(<>vItemsTypeAlt)
ARRAY TEXT:C222(<>aItemXRefsAction; 0)
C_TEXT:C284(<>vItemXRefsAction)
ARRAY TEXT:C222(<>aJobType; 0)
C_TEXT:C284(<>vJobType)
ARRAY TEXT:C222(<>aNeed; 0)
C_TEXT:C284(<>vNeed)
ARRAY TEXT:C222(<>aNoteType; 0)
C_TEXT:C284(<>vNoteType)
ARRAY TEXT:C222(<>aOrdersProfile1; 0)
C_TEXT:C284(<>vOrdersProfile1)
ARRAY TEXT:C222(<>aOrdersProfile2; 0)
C_TEXT:C284(<>vOrdersProfile2)
ARRAY TEXT:C222(<>aOrdersProfile3; 0)
C_TEXT:C284(<>vOrdersProfile3)
ARRAY TEXT:C222(<>aPayAction; 0)
C_TEXT:C284(<>vPayAction)
ARRAY TEXT:C222(<>aPOsProfile1; 0)
C_TEXT:C284(<>vPOsProfile1)
ARRAY TEXT:C222(<>aPOsProfile2; 0)
C_TEXT:C284(<>vPOsProfile2)
ARRAY TEXT:C222(<>aPOsProfile3; 0)
C_TEXT:C284(<>vPOsProfile3)
ARRAY TEXT:C222(<>aPOsStatus; 0)
C_TEXT:C284(<>vPOsStatus)
ARRAY TEXT:C222(<>aPriorities; 0)
C_TEXT:C284(<>vPriorities)
ARRAY TEXT:C222(<>aProfile1; 0)
C_TEXT:C284(<>vProfile1)
ARRAY TEXT:C222(<>aProfile2; 0)
C_TEXT:C284(<>vProfile2)
ARRAY TEXT:C222(<>aProfile3; 0)
C_TEXT:C284(<>vProfile3)
ARRAY TEXT:C222(<>aProfile4; 0)
C_TEXT:C284(<>vProfile4)
ARRAY TEXT:C222(<>aProfile5; 0)
C_TEXT:C284(<>vProfile5)
ARRAY TEXT:C222(<>aProfile6; 0)
C_TEXT:C284(<>vProfile6)
ARRAY TEXT:C222(<>aProfile7; 0)
C_TEXT:C284(<>vProfile7)
ARRAY TEXT:C222(<>aProposalsStatus; 0)
C_TEXT:C284(<>vProposalsStatus)
ARRAY TEXT:C222(<>aProspect; 0)
C_TEXT:C284(<>vProspect)
ARRAY TEXT:C222(<>aRank; 0)
C_TEXT:C284(<>vRank)
ARRAY TEXT:C222(<>aReasons; 0)
C_TEXT:C284(<>vReasons)
ARRAY TEXT:C222(<>aRepsProfile1; 0)
C_TEXT:C284(<>vRepsProfile1)
ARRAY TEXT:C222(<>aRepsProfile2; 0)
C_TEXT:C284(<>vRepsProfile2)
ARRAY TEXT:C222(<>aRepsProfile3; 0)
C_TEXT:C284(<>vRepsProfile3)
ARRAY TEXT:C222(<>aRepsProfile4; 0)
C_TEXT:C284(<>vRepsProfile4)
ARRAY TEXT:C222(<>aRepsProfile5; 0)
C_TEXT:C284(<>vRepsProfile5)
ARRAY TEXT:C222(<>aRequisitionsAction; 0)
C_TEXT:C284(<>vRequisitionsAction)
ARRAY TEXT:C222(<>aRequisitionsProfile1; 0)
C_TEXT:C284(<>vRequisitionsProfile1)
ARRAY TEXT:C222(<>aRequisitionsProfile2; 0)
C_TEXT:C284(<>vRequisitionsProfile2)
ARRAY TEXT:C222(<>aRequisitionsProfile3; 0)
C_TEXT:C284(<>vRequisitionsProfile3)
ARRAY TEXT:C222(<>aRequisitionsProfile4; 0)
C_TEXT:C284(<>vRequisitionsProfile4)
ARRAY TEXT:C222(<>aRequisitionsStatus; 0)
C_TEXT:C284(<>vRequisitionsStatus)
ARRAY TEXT:C222(<>aSalutation; 0)
C_TEXT:C284(<>vSalutation)
ARRAY TEXT:C222(<>aSector; 0)
C_TEXT:C284(<>vSector)
ARRAY TEXT:C222(<>aServiceProfile1; 0)
C_TEXT:C284(<>vServiceProfile1)
ARRAY TEXT:C222(<>aServiceProfile2; 0)
C_TEXT:C284(<>vServiceProfile2)
ARRAY TEXT:C222(<>aServiceProfile3; 0)
C_TEXT:C284(<>vServiceProfile3)
ARRAY TEXT:C222(<>aServiceProfile4; 0)
C_TEXT:C284(<>vServiceProfile4)
ARRAY TEXT:C222(<>aServiceReference; 0)
C_TEXT:C284(<>vServiceReference)
ARRAY TEXT:C222(<>aStateList; 0)
C_TEXT:C284(<>vStateList)
ARRAY TEXT:C222(<>aStatus; 0)
C_TEXT:C284(<>vStatus)
ARRAY TEXT:C222(<>atProfiles_Contacts; 0)
C_TEXT:C284(<>vtProfiles_Contacts)
ARRAY TEXT:C222(<>atProfiles_Customers; 0)
C_TEXT:C284(<>vtProfiles_Customers)
ARRAY TEXT:C222(<>atProfiles_Invoices; 0)
C_TEXT:C284(<>vtProfiles_Invoices)
ARRAY TEXT:C222(<>atProfiles_Items; 0)
C_TEXT:C284(<>vtProfiles_Items)
ARRAY TEXT:C222(<>atProfiles_Orders; 0)
C_TEXT:C284(<>vtProfiles_Orders)
ARRAY TEXT:C222(<>aTQStatus; 0)
C_TEXT:C284(<>vTQStatus)
ARRAY TEXT:C222(<>aTypeSale; 0)

ARRAY TEXT:C222(<>aVendorsProfile1; 0)
C_TEXT:C284(<>vVendorsProfile1)
ARRAY TEXT:C222(<>aVendorsProfile2; 0)
C_TEXT:C284(<>vVendorsProfile2)
ARRAY TEXT:C222(<>aVendorsProfile3; 0)
C_TEXT:C284(<>vVendorsProfile3)
ARRAY TEXT:C222(<>aVendorsProfile4; 0)
C_TEXT:C284(<>vVendorsProfile4)
ARRAY TEXT:C222(<>aVendorsProfile5; 0)
C_TEXT:C284(<>vVendorsProfile5)
ARRAY TEXT:C222(<>aVendorsProfile6; 0)
C_TEXT:C284(<>vVendorsProfile6)
ARRAY TEXT:C222(<>aVendorsProfile7; 0)
C_TEXT:C284(<>vVendorsProfile7)
ARRAY TEXT:C222(<>aWOdrawsStatus; 0)
C_TEXT:C284(<>vWOdrawsStatus)
ARRAY TEXT:C222(<>aWorkOrdersProfile1; 0)
C_TEXT:C284(<>vWorkOrdersProfile1)
ARRAY TEXT:C222(<>aWorkOrdersProfile2; 0)
C_TEXT:C284(<>vWorkOrdersProfile2)
ARRAY TEXT:C222(<>aWorkOrdersProfile3; 0)
C_TEXT:C284(<>vWorkOrdersProfile3)
ARRAY TEXT:C222(<>aWorkOrdersProfile4; 0)
C_TEXT:C284(<>vWorkOrdersProfile4)
ARRAY TEXT:C222(<>aWorkOrdersStatus; 0)
C_TEXT:C284(<>vWorkOrdersStatus)



$0:="aActions,aActionsInvoices,aActionsOrders,aActionsPOs,aActionsProjects,"+\
"aActionsProposals,aActionsVendors,aActionsWorkOrders,aActivities,"+\
"aBillInstructions,aCommoDeviceType,aConsign,aCountryList,aCustomersPO,"+\
"aFilCustPro,aFilInvPro,aFilOrdPro,aFilPoPro,aFilPpPro,aFilVdPro,aFOB,"+\
"aItemsClass,aItemSpecProfile1,aItemSpecProfile10,aItemSpecProfile11,"+\
"aItemSpecProfile12,aItemSpecProfile13,aItemSpecProfile14,aItemSpecProfile15,"+\
"aItemSpecProfile16,aItemSpecPro17,aItemSpecProfile18,aItemSpecProfile19,"+\
"aItemSpecProfile2,aItemSpecProfile20,aItemSpecProfile21,aItemSpecProfile3,"+\
"aItemSpecProfile4,aItemSpecProfile5,aItemSpecProfile6,aItemSpecProfile7,"+\
"aItemSpecProfile8,aItemSpecProfile9,aItemsProfile1,aItemsProfile1Alt,"+\
"aItemsProfile2,aItemsProfile3,aItemsProfile4,aItemsProfile5,aItemsProfile6,"+\
"aItemsType,aItemsTypeAlt,aItemXRefsAction,aJobType,aNeed,aNoteType,"+\
"aOrdersProfile1,aOrdersProfile2,aOrdersProfile3,aPayAction,aPOsProfile1,"+\
"aPOsProfile2,aPOsProfile3,aPOsStatus,aProfile1,aProfile2,aProfile3,"+\
"aProfile4,aProfile5,aProposalsStatus,aProspect,aRank,aReasons,"+\
"aRepsProfile1,aRepsProfile2,aRepsProfile3,aRepsProfile4,aRepsProfile5,aRequisitionsAction,"+\
"aRequisitionsProfile1,aRequisitionsProfile2,aRequisitionsProfile3,"+\
"aRequisitionsProfile4,aRequisitionsStatus,aSalutation,aSector,aServiceProfile1,"+\
"aServiceProfile2,aServiceProfile3,aServiceProfile4,aServiceReference,"+\
"aStateList,aStatus,atProfiles_Contacts,atProfiles_Customers,"+\
"atProfiles_Invoices,atProfiles_Items,atProfiles_Orders,aTQStatus,"+\
"aTypeSale,aVendorsProfile1,aVendorsProfile2,"+\
"aVendorsProfile3,aVendorsProfile4,aVendorsProfile5,aWOdrawsStatus,"+\
"aWorkOrdersProfile1,aWorkOrdersProfile2,aWorkOrdersProfile3,"+\
"aWorkOrdersProfile4"


//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 04/24/21, 00:37:32
// ----------------------------------------------------
// Method: SelectList_Declare
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($0)


$0:="aActions,aActionsInvoices,aActionsOrders,aActionsPOs,aActionsProjects,"+\
"aActionsProposals,aActionsVendors,aActionsWorkOrders,aActivities,"+\
"aBillInstructions,aCommoDeviceType,aConsign,aCountryList,aCustomersPO,"+\
"aFilCustPro,aFilInvPro,aFilOrdPro,aFilPoPro,aFilPpPro,aFilVdPro,aFOB,"+\
"aItemsClass,aItemSpecProfile1,aItemSpecProfile10,aItemSpecProfile11,"+\
"aItemSpecProfile12,aItemSpecProfile13,aItemSpecProfile14,aItemSpecProfile15,"+\
"aItemSpecProfile16,aItemSpecPro17,aItemSpecProfile18,aItemSpecProfile19,"+\
"aItemSpecProfile2,aItemSpecProfile20,aItemSpecProfile21,aItemSpecProfile3,"+\
"aItemSpecProfile4,aItemSpecProfile5,aItemSpecProfile6,aItemSpecProfile7,"+\
"aItemSpecProfile8,aItemSpecProfile9,aItemsProfile1,aItemsProfile1Alt,"+\
"aItemsProfile2,aItemsProfile3,aItemsProfile4,aItemsProfile5,aItemsProfile6,"+\
"aItemsType,aItemsTypeAlt,aItemXRefsAction,aJobType,aNeed,aNoteType,"+\
"aOrdersProfile1,aOrdersProfile2,aOrdersProfile3,aPayAction,aPOsProfile1,"+\
"aPOsProfile2,aPOsProfile3,aPOsStatus,aProfile1,aProfile2,aProfile3,"+\
"aProfile4,aProfile5,aProposalsStatus,aProspect,aRank,aReasons,"+\
"aRepsProfile1,aRepsProfile2,aRepsProfile3,aRepsProfile4,aRepsProfile5,aRequisitionsAction,"+\
"aRequisitionsProfile1,aRequisitionsProfile2,aRequisitionsProfile3,"+\
"aRequisitionsProfile4,aRequisitionsStatus,aSalutation,aSector,aServiceProfile1,"+\
"aServiceProfile2,aServiceProfile3,aServiceProfile4,aServiceReference,"+\
"aStateList,aStatus,atProfiles_Contacts,atProfiles_Customers,"+\
"atProfiles_Invoices,atProfiles_Items,atProfiles_Orders,aTQStatus,"+\
"aVendorsProfile1,aVendorsProfile2,"+\
"aVendorsProfile3,aVendorsProfile4,aVendorsProfile5,aWOdrawsStatus,"+\
"aWorkOrdersProfile1,aWorkOrdersProfile2,aWorkOrdersProfile3,"+\
"aWorkOrdersProfile4"


If (False:C215)  // this is a terrible way to do this
	$0:="aActions,aActionsContacts,aActionsInvoices,aActionsOrders,aActionsPOs,"+\
		"aActionsProjects,aActionsProposals,aActionsVendors,aActionsWorkOrders,"+\
		"aActivities,aBillInstructions,aCommoDeviceType,aConsign,aCountryList,aCustomersPO,"+\
		"aFilCustPro,aFilInvPro,aFilOrdPro,aFilPoPro,aFilPpPro,aFilVdPro,aFOB,aItemsClass,"+\
		"aItemSpecProfile1,aItemSpecProfile10,aItemSpecProfile11,aItemSpecProfile12,"+\
		"aItemSpecProfile13,aItemSpecProfile14,aItemSpecProfile15,aItemSpecProfile16,"+\
		"aItemSpecProfile17,aItemSpecProfile18,aItemSpecProfile19,aItemSpecProfile2,"+\
		"aItemSpecProfile20,aItemSpecProfile21,aItemSpecProfile3,aItemSpecProfile4,"+\
		"aItemSpecProfile5,aItemSpecProfile6,aItemSpecProfile7,aItemSpecProfile8,"+\
		"aItemSpecProfile9,aItemsProfile1,aItemsProfile1Alt,aItemsProfile2,aItemsProfile3,"+\
		"aItemsProfile4,aItemsProfile5,aItemsProfile6,aItemsType,aItemsTypeAlt,aItemXRefsAction,"+\
		"aJobType,aNeed,aNoteType,aOrdersProfile1,aOrdersProfile2,aOrdersProfile3,aPayAction,"+\
		"aPOsProfile1,aPOsProfile2,aPOsProfile3,aPOsStatus,aPriorities,aProfile1,aProfile2,aProfile3,"+\
		"aProfile4,aProfile5,aProfile6,aProfile7,aProposalsStatus,aProspect,aRank,aReasons,"+\
		"aRepsProfile1,aRepsProfile2,aRepsProfile3,aRepsProfile4,aRepsProfile5,"+\
		"aRequisitionsAction,aRequisitionsProfile1,aRequisitionsProfile2,aRequisitionsProfile3,"+\
		"aRequisitionsProfile4,aRequisitionsStatus,aSalutation,aSector,"+\
		"aServiceProfile1,aServiceProfile2,aServiceProfile3,aServiceProfile4,aServiceReference,"+\
		"aStateList,aStatus,atProfiles_Contacts,atProfiles_Customers,atProfiles_Invoices,atProfiles_Items,"+\
		"atProfiles_Orders,aTQStatus,aTypeSale,aVendorsProfile1,aVendorsProfile2,aVendorsProfile3,"+\
		"aVendorsProfile4,aVendorsProfile5,aVendorsProfile6,aVendorsProfile7,aWOdrawsStatus,"+\
		"aWorkOrdersProfile1,aWorkOrdersProfile2,aWorkOrdersProfile3,aWorkOrdersProfile4,aWorkOrdersStatus"
End if 