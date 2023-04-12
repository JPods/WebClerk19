If (<>aPrsName>0)
	//TRACE
	Case of 
		: (Size of array:C274(<>aPrsName)<<>aPrsName)
			// do nothing
		: ((<>aPrsName{<>aPrsName}="Main") | (<>aPrsName{<>aPrsName}="Sales Dept"))
			Dept_Sales
		: (<>aPrsName{<>aPrsName}="WebClerk@")
			$found:=Prs_CheckRunnin("WebClerk")
			If ($found>0)
				BRING TO FRONT:C326($found)
				
			Else 
				SHOW PROCESS:C325(<>aPrsNum{<>aPrsName})
				BRING TO FRONT:C326(<>aPrsNum{<>aPrsName})
				
			End if 
		Else 
			SHOW PROCESS:C325(<>aPrsNum{<>aPrsName})
			BRING TO FRONT:C326(<>aPrsNum{<>aPrsName})
			
			//$prcNum:=18
			//C_Longint($prcNum)
			//BRING TO FRONT($prcNum)
	End case 
	//Process_ListActive 
End if 


