
CONFIRM:C162("Are you sure you wish to build and replace existing keys?")
If (OK=1)
	GENERATE ENCRYPTION KEYPAIR:C688([SyncRelation:103]PrivateKey:45; [SyncRelation:103]PublicKey:46)
	iLoText7:=BLOB to text:C555([SyncRelation:103]PrivateKey:45; UTF8 text without length:K22:17)
	iLoText8:=BLOB to text:C555([SyncRelation:103]PublicKey:46; UTF8 text without length:K22:17)
End if 