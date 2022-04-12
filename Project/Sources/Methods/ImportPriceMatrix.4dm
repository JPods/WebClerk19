//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 05/15/11, 20:29:16
// ----------------------------------------------------
// Method: ImportPriceMatrix
// Description
// 
//
// Parameters
// ----------------------------------------------------
myDoc:=Open document:C264(""; "Open Tab Delimited Text File to Import")
If (OK=1)
	
	RECEIVE PACKET:C104(myDoc; vText1; "\r")  //clear off header
	//
	Repeat 
		RECEIVE PACKET:C104(myDoc; vText1; "\r")
		If (OK=1)
			TextToArray(vText1; ->aText1; "\t")  //now each line across the page is loaded into an array element "\t"
			
			If (Size of array:C274(aText1)>=2)
				vText2:=aText1{1}+"_"+[Customer:2]customerID:1
				vText3:=aText1{2}
				
				QUERY:C277([PriceMatrix:105]; [PriceMatrix:105]itemNum:11=vText2; *)
				QUERY:C277([PriceMatrix:105];  & [PriceMatrix:105]typeSale:3=vText3)
				DELETE SELECTION:C66([PriceMatrix:105])
				
				ARRAY REAL:C219(aReal1; 0)
				ARRAY REAL:C219(aReal2; 0)
				vi1:=0
				vi2:=2  //skip the aText1 element, ItemNum
				vi3:=0
				vi4:=Size of array:C274(aText1)
				Repeat 
					vi1:=vi2+1
					vi2:=vi1+1
					vi3:=Size of array:C274(aReal1)+1
					If (Length:C16(aText1{vi1})>0)
						INSERT IN ARRAY:C227(aReal1; vi3; 1)
						INSERT IN ARRAY:C227(aReal2; vi3; 1)
						aReal1{vi3}:=Num:C11(aText1{vi1})
						aReal2{vi3}:=Num:C11(aText1{vi2})
					Else 
						vi2:=vi4
					End if 
				Until (vi2>=vi4)
				vi2:=Size of array:C274(aReal1)
				For (vi1; 1; vi2)
					CREATE RECORD:C68([PriceMatrix:105])
					
					[PriceMatrix:105]itemNum:11:=vText2
					[PriceMatrix:105]typeSale:3:=vText3
					[PriceMatrix:105]quantityMin:4:=aReal1{vi1}
					If (vi1<vi2)
						[PriceMatrix:105]quantityMax:5:=aReal1{vi1+1}-1
					Else 
						[PriceMatrix:105]quantityMax:5:=10000000
					End if 
					[PriceMatrix:105]price:6:=aReal2{vi1}
					[PriceMatrix:105]dateCreated:14:=Current date:C33
					[PriceMatrix:105]nameID:16:=Current user:C182
					[PriceMatrix:105]vendorID:12:=[Customer:2]customerID:1
					SAVE RECORD:C53([PriceMatrix:105])
				End for 
			End if 
		End if 
	Until (OK=0)
End if 
