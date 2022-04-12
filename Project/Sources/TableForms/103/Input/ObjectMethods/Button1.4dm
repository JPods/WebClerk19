



WebClientTest



If (False:C215)
	
	$myTest:=2
	Case of 
		: ($myTest=1)
			WebServiceSynRelationCall
		: ($myTest=2)
			WebServiceSandBox
		: ($myTest=3)
			
	End case 
	
End if 