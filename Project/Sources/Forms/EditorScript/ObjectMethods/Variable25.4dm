// doSearch:=3
// Insert
C_TEXT:C284(MDDemo_HTML; Wiki_PageTitle; Wiki_PageAuthor; Wiki_PageDate)

C_LONGINT:C283($result)

//1 = file exists
//0 = folder exists
//<0 = invalid path, return OS error code
// $result:=Test path name($pathname)

vTextSummary:=Markdown Process Text(vTextSummary; 0)
Wiki_PageTitle:=Markdown Get Doc Title
Wiki_PageAuthor:=Markdown Get Doc Author
Wiki_PageDate:=Markdown Get Doc Date
//  Wiki_PageTOC:=Markdown Get TOC 

//  ALERT("Title: "+Wiki_PageTitle+"\r"+"Author: "+Wiki_PageAuthor+"\r"+"Date: "+Wiki_PageDate+"\r"+"TOC: "+string(Wiki_PageTOC))
