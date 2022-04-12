//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-08-19T00:00:00, 09:32:02
// ----------------------------------------------------
// Method: URpt_SetTypePop
// Description
// Modified: 08/19/13
// 
// 
//
// Parameters
// ----------------------------------------------------

// ### bj ### 20190117_0206
// remove this duplication at some point

Case of 
	: (([UserReport:46]Creator:6="Oth@") | ([UserReport:46]Creator:6=""))
		[UserReport:46]Creator:6:="Other"
		<>yURptTypes:=1
	: (([UserReport:46]Creator:6="GTSR") | ([UserReport:46]Creator:6="SuperReport") | ([UserReport:46]Creator:6="Super Report") | ([UserReport:46]Creator:6="Sup@"))
		[UserReport:46]Creator:6:="SuperReport"
		<>yURptTypes:=2
	: (([UserReport:46]Creator:6="JITA") | ([UserReport:46]Creator:6="QuickReport") | ([UserReport:46]Creator:6="Qui@"))
		[UserReport:46]Creator:6:="QuickReport"
		<>yURptTypes:=3
	: (([UserReport:46]Creator:6="FRmk") | ([UserReport:46]Creator:6="EDIx") | ([UserReport:46]Creator:6="Execute") | ([UserReport:46]Creator:6="Scri@"))
		[UserReport:46]Creator:6:="Script"
		<>yURptTypes:=4
	: (([UserReport:46]Creator:6="Text-Out") | ([UserReport:46]Creator:6="TxtO") | ([UserReport:46]Creator:6="Text@"))
		[UserReport:46]Creator:6:="Text-Out"
		<>yURptTypes:=5
		
	: (([UserReport:46]Creator:6="EDIO") | ([UserReport:46]Creator:6="EDI-Out") | ([UserReport:46]Creator:6="EDI Out"))
		[UserReport:46]Creator:6:="EDI-Out"
		<>yURptTypes:=6
		
	: (([UserReport:46]Creator:6="EDI In") | ([UserReport:46]Creator:6="EDI-In") | ([UserReport:46]Creator:6="EDII"))
		[UserReport:46]Creator:6:="EDI-In"
		<>yURptTypes:=7
		
		// 8 is a repeat of scripts
		
	: (([UserReport:46]Creator:6="MySv") | ([UserReport:46]Creator:6="Serv@"))
		[UserReport:46]Creator:6:="Service"
		<>yURptTypes:=9
	: (([UserReport:46]Creator:6="ScOp") | ([UserReport:46]Creator:6="Sch@"))
		[UserReport:46]Creator:6:="Schedule"
		<>yURptTypes:=10
		
	: (([UserReport:46]Creator:6="Tiny@") | ([UserReport:46]Creator:6="TMCE"))
		[UserReport:46]Creator:6:="TinyMCE"
		<>yURptTypes:=11
		
	: (([UserReport:46]Creator:6="Ema@") | ([UserReport:46]Creator:6="mail"))
		[UserReport:46]Creator:6:="Email"
		<>yURptTypes:=12
		
	: (([UserReport:46]Creator:6="Fax Attachment@") | ([UserReport:46]Creator:6="4com"))
		[UserReport:46]Creator:6:="Fax"
		<>yURptTypes:=13
		
	: (([UserReport:46]Creator:6="Brow@") | ([UserReport:46]Creator:6="Brow"))
		[UserReport:46]Creator:6:="Browser"
		<>yURptTypes:=14
		
	: (([UserReport:46]Creator:6="Clip@") | ([UserReport:46]Creator:6="Clipboard") | ([UserReport:46]Creator:6="pasteboard"))
		[UserReport:46]Creator:6:="Clipboard"
		<>yURptTypes:=15
		
End case 
aLoText5:=<>yURptTypes
[UserReport:46]TypeDoc:21:=[UserReport:46]Creator:6

//  <>yURptTypes{1}:="Other"  //1 must always be other
//  <>yURptCreatr{1}:=""
//  <>yURptTypes{2}:="SuperReport"
//  <>yURptCreatr{2}:="GTSR"
//  <>yURptTypes{3}:="QuickReport"
//  <>yURptCreatr{3}:="JITA"
//  <>yURptTypes{4}:="Script"
//  <>yURptCreatr{4}:="FRmk"
//  <>yURptTypes{5}:="Text-Out"
//  <>yURptCreatr{5}:="TxtO"
//  <>yURptTypes{6}:="EDI-Out"
//  <>yURptCreatr{6}:="EDIO"
//  <>yURptTypes{7}:="EDI In"
//  <>yURptCreatr{7}:="EDII"
//  <>yURptTypes{8}:="Script"
//  <>yURptCreatr{8}:="EDIx"
//  <>yURptTypes{9}:="Service"
//  <>yURptCreatr{9}:="MySv"
//  <>yURptTypes{10}:="Schedule"
//  <>yURptCreatr{10}:="ScOp"
//  <>yURptTypes{11}:="TinyMCE"
//  <>yURptCreatr{11}:="TMCE"
//  <>yURptTypes{12}:="Email"
//  <>yURptCreatr{12}:="Mail"
//  <>yURptTypes{13}:="Fax Attachment"
//  <>yURptCreatr{13}:="4com"
//  <>yURptTypes{14}:="Browser"
//  <>yURptCreatr{14}:="Brow"
//  <>yURptTypes{15}:="Clipboard"
//  <>yURptCreatr{15}:="Clip"