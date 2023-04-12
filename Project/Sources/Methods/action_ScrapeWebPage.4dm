//%attributes = {}

// Modified by: Bill James (2022-05-30T05:00:00Z)
// Method: action_ScrapeWebPage
// Description 
// Parameters
// ----------------------------------------------------
// https://blog.4d.com/web-scraping-using-object-notation/
#DECLARE($url : Text)->$result : Variant
// draft
Case of 
	: (Count parameters:C259=0)
		$url:=Request:C163("Enter URL for a web page")
		If ($url#"")
			action_ScrapeWebPage($url)
		End if 
	: (Count parameters:C259=1)
		//$url:="https://blog.4d.com"
		var $answer_b : Blob
		var $working_t : Text
		//  $status:=HTTP Get($url; $answer_b)
		Case of 
			: (($url="@.htm@") | ($url="@.txt@"))  // |($url="@.htm@")|($url="@.htm@"))
				$status:=HTTP Get:C1157($url; $working_t)
				If ($status=200)
					//$working_t=BLOB to text($answer_b)
					$result:=$working_t
				End if 
			: (($url="@.jp@") | ($url="@.sv@") | \
				($url="@.m@") | ($url="@.g@") | \
				($url="@.pn@") | ($url="@.pd@"))
				$status:=HTTP Get:C1157($url; $answer_b)
				If ($status=200)
					//$working_t=BLOB to text($answer_b)
					$result:=$answer_b
				End if 
				
		End case 
End case 