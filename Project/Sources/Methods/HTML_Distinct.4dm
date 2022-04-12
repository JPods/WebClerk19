//%attributes = {"publishedWeb":true}

If (False:C215)
	//Procedure: HTML_Distinct 
	//Date: 07/01/02
	//Who: Bill
	//Description: Build or skip the text document to clipboard
	//values of 3 and 4 for text documents options
	//- to clear existing text doc
	//no sort if array is empty
	//zero to clear array
End if 
//HTML_Distinct ([Item]typeID;-3;[Item]Publish;"TallyResultPurpose")
C_POINTER:C301($1; $3)
C_LONGINT:C283($2; $clear)
C_TEXT:C284($lineBreak)
C_TEXT:C284($4)
C_POINTER:C301($5)  //array to copy values to
$viDoText:=0
If (Count parameters:C259=0)
	If (allowAlerts_boo)
		ALERT:C41("Point to the field.")
	End if 
Else 
	If (Count parameters:C259>1)
		$clear:=$2
	Else 
		$4:=""
		$clear:=0
	End if 
End if 
If (Is macOS:C1572)
	$lineBreak:=Char:C90(13)
Else 
	$lineBreak:=Char:C90(13)+Char:C90(10)
End if 
ARRAY TEXT:C222($rayValues; 0)
Case of 
	: ($4="SkipSearch")  //added for general use
		
	: ($4="")
		QUERY:C277(Table:C252(Table:C252($3))->; $3->>0)
	Else 
		QUERY:C277([TallyResult:73]; [TallyResult:73]publish:36>0; *)
		QUERY:C277([TallyResult:73];  & [TallyResult:73]purpose:2=$4)
		//ALL RECORDS(File(File($1)))
End case 

DISTINCT VALUES:C339($1->; $rayValues)

$k:=Size of array:C274($rayValues)


If ($k>0)
	SORT ARRAY:C229($rayValues)
End if 
If ($clear<0)
	vText1:=""
End if 
If (Abs:C99($clear)=3)
	For ($i; 1; $k)
		If ($rayValues{$i}#"")
			vText1:=vText1+$rayValues{$i}+"\r"
		End if 
	End for 
End if 
If (Abs:C99($clear)=4)
	For ($i; 1; $k)
		If ($rayValues{$i}#"")
			vText1:=vText1+"<option value="+Txt_Quoted($rayValues{$i})+">"+$rayValues{$i}+"</option>"+$lineBreak
		End if 
	End for 
End if 
If (Count parameters:C259>4)
	COPY ARRAY:C226($rayValues; $5->)
End if 
If ($clear=0)
	vText1:=""
	ARRAY TEXT:C222($rayValues; 0)
End if 


If (False:C215)
	HTML_Distinct(->[Customer:2]email:81; -3; ->[Item:4]publish:60; "SkipSearch"; ->aText1)
	SET TEXT TO PASTEBOARD:C523(vText1)
End if 
