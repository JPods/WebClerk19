//%attributes = {}

// Modified by: Bill James (2022-08-06T05:00:00Z)
// Method: WP_SallyPort
// Description 
// Parameters
// ----------------------------------------------------

If (Storage:C1525.iSabrd=Null:C1517)
	$o:=New object:C1471
	$o.need:=""
	$o.need:=Request:C163("Define iSabrdGroup for this import")
	Storage_ToNew($o; "iSabrd")
End if 
If (Storage:C1525.iSabrd#Null:C1517)
	If (Storage:C1525.iSabrd.need#"")  // & (Current user="bill.james"))
		var $endLoop : Boolean
		var $working_t; $one_t : Text
		var $c; $final_c : Collection
		var $result : Object
		$final_c:=New collection:C1472
		$endLoop:=False:C215
		$working_t:=Get text from pasteboard:C524
		Repeat 
			$p:=Position:C15("West Point Association of Graduates - Home"; $working_t)
			If ($p<1)
				$endLoop:=True:C214
			Else 
				$working_t:=Substring:C12($working_t; $p+10)
				$pEnd:=Position:C15("West Point Association of Graduates"; $working_t)
				If ($pEnd>0)
					$one_t:=Substring:C12($working_t; 1; $pEnd)
					$working_t:=Substring:C12($working_t; $pEnd)
				Else 
					$one_t:=$working_t
					$working_t:=""
				End if 
				$c:=Split string:C1554($one_t; "\n")
				var $label : Text
				var $i; $index : Integer
				var $rec_o : cs:C1710.Customer
				var $temp_o : Object
				$rec_o:=ds:C1482.Customer.new()
				$rec_o.customerID:="SallyPort"+String:C10(CounterNew("Customer"))
				$rec_o.obGeneral:=Init_obGeneral
				$rec_o.obHistory:=New object:C1471("SallyPort_c"; $c)
				$i:=-1
				$temp_o:=New object:C1471
				For each ($label; $c)
					$i:=$i+1
					var $parse_c; $line_c : Collection
					Case of 
						: ($label="Send message")
							$temp_o.name:=$c[$i+1]
							$parse_c:=Split string:C1554($temp_o.name; " ")
							
							var $str; $test_t : Text
							$line_c:=New collection:C1472
							For each ($str; $parse_c)
								$test_t:=Txt_TrimSpaces($str)
								Case of 
									: ($test_t="Jr@")
									: ($test_t="Sr@")
									: ($test_t="II@")
									Else 
										$line_c.push($test_t)
								End case 
							End for each 
							$rec_o.nameFirst:=$line_c[0]
							$rec_o.nameLast:=$line_c[$line_c.length-1]
							$rec_o.company:=$rec_o.nameLast+", "+$rec_o.nameFirst
							$rec_o.individual:=True:C214
							
							$rec_o.company:=$rec_o.nameLast+", "+$rec_o.nameFirst
							$rec_o.individual:=True:C214
							$rec_o.profile1:=$temp_o.name
							$rec_o.comment:=$rec_o.comment+"\r\r"+"FullName: "+$c[$i+1]
							
						: ($label="Enter Location for Map")
							$temp_o.location:=$c[$i+1]
							$line_c:=Split string:C1554($temp_o.location; ";")
							If ($line_c.length>1)
								$rec_o.city:=Txt_TrimSpaces($line_c[0])
								$rec_o.state:=Txt_TrimSpaces($line_c[1])
							Else 
								$temp_o.location:="leaflet"
							End if 
							
						: ($label="Affiliation")
							$temp_o.class:=$c[$i+1]
							$rec_o.profile1:=$c[$i+1]
							
						: ($label="Cadet Company :")
							$temp_o.cadetCompany:=$c[$i+1]
							$rec_o.profile2:=$c[$i+1]
							
						: ($label="Retired Branch :")
							$temp_o.branch:=$c[$i+1]
							$rec_o.profile3:=$c[$i+1]
							
						: ($label="Title or Rank :")
							$temp_o.title:=$c[$i+1]
							$rec_o.title:=$c[$i+1]
							
						: ($label="Name at Graduation :")
							$temp_o.nameAtGraduation:=$c[$i+1]
							$rec_o.profile4:=$c[$i+1]
							$rec_o.comment:=$rec_o.comment+"\r\r"+"Name at Graduation: "+$c[$i+1]
							
							If ($rec_o.nameFirst="")
								$line_c:=Split string:C1554($temp_o.nameAtGraduation; " ")
								var $parse_c : Collection
								var $str; $test_t : Text
								$parse_c:=$line_c
								$line_c:=New collection:C1472
								For each ($str; $parse_c)
									$test_t:=Txt_TrimSpaces($str)
									Case of 
										: ($test_t="Jr@")
										: ($test_t="Sr@")
										: ($test_t="II@")
										Else 
											$line_c.push($test_t)
									End case 
								End for each 
								$rec_o.nameFirst:=$line_c[0]
								$rec_o.nameLast:=$line_c[$line_c.length-1]
								$rec_o.company:=$rec_o.nameLast+", "+$rec_o.nameFirst
								$rec_o.individual:=True:C214
							End if 
							
						: ($label="Emails")
							$temp_o.emails:=$c[$i+1]
							$rec_o.email:=$c[$i+1]
							
						: ($label="Experience")
							$temp_o.experience:=$c[$i+1]
							$rec_o.comment:=$rec_o.comment+"\r\r"+"Experient: "+$c[$i+1]
							
						: ($label="Present")
							$temp_o.present:=$c[$i+1]
							$rec_o.comment:=$rec_o.comment+"\r\r"+"Present: "+$c[$i+1]
							
					End case 
				End for each 
				$rec_o.need:=Storage:C1525.iSabrd.need
				$rec_o.prospect:=Storage:C1525.iSabrd.need
				$rec_o.adSource:="SP_"+Storage:C1525.iSabrd.need
				$rec_o.dateOpened:=Current date:C33
				$rec_o.comment:=Substring:C12($rec_o.comment; 3)
				$result:=$rec_o.save()
				
			End if 
		Until ($endLoop)
	End if 
End if 