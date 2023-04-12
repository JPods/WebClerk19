//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 03/17/20, 13:36:37
// ----------------------------------------------------
// Method: URL_Decode
// Description
// 
//
// Parameters
// ----------------------------------------------------


//<declarations>
//==================================
//  Type variables 
//==================================

C_LONGINT:C283($vi1; $vi2; $viCode)
C_TEXT:C284($1; $vtChar; $vtCode; $vtCode1; $vtCode2; $vtDecoded; $vtEncoded; $vtString)

//==================================
//  Initialize variables 
//==================================

$vi1:=0
$vi2:=0
$viCode:=0
$vtChar:=""
$vtCode:=""
$vtCode1:=""
$vtCode2:=""
$vtDecoded:=""
$vtEncoded:=""
$vtString:=""
//</declarations>

//================================================================  
//  URL Decode  
//================================================================

$vtString:=$1
$vtDecoded:=""

//Console_Log ($vtString)

$vi1:=0
$vi2:=Length:C16($vtString)


If ($vi2>0)
	
	Repeat 
		
		$vi1:=$vi1+1
		$vtChar:=$vtString[[$vi1]]
		$viCode:=Character code:C91($vtString[[$vi1]])
		
		Case of 
			: (Match regex:C1019("[A-Za-z0-9_]"; $vtChar; 1))
				
				$vtDecoded:=$vtDecoded+$vtChar
				
			: (Match regex:C1019("[+]"; $vtChar; 1))
				$vtDecoded:=$vtDecoded+" "
				
				
			: ($vtChar="%")
				
				$vi1:=$vi1+1  // move pointer to character after the %
				$vtCode:=Substring:C12($vtString; $vi1; 2)  // Get the next 2 characters
				
				//================================================================  
				//  Convert 2 digit Hex as string to Decimal  
				//================================================================
				
				$vtCode1:=$vtCode[[1]]
				$vtCode2:=$vtCode[[2]]
				
				Case of 
					: (Match regex:C1019("[0-9]"; $vtCode1; 1))
						$viCode:=Num:C11($vtCode1)*16
						
					: (Match regex:C1019("[A-F]"; $vtCode1; 1))
						
						Case of 
							: ($vtCode1="A")
								$viCode:=10*16
								
							: ($vtCode1="B")
								$viCode:=11*16
								
							: ($vtCode1="C")
								$viCode:=12*16
								
							: ($vtCode1="D")
								$viCode:=13*16
								
							: ($vtCode1="E")
								$viCode:=14*16
								
							: ($vtCode1="F")
								$viCode:=15*16
								
						End case 
						
				End case 
				
				// decode Hex Characters
				
				Case of 
					: (Match regex:C1019("[0-9]"; $vtCode2; 1))
						$viCode:=$viCode+Num:C11($vtCode2)
						
					: (Match regex:C1019("[A-F]"; $vtCode2; 1))
						
						Case of 
							: ($vtCode2="A")
								$viCode:=$viCode+10
								
							: ($vtCode2="B")
								$viCode:=$viCode+11
								
							: ($vtCode2="C")
								$viCode:=$viCode+12
								
							: ($vtCode2="D")
								$viCode:=$viCode+13
								
							: ($vtCode2="E")
								$viCode:=$viCode+14
								
							: ($vtCode2="F")
								$viCode:=$viCode+15
								
						End case 
						
				End case 
				
				$vtChar:=Char:C90($viCode)
				$vtDecoded:=$vtDecoded+$vtChar
				
				$vi1:=$vi1+1
				
			Else 
				
				$vtDecoded:=$vtDecoded+$vtChar
		End case 
		
	Until ($vi1=$vi2)
	
End if 
//Console_Log ($vtDecoded)

$0:=$vtDecoded