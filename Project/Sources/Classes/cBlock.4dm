//https://www.youtube.com/watch?v=PudDtdIYRio
Class constructor($data : Variant; $previousHash : Text)
	var $timeStamp : cs:C1710.cDateTime
	This:C1470.ID:=Generate UUID:C1066
	This:C1470.timeStamp:=cs:C1710.cDateTime.new()
	This:C1470.data:=$data
	This:C1470.previousHash:=$previousHash
	This:C1470.nonce:=0
	This:C1470.hash:=This:C1470.calculateHash()
	
Function calculateHash()->$result : Text
	// calculates the hash (digest) from the content of the block
	$result:=This:C1470.ID+\
		This:C1470.timeStamp.toString()+\
		JSON Stringify:C1217(This:C1470.data)+\
		This:C1470.previousHash+\
		String:C10(This:C1470.nonce)
	
	$result:=Generate digest:C1147($result; SHA256 digest:K66:4)
	
Function isValid->$isTrue : Boolean
	// returns true if the hash is valid
	$isTrue:=(This:C1470.hash=This:C1470.calculateHash())
	
	