//%attributes = {"publishedWeb":true}
//Procedure: jPopUpArray
//Friday, May 1, 1998 / 8:59:30 PM
C_POINTER:C301($1; $2; $ptPopup; $ptField)
C_TEXT:C284($vtValue; $vtArrayName; $text)
C_LONGINT:C283($i; viTableNum; viFieldNum)
$ptPopup:=$1
$ptField:=$2
If ($ptPopup->>1)
	If (entryEntity#Null:C1517)
		var $fieldName : Text
		$fieldName:=Field name:C257($ptField)
		entryEntity[$fieldName]:=$ptPopup->{$ptPopup->}
	Else 
		$vtValue:=$ptPopup->{$ptPopup->}
		RESOLVE POINTER:C394($ptPopup; $vtArrayName; viTableNum; viFieldNum)
		
		
		C_LONGINT:C283($Type)
		$Type:=Type:C295($ptField->)
		Case of 
			: (($Type=0) | ($Type=2) | ($Type=24))  //string      
				If (($ptPopup=(-><>aReps)) & ($vtValue="Search"))
					Rep_Find($ptField)
				Else 
					QUERY:C277([PopUp:23]; [PopUp:23]arrayName:3=$vtArrayName)  // ### jwm ### 20171110_1304
					If (([PopUp:23]alternates:6) & ($vtArrayName#"<>aTypeSale"))  // needs to be specific
						ARRAY TEXT:C222($atvalues; 0)
						$text:=$ptField->
						TextToArray($text; ->$atValues; " "; False:C215)
						
						$fia:=Find in array:C230($atValues; $vtValue)
						If ($fia=-1)
							CONFIRM:C162("Add Value \""+$vtValue+"\""; " Add "; " Cancel ")
							If (OK=1)
								APPEND TO ARRAY:C911($atvalues; $vtValue)
							End if 
						Else 
							CONFIRM:C162("Remove Value \""+$vtValue+"\""; " Remove "; " Cancel ")
							If (OK=1)
								DELETE FROM ARRAY:C228($atvalues; $fia; 1)
							End if 
						End if 
						//SORT ARRAY($atvalues)    // ### jwm ### 20171121_1522 request to not sort values
						$text:=""
						For ($i; 1; Size of array:C274($atvalues))
							$text:=$text+$atvalues{$i}+" "
						End for 
						
						If (Length:C16($text)>80)
							ALERT:C41("Error: Maximum Length of 80 exceded")
						Else 
							$ptField->:=$text
						End if 
						
					Else 
						$ptField->:=$vtValue
					End if 
					UNLOAD RECORD:C212([PopUp:23])
				End if 
			: (($Type=1) | ($Type=8) | ($Type=9))  //number
				$ptField->:=Num:C11($ptPopup->{$ptPopup->})
			: ($Type=11)  //time
				$ptField->:=Time:C179($ptPopup->{$ptPopup->})
			: ($Type=4)  //date
				Case of 
					: ($ptPopup->{$ptPopup->}="Today")
						$ptField->:=Current date:C33
					: ($ptPopup->{$ptPopup->}="Yesterday")
						$ptField->:=Current date:C33-1
					: ($ptPopup->{$ptPopup->}="Tomarrow")
						$ptField->:=Current date:C33+1
					: ($ptPopup->{$ptPopup->}="1 Week Ago")
						$ptField->:=Current date:C33-7
					: ($ptPopup->{$ptPopup->}="1 Week from now")
						$ptField->:=Current date:C33+7
					: (($ptPopup->{$ptPopup->}="Sunday") | ($ptPopup->{$ptPopup->}="Sun"))
						$ptField->:=Date_ThisWeek
					: (($ptPopup->{$ptPopup->}="Monday") | ($ptPopup->{$ptPopup->}="Mon"))
						$ptField->:=Date_ThisWeek+1
					: (($ptPopup->{$ptPopup->}="Tuesday") | ($ptPopup->{$ptPopup->}="Tue"))
						$ptField->:=Date_ThisWeek+2
					: (($ptPopup->{$ptPopup->}="Wednesday") | ($ptPopup->{$ptPopup->}="Wed"))
						$ptField->:=Date_ThisWeek+3
					: (($ptPopup->{$ptPopup->}="Thursday") | ($ptPopup->{$ptPopup->}="Thu"))
						$ptField->:=Date_ThisWeek+4
					: (($ptPopup->{$ptPopup->}="Friday") | ($ptPopup->{$ptPopup->}="Fri"))
						$ptField->:=Date_ThisWeek+5
					: (($ptPopup->{$ptPopup->}="Saturday") | ($ptPopup->{$ptPopup->}="Sat"))
						$ptField->:=Date_ThisWeek+6
					: ($ptPopup->{$ptPopup->}="1st of Month")
						$ptField->:=Date_ThisMon
					: ($ptPopup->{$ptPopup->}="End of Month")
						$ptField->:=Date_ThisMon(Current date:C33; 1)
					: ($ptPopup->{$ptPopup->}="1st of Year")
						$ptField->:=Date_ThisYear
					: ($ptPopup->{$ptPopup->}="End of Year")
						$ptField->:=Date_ThisYear(Current date:C33; 1)
					Else 
						$ptField->:=Date:C102($ptPopup->{$ptPopup->})
				End case 
			: ($Type=6)  //boolean
				Case of 
					: ($ptPopup->{$ptPopup->}="True")
						$ptField->:=True:C214
					: ($ptPopup->{$ptPopup->}="T")
						$ptField->:=True:C214
					: ($ptPopup->{$ptPopup->}="1")
						$ptField->:=True:C214
					: ($ptPopup->{$ptPopup->}="On")
						$ptField->:=True:C214
					Else 
						$ptField->:=False:C215
				End case 
		End case 
	End if 
End if 
$ptPopup->:=1