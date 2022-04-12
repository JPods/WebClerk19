//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 130301, 23:58:39
// ----------------------------------------------------
// Method: Essentials
// Description
// 
//
// Parameters
// ----------------------------------------------------

//  DefaultSetupReturn
//  DefaultSetupsReturnValue

//iLoaText1{1}:="Types"
//iLoaText1{2}:="Is Boolean"
//iLoaText1{3}:="Is Date"
//iLoaText1{4}:="Is Integer"
//iLoaText1{5}:="Is LongInt"
//iLoaText1{6}:="Is Real"
//iLoaText1{7}:="Is String Var"
//iLoaText1{8}:="Is Time"

//build WOTransferLable
C_LONGINT:C283(<>Order2POCost210)
QUERY:C277([DefaultSetup:86]; [DefaultSetup:86]variableName:7="<>Order2POCost210")
If (Records in selection:C76([DefaultSetup:86])=0)
	CREATE RECORD:C68([DefaultSetup:86])
	
	[DefaultSetup:86]value:9:="3"
	[DefaultSetup:86]variableName:7:="<>Order2POCost210"
	[DefaultSetup:86]type:8:="Is Integer"
	//PO_AddNewLines  illustrates this
	[DefaultSetup:86]howUsed:10:="Controls how costs are transferred from an Order to PO"+"\r"+"3 = Orderline cost"+"\r"+"2 = [Item]CostLastInShip"+"\r"+"1 = [Item]CostAverage"
	[DefaultSetup:86]group:12:="all"
	[DefaultSetup:86]layoutName:3:="[PO]Input"
	SAVE RECORD:C53([DefaultSetup:86])
End if 
FIRST RECORD:C50([DefaultSetup:86])
<>Order2POCost210:=Num:C11([DefaultSetup:86]value:9)

<>vignorprimary:=0  //allows records in to by-pass search and replace, unique fields must be deactivated
<>ignorInputLayout:=0

C_TEXT:C284(<>vtQueryBy)
DefaultSetupsCreate("<>vtQueryBy"; "contains"; "Is Text"; "all"; "Query option control"; "Used in KeyWordByTag between contains or keyword.")
$error:=DefaultSetupReturn("<>vtQueryBy")

C_LONGINT:C283(<>unloaddelay)
DefaultSetupsCreate("<>unloaddelay"; "50"; "Is Text"; "all"; "Help System"; "Delay in opening a new process so if they are run on the remote server, the server has time to get organized")
$error:=DefaultSetupReturn("<>unloaddelay")

C_BOOLEAN:C305(<>vbLogStrFieldChanges)
DefaultSetupsCreate("<>vbLogStrFieldChanges"; "true"; "Is boolean"; "all"; "WC_Parse"; "Logs changes in string fields into comments.")

C_TEXT:C284(<>jitHelpPathLocal)
DefaultSetupsCreate("<>jitHelpPathLocal"; Storage:C1525.folder.jitF+"jitWeb"+Folder separator:K24:12+"jitHelp"+Folder separator:K24:12+"index.html"; "Is Text"; "all"; "Help System"; "Path to local machine help files.")
$error:=DefaultSetupReturn("<>jitHelpPathLocal")
C_TEXT:C284(<>jitHelpPathNetwork)
DefaultSetupsCreate("<>jitHelpPathNetwork"; ""; "Is Text"; "all"; "Help System"; "Path to the local network based support site.")
$error:=DefaultSetupReturn("<>jitHelpPathNetwork")
C_TEXT:C284(<>jitHelpPathWeb)
DefaultSetupsCreate("<>jitHelpPathWeb"; ""; "Is Text"; "all"; "Help System"; "Path to the web based support site.")
$error:=DefaultSetupReturn("<>jitHelpPathWeb")

DefaultSetupsCreate("ProcessWindow"; "LowerLeft"; "Is String Var"; "all"; "Processes"; "Places the Process Window in the LowerLeft or UpperRight.")

C_LONGINT:C283(<>viloadOrderCost)
DefaultSetupsCreate("<>viloadOrderCost"; "0"; "Is Integer"; "all"; "Launching processes"; "Forces costs to transfer from orders.")
$error:=DefaultSetupReturn("<>viloadOrderCost")

