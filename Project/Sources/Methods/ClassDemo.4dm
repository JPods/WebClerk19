//%attributes = {}
vi2:=10
For (vi1; 1; 10)
	ALERT:C41("Tell class the count "+String:C10(vi1)+" of "+String:C10(vi2))
End for 

vi2:=1
While (vi2<10)
	ALERT:C41("Tell class the count "+String:C10(vi2))
	vi2:=vi2+1
End while 