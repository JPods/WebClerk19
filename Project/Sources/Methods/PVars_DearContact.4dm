//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-27T06:00:00Z)
// Method: PVars_DearContact
// Description 
// Parameters
// ----------------------------------------------------




C_BOOLEAN:C305($1)
C_POINTER:C301($2; $3; $4; $5; $6; $7; $8; $9)
C_BOOLEAN:C305($doLess)
//what are the pointers
//$1:=Individual
//$2:=([Contact]Salutation)
//$3:=([Contact]FirstName)
//$4:=([Contact]LastName)
//$5; Related Contacts Acct Field
//$6; Search Related By Field
//$7;Boo, Ltr List
//$8; Saluation Field
//$9; First Name Field
//$10; Last Name Field
//
$doLess:=False:C215
If ($1)
	$doLess:=True:C214
Else 
	Case of 
		: (($3->#"") & ($4->#""))
			$doLess:=True:C214
		: (Count parameters:C259>4)
			QUERY:C277(Table:C252(Table:C252($6))->; $6->=$5->; *)
			QUERY:C277(Table:C252(Table:C252($6))->;  & $7->=True:C214)
			FIRST RECORD:C50(Table:C252(Table:C252($6))->)
			If (Records in selection:C76(Table:C252(Table:C252($6))->)>0)
				Case of 
					: (($8->#"") & ($10->#""))
						DearContact:="Dear "+jConcat($8->; " ")+jConcat($10->; "")
					: (($8->="") & ($9->#""))
						DearContact:="Dear "+$9->
					: (($8->="") & ($10->#""))
						DearContact:="Attn: "+$10->
					Else 
						DearContact:="To Whom It May Concern:"
				End case 
			Else 
				$doLess:=True:C214
			End if 
		Else 
			$doLess:=True:C214
	End case 
End if 
If ($doLess)
	Case of 
		: (($2->="") & ($3->#""))
			DearContact:="Dear "+$3->
		: (($2->#"") & ($4->#""))
			DearContact:="Dear "+jConcat($2->; " ")+jConcat($4->; "")
		: (($3->="") & ($4->#""))
			DearContact:="Dear "+$4->
		Else 
			DearContact:="To Whom It May Concern:"
	End case 
End if 