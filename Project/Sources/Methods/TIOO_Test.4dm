//%attributes = {"publishedWeb":true}
C_TEXT:C284(FilePathin)
C_TEXT:C284(FilePathout)
FilePathout:=Get_FolderName("select output directory")
FilePathin:=Get_FileName("Find TextOut File:"; "TEXT")
TRACE:C157
TIOO_ReadFile(->FilePathin; ->FilePathout)