//%attributes = {"publishedWeb":true}
//Procedure: TIOI_Test
C_TEXT:C284(FilePath)
FilePath:=Get_FileName("Find TextIn File:"; "TEXT")
C_TEXT:C284(FilePath2)
FilePath2:=Get_FileName("Find the File to Read:"; "TEXT")
TIOI_ReadFile(->FilePath; ->FilePath2)