//%attributes = {"publishedWeb":true}
C_TEXT:C284($1; $2)
If (Count parameters:C259=3)
	vText1:=$1
	vText3:=$2
Else 
	vText1:="C:\\DataReach\\newfnet\\fnet.txt"
	vText3:="6.500"
End if 
If (HFS_Exists(vText1)=1)
	ARRAY TEXT:C222(aText4; 8)
	ARRAY TEXT:C222(<>aText5; 9)
	ARRAY TEXT:C222(<>aText6; 9)
	ARRAY TEXT:C222(<>aText3; 12)
	vi1:=0
	ON ERR CALL:C155("jOECNoAction")
	myDoc:=Open document:C264(vText1)
	If (OK=1)
		//RECEIVE PACKET(myDoc;vText2;"\r")
		//RECEIVE PACKET(myDoc;vText2;"\r")
		RECEIVE PACKET:C104(myDoc; vText2; "\r")
		vi7:=0
		Repeat 
			RECEIVE PACKET:C104(myDoc; vText2; "\r")
			vi7:=vi7+1
			If (OK=1)
				MESSAGE:C88("Processing: "+String:C10(vi7))
				If (Length:C16(vText2)<5)
					OK:=0
				Else 
					If (Character code:C91(vText2)=10)
						vtext2:=Substring:C12(vText2; 2)
					End if 
					aText4{1}:=Substring:C12(vText2; 1; 3)  //catagory
					aText4{2}:=Substring:C12(vText2; 6; 5)  //coupon rate, percent
					vi4:=Num:C11(Substring:C12(vText2; 12; 2))  //month
					aText4{4}:=Substring:C12(vText2; 16; 5)  //bid
					aText4{5}:=Substring:C12(vText2; 23; 5)  //ask
					aText4{6}:=Substring:C12(vText2; 30; 5)  //yield
					aText4{7}:=Substring:C12(vText2; 36; 5)  //change
					aText4{7}:=Replace string:C233(aText4{7}; " "; "")
					aText4{8}:=Substring:C12(vText2; 42)  //skip two and read          
					Case of 
						: ((aText4{1}="312") & (aText4{2}=vText3))
							vi1:=vi1+1
							//Alert(aText4{1}+"; "+string(vi4)+"; "+aText4{7}+"; "+string(vi1)+"; "+aText4{2})
							Case of 
								: (vi1=7)
									<>aText5{1}:=Substring:C12(<>arrmonth{vi4}; 1; 3)
									<>aText6{1}:=aText4{7}
								: (vi1=8)
									<>aText5{2}:=Substring:C12(<>arrmonth{vi4}; 1; 3)
									<>aText6{2}:=aText4{7}
								Else 
									<>aText5{3}:=Substring:C12(<>arrmonth{vi4}; 1; 3)
									<>aText6{3}:=aText4{7}
							End case 
						: ((aText4{1}="401") & (aText4{2}=vText3))
							vi1:=vi1+1
							//Alert(aText4{1}+"; "+string(vi4)+"; "+aText4{7}+"; "+string(vi1)+"; "+aText4{2})
							Case of 
								: (vi1=4)
									<>aText5{4}:=Substring:C12(<>arrmonth{vi4}; 1; 3)
									<>aText6{4}:=aText4{7}
								: (vi1=5)
									<>aText5{5}:=Substring:C12(<>arrmonth{vi4}; 1; 3)
									<>aText6{5}:=aText4{7}
								Else 
									<>aText5{6}:=Substring:C12(<>arrmonth{vi4}; 1; 3)
									<>aText6{6}:=aText4{7}
							End case 
						: ((aText4{1}="400") & (aText4{2}=vText3))
							vi1:=vi1+1
							//Alert(aText4{1}+"; "+string(vi4)+"; "+aText4{7}+"; "+string(vi1)+"; "+aText4{2})
							Case of 
								: (vi1=1)
									<>aText5{7}:=Substring:C12(<>arrmonth{vi4}; 1; 3)
									<>aText6{7}:=aText4{7}
								: (vi1=2)
									<>aText5{8}:=Substring:C12(<>arrmonth{vi4}; 1; 3)
									<>aText6{8}:=aText4{7}
								Else 
									<>aText5{9}:=Substring:C12(<>arrmonth{vi4}; 1; 3)
									<>aText6{9}:=aText4{7}
							End case 
							//: (aText4{1}="204")
							//
							//: (aText4{1}="101")
							//
							//: (aText4{1}="201")
							//Case of 
						: (aText4{8}="TC2Y")
							<>aText3{7}:=aText4{6}
							<>aText3{8}:=aText4{7}
						: (aText4{8}="TC5Y")
							<>aText3{5}:=aText4{6}
							<>aText3{6}:=aText4{7}
						: (aText4{8}="TC10")
							<>aText3{3}:=aText4{6}
							<>aText3{4}:=aText4{7}
						: (aText4{8}="TC30")
							<>aText3{1}:=aText4{6}
							<>aText3{2}:=aText4{7}
						: (aText4{8}="TB6M")
							<>aText3{11}:=aText4{6}
							<>aText3{12}:=aText4{7}
						: (aText4{8}="TB1Y")
							<>aText3{9}:=aText4{6}
							<>aText3{10}:=aText4{7}
					End case 
					
					//End case 
				End if 
			End if 
		Until (OK=0)
		//For (vi1;1;12)
		// If (<>aText3{vi1}="-999")
		//   <>aText3{vi1}:="NC"
		//End if 
		// End for 
		// For (vi1;1;9)
		// If (<>aText6{vi1}="-999")
		//  <>aText6{vi1}:="NC"
		//End if 
		// End for 
		Case of 
			: (vi5=1)
				vi1:=HFS_Rename(document; "fNet"+String:C10(DateTime_DTTo)+".txt")
				vi1:=HFS_Move(document; "C:\\DataReach\\ProcFNet")
			: (vi5=2)
				CLOSE DOCUMENT:C267(myDoc)
				vi1:=HFS_Rename(document; "fNet"+String:C10(DateTime_DTTo)+".txt")
			: (vi5=3)
				vi1:=HFS_Delete(document)
		End case 
	End if 
End if 
REDRAW WINDOW:C456