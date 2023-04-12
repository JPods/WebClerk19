//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: LWCStartProcess
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 

//TRACE

ptCurTable:=<>ptCurTable
C_LONGINT:C283($viProcess)
$viProcess:=Current process:C322
SET MENU BAR:C67(1; $viProcess; *)
Process_InitLocal
C_POINTER:C301($ptOrgFile)
myOK:=0
C_TEXT:C284($strPageID)
$thePage:=""
$strPageID:=""
If (ptCurTable#(->[Employee:19]))
	QUERY:C277([Employee:19]; [Employee:19]nameID:1=Current user:C182)
	If (Records in selection:C76([Employee:19])=1)
		If ([Employee:19]localWebPage:45#0)
			$strPageID:=String:C10([Employee:19]localWebPage:45)
		End if 
	End if 
	REDUCE SELECTION:C351([Employee:19]; 0)
End if 
//TRACE
C_LONGINT:C283($theRecNum)
C_TEXT:C284($theScript; $thePage)
myOK:=1
$strPageID:=<>jitPageOne
$theRecNum:=<>jitRecordNum
$theScript:=<>jitScript

Case of 
	: (<>prcControl=1)
		<>prcControl:=0
		//USE SET("<>curSelSet")
		If ($thePage="")
			$thePage:="LWC"+Table name:C256(ptCurTable)+"List"+$strPageID+".html"
		End if 
		$theCommand:="LWC_Display?jitPageOne="+$thePage+"&TableName="+Table name:C256(ptCurTable)+"&RecordNum=-11&jitScript="+$theScript
		If (Storage:C1525.wc.localHost="")
			OPEN URL:C673("http://localhost:8080/"+$theCommand)
		Else 
			OPEN URL:C673("http://"+Storage:C1525.wc.localHost+"/"+$theCommand)
		End if 
		DELAY PROCESS:C323(Current process:C322; 600)
		CLEAR SET:C117("<>curSelSet")
	: (<>prcControl=-1)
		<>prcControl:=0
		
		OPEN URL:C673("http://localhost/LWC_ServeMilgard?TableName=Customers&ProcessNum="+$1)
		
	: (<>prcControl>1)
		<>prcControl:=0
		If ($thePage="")
			$thePage:="LWC"+Table name:C256(ptCurTable)+"One"+$strPageID+".html"
		End if 
		$theCommand:="LWC_Display?jitPageOne="+$thePage+"&TableName="+Table name:C256(ptCurTable)+"&RecordNum="+String:C10($theRecNum)+"&jitScript="+$theScript
		If (Storage:C1525.wc.localHost="")
			OPEN URL:C673("http://localhost:8080/"+$theCommand)
		Else 
			OPEN URL:C673("http://"+Storage:C1525.wc.localHost+"/"+$theCommand)
		End if 
		
End case 

