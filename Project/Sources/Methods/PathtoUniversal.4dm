//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/25/18, 00:45:50
// ----------------------------------------------------
// Method: PathtoUniversal
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($0; $1; $thePath)
C_TEXT:C284(<>vtServerName; <>vtShareName; $vtServerName; $vtShareName)
// interprocess variables contain Folder Seperators 
$thePath:=$1

If ((<>vtServerName="") | (<>vtShareName=""))
	// no server to reference
	// we are done
	If (<>viDebugMode>410)
		ConsoleMessage("No server paths defined: <>vtServerName or <>vtShareName are empty in Defaults")
	End if 
Else 
	Case of 
		: (($thePath="http") | ($thePath="sft") | ($thePath="ftp") | ($thePath="ssh") | ($thePath="vnc"))
			// if already a universal path, save as is
			
		: (Substring:C12($thePath; 1; 2)="\\\\")  // not each is escaped  (\\ServerName\ShareName\PathToFile)  
			// if already a universal path, save as is
			
		: (Substring:C12($thePath; 1; 2)="C:")  // not each is escaped  (\\ServerName\ShareName\PathToFile)  
			// Drop out is it a local PC path
		: (Substring:C12($thePath; 1; 2)="D:")  // not each is escaped  (\\ServerName\ShareName\PathToFile)  
			// Drop out is it a local PC path
			
		Else 
			
			$thePath:=Replace string:C233($thePath; "\\"; ":")  //  (ServerName\ShareName\PathToFile)
			$thePath:=Replace string:C233($thePath; "::"; ":")  // clear single letter drive :
			
			
			ARRAY TEXT:C222($atPath; 0)
			TextToArray($thePath; ->$atPath; ":"; False:C215)  // split the path into folders
			// these should not have "\\"
			$vtServerName:=Replace string:C233(<>vtServerName; "\\"; "")
			$vtShareName:=Replace string:C233(<>vtShareName; "\\"; "")
			
			Case of 
				: (Length:C16($atPath{1})=1)  // Mapped drive letter
					$atPath{1}:=$vtServerName+"\\"+$vtShareName
				: ($atPath{1}=$vtShareName)  //  add the server name if there is one
					$atPath{1}:=$vtServerName+"\\"+$vtShareName
			End case 
			
			C_TEXT:C284($leadStr)
			$thePath:=""  // clear out the path to rebuild it
			If (Size of array:C274($atPath)=0)
				$0:=""
			Else 
				C_LONGINT:C283($incRay; $cntRay)
				$cntRay:=Size of array:C274($atPath)  // rebuild the path
				For ($incRay; 1; $cntRay)
					$thePath:=$thePath+$atPath{$incRay}
					If ($incRay<$cntRay)
						$thePath:=$thePath+"\\"
					End if 
				End for 
			End if 
			$thePath:="\\\\"+$thePath
	End case 
	
End if 
$0:=$thePath