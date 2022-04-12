//%attributes = {"publishedWeb":true}

//<declarations>
//==================================
//  Type variables 
//==================================


C_LONGINT:C283($viCountKeywords; $viField; $viIncKeywords; $viTable; $viType)
C_TEXT:C284($vtKeywords; $vtMyKeyWords)
C_POINTER:C301($1; $vpField; $vpKeyText)

//==================================
//  Initialize variables 
//==================================

$viCountKeywords:=0
$viField:=0
$viIncKeywords:=0
$viTable:=0
$viType:=0
$vtKeywords:=""
$vtMyKeyWords:=""
//</declarations>

If (Count parameters:C259=1)  //  pointer to table required
	$viTable:=Table:C252($1)
	If (Is table number valid:C999($viTable))
		For ($viField; 1; Get last field number:C255($viTable))  //Loop through fields
			If (Is field number valid:C1000($viTable; $viField))
				
				GET FIELD PROPERTIES:C258($viTable; $viField; $viType)  // get the field attributes
				$vpField:=Field:C253($viTable; $viField)
				
				Case of 
					: ($viType=Is alpha field:K8:1)  // 0
						$vtKeywords:=$vtKeywords+" "+$vpField->
						$vtKeywords:=Replace string:C233($vtKeywords; "-"; "_")
						
					: ($viType=Is real:K8:4)  // 1
						$vtKeywords:=$vtKeywords+" "+String:C10($vpField->)
						
					: ($viType=Is text:K8:3)  // 2
						$vtKeywords:=$vtKeywords+" "+$vpField->
						$vtKeywords:=Replace string:C233($vtKeywords; "-"; "_")
						
						If (Field name:C257($vpField)="KeyText")
							$vpKeyText:=$vpField
						End if 
						
					: ($viType=Is picture:K8:10)  // 3
						
						
					: ($viType=Is date:K8:7)  // 4
						
						
					: ($viType=Is boolean:K8:9)  // 6
						$vtKeywords:=$vtKeywords+" "+Field name:C257($vpField)+"_"+String:C10($vpField->)
						
					: ($viType=Is subtable:K8:11)  // 7
						
						
					: ($viType=Is integer:K8:5)  // 8
						$vtKeywords:=$vtKeywords+" "+String:C10($vpField->)
						
						
					: ($viType=Is longint:K8:6)  // 9
						$vtKeywords:=$vtKeywords+" "+String:C10($vpField->)
						
					: ($viType=Is time:K8:8)  // 11
						
						
					: ($viType=Is integer 64 bits:K8:25)  // 25
						$vtKeywords:=$vtKeywords+" "+String:C10($vpField->)
						
						
					: ($viType=Is BLOB:K8:12)  // 30
						
						
					: ($viType=_o_Is float:K8:26)  // 35
						$vtKeywords:=$vtKeywords+" "+String:C10($vpField->)
						
						
					: ($viType=Is object:K8:27)  // 38
						
						
					Else 
						
				End case 
				
			End if   //  valid field
			
		End for   // loop through fields
		
		ARRAY TEXT:C222($atMyKeywords; 0)
		GET TEXT KEYWORDS:C1141($vtKeywords; $atMyKeywords; *)  //Unique words
		SORT ARRAY:C229($atMyKeywords)
		$viCountKeywords:=Size of array:C274($atMyKeywords)
		For ($viIncKeywords; 1; $viCountKeywords)
			$vtMyKeyWords:=$vtMyKeyWords+$atMyKeywords{$viIncKeywords}+" "
		End for 
		$vpKeyText->:=$vtMyKeyWords
		
		
	End if   // valid table
	
End if   // parameters = 1
