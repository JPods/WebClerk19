//%attributes = {"publishedWeb":true}

// Modified by: William James (2013-10-18T00:00:00)


// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-10-18T00:00:00, 14:19:25
// ----------------------------------------------------
// Method: jStartup
// Description
// Modified: 10/18/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------



READ WRITE:C146([Default:15])


jStart0
jStart1
jStart2
jStart3  //data conversions
jStart4Images
ApplicationLoad
//
QUERY:C277([Default:15]; [Default:15]primeDefault:176=1)
<>vlQuitOne:=-1
If (False:C215)  //(([Default]Domain#"www.yourdomain.com")&(Storage.default.emailServer#"")&(Storage.default.emailServer#"demo")&(<>vlOnCD=0))
	//build a version checker: fixThis
End if 
Case of 
	: ((Num:C11(Application type:C494=4D Remote mode:K5:5)#0) | ([Default:15]company:19#"National Athletic Distributor"))  //skip if client
	: (Records in table:C83([TechNote:58])<100)
		If (HFS_Exists(Storage:C1525.folder.jitF+"jitManual")=1)
			CONFIRM:C162("Load the jitManual?")
			If (OK=1)
				Records_In
			End if 
		End if 
	Else 
		Case of 
			: (HFS_Exists(Storage:C1525.folder.jitF+"jitManual.txt")=1)
			: (HFS_Exists(Storage:C1525.folder.jitF+"jitManual")=1)
			Else 
				Records_Out(->[TechNote:58]; "jitManual"; 1)
		End case 
End case 

//If (HFS_Exists (Storage.folder.jitF+"jitWebEngine.txt")=1) // #### AZM #### 20171013_1409 - This is never used. Bill doesn't even know what it was fore.
//<>webEngine:=1
//Else 
//<>webEngine:=0
//End if 
//  ### jwm ### 20131108_1805
C_BOOLEAN:C305(<>vbScaleOn)  //Storage.folder.jitF+"jitPrefs"+Folder separator
// Modified by: William James (2013-10-18T00:00:00)
QUERY:C277([DefaultSetup:86]; [DefaultSetup:86]variableName:7="ReadScale_"+Current machine:C483)
If (Records in selection:C76([DefaultSetup:86])>0)
	FIRST RECORD:C50([DefaultSetup:86])
	<>vbScaleOn:=(([DefaultSetup:86]value:9="1") | ([DefaultSetup:86]value:9="t@") | ([DefaultSetup:86]value:9="Y@"))
Else 
	If (HFS_Exists(Storage:C1525.folder.jitF+"jitScale.txt")=1)
		<>vbScaleOn:=True:C214
	Else 
		//  ### jwm ### 20131109_1225 begin
		If (HFS_Exists(Storage:C1525.folder.jitF+"jitPrefs"+Folder separator:K24:12+"jitScale.txt")=1)
			<>vbScaleOn:=True:C214
		Else 
			<>vbScaleOn:=False:C215
		End if 
	End if 
	
	//  ### jwm ### 20131109_1225 end
End if 
REDUCE SELECTION:C351([DefaultSetup:86]; 0)
//
UNLOAD RECORD:C212([Default:15])
READ ONLY:C145([Default:15])
//