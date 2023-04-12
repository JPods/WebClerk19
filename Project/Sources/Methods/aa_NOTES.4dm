//%attributes = {}

// Changes Since 16v54:  

// GL_JrnlBOM
// GL2_ConnectedPJ
// GL_JrnlSale
// GL_JrnlCash
// GL2_InsightPJ

// Fixed iLo Customers 9 point font


If (False:C215)  //working
	FixImagePath
	WC_ajaxServer
	jsonToRecord
	jsonValueExtract
	jsonSelectionToObject
	jsonFieldsToObject
	SelectionToJSON
	FixRenumberClones
	WebHelp
	Path_CustomerTask
	
	BootStrapConvert
	// Keywords everywhere
	Key_Search
	Key_CreateRecord
	KeyFindBuildMissing
	KeyPageReadDataTest
	KeyReplaceComponent
	//KeywordClearBad
	
	RelatedByNumberPrs
	
	ParseOrderLines  // add dInventory mechanism
	// no mechanism for deleting a line
End if 


// ### bj ### 20191210_1132
// 2019-11-20
//Input layout Customers, no detail for Call Reports.
// added or changed field names
// [QAQuestion]Sequence
// [QaAnswer]Sequence
// ActionBy and DateAction in Customers, Vendors, Contacts, Big4, WorkOrders
// image testing and loading
// email as a separate process
// json in ScriptEditor

//  needed is a minimum form size on opening. Some input forms are small.


//  gkgkgk autoincrement UniqueID in Maps

// made changes in v15fw but did not move them into this. Review again
// Matched Console_Log procedure
// Counter systems not changed. Review at some point  QQQQ
// CounterNew, CounterRecover, CounterResetPending, Counters_MaxValue
// create a TinyMCE means of doing letters

// blessed merge with JWM synced copies named 15vbe

// 161215  PpLnFillRec  Double check 
// NTHTTPPD_Server added explanation of certs
//  PPLineDelete   Button in input layouts

// 150731  Check EventLogs iLo for loading of text field
//  Deleted shipping page in [Invoice]

// 150430: fixed WCC Invoice quantities.

// 150413:  changed Carriers in jAcceptButton and CloneRecord 

// zzzcheck SpecialDiscounts

// 150413: added Customer, Contacts and Vendor Keywords

//  version ComExzvb 07/11/2014 changed to related popups
// Modified by: William James (2014-06-11T00:00:00 Subrecord eliminated)
//  added discount capabilities to WebTemps must be very careful with this.

// Fixed voiding Orders and Invoices dInventory  20140327

// ALERT("New Line.")  replaced with  a beep
// Modified by: William James (2014-03-28T00:00:00 Subrecord eliminated)



//  [ItemsCarried]Output is missing lables
// [Customer]Output bottom buttons


//  next is itemXref

// Test bottom 

//  ????? fix all of these

// Modified by: William James (2013-10-18T00:00:00)
//  WebClerk color on
//  Set window size default  //WindowSizeSet // gkgkgk removed
//  scale set by default  in //jStartup
// added show list features for items in Ord, Inv, PO, Proposals, QQ
//  added show list fearture in Customer Query

// fixed bug in PayMethodAmounts if there was no order or no invoive, avoid finding all payments 

// Modified by: William James (2013-11-08T00:00:00)
// Method: Email_Governor
If ([Report:46]scriptExecute:4)  //| ([UserReport]ScriptBegin#""))  // once per session
	ExecuteText(0; [Report:46]scriptBegin:5)
End if 

//  <>useTransactions sets a boolean to use or not use transactions

//  PricingLvlDflts changes to load everything
//   J_PrntPrimary
//   jRptUserDefined
//  P_vHereBegin 
//  P_vHereEnd 


// Subrecord to records 
// Forecasting
// CMA
//  Production
//  Orders
// Proposal lines
//  Invoices
// dinventory

//  calc Order from arrays on only one in the program Query "[Order]Total:=" to correct

//    ////   change this to calc from arrays Pricing_Update

//  aOlineRec, aiLineRec, aPlineRec and aPoLineRec changed to a--LineAction 

//  Added OEC_Web to trap web based error dialogs. Make sure called in the WC_RequestHandler with no other err handlers called or released