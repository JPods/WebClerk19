//%attributes = {"publishedWeb":true}
//Trans_Relate
C_POINTER:C301($1)
C_TEXT:C284($2)  //name of the set
//
Case of 
	: ($1=(->[Customer:2]))
		CREATE EMPTY SET:C140([DCash:62]; "$cumSet")
		If (vHere>1)
			FIRST RECORD:C50([Customer:2])
			$k:=Records in selection:C76([Customer:2])
		Else 
			$k:=1
		End if 
		For ($i; 1; $k)
			QUERY:C277([DCash:62]; [DCash:62]customerIDApply:1=[Customer:2]customerID:1)
			CREATE SET:C116([DCash:62]; "$current")
			UNION:C120("$current"; "$cumSet"; "$cumSet")
			CLEAR SET:C117("$current")
			QUERY:C277([DCash:62]; [DCash:62]customerIDReceive:7=[Customer:2]customerID:1)
			CREATE SET:C116([DCash:62]; "$current")
			UNION:C120("$current"; "$cumSet"; "$cumSet")
			CLEAR SET:C117("$current")
			If (vHere>1)
				NEXT RECORD:C51([Customer:2])
			End if 
		End for 
	: ($1=(->[Invoice:26]))
		CREATE EMPTY SET:C140([DCash:62]; "$cumSet")
		If (vHere>1)
			FIRST RECORD:C50([Invoice:26])
			$k:=Records in selection:C76([Invoice:26])
		Else 
			$k:=1
		End if 
		For ($i; 1; $k)
			QUERY:C277([DCash:62]; [DCash:62]tableApply:2=26; *)
			QUERY:C277([DCash:62];  & [DCash:62]docApply:3=[Invoice:26]invoiceNum:2)
			CREATE SET:C116([DCash:62]; "$current")
			UNION:C120("$current"; "$cumSet"; "$cumSet")
			CLEAR SET:C117("$current")
			QUERY:C277([DCash:62]; [DCash:62]tableReceive:8=26; *)
			QUERY:C277([DCash:62];  & [DCash:62]docReceive:4=[Invoice:26]invoiceNum:2)
			CREATE SET:C116([DCash:62]; "$current")
			UNION:C120("$current"; "$cumSet"; "$cumSet")
			CLEAR SET:C117("$current")
			If (vHere>1)
				NEXT RECORD:C51([Invoice:26])
			End if 
		End for 
	: ($1=(->[Payment:28]))
		CREATE EMPTY SET:C140([DCash:62]; "$cumSet")
		If (vHere>1)
			FIRST RECORD:C50([Payment:28])
			$k:=Records in selection:C76([Payment:28])
		Else 
			$k:=1
		End if 
		For ($i; 1; $k)
			QUERY:C277([DCash:62]; [DCash:62]tableApply:2=26; *)
			QUERY:C277([DCash:62];  & [DCash:62]docApply:3=[Payment:28]idNum:8)
			CREATE SET:C116([DCash:62]; "$current")
			UNION:C120("$current"; "$cumSet"; "$cumSet")
			CLEAR SET:C117("$current")
			QUERY:C277([DCash:62]; [DCash:62]tableReceive:8=28; *)
			QUERY:C277([DCash:62];  & [DCash:62]docReceive:4=[Payment:28]idNum:8)
			CREATE SET:C116([DCash:62]; "$current")
			UNION:C120("$current"; "$cumSet"; "$cumSet")
			CLEAR SET:C117("$current")
			If (vHere>1)
				NEXT RECORD:C51([Payment:28])
			End if 
		End for 
End case 
COPY SET:C600("$cumSet"; $2)
CLEAR SET:C117("$cumSet")