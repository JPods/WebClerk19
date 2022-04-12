//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/07/12, 00:25:00
// ----------------------------------------------------
// Method: DefaultSetupReturn
// Description
// $0 Returns UniqueID, -1 is returned if no record is found
// <>aDSType{$w} is a string name of the setting desired
// $ptVariable is pointer into which the value of the variable is returned. This must be of the correct type
// 
// ----------------------------------------------------
// Modified by: williamjames (121107)


C_LONGINT:C283($0; $w; $type)
C_TEXT:C284($1)
C_POINTER:C301($2; $ptVariable)
If (Count parameters:C259=1)
	$ptVariable:=Get pointer:C304($1)
Else 
	$ptVariable:=$2  // allows default variables to be created for 
	//                  non-existing variables and purposes.
End if 
$0:=-2
If (Not:C34(Is nil pointer:C315($ptVariable)))
	$0:=-1
	$w:=Find in array:C230(<>aDSVariableName; $1)
	$type:=Type:C295($ptVariable->)
	If ($w>0)
		Case of 
			: (<>aDSType{$w}="Is Boolean")  //6
				$ptVariable->:=(<>aDSValue{$w}="true")
			: (<>aDSType{$w}="Is Date")  //4
				$ptVariable->:=Date:C102(<>aDSValue{$w})
			: (<>aDSType{$w}="Is Integer")  //8
				$ptVariable->:=Num:C11(<>aDSValue{$w})
			: ((<>aDSType{$w}="Is LongInt") | (<>aDSType{$w}="Is Integer 64 bits") | (<>aDSType{$w}="Is Integer 64 bits"))
				$ptVariable->:=Num:C11(<>aDSValue{$w})
			: ((<>aDSType{$w}="Is Real") | (<>aDSType{$w}="Is Float"))
				$ptVariable->:=Num:C11(<>aDSValue{$w})
			: (<>aDSType{$w}="Is String Var")  //24
				$ptVariable->:=<>aDSValue{$w}
			: (<>aDSType{$w}="Is Time")  //11
				$ptVariable->:=Time:C179(<>aDSValue{$w})
			: (<>aDSType{$w}="Is Alpha Field")  //0
				$ptVariable->:=<>aDSValue{$w}
		End case 
	End if 
End if 
$0:=$w

If (False:C215)
	
	//did not work
	
	Case of 
		: ($type=Is boolean:K8:9)  //6
			$ptVariable->:=((<>aDSValue{$w}="t@") | (<>aDSValue{$w}="Y@") | (<>aDSValue{$w}="1"))
		: ($type=Is date:K8:7)  //4
			$ptVariable->:=Date:C102(<>aDSValue{$w})
		: ($type=Is integer:K8:5)  //8
			$ptVariable->:=Num:C11(<>aDSValue{$w})
		: (($type=Is longint:K8:6) | ($type=Is integer 64 bits:K8:25) | ($type=Is integer 64 bits:K8:25))
			$ptVariable->:=Num:C11(<>aDSValue{$w})
		: (($type=Is real:K8:4) | ($type=_o_Is float:K8:26))
			$ptVariable->:=Num:C11(<>aDSValue{$w})
		: ($type=Is string var:K8:2)  //24
			$ptVariable->:=<>aDSValue{$w}
		: ($type=Is time:K8:8)  //11
			$ptVariable->:=Time:C179(<>aDSValue{$w})
		: ($type=Is alpha field:K8:1)  //0
			$ptVariable->:=<>aDSValue{$w}
	End case 
	
	
	Case of 
		: (<>aDSType{$w}="Is Boolean")  //6
			$ptVariable->:=(<>aDSValue{$w}="true")
		: (<>aDSType{$w}="Is Date")  //4
			$ptVariable->:=Date:C102(<>aDSValue{$w})
		: (<>aDSType{$w}="Is Integer")  //8
			$ptVariable->:=Num:C11(<>aDSValue{$w})
		: ((<>aDSType{$w}="Is LongInt") | (<>aDSType{$w}="Is Integer 64 bits") | (<>aDSType{$w}="Is Integer 64 bits"))
			$ptVariable->:=Num:C11(<>aDSValue{$w})
		: ((<>aDSType{$w}="Is Real") | (<>aDSType{$w}="Is Float"))
			$ptVariable->:=Num:C11(<>aDSValue{$w})
		: (<>aDSType{$w}="Is String Var")  //24
			$ptVariable->:=<>aDSValue{$w}
		: (<>aDSType{$w}="Is Time")  //11
			$ptVariable->:=Time:C179(<>aDSValue{$w})
		: (<>aDSType{$w}="Is Alpha Field")  //0
			$ptVariable->:=<>aDSValue{$w}
	End case 
	
	
	
	Case of 
			
		: (<>aDSType{$w}="Is Picture")  //3
			
		: (<>aDSType{$w}="Is Pointer")  //23
			
			
		: (<>aDSType{$w}="Is Text")  //2
			
			
		: (<>aDSType{$w}="Is BLOB")  //30
			
		: (<>aDSType{$w}="Is Undefined")  //5
			
		: (<>aDSType{$w}="LongInt array")  //16
			
		: (<>aDSType{$w}="Picture array")  //19
			
		: (<>aDSType{$w}="Pointer array")  //20
			
		: (<>aDSType{$w}="Real array")  //14
			
		: (<>aDSType{$w}="String array")  //21
			
		: (<>aDSType{$w}="Text array")  //18
			
		: (<>aDSType{$w}="Array 2D")  //13
			
		: (<>aDSType{$w}="Boolean array")  //22
			
		: (<>aDSType{$w}="Date array")  //17
			
		: (<>aDSType{$w}="Integer array")  //15
			
		: (<>aDSType{$w}="Is Subtable")  //7
			
	End case 
End if 