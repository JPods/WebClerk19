//%attributes = {}


QUERY:C277([TallyMaster:60]; [TallyMaster:60]idNum:4>658)
ORDER BY:C49([TallyMaster:60]; [TallyMaster:60]idNum:4)
FIRST RECORD:C50([TallyMaster:60])
vi2:=Records in selection:C76([TallyMaster:60])
vText1:=""
For (vi1; 1; vi2)
	vText1:=vText1+String:C10([TallyMaster:60]idNum:4; "0000")+"\t"+Substring:C12([TallyMaster:60]script:9; Length:C16([TallyMaster:60]script:9)-0)+"\t"+"~"
	NEXT RECORD:C51([TallyMaster:60])
End for 
REDUCE SELECTION:C351([TallyMaster:60]; 0)
SET TEXT TO PASTEBOARD:C523(vText1)
ALERT:C41("Data on Clipboard")

vText1:=Get text from pasteboard:C524


ALL RECORDS:C47([TallyMaster:60])
ORDER BY:C49([TallyMaster:60]; [TallyMaster:60]idNum:4)
FIRST RECORD:C50([TallyMaster:60])
vi2:=Records in selection:C76([TallyMaster:60])
vText1:=""
For (vi1; 1; vi2)
	vText1:=vText1+String:C10([TallyMaster:60]idNum:4; "00000")+"\t"+Substring:C12([TallyMaster:60]script:9; Length:C16([TallyMaster:60]script:9)-5)+"\t"+"old"+"\r"
	NEXT RECORD:C51([TallyMaster:60])
End for 
REDUCE SELECTION:C351([TallyMaster:60]; 0)
SET TEXT TO PASTEBOARD:C523(vText1)
ALERT:C41("Data on Clipboard")
