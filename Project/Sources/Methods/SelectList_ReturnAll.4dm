//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 04/22/21, 21:57:45
// ----------------------------------------------------
// Method: SelectList_ReturnAll
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_OBJECT:C1216($obRec; $obSel)
C_OBJECT:C1216($obSelectLists)
$obSelectLists:=New object:C1471

If (<>viDebugMode>410)
	ConsoleLog("Launch")
End if 


C_TEXT:C284($vtList; $vtName)
$vtList:="aActions,aActionsInvoices,aActionsOrders,aActionsPOs,aActionsProjects,"+\
"aActionsProposals,aActionsVendors,aActionsWorkOrders,aActivities,aJobType,"+\
"aNeed,aNoteType,aPayAction,aPOsStatus,aProposalsStatus,aProspect,"+\
"aRank,aReasons,aStateList,aStatus,aNeed,aContractDetail"

$sadf:="aTaxJuris,aNameID,aTerms,aAdSource,aTypeSale,aRepID"
// aAdSource in Vue.js is aAdSources in WC
// aRepID Vue.js is <>aReps in WC

$vtList:="aContractDetail,aActions,aTaxJuris,aNameID,aActionsOrders,aActionsInvoices,"+\
"aActionsProposals,aActionsPOs,aTerms,aStatus,aAdSources,aTypeSale,"+\
"aReps,aNeed"
C_COLLECTION:C1488($cBegin)
$cBegin:=Split string:C1554($vtList; ";")
ARRAY TEXT:C222($aSendList; 0)
COLLECTION TO ARRAY:C1562($cBegin; $aSendList)


C_COLLECTION:C1488($vcPopups)
C_COLLECTION:C1488($temp_c)
C_OBJECT:C1216($obRec)
$obRec:=ds:C1482.WebClerk.query("publish = 1").first()
If ($obRec.obGeneral.selectLists=Null:C1517)
	$vcPopups:=Split string:C1554($vtList; ";")
	$obRec.obGeneral.selectLists:=$vcPopups
	$result_o:=$obRec.save()
End if 
$vcPopups:=$obRec.obGeneral.selectLists




C_POINTER:C301($ptArray)
C_LONGINT:C283($found)
C_TEXT:C284($vtBuildName)
//For each ($vtNameArray; $vcPopups)
For each ($vtNameArray; $cBegin)
	$found:=Find in array:C230($aSendList; $vtNameArray)
	If ($found>0)  // match spelling in the list above
		Case of 
			: (False:C215)  //$vtNameArray="aRepID")  // example of how the LogInForm.Vue was inconsistent
				$vtBuildName:="aReps"  // corrected it so the name align. 
			: (False:C215)  //($vtNameArray="aAdSource")
				$vtBuildName:="aAdSources"
			Else 
				$vtBuildName:=$vtNameArray
		End case 
		$ptArray:=Get pointer:C304("<>"+$vtNameArray)
		If (Not:C34(Is nil pointer:C315($ptArray)))
			$temp_c:=SelectList_toCollection("<>"+$vtBuildName)
			If ($temp_c#Null:C1517)
				If ($temp_c.length>0)
					$obSelectLists[$vtNameArray]:=$temp_c
				End if 
			End if 
		End if 
	End if 
End for each 

vResponse:=JSON Stringify:C1217($obSelectLists)
ON ERR CALL:C155("")




//$obSelectLists["States"
//$obSelectLists["Priority"


//      companyLatLng : [['lat','38.7634288'],['lng','-92.4900556']],
//      aQAType : [['Dryer-Vent','Dryer-Vent'],['Gas-Service-Call','Gas-Service-Call'],['Inspection-Level-2','Inspection-Level-2'],['Job-Setup','Job-Setup'],['Pellet-Stove','Pellet-Stove']],
//      aQACustomer : [['Site-Inspection','Site-Inspection']],

//      aDataCheckBox : [['Yes','yes'],['No','no']],
//      aNameID : [],

//      aTerms : [],
//      aSaleJurisSources : [['Distributor','Distributor'],['Retail','Retail'],['Subcontract','Subcontract'],['TrucktoCustomer','TrucktoCustomer'],['TrucktoTruck','TrucktoTruck'],['Wholesale','Wholesale']],
//      aStatus : [],
//      aContractDetail : [['Estimate','Estimate'],['Subcontract-Proposal','Subcontract-Proposal'],['Addl Work-Estimate','Addl Work-Estimate'],['Addl Work-Proposal','Addl Work-Proposal'],['Change Order-Proposal','Change Order-Proposal'],['Subcontract-Estimate','Subcontract-Estimate'],['Change Order-Estimate','Change Order-Estimate']],
//      aAdSource : [],
//      aTypeSale : [],
//      aRepID : [],
//      aDataTrueFalse : [['true','true'],['false','false']],
//      aUseType : [['UseType','Reprints','WebPrints','Book','NewsLetter']],
//      ajobList : [['Job Class','Job Class'],['*Estimate Job','*Estimate Job'],['*Sweeps Service','*Sweeps Service'],['Attic Insulation Shield/FS','Attic Insulation Shield/FS'],['Chase Cover','Chase Cover'],['Chimney Caps','Chimney Caps'],['Class A Install','Class A Install'],['Class B Install','Class B Install'],['Firebox Repairs','Firebox Repairs'],['FireStop Install','FireStop Install'],['Flashings/Crickets','Flashings/Crickets'],['Gas Insert','Gas Insert'],['Gas Log Installs','Gas Log Installs'],['Gas Stove','Gas Stove'],['level Three Inspect','level Three Inspect'],['New Const Gas FP','New Const Gas FP'],['New Const Masonry','New Const Masonry'],['New Const Wood FP','New Const Wood FP'],['Pellet Insert','Pellet Insert'],['Pellet Stove','Pellet Stove'],['Plaster & Paint','Plaster & Paint'],['R&R Brick Chimneys','R&R Brick Chimneys'],['R&R Gas FP','R&R Gas FP'],['R&R Wood Chases','R&R Wood Chases'],['R&R Wood FP','R&R Wood FP'],['Recrown','Recrown'],['Reface FirePlace','Reface FirePlace'],['Reline Gas','Reline Gas'],['Reline Wood','Reline Wood'],['Run Gas Line','Run Gas Line'],['Water Repellant','Water Repellant'],['Wood Insert','Wood Insert'],['Wood Stove','Wood Stove']],
//      aImportance : [['Emergency','Emergency'],['High','High'],['Medium','Medium'],['Low','Low'],['Objective','Objective']],
//      aStates:["AL","AK","AZ","AR","CA","CO","CT","DE","DC","FL","GA","HI","ID","IN","IL","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY"],
//      usersColors:{






