//%attributes = {"publishedWeb":true}
//$1aServiceDate; $0 is the position; $2 date field; $3 time array; $4 time field
C_POINTER:C301($1; $2; $3; $4)
C_LONGINT:C283($0; $cnt)
C_BOOLEAN:C305($Done)
$cnt:=Size of array:C274($1->)
$0:=1
$Done:=False:C215
Repeat 
	Case of 
		: ($0>$cnt)
			$Done:=True:C214
		: ($2-><=$1->{$0})
			Repeat 
				Case of 
					: ($0>Size of array:C274($1->))
						$Done:=True:C214
					: (($1->{$0}>$2->) | (($1->{$0}=$2->) & (($4->*1)<$3->{$0})) | ($0>$cnt))
						$Done:=True:C214
					Else 
						$0:=$0+1
				End case 
			Until ($done)
		Else 
			$0:=$0+1
	End case 
Until ($done)