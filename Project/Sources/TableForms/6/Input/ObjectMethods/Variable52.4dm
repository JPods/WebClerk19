Case of 
	: (aContact>0)
		QUERY:C277([Contact:13]; [Contact:13]idNum:28=aContactUnique{aContact})  // Replaced GOTO Record in Selection
		[Service:6]attention:30:=[Contact:13]nameFirst:2+" "+[Contact:13]nameLast:4  //Parse_ContctRay (aContact{aContact})
		[Service:6]contactid:52:=[Contact:13]idNum:28
	: ((Size of array:C274(aContact)>0) & (aContact=0))
		aContact:=1
End case 