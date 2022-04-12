//%attributes = {"publishedWeb":true}
ALL RECORDS:C47([OrderLine:49])
ORDER BY:C49([Contact:13]; [Contact:13]customerID:1)
FIRST RECORD:C50([Contact:13])
vi2:=Records in selection:C76([Contact:13])
For (vi1; 1; vi2)
	If ([Contact:13]customerID:1#[Customer:2]customerID:1)
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Contact:13]customerID:1)
	End if 
	If (Record number:C243([Customer:2])=-1)
		[Contact:13]profile1:18:="No Cust"
	Else 
		[Contact:13]profile1:18:=[Customer:2]profile1:26
	End if 
	SAVE RECORD:C53([Contact:13])
	NEXT RECORD:C51([Contact:13])
End for 

If (False:C215)
	//CREATE EMPTY SET([Order];"current")
	vText1:=""
	ORDER BY:C49([OrderLine:49]; [OrderLine:49]orderNum:1)
	FIRST RECORD:C50([OrderLine:49])
	vi2:=Records in selection:C76([OrderLine:49])
	For (vi1; 1; vi2)
		If (Find in array:C230(aTmpLong1; [OrderLine:49]orderNum:1)<1)
			INSERT IN ARRAY:C227(aTmpLong1; 1; 1)
			aTmpLong1{1}:=[OrderLine:49]orderNum:1
		End if 
		NEXT RECORD:C51([OrderLine:49])
	End for 
	vi2:=Size of array:C274(aTmpLong1)
	For (vi1; vi2; 1; -1)
		QUERY:C277([Order:3]; [Order:3]orderNum:2=aTmpLong1{vi1})
		If (Record number:C243([Order:3])>-1)
			DELETE FROM ARRAY:C228(aTmpLong1; vi1; 1)
		Else 
			vText1:=vText1+"\r"+String:C10(aTmpLong1{vi1})
			QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=aTmpLong1{vi1})
			OptKey:=1
			
			[Order:3]profile6:105:="rebuilt_070315"
			//ADD TO SET("current")
		End if 
	End for 
	//USE SET("current")
	//CLEAR SET("current")
	SET TEXT TO PASTEBOARD:C523(vText1)
End if 