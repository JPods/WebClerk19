//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2021-12-10T06:00:00Z)
// Method: Rep_DealerList
// Description 
// Parameters
// ----------------------------------------------------


vi10:=DateTime_Enter
READ WRITE:C146([TallyResult:73])
QUERY:C277([Rep:8]; [Rep:8]active:21=True:C214)
vi2:=Records in selection:C76([Rep:8])
FIRST RECORD:C50([Rep:8])
For (vi1; 1; vi2)
	MESSAGE:C88(String:C10(vi1))
	QUERY:C277([TallyResult:73]; [TallyResult:73]purpose:2="DealerLocator"; *)
	QUERY:C277([TallyResult:73];  & [TallyResult:73]customerID:30=[Rep:8]RepID:1)
	If (Records in selection:C76([TallyResult:73])=0)
		CREATE RECORD:C68([TallyResult:73])
		
		[TallyResult:73]nameProfile1:26:="Zip"
		[TallyResult:73]nameProfile2:27:="Company"
		[TallyResult:73]nameProfile3:28:="Phone"
		//
		[TallyResult:73]purpose:2:="DealerLocator"
		[TallyResult:73]customerID:30:=[Rep:8]RepID:1
		[TallyResult:73]name:1:=[Rep:8]comment:19
	End if 
	[TallyResult:73]dtReport:12:=vi10
	[TallyResult:73]profile1:17:=[Rep:8]zip:8
	[TallyResult:73]profile2:18:=Substring:C12([Rep:8]company:2; 1; 20)
	[TallyResult:73]profile3:19:=Format_Phone([Rep:8]phone:10)
	[TallyResult:73]textBlk1:5:=[Rep:8]company:2+"\r"+[Rep:8]address1:4+("\r"*Num:C11([Rep:8]address2:5#""))+[Rep:8]address2:5+"\r"+[Rep:8]city:6+", "+[Rep:8]state:7+"  "+[Rep:8]zip:8  //+"\r"+[rep]Country
	[TallyResult:73]textBlk1:5:=[TallyResult:73]textBlk1:5+"\r"+"mailto:"+[Rep:8]email:22+"\r"+"http://"+[Rep:8]domain:30
	[TallyResult:73]publish:36:=1
	SAVE RECORD:C53([TallyResult:73])
	NEXT RECORD:C51([Rep:8])
End for 
REDRAW WINDOW:C456

////script
//ALL RECORDS([Rep])
//vi2:=Records in selection([Rep])
//If (vi2>0)
//FIRST RECORD([Rep])
//For (vi1;1;vi2)
//If ([Rep]Phone#"")
//ParsePhone ([Rep]Phone;->[Rep]Phone;<>tcLocalArea)
//End if 
//If ([Rep]FAX#"")
//ParsePhone ([Rep]FAX;->[Rep]FAX;<>tcLocalArea)
//End if 
//SAVE RECORD([Rep])
//UNLOAD RECORD([Rep])
//NEXT RECORD([Rep])
//End for 
//End if 