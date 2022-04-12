//%attributes = {"publishedWeb":true}
//Procedure: Tally_AddRec
If (Records in selection:C76([TallyResult:73])=0)
	CREATE RECORD:C68([TallyResult:73])
	
	[TallyResult:73]name:1:=$1
	[TallyResult:73]purpose:2:=$2
	[TallyResult:73]tableNum:3:=$3
	[TallyResult:73]fieldNum:4:=$4
	[TallyResult:73]textBlk1:5:=$5
	[TallyResult:73]textBlk2:6:=$6
	[TallyResult:73]longint1:7:=$7
	[TallyResult:73]longInt2:8:=$8
	[TallyResult:73]dtCreated:11:=DateTime_Enter
	[TallyResult:73]dtReport:12:=$9
	[TallyResult:73]real1:13:=$10
	[TallyResult:73]real2:14:=$11
	[TallyResult:73]real3:15:=$12
	[TallyResult:73]real4:16:=$13
	[TallyResult:73]profile1:17:=$14
	[TallyResult:73]profile2:18:=$15
	[TallyResult:73]profile3:19:=$16
	QUERY:C277([TallyMaster:60]; [TallyMaster:60]idNum:4=[TallyResult:73]dtCreated:11)
	If (Records in selection:C76([TallyResult:73])=1)
		[TallyResult:73]nameReal1:20:=[TallyMaster:60]realName1:16
		[TallyResult:73]nameProfile2:27:=[TallyMaster:60]profileName2:14
		[TallyResult:73]nameProfile3:28:=[TallyMaster:60]profileName3:15
		[TallyResult:73]nameReal1:20:=[TallyMaster:60]realName1:16
		[TallyResult:73]nameReal2:21:=[TallyMaster:60]realName2:17
		[TallyResult:73]nameReal3:22:=[TallyMaster:60]realName3:18
		[TallyResult:73]nameReal4:23:=[TallyMaster:60]realName4:19
		[TallyResult:73]nameLong1:24:=[TallyMaster:60]longName1:20
		[TallyResult:73]nameLong2:25:=[TallyMaster:60]longName2:21
		SAVE RECORD:C53([TallyResult:73])
	End if 
End if 