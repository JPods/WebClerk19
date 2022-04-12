//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): jmedlen
// Date and time: 09/01/09, 20:51:33
// ----------------------------------------------------
// Method: TIO_ParseRawTxt
// Description token sensitive 
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20170412_1150 restored original method

C_TEXT:C284($0)  //Type to return, "" is a successful ending
C_TIME:C306($1)  //File ID
C_LONGINT:C283($NonSpace; $i; $k)

If (True:C214)  //Is macOS  line endings CRLF or CR
	// ### jwm ### 20190404_1023 should parse Mac or Windows
	RECEIVE PACKET:C104($1; $RowText; "\r")
	If ($RowText#"")
		If ($RowText[[1]]="\n")
			$RowText:=Substring:C12($RowText; 2)  //strip off Line Feed
		End if 
	End if 
	
Else 
	RECEIVE PACKET:C104($1; $RowText; "\n")
	$RowText:=Substring:C12($RowText; 1; Length:C16($RowText)-1)  //strip off Carriage Return
End if 
If ((OK=1) | (Length:C16($RowText)>5))
	
	If ((OK#1) & (Length:C16($RowText)>5))
		TRACE:C157
	End if 
	If (False:C215)  //### jwm ### 20110216  string array error when string is all spaces
		C_LONGINT:C283($NonSpace)  //Strip leading spaces
		$NonSpace:=1  //assume 1st char is not a space
		$LenText:=Length:C16($RowText)
		If ($LenText#0)  //### jwm ### 20100614 protect against zero length string
			While (($NonSpace<=$LenText) & ($RowText[[$NonSpace]]=" "))
				$NonSpace:=$NonSpace+1
			End while 
		End if 
		If ($NonSpace>1)
			$RowText:=Substring:C12($RowText; $NonSpace)
		End if 
		//### jwm ### 20110216 new procedure trim leading spaces
		$k:=Length:C16($RowText)
		$NonSpace:=0
		For ($i; 1; $k)
			If ($RowText[[$i]]#" ")
				$NonSpace:=$i
				$i:=$k
			End if 
		End for 
		If ($NonSpace#0)
			$RowText:=Substring:C12($RowText; $NonSpace)
		Else 
			$RowText:=""
		End if 
		//### jwm ### 20110216 end new procedure trim leading spaces
	End if 
	//### jwm ### 20110217 trim leading spaces using While statement
	$k:=Length:C16($RowText)
	$NonSpace:=0
	$i:=1  //Starting Character
	While (($i<=$k) & ($NonSpace=0))  //until non space character or end of string
		If ($RowText[[$i]]#" ")
			$NonSpace:=$i
		End if 
		$i:=$i+1
	End while 
	If ($NonSpace#0)
		$RowText:=Substring:C12($RowText; $NonSpace)
	Else 
		$RowText:=""
	End if 
	//### jwm ### 20110217 End trim leading spaces using While statement
	If ($RowText#"")
		
		If (<>viDebugMode>=3)  // ### jwm ### 20170303_1603 could be expanded to case statement
			ConsoleMessage(vtLineNum+"\t"+$RowText)
			//TRACE
		End if 
		
		C_LONGINT:C283($pos)
		$pos:=Position:C15("\t"; $RowText)
		If ($pos>0)
			If ($pos<=21)  //one more then 20 which is the size of $0
				$0:=Substring:C12($RowText; 1; $pos-1)
			Else 
				$0:="xxxError"  //Row data to long for $0, don't return ""
			End if 
			C_TEXT:C284(tTIOTxtData)  //row info
			tTIOTxtData:=Substring:C12($RowText; $pos+1)
			$pos:=Position:C15("\t"; tTIOTxtData)  //look for comment
			If ($pos>0)  //strip it off
				tTIOTxtData:=Substring:C12(tTIOTxtData; 1; $pos-1)
			End if 
		Else 
			$0:=$RowText
			tTIOTxtData:=""
		End if 
	Else 
		$0:="xxxBLANK"  //No Row data, don't return ""
	End if 
Else 
	$0:=""  //successful ending
End if 
