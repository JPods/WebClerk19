//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/08/19, 18:26:24
// ----------------------------------------------------
// Method: PathToSystem
// Description
// 
//
// Parameters
// ----------------------------------------------------
// needs review by JM
// ### jwm ### 20190305_1442 fucked up by Bill again  -- I made this much harder than is required. 
//      See at bottom. What is important is that documents can be saved in 3 formats and multiple locations
// ### bj ### 20211102_2134  Get rid of this character by character path change
// use Convert path POSIX to system($path)
// and Convert path system to POSIX($path)

// 1. saved from POSIX:  //run an admin cronjob to convert paths to POSIX
// 2. options path saved from Windows:
//     2.1. used on Mac
//         2.1.1. saved in local format
//         2.1.2. saved in server format
//     2.2. used on Windows
//         2.2.1. saved in local format
//         2.2.2. saved in server format
// 3. options path saved from Mac:
//     3.1. used on Mac
//         3.1.1. saved in local format
//         3.1.2. saved in server format
//     3.2. used on Windows
//         1.2.1. saved in local format
//         1.2.2. saved in server format
If (False:C215)
	ConsoleMessage("Paths: "+JSON Stringify:C1217(Storage:C1525.paths))
	var $obPaths : Object
	$obPaths:=Storage:C1525.paths  // these are already in the local OS format
	// POSIX Mac
	$path:="/Volumes/ShareBillPC/CommerceExpert/Customers/411/ArmyFuelCostsAnderson.jpg"
	// Mac: 
	$path:=Convert path POSIX to system:C1107($path)
	//  POSIX Path Windows
	$path:="//"+Storage:C1525.paths.shareServer+"/"+Storage:C1525.paths.shareName+"/CommerceExpert/Customers/411/ArmyFuelCostsAnderson.jpg"
	// Windows
	$path:="\\\\"+Storage:C1525.paths.shareServer+"\\"+Storage:C1525.paths.shareName+"\\"+"CommerceExpert\\Customers\\411\\ArmyFuelCostsAnderson.jpg"
	// Windows
	
	If (False:C215)  // testing
		$path:=Convert path system to POSIX:C1106($path)
	End if 
	If (False:C215)
		$path:=Convert path POSIX to system:C1107($path)
	End if 
End if 


C_TEXT:C284($1; $path; $path; $0)
C_TEXT:C284($2; $warning)
C_LONGINT:C283($p)
C_BOOLEAN:C305($doChange)
C_TEXT:C284($0; $1; $path)
C_TEXT:C284(<>vtServerName; <>vtShareName; $vtServerName; $vtShareName)

$warning:=""
If (Count parameters:C259>1)
	$warning:=$2
End if 

$path:=$1
$0:=$path

If (<>viDebugMode=411)
	ConsoleMessage("start path: "+$path)
End if 
If ($path="")
	$0:=""
Else 
	If (Test path name:C476($path)>=0)  // path works
		$0:=$path
	Else 
		$path:=Convert path POSIX to system:C1107($path)
		If (Test path name:C476($path)>=0)  // path works
			$0:=$path
		Else 
			ConsoleMessage("ERROR: "+String:C10($result)+"  NOT FOUND, try server and local\r"+$path)
			BEEP:C151
			$w:=Position:C15("CommerceExpert"; $path)
			If ($w>0)
				$pathStub:=Substring:C12($path; $w+15)
				$pathStub:=Replace string:C233($pathStub; "/"; Folder separator:K24:12)
				$pathStub:=Replace string:C233($pathStub; ":"; Folder separator:K24:12)
				$pathStub:=Replace string:C233($pathStub; "\\"; Folder separator:K24:12)
				$pathServer:=Storage:C1525.paths.serverComEx+$pathStub
				If (Test path name:C476($pathServer)=1)
					$0:=$pathServer
				Else 
					ConsoleMessage("ERROR: "+String:C10($result)+"  Server FOUND\r"+$pathServer)
					$pathLocal:=Storage:C1525.paths.localComEx+$pathStub
					If (Test path name:C476($pathLocal)=1)
						$0:=$pathLocal
					Else 
						ConsoleMessage("ERROR: "+String:C10($result)+"  Local FOUND\r"+$pathLocal)
					End if 
				End if 
			End if 
		End if 
	End if 
