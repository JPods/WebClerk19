If (<>aPrsName>0)
	//TRACE
	Case of 
		: ((<>aPrsName{<>aPrsName}="Main") | (<>aPrsName{<>aPrsName}="Sales Dept"))
			Dept_Sales
		: (<>aPrsName{<>aPrsName}="WebClerk@")
			$found:=Prs_CheckRunnin("WebClerk")
			If ($found>0)
				If (Frontmost process:C327#<>aPrsNum{$found})
					BRING TO FRONT:C326(<>aPrsNum{$found})
				Else 
					SHOW PROCESS:C325(<>aPrsNum{<>aPrsName})
					BRING TO FRONT:C326(<>aPrsNum{<>aPrsName})
				End if 
			End if 
		Else 
			SHOW PROCESS:C325(<>aPrsNum{<>aPrsName})
			BRING TO FRONT:C326(<>aPrsNum{<>aPrsName})
			
			//$prcNum:=18
			//C_Longint($prcNum)
			//BRING TO FRONT($prcNum)
	End case 
	//Prs_ListActive 
End if 


