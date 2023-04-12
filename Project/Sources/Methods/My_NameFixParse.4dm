//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/21/11, 02:16:31
// ----------------------------------------------------
// Method: My_NameFixParse
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1; $doTableNum)
If (Count parameters:C259=1)
	$doTableNum:=$1
Else 
	$doTableNum:=-1
End if 

C_LONGINT:C283($k; $i)



QUERY:C277([Customer:2]; [Customer:2]company:2="@,@")
FIRST RECORD:C50([Customer:2])
$k:=Records in selection:C76([Customer:2])
For ($i; 1; $k)
	$comma:=Position:C15(","; [Customer:2]company:2)
	[Customer:2]nameLast:23:=Substring:C12([Customer:2]company:2; 1; $comma-1)
	[Customer:2]nameFirst:73:=Substring:C12([Customer:2]company:2; $comma+1)
	SAVE RECORD:C53([Customer:2])
	NEXT RECORD:C51([Customer:2])
End for 

UNLOAD RECORD:C212([Customer:2])








If (($doTableNum=-1) | ($doTableNum=Table:C252(->[Contact:13])))
	CONFIRM:C162("Click OK to parse out of Contact file last name")
	If (OK=1)
		QUERY:C277([Contact:13])
		If (OK=1)
			FIRST RECORD:C50([Contact:13])
			$k:=Records in selection:C76([Contact:13])
			//ThermoInitExit ("Converting Contact Last Name";$k;True)
			$viProgressID:=Progress New
			
			For ($i; 1; $k)
				//Thermo_Update ($i)
				ProgressUpdate($viProgressID; $i; $k; "Converting Contact Last Name")
				
				If (<>ThermoAbort)
					$i:=$k
				End if 
				If ([Contact:13]nameLast:4#"")
					Parse_UnWanted(process_o.entry_o.nameLast)
					SAVE RECORD:C53([Contact:13])
				End if 
				NEXT RECORD:C51([Contact:13])
			End for 
			//Thermo_Close 
			Progress QUIT($viProgressID)
		End if 
	End if 
	UNLOAD RECORD:C212([Contact:13])
End if 
//
If (($doTableNum=-1) | ($doTableNum=Table:C252(->[Customer:2])))
	CONFIRM:C162("Click OK to parse out of [Customer]LastName field to first & last names.")
	If (OK=1)
		QUERY:C277([Customer:2])
		If (OK=1)
			FIRST RECORD:C50([Customer:2])
			$k:=Records in selection:C76([Customer:2])
			//ThermoInitExit ("Converting Customers Last Name";$k;True)
			For ($i; 1; $k)
				//Thermo_Update ($i)
				//If (<>ThermoAbort)
				//$i:=$k
				//End if 
				If (Position:C15(","; [Customer:2]company:2)>0)
					Parse_UnWanted(process_o.entry_o.company)
					SAVE RECORD:C53([Customer:2])
				End if 
				If (False:C215)
					If ([Customer:2]nameLast:23#"")
						Parse_UnWanted(process_o.entry_o.nameLast)
						SAVE RECORD:C53([Customer:2])
					End if 
				End if 
				NEXT RECORD:C51([Customer:2])
			End for 
			//Thermo_Close 
			v1:=""
		End if 
	End if 
	UNLOAD RECORD:C212([Customer:2])
End if 
//

If (($doTableNum=-1) | ($doTableNum=Table:C252(->[Contact:13])))
	CONFIRM:C162("Click OK to replace [Customer]First/LastNames with contacts.")
	If (OK=1)
		C_LONGINT:C283($i)
		
		MESSAGES OFF:C175
		QUERY:C277([Customer:2])
		FIRST RECORD:C50([Customer:2])
		$k:=Records in selection:C76([Customer:2])
		//ThermoInitExit ("Converting Customers Last Name";$k;True)
		$viProgressID:=Progress New
		
		For ($i; 1; $k)
			//Thermo_Update ($i)
			ProgressUpdate($viProgressID; $i; $k; "Converting Customers Last Name")
			If (ThermoAbort)
				$i:=$k
			End if 
			QUERY:C277([Contact:13]; [Contact:13]customerID:1=[Customer:2]customerID:1)
			Case of 
				: (Records in selection:C76([Contact:13])=0)
					//      [Customer]LastName:=""
				: (Records in selection:C76([Contact:13])=1)
					[Customer:2]nameLast:23:=[Contact:13]nameLast:4
					[Customer:2]nameFirst:73:=[Contact:13]nameFirst:2
				: (Records in selection:C76([Contact:13])>1)
					CREATE SET:C116([Contact:13]; "Empty")
					QUERY SELECTION BY FORMULA:C207([Contact:13]; [Contact:13]letterList:13=True:C214)
					If (Records in selection:C76([Contact:13])>0)
						FIRST RECORD:C50([Contact:13])
						[Customer:2]nameLast:23:=[Contact:13]nameLast:4
						[Customer:2]nameFirst:73:=[Contact:13]nameFirst:2
					Else 
						USE SET:C118("Empty")
						FIRST RECORD:C50([Contact:13])
						[Customer:2]nameLast:23:=[Contact:13]nameLast:4
						[Customer:2]nameFirst:73:=[Contact:13]nameFirst:2
					End if 
					CLEAR SET:C117("Empty")
			End case 
			SAVE RECORD:C53([Customer:2])
			UNLOAD RECORD:C212([Customer:2])
			NEXT RECORD:C51([Customer:2])
		End for 
		//Thermo_Close 
		Progress QUIT($viProgressID)
		MESSAGES ON:C181
	End if 
End if 