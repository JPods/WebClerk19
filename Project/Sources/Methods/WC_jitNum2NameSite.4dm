//%attributes = {"publishedWeb":true}


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-05-08T00:00:00, 14:47:50
// ----------------------------------------------------
// Method: WC_jitNum2NameSite
// Description
// Modified: 05/08/17
// 
// 
//
// Parameters
// ----------------------------------------------------

// Name

C_LONGINT:C283($err; $i; $k)
C_TEXT:C284($1; $doHtml)
C_TEXT:C284($tableNumFold; $theSite)
C_LONGINT:C283($doNum2Name)
C_POINTER:C301($ptFldArray)
$doNum2Name:=0
If (Count parameters:C259=1)
	$doHtml:=$1
Else 
	$doHtml:="Named"
End if 
Case of 
	: ($doHtml="Numbered")
		CONFIRM:C162("Convert site to Numbered Html Tags?")
		$doNum2Name:=Num:C11(OK=1)
	: ($doHtml="Named")
		CONFIRM:C162("Convert site to Named Html Tags?")
		$doNum2Name:=Num:C11(OK=1)*2
End case 
If ($doNum2Name>0)
	$tableNumFold:=Get_FolderName("Select folder to List Files.")
	If ($tableNumFold#"")
		ARRAY TEXT:C222(aText1; 0)
		$error:=HFS_CatToArray($tableNumFold; "aText1")
		$k:=Size of array:C274(aText1)
		C_TEXT:C284($theBody; $testText; $thePage; $theHead; $buildPage)
		C_LONGINT:C283($i; $k; $myOK)
		For ($i; 1; $k)
			$buildPage:=""
			MESSAGE:C88(String:C10($i)+" to zero")
			$bodyBeg:=Position:C15("."; aText1{$i})
			If ($bodyBeg>0)
				myDoc:=Open document:C264($tableNumFold+aText1{$i})
				If (OK=1)
					$thePage:=""
					RECEIVE PACKET:C104(myDoc; vText10; 2000000000)
					If (OK=1)
						CLOSE DOCUMENT:C267(myDoc)
						If (OK=1)
							vText10:=WC_jitNum2Name(vText10; $doHtml)
							
							// ### bj ### 20190925_0341
							// $myOK was always zero
							
							//  If ($myOK=1)
							$err:=HFS_Delete($tableNumFold+aText1{$i})
							If ($err=0)
								myDoc:=Create document:C266($tableNumFold+aText1{$i})
								If (OK=1)
									SEND PACKET:C103(myDoc; vText10)
									CLOSE DOCUMENT:C267(myDoc)
								End if 
								//  End if 
							End if 
						End if 
					End if 
				End if 
			End if 
		End for 
	End if 
End if 


REDRAW WINDOW:C456

// ### bj ### 20190721_2307
// delete or modify above
If (False:C215)  // from v121
	
	
	
	
	// ----------------------------------------------------
	// User name (OS): Bill James
	// Date and time: 2017-05-08T00:00:00, 14:47:50
	// ----------------------------------------------------
	// Method: WC_jitNum2NameSite
	// Description
	// Modified: 05/08/17
	// 
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
	// Name
	TRACE:C157
	C_LONGINT:C283($err; $i; $k)
	C_TEXT:C284($1; $vtConvertTo)
	C_TEXT:C284($tableNumFold; $theSite)
	C_LONGINT:C283($doNum2Name)
	C_POINTER:C301($ptFldArray)
	$doNum2Name:=0
	If (Count parameters:C259=1)
		$vtConvertTo:=$1
	Else 
		$vtConvertTo:=Request:C163("Convert to Named or Numbered?"; "Named")
		If (OK=0)
			$vtConvertTo:=""
		End if 
	End if 
	Case of 
		: ($vtConvertTo="Numbered")
			CONFIRM:C162("Convert site to Numbered Html Tags?")
			$doNum2Name:=Num:C11(OK=1)
		: ($vtConvertTo="Named")
			CONFIRM:C162("Convert site to Named Html Tags?")
			$doNum2Name:=Num:C11(OK=1)*2
	End case 
	If ($doNum2Name>0)
		$tableNumFold:=Get_FolderName("Select folder to List Files.")
		If ($tableNumFold#"")
			ARRAY TEXT:C222(aText1; 0)
			$error:=HFS_CatToArray($tableNumFold; "aText1")
			$k:=Size of array:C274(aText1)
			C_TEXT:C284($theBody; $testText; $thePage; $theHead; $buildPage)
			C_LONGINT:C283($i; $k; $myOK)
			For ($i; 1; $k)
				$buildPage:=""
				MESSAGE:C88(String:C10($i)+" to zero")
				$bodyBeg:=Position:C15("."; aText1{$i})
				If ($bodyBeg>0)
					If (aText1{$i}#".@")
						myDoc:=Open document:C264($tableNumFold+aText1{$i})
						If (OK=1)
							$thePage:=""
							RECEIVE PACKET:C104(myDoc; vText10; 2000000000)
							If (OK=1)
								CLOSE DOCUMENT:C267(myDoc)
								If (OK=1)
									vText10:=WC_jitNum2Name(vText10; $vtConvertTo)
									If ($myOK=1)
										$err:=HFS_Delete($tableNumFold+aText1{$i})
										If ($err=0)
											myDoc:=Create document:C266($tableNumFold+aText1{$i})
											If (OK=1)
												SEND PACKET:C103(myDoc; vText10)
												CLOSE DOCUMENT:C267(myDoc)
											End if 
										End if 
									End if 
								End if 
							End if 
						End if 
					End if 
				End if 
			End for 
		End if 
	End if 
	
	
	REDRAW WINDOW:C456
	
End if 
