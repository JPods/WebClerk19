If (aContact>0)
	QUERY:C277([QQQContact:13]; [QQQContact:13]idUnique:28=aContactUnique{aContact})  // Replaced GOTO Record in Selection
	[Proposal:42]requestedBy:62:=[QQQContact:13]NameFirst:2+" "+[QQQContact:13]NameLast:4
End if 