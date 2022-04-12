//%attributes = {"publishedWeb":true}
//Procedure: TIOI_AddExitCmd
//Inserts an Exit Loop command: to function as a un-conditional brach
C_LONGINT:C283($0)  //return corrected size of arrays
C_LONGINT:C283($1)  //Element to insert Exit Loop command
INSERT IN ARRAY:C227(aTIOTypeCd; $1)
INSERT IN ARRAY:C227(aTIOTypePtr; $1)
INSERT IN ARRAY:C227(aTIOTyIndex; $1)
aTIOTypeCd{$1}:=<>ciTInExitLp
TIOI_StackIXPsh($1)  //allows correction when end of structure (i.e. Loop, Is List) is encountered
aTIOTypePtr{$1}:=->[Control:1]Approved:1  //a non-error generic result 
aTIOTyIndex{$1}:=32000  //pre fill index that will terminate if not updated by an end loop
$0:=Size of array:C274(aTIOTypeCd)  //return corrected Size of array