End if 



If (False:C215)
	
	
	If (Test path name:C476($path)>=0)  // path works
		$0:=$path
	Else 
		$path:=Convert path POSIX to system:C1107($path)
		If (Test path name:C476($path)>=0)  // path works
			$0:=$path
		Else 
			If (Storage:C1525.paths.shareName="")
				$0:="Error: no shareName to convert from -- "+$path
				ConsoleMessage($0)
			Else 
				$p:=(Position:C15(Storage:C1525.paths.shareName; $path))
				If ($p<1)  // the path has a shareName
					$p:=(Position:C15("CommerceExpert"; $path))
					If ($p>=1)
						$docPathStub:=Substring:C12($path; $p+Length:C16("CommerceExpert")+1)  /// convert from a Mac server format to Windows
						$docPathStub:=Replace string:C233($docPathStub; "/"; Folder separator:K24:12)
						Case of 
							: (Is macOS:C1572)
								$docPathStub:=Replace string:C233($docPathStub; "\\"; ":")
							: (Is Windows:C1573)
								$docPathStub:=Replace string:C233($docPathStub; ":"; "\\")
						End case 
					Else 
						$0:="Error: path does not contain the shareName "+Storage:C1525.paths.shareName+" -- "+$path
						ConsoleMessage($0)
					End if 
				Else 
					$docPathStub:=Substring:C12($path; $p+Length:C16(Storage:C1525.paths.shareName)+1)  /// convert from a Mac server format to Windows
					
					Case of 
						: (Is macOS:C1572)
							$docPathStub:=Replace string:C233($docPathStub; "\\"; ":")
							$docPathStub:=Replace string:C233($docPathStub; "/"; ":")
							$path:=Storage:C1525.paths.shareName+":"+$docPathStub
						: (Is Windows:C1573)
							$docPathStub:=Replace string:C233($docPathStub; "/"; Folder separator:K24:12)
							$docPathStub:=Replace string:C233($docPathStub; ":"; "\\")
							$path:=Storage:C1525.paths.sharePath+$docPathStub
					End case 
					// clip the shareName and add the serverPath in the local system
					
					If (Test path name:C476($path)>=0)  // path works
						$0:=$path
					Else 
						$0:="Error: not a valid path -- "+$path
						ConsoleMessage($0)
					End if 
				End if 
			End if 
		End if 
	End if 
	
	
	// test to see if it works
	$error:=Test path name:C476($path)
	If ($error=-43)
		// ### bj ### 20200101_1740
		// talk with jm
		// perhaps path is in a foreign format convert to POSIX
		
		If (False:C215)  // DO NOT USE if allready in POSIX
			// this added odd things (/Applications/4D v17.3/)
			// $path was /Users/williamjames/Documents/CommerceExpert/Customers/TimSpo/Photo-QID-36.png
			//   /Applications/4D v17.3/:Users:williamjames:Documents:CommerceExpert:Customers:TimSpo:Photo-QID-36.png
			$path:=Convert path system to POSIX:C1106($path)
		End if 
		// if already in POSIX should make no difference
		
		// convert from POSIX to system
		$systemPath:=Convert path POSIX to system:C1107($path)
		$error:=Test path name:C476($systemPath)
		If ($error=1)
			$path:=$systemPath
			$0:=$systemPath
		End if 
	End if 
	
	Case of 
		: ($error=0)  // valid folder
		: ($error=1)  // valid document
			
		: (($path="http") | ($path="sft") | ($path="smb") | ($path="ftp") | ($path="ssh") | ($path="vnc"))
			// this will never happen
			// if already a universal path, save as is
			
		: ((<>vtServerName="") | (<>vtShareName=""))
			//done
		: ((Substring:C12($path; 1; 2)="\\\\") & (Not:C34(Is macOS:C1572)))
			//done  this is bad logic !!!
		Else 
			// test the path for local and server and CommerceExpert
			// works, there is no need for the array to test with
			C_TEXT:C284($vtToArray)
			$vtToArray:=$path  // never change $path 
			// KEEP ASIS so we know if it is a doc or folder
			$vtToArray:=Replace string:C233($vtToArray; "\\"; ":")
			$vtToArray:=Replace string:C233($vtToArray; "::"; ":")
			$vtToArray:=Replace string:C233($vtToArray; "/"; ":")
			ARRAY TEXT:C222($atPath; 0)
			TextToArray($vtToArray; ->$atPath; ":"; False:C215)  // split the path into folders
			
			C_LONGINT:C283($incRay; $cntRay)
			// setup to test path options and CommerceExpert folder on local and server
			C_TEXT:C284($localPath; $serverPath; $comExPath; $rootPath; $path)
			C_LONGINT:C283($sizeArray; $rayRisk)
			C_TEXT:C284($element1; $element2; $behavior)
			$sizeArray:=Size of array:C274($atPath)
			Case of   // manage array size risk
				: ($sizeArray>1)
					$element1:=$atPath{1}
					$element2:=$atPath{2}
				: ($sizeArray>0)
					$element1:=$atPath{1}
				Else 
					$element1:=""
					$element2:=""
			End case 
			Case of 
				: (($element1="") & ($element2=""))
					$behavior:="noserver"
					$serverPath:=""
				: ($element1=<>vtShareName)  // this is a mac formated server path
					$behavior:="server: Mac Path"
					For ($incRay; 2; $sizeArray)  // build up the path minus servers
						$rootPath:=$rootPath+Folder separator:K24:12+$atPath{$incRay}
					End for 
					If (Is macOS:C1572)
						$serverPath:=<>vtShareName  // root path begins with folder seperator +Folder separator  //  ================= CHECK THIS ====================
					Else 
						If (<>vtShareName#"")  // there is a server defined
							$serverPath:="\\\\"+<>vtServerName+"\\"+<>vtShareName  // root path begins with folder seperator +"\\"
						End if 
					End if 
				: (($element1=<>vtServerName) & ($element2=<>vtShareName))  // this is a PC formated server path
					$behavior:="server: PC Path"
					// bypass the risk of same named server and share
					For ($incRay; 3; $sizeArray)  // build up the path minus servers
						$rootPath:=$rootPath+Folder separator:K24:12+$atPath{$incRay}
					End for 
					If (Is macOS:C1572)
						$serverPath:=<>vtShareName  //  +Folder separator
					Else 
						$serverPath:="\\\\"+<>vtServerName+"\\"+<>vtShareName  //+"\\"  // ### jwm ### 20190307_1915
					End if 
			End case 
			// there are now two three possible paths
			$error:=-1
			If ($serverPath#"")  // test the server path
				$path:=$serverPath+$rootPath
				$error:=Test path name:C476($path)
				//TRACE
				If ($error>=0)
					$0:=$path  // path worked and the effort ends
					If (<>viDebugMode=411)
						ConsoleMessage("valid server path: "+$path)
					End if 
				End if 
			End if 
			If ($error<0)  // path failed, check for ComEx folder
				$p:=Position:C15("CommerceExpert"; $rootPath)  // check the path without server and share
				If ($p<1)
					$0:=$path  // return what we were given. There is no server or ComEx paths to test
					If (<>viDebugMode=411)
						ConsoleMessage("No server, path failed, no CommerceExpert folder: "+$rootPath)
					End if 
				Else   // test ComEx folders locally and on server
					$comExPath:=Substring:C12($rootPath; $p)
					$path:=Storage:C1525.folder.jitF+$comExPath
					$error:=Test path name:C476($path)
					If ($error>=0)  // valid local path
						$0:=$path
						If (<>viDebugMode=411)
							ConsoleMessage("Local ComEx path valid: "+$path)
						End if 
					Else 
						If ($serverPath#"")
							$path:=$serverPath+$comExPath
							$error:=Test path name:C476($path)
							If ($error>=0)
								// valid server path
								$0:=$path
								If (<>viDebugMode=411)
									ConsoleMessage("Server ComEx path valid: "+$path)
								End if 
							End if 
						End if 
					End if 
				End if 
			End if 
	End case 
End if 