C_LONGINT:C283($error)

C_LONGINT:C283(<>ignorInputLayout)
DefaultSetupsCreate("<>ignorInputLayout"; "1"; "Is Integer"; "all"; "Launching processes"; "If not zero, ignors the Input layout selection to work with the existing default. Should generally be zero.")
$error:=DefaultSetupReturn("<>ignorInputLayout")

C_LONGINT:C283(<>showEmailDialog)
DefaultSetupsCreate("<>showEmailDialog"; "1"; "Is Integer"; "all"; "email message"; "Set to zero to suppress displaying email summary in an input layout.")
$error:=DefaultSetupReturn("<>showEmailDialog")

C_LONGINT:C283(<>doEventLogInCreditCard)
DefaultSetupsCreate("<>doEventLogInCreditCard"; "1"; "Is Integer"; "all"; "Credit Cards"; "Must be set to 1 to record EventLogs with processing credit cards.")
$error:=DefaultSetupReturn("<>doEventLogInCreditCard")
<>keywordItemQuery:=Num:C11(DefaultSetupsReturnValue("<>keywordItemQuery"))

C_LONGINT:C283(<>keywordItemQuery)
DefaultSetupsCreate("<>keywordItemQuery"; "0"; "Is Integer"; "all"; "Big 4"; "Query by Keywords in Orders/Invoices/PPs/POs.")
$error:=DefaultSetupReturn("<>keywordItemQuery")

DefaultSetupsCreate("vSetPublish"; "1"; "Is Integer"; "all"; "Import Items"; "Automatically sets the publish level on importing items.")
DefaultSetupsCreate("vMakeKeyWords"; "1"; "Is Integer"; "all"; "Import Items"; "Automatically makes keywords on importing items.")
DefaultSetupsCreate("vMakeItemNum"; "1"; "Is Integer"; "all"; "Import Items"; "Automatically sets ItemNum to MfrItemNum_mfrID on importing items if empty.")


C_LONGINT:C283(<>delayProcessUnload)
DefaultSetupsCreate("<>delayProcessUnload"; "30"; "Is Integer"; "all"; "Process Opening"; "Delays on opening process so records can be unloaded in the initiating process.")
$error:=DefaultSetupReturn("<>delayProcessUnload")

If (False:C215)  //  hold for example
	QUERY:C277([DefaultSetup:86]; [DefaultSetup:86]variableName:7="<>delayProcessUnload")
	If (Records in selection:C76([DefaultSetup:86])=0)
		CREATE RECORD:C68([DefaultSetup:86])
		
		[DefaultSetup:86]value:9:="30"  // 50 milliseconds. This is to give ser
		[DefaultSetup:86]variableName:7:="<>delayProcessUnload"
		[DefaultSetup:86]type:8:="Is Integer"
		//PO_AddNewLines  illustrates this
		[DefaultSetup:86]howUsed:10:="Delays on opening process so records can be unloaded in the initiating process."
		[DefaultSetup:86]group:12:="all"
		[DefaultSetup:86]layoutName:3:="Process Opening"
		SAVE RECORD:C53([DefaultSetup:86])
	End if 
	FIRST RECORD:C50([DefaultSetup:86])
End if 

REDUCE SELECTION:C351([DefaultSetup:86]; 0)

QUERY:C277([Carrier:11]; [Carrier:11]idNum:44=0)
If (Records in selection:C76([Carrier:11])>0)
	ConvertCarrierSubRecs
	REDUCE SELECTION:C351([Carrier:11]; 0)
End if 

QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="jitImportExport")
C_LONGINT:C283($i; $k)
$k:=Records in selection:C76([TallyMaster:60])
If ($k>0)
	FIRST RECORD:C50([TallyMaster:60])
	For ($i; 1; $k)
		[TallyMaster:60]purpose:3:="ImportExport"
		SAVE RECORD:C53([TallyMaster:60])
		NEXT RECORD:C51([TallyMaster:60])
	End for 
End if 



If (False:C215)  // use this to fix all uniqueIDs
	Utility_FixUniqueID
End if 

Execute_TallyMaster("Essentials"; "Admin")