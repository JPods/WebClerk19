//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: txtDateFrom
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 




C_TEXT:C284($1; $theDate; $theContinueQuery)
C_LONGINT:C283($0; $2; $3; $theType)
C_POINTER:C301($4)
C_DATE:C307(vTmpDateBeg; vTmpDateEnd)
vTmpDateBeg:=!00-00-00!
vTmpDateEnd:=!00-00-00!
$theDate:=$1
$0:=$3
If ($3>0)
	$theContinueQuery:="; &"
Else 
	$theContinueQuery:=";"
End if 
C_POINTER:C301($ptTable)
$ptTable:=Table:C252(Table:C252($4))
$theType:=Type:C295($4->)
C_TEXT:C284($nameTable; $nameField)
$nameTable:=Table name:C256(Table:C252($ptTable))
$nameTable:="["+$nameTable+"]"
$nameField:=Field name:C257(Table:C252($ptTable); Field:C253($4))
TRACE:C157
If ($theDate#"")
	If (($theType=Is longint:K8:6) & ($theDate="0"))  //date  
		If ($0=0)
			//QUERY($ptTable->;$4->>=0;*)
			vURLQueryScript:=vURLQueryScript+"QUERY("+$nameTable+$theContinueQuery+$nameTable+$nameField+">=0;*)"+"\r"
		Else 
			//QUERY($ptTable->;&$4->>=0;*)
			vURLQueryScript:=vURLQueryScript+"QUERY("+$nameTable+";&"+$nameTable+$nameField+">=0;*)"+"\r"
		End if 
	Else 
		C_LONGINT:C283($p)
		$p:=Position:C15(";"; $theDate)
		Case of 
			: (Length:C16($theDate)=0)  //protect from crash
			: ($theDate[[1]]="=")
				vTmpDateBeg:=Date_GoFigure(Substring:C12($theDate; 2))
				vTmpDateEnd:=vTmpDateBeg
			: ($theDate[[1]]="<")
				vTmpDateBeg:=!00-00-00!
				vTmpDateEnd:=Date_GoFigure(Substring:C12($theDate; 2))
			: ($theDate[[1]]=">")
				vTmpDateBeg:=Date_GoFigure(Substring:C12($theDate; 2))
				vTmpDateEnd:=!00-00-00!
			: ($p=1)
				vTmpDateBeg:=!00-00-00!
				vTmpDateEnd:=Date_GoFigure(Substring:C12($theDate; 2))
			: ($p=0)
				vTmpDateBeg:=Date_GoFigure($theDate)
				vTmpDateEnd:=vTmpDateBeg
			Else 
				vTmpDateBeg:=Date_GoFigure(Substring:C12($theDate; 1; $p-1))
				vTmpDateEnd:=Date_GoFigure(Substring:C12($theDate; $p+1))
		End case 
		Case of 
			: ((($2=1) & ($3>0)) | ($1="0"))
				Case of 
					: (Type:C295($4->)=Is date:K8:7)  //date
						If (vTmpDateBeg#!00-00-00!)
							//QUERY($ptTable->;&$4->>=vTmpDateBeg;*)
							vURLQueryScript:=vURLQueryScript+"QUERY("+$nameTable+";&"+$nameTable+$nameField+">="+String:C10(vTmpDateBeg)+";*)"+"\r"
							$0:=$3+1
						End if 
						If (vTmpDateEnd#!00-00-00!)
							//QUERY($ptTable->;&$4-><=vTmpDateEnd;*)
							vURLQueryScript:=vURLQueryScript+"QUERY("+$nameTable+";&"+$nameTable+$nameField+"<="+String:C10(vTmpDateEnd)+";*)"+"\r"
							$0:=$3+1
						End if 
					: (Type:C295($4->)=Is longint:K8:6)  //9
						If (vTmpDateBeg#!00-00-00!)
							$DTitem:=DateTime_Enter(vTmpDateBeg)
							//QUERY($ptTable->;&$4->>=$DTitem;*)
							vURLQueryScript:=vURLQueryScript+"QUERY("+$nameTable+";&"+$nameTable+$nameField+">="+String:C10($DTitem)+";*)"+"\r"
							$0:=$3+1
						End if 
						If (vTmpDateEnd#!00-00-00!)
							$DTitem:=DateTime_Enter(vTmpDateEnd; ?23:59:59?)
							//QUERY($ptTable->;&$4-><=$DTitem;*)
							vURLQueryScript:=vURLQueryScript+"QUERY("+$nameTable+";&"+$nameTable+$nameField+"<="+String:C10($DTitem)+";*)"+"\r"
							$0:=$3+1
						End if 
				End case 
				vTmpDateBeg:=!00-00-00!
				vTmpDateEnd:=!00-00-00!
			: (($2=1) & ($3=0))
				$ptTable:=Table:C252(Table:C252($4))
				Case of 
					: (Type:C295($4->)=Is date:K8:7)  //date
						If (vTmpDateBeg#!00-00-00!)
							//QUERY($ptTable->;$4->>=vTmpDateBeg;*)
							vURLQueryScript:=vURLQueryScript+"QUERY("+$nameTable+$theContinueQuery+$nameTable+$nameField+">="+String:C10(vTmpDateBeg)+";*)"+"\r"
							$0:=$3+1
						End if 
						If (vTmpDateEnd#!00-00-00!)
							If ($3=0)
								//QUERY($ptTable->;$4-><=vTmpDateEnd;*)
								vURLQueryScript:=vURLQueryScript+"QUERY("+$nameTable+$theContinueQuery+$nameTable+$nameField+"<="+String:C10(vTmpDateEnd)+";*)"+"\r"
							Else 
								//QUERY($ptTable->;&$4-><=vTmpDateEnd;*)
								vURLQueryScript:=vURLQueryScript+"QUERY("+$nameTable+";&"+$nameTable+$nameField+"<="+String:C10(vTmpDateEnd)+";*)"+"\r"
								$0:=$3+1
							End if 
						End if 
					: (Type:C295($4->)=Is longint:K8:6)  //9
						If (vTmpDateBeg#!00-00-00!)
							$DTitem:=DateTime_Enter(vTmpDateBeg)
							//QUERY($ptTable->;$4->>=$DTitem;*)
							vURLQueryScript:=vURLQueryScript+"QUERY("+$nameTable+$theContinueQuery+$nameTable+$nameField+">="+String:C10($DTitem)+";*)"+"\r"
							$0:=$3+1
						End if 
						If (vTmpDateEnd#!00-00-00!)
							$DTitem:=DateTime_Enter(vTmpDateEnd; ?23:59:59?)
							If ($0=0)
								//QUERY($ptTable->;$4-><=$DTitem;*)
								vURLQueryScript:=vURLQueryScript+"QUERY("+$nameTable+$theContinueQuery+$nameTable+$nameField+"<="+String:C10($DTitem)+";*)"+"\r"
							Else 
								//QUERY($ptTable->;&$4-><=$DTitem;*)
								vURLQueryScript:=vURLQueryScript+"QUERY("+$nameTable+";&"+$nameTable+$nameField+"<="+String:C10($DTitem)+";*)"+"\r"
								$0:=$3+1
							End if 
						End if 
				End case 
				vTmpDateBeg:=!00-00-00!
				vTmpDateEnd:=!00-00-00!
		End case 
	End if 
End if 