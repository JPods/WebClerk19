If (False:C215)
	//Date: 03/01/02
	//Who: Dan Bentson, Arkware
	//Description: Go back to an earlier date - 7 years
	
	//Date: 04/22/02
	//Who:Janani
	//Description: Added the report generation to include full year
	VERSION_960
End if 

Case of 
	: (Before:C29)
		ARRAY TEXT:C222(<>TCMTallyMonth; 0)
		ARRAY LONGINT:C221(<>TCMTallyYear; 0)
		
		INSERT IN ARRAY:C227(<>TCMTallyMonth; 1)
		<>TCMTallyMonth{1}:="Full Year"
		INSERT IN ARRAY:C227(<>TCMTallyMonth; 1)
		<>TCMTallyMonth{1}:="December"
		INSERT IN ARRAY:C227(<>TCMTallyMonth; 1)
		<>TCMTallyMonth{1}:="November"
		INSERT IN ARRAY:C227(<>TCMTallyMonth; 1)
		<>TCMTallyMonth{1}:="October"
		INSERT IN ARRAY:C227(<>TCMTallyMonth; 1)
		<>TCMTallyMonth{1}:="September"
		INSERT IN ARRAY:C227(<>TCMTallyMonth; 1)
		<>TCMTallyMonth{1}:="August"
		INSERT IN ARRAY:C227(<>TCMTallyMonth; 1)
		<>TCMTallyMonth{1}:="July"
		INSERT IN ARRAY:C227(<>TCMTallyMonth; 1)
		<>TCMTallyMonth{1}:="June"
		INSERT IN ARRAY:C227(<>TCMTallyMonth; 1)
		<>TCMTallyMonth{1}:="May"
		INSERT IN ARRAY:C227(<>TCMTallyMonth; 1)
		<>TCMTallyMonth{1}:="April"
		INSERT IN ARRAY:C227(<>TCMTallyMonth; 1)
		<>TCMTallyMonth{1}:="March"
		INSERT IN ARRAY:C227(<>TCMTallyMonth; 1)
		<>TCMTallyMonth{1}:="February"
		INSERT IN ARRAY:C227(<>TCMTallyMonth; 1)
		<>TCMTallyMonth{1}:="January"
		
		For ($count; Year of:C25(Current date:C33); Year of:C25(Current date:C33)-7; -1)
			INSERT IN ARRAY:C227(<>TCMTallyYear; 1)
			<>TCMTallyYear{1}:=$count
		End for 
		
		<>TCMTallyMonth:=Month of:C24(Current date:C33)  // default selected
		<>TCMTallyYear:=8  //default selected
		
End case 