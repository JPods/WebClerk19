//%attributes = {}

// Modified by: Bill James (2022-06-22T05:00:00Z)
// Method: Init_ObHistory
// Description 
// Parameters
// ----------------------------------------------------
#DECLARE($property : Text)->$result : Object
Case of 
	: ($property="")
		$result:=New object:C1471("id"; New object:C1471("big4"; ""; \
			"parent1"; ""; "parent2"; ""; \
			"parent3"; ""; "sales"; ""; \
			"rep"; ""; "other"; New object:C1471))
	: ($property="id")
		$result:=New object:C1471("big4"; ""; "parent1"; ""; "parent2"; ""; \
			"parent3"; ""; "sales"; ""; "rep"; ""; "other"; New object:C1471)
	Else 
		// TBD uses
End case 
