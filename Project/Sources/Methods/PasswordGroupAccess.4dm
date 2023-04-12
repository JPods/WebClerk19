//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-13T00:00:00, 15:39:06
// ----------------------------------------------------
// Method: PasswordGroupAccess
// Description
// Modified: 08/13/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)
C_BOOLEAN:C305($0; $accessAllowed)
$accessAllowed:=True:C214
Case of 
	: ($1=(->[Base:1]))
		
		//
	: ($1=(->[Invoice:26]))
		
		
	: (($1=(->[InvoiceLine:54])) | ($1=(->[OrderLine:49])) | ($1=(->[ProposalLine:43])))
		
	: ($1=(->[TallyMaster:60]))
		$accessAllowed:=UserInPassWordGroup("EditReportScript")
		
	: ($1=(->[TallyResult:73]))
		$accessAllowed:=UserInPassWordGroup("Archive")
		
	: (($1=(->[Usage:5])) | ($1=(->[UsageSummary:33])))
		$accessAllowed:=UserInPassWordGroup("Archive")
		
	: ($1=(->[Payment:28]))
		
		
	: ($1=(->[Employee:19]))
		$accessAllowed:=UserInPassWordGroup("Employee")
		
	: ($1=(->[DefaultAccount:32]))
		$accessAllowed:=UserInPassWordGroup("Archive")
		
	: ($1=(->[Time:56]))
		(UserInPassWordGroup("Time"))
		
		//    
	: ($1=(->[Default:15]))
		$accessAllowed:=UserInPassWordGroup("Default")
		
		//
	: ($1=(->[Employee:19]))
		
	: (($1=(->[SyncRecord:109])) | ($1=(->[SyncRelation:103])) | ($1=(->[zzzSyncMap:112])) | ($1=(->[SyncJob:104])))
		
		$accessAllowed:=UserInPassWordGroup("Sync")
		
	: ($1=(->[RemoteUser:57]))
		$accessAllowed:=UserInPassWordGroup("RemoteUser")
		
	: ($1=(->[Term:37]))
		$accessAllowed:=UserInPassWordGroup("Term")
		
	: (($1=(->[SalesJournal:50])) | ($1=(->[PurchaseJournal:51])) | ($1=(->[CashJournal:52])))
		$accessAllowed:=UserInPassWordGroup("Accounting")
		
	Else 
		
End case 


$0:=$accessAllowed

If (False:C215)
	Case of 
			
			//
		: ($1=(->[Order:3]))
			
			
			//    
		: ($1=(->[Customer:2]))
			
			
			//
		: ($1=(->[Proposal:42]))
			
			
			//
		: ($1=(->[Contact:13]))
			
			
			//
		: ($1=(->[Reference:7]))
			
			
			//
		: ($1=(->[Rep:8]))
			
			
			//    
		: ($1=(->[Item:4]))
			
			
			//
		: ($1=(->[Project:24]))
			
			
			//
		: (($1=(->[PO:39])) | ($1=(->[POLine:40])))
			
			
			//  
		: ($1=(->[Vendor:38]))
			
			
			//
		: ($1=(->[ItemSerial:47]))
			
			
			//
		: (($1=(->[InventoryStack:29])) | ($1=(->[POReceipt:95])) | ($1=(->[BOM:21])) | ($1=(->[ItemSpec:31])) | ($1=(->[ItemXRef:22])) | ($1=(->[DInventory:36])) | ($1=(->[ItemSiteBucket:136])) | ($1=(->[ItemSerialAction:64])))
			
			
			//
		: (($1=(->[WOTemplate:69])) | ($1=(->[WODraw:68])) | ($1=(->[WorkOrderTask:67])) | ($1=(->[WorkOrderEvent:121])))
			
			
		: ($1=(->[WorkOrder:66]))
			
			
			//
		: ($1=(->[TechNote:58]))
			
			
			//
		: ($1=(->[UsageSummary:33]))
			
			
			//
		: ($1=(->[Usage:5]))
			
			
			//        
		: ($1=(->[Service:6]))
			
			
			
		: ($1=(->[Carrier:11]))
			
			//
			
			
			//    
		: ($1=(->[CallReport:34]))
			
			
			//
		: ($1=(->[DivisionDefault:85]))
			
			
			//
		: ($1=(->[GenericParent:89]))
			
			
			//    
		: ($1=(->[GenericChild1:90]))
			
			
			
		: ($1=(->[GenericChild2:91]))
			
			
			//    
		: ($1=(->[WebClerk:78]))
			
			
	End case 
End if